From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/8] vcs-svn: convert REPORT_FILENO to an option
Date: Wed, 6 Jul 2011 15:39:47 +0530
Message-ID: <CALkWK0nO7dKkh-5kdLSwbncujOW4R-x_uRCXQcSbkhVP-qstVw@mail.gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com> <1309715877-13814-8-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeP3h-0002kY-9g
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab1GFKKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:10:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40315 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1GFKKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:10:08 -0400
Received: by wwe5 with SMTP id 5so6785732wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nP0NPG90h3UEL2PVQAbVNPiGLFKrClSE2EBSqCR+NU8=;
        b=w9NuuskZmiPav8JbulLp351qenK0TOYKq9wsomRG05fs+ki7cfeIYe2gLeqRxjBVWC
         pP7b4J0IEWF5jMt855xgtmmQ2XZ+lyWBnMmb6CSeKbD7eLvqUEg9yoDh4ZNpgN2iZZtB
         NRRCRTGmBq3L4cOoghljjsZzgWlQ4pN+l0dBY=
Received: by 10.216.50.2 with SMTP id y2mr6859034web.77.1309947007111; Wed, 06
 Jul 2011 03:10:07 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 03:09:47 -0700 (PDT)
In-Reply-To: <1309715877-13814-8-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176677>

Hi again,

Dmitry Ivankov writes:
> svn-fe needs to read fast-import's responses to "ls" and "cat-blob".
> These come through a file descriptor number 3.
>
> Sometimes it is easier to setup variable fd than a fixed one. It is
> the case with pipe() call and even more fd=3 can be already taken.
> On Windows file descriptors are not by default inherited by a child
> process, nor there is an option to setup descriptors other than
> standard stdin, stdout, stderr at a process creation time.
>
> Add an option for this file descriptor number in vcs-svn/ and svn-fe,
> add a simple test for it.
>
> To be used like following:
> $ svn-fe --read-blob-fd=7 ... 7<somewhere

Except for the fact that you're changing the API to accommodate an
extra option as I already pointed out earlier, I like this patch.
This was one of the things that I'd wanted to do myself, but never
actually got around to doing.

Thanks for working on this.

-- Ram
