From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What changed in merge commit?
Date: Mon, 18 Jul 2011 18:52:33 +0200
Message-ID: <CABPQNSaOQxBqf34_799zc46EnHsc7L3BiSATyYq+Q6oGs0H6sw@mail.gmail.com>
References: <CAF_dkJC-ee2Bqyi2_Fx_j8mu3tCFsV8o=xMRLjx+s2di4=HfkQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 18:53:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qir4I-0000A9-J4
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab1GRQxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 12:53:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37645 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab1GRQxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 12:53:13 -0400
Received: by pvg12 with SMTP id 12so3139616pvg.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GiRxTZAX4Eog4+bu/DMbUFoZDfCzrG1cF5b3tSpVn88=;
        b=hDFPpuytwoLoDz32jwVJUw/Avid+h9byWxwhiwVzM+iGX3TvLf0har/TKGgIaJjayj
         Y1SSE1+BhmEKG2Xyn8c3XZtFsfLkq2MagAb1idXhoQR2PhBw/kRDwQDLQAjttaSYJBvO
         YnYHQ+HOjpsTW+Bo7/y/BCJ7r8RKr1TbcjEwE=
Received: by 10.68.10.98 with SMTP id h2mr8215357pbb.372.1311007993185; Mon,
 18 Jul 2011 09:53:13 -0700 (PDT)
Received: by 10.68.48.130 with HTTP; Mon, 18 Jul 2011 09:52:33 -0700 (PDT)
In-Reply-To: <CAF_dkJC-ee2Bqyi2_Fx_j8mu3tCFsV8o=xMRLjx+s2di4=HfkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177385>

On Mon, Jul 18, 2011 at 6:44 PM, Patrick Doyle <wpdster@gmail.com> wrote:
> Since today seems to be my day to hang out on this list, I thought I'd
> ask another burning question...
>
> How can I see what changed in a merge commit?
>
> $ git log
>
> just says "merge remote branch 'origin/master' into wpd" and
>
> $ git log --name-status
>
> says the same thing -- it doesn't list any files as having changed.

That's because nothing did change; it's the merge's parents that are
the commits that changed something. If there was a fix-up (either due
to a merge-conflict or an explicitly squashed-in change), then that
would show up for the merge-commit.

You probably want to do something like "git diff SHA1-OF-MERGE^
SHA1-OF-MERGE" to see what the merge changed compared to it's previous
commit.
