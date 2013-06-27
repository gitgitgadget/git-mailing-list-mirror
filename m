From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v15 01/16] test: add test cases for relative_path
Date: Thu, 27 Jun 2013 09:00:10 +0800
Message-ID: <CANYiYbESfNyNpiV=Ho_fxfQ6CxR5j3nGfKw_va8jq_5T72uPfA@mail.gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
	<569bd5216b6a8d63c9139c20390488b93f402086.1372175282.git.worldhello.net@gmail.com>
	<7vehbowyv4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 03:00:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us0ZO-0007WF-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 03:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab3F0BAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 21:00:12 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:63133 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3F0BAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 21:00:11 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so93517wib.6
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TsDeoK19tx/P4YBHcWveZly8NIkuYqp78isY7WQn0hg=;
        b=O/RKdexmpfE8iGFrNjz655UU867fekIwmkI51lrvrqQW64Ku8OJQBZLxZyUKHYvUWS
         L04c/qKHwKh1SoUuerY1YreCKjOFC+MkF7HGFVgdc7fAbxH2lNlXjpzgF+h/CE9u4esm
         DPIkIHDAlEjL/aUGnUeCqKRvHanQZBjJba6Wxyl/xFn47pc8D5lCdsBALdCccLr8ALKV
         qRAcq2eMU4HMglaIVXCUx5sBx90yyRxUdmhXkyRJH01KhosxijEC+1o8Z3jZlFSKWrYR
         G6Jn53scmI5EYKO4rHgUsJ9TF9wYB7TL94awTUvWCEFy+cJZJNb3mtKBASl1RW4JrUli
         lTnQ==
X-Received: by 10.194.249.129 with SMTP id yu1mr4716536wjc.10.1372294810265;
 Wed, 26 Jun 2013 18:00:10 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Wed, 26 Jun 2013 18:00:10 -0700 (PDT)
In-Reply-To: <7vehbowyv4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229077>

2013/6/27 Junio C Hamano <gitster@pobox.com>
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > Add subcommand "relative_path" in test-path-utils, and add test cases
> > in t0060.
> >
> > Johannes tested this commit on Windows, and found that some relative_path
>
> "this commit", or "an earlier version of this patch"?  I am guessing
> it is the latter (if so, I can easily amend locally without a need
> for rerolling).

Sorry, my English. I should say: Johannes helped to test these test cases on
Windows, and found that ...

>
> > tests should be skipped on Windows. This is because the bash on Windows
> > rewrites arguments of regular Windows programs, such as git and the
> > test helpers, if the arguments look like absolute POSIX paths. As a
> > consequence, the actual tests performed are not what the tests scripts
> > expect.
> >
> > The tests that need *not* be skipped are those where the two paths passed
> > to 'test-path-utils relative_path' have the same prefix and the result is
> > expected to be a relative path. This is because the rewriting changes
> > "/a/b" to "D:/Src/MSysGit/a/b", and when both inputs are extended the same
> > way, this just cancels out in the relative path computation.
> >
> > Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> I somehow lost track, but does the above list of sign-offs reflect
> the origins of the changes contained in this patch, or is the second
> one meant to be helped-by or something (if so, I can easily amend
> locally without a need for rerolling)?

Johannes offered a nice patch based on the last one of this
patch series. I move his patch right after the first patch
(patch 01: test: add test cases for relative_path). But I think
as a cooking topic, it should not has a commit to fix another.
So I squash Johannes' commit to the previous commit, and
add his signed-off-by.


--
Jiang Xin
