From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Sun, 31 Aug 2014 11:52:50 +0700
Message-ID: <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley>
 <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 06:53:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNx8n-0006jb-FU
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 06:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbaHaExW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 00:53:22 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:52710 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaHaExV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 00:53:21 -0400
Received: by mail-ig0-f174.google.com with SMTP id a13so2209617igq.7
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 21:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1Iez0ojN/W37koDVanUgO7e9CIjBjUwa0P4c/9iGLwM=;
        b=DNBkg4fiNLaDl6glPStoRNKpyCul3nS6KUelZMaUh+Yfm/sB7HiITni7UAgrLhsYj/
         QdNfam7ghgXq4HfI4mlvmjLNm5z0AIn+nbiHoZtNGcG5AJhzToaVTOCnnztyU3A2liLn
         3ClL4G/H9ZbW/CIIBlKNythGC/XiXSKiFEsuTTvTCmYP1JQnFOSQCR7bYgci0iziW8ba
         Ll9pepe5fBCUHkq/+UzwmxqSsFLnwO7wYXSuEwvRoOaXwAfEbiC5+F5twTPH0uv30poJ
         1a6RsjqPE5YQX/3X9ZhEf8ujibuXgKKu5IizKtKknUAyHAXQkh6cZ8pUiqObDtQ7zPEy
         Rdkw==
X-Received: by 10.42.247.137 with SMTP id mc9mr19164653icb.13.1409460800789;
 Sat, 30 Aug 2014 21:53:20 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Sat, 30 Aug 2014 21:52:50 -0700 (PDT)
In-Reply-To: <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256280>

On Sun, Aug 31, 2014 at 11:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> All checkouts share the same repository. Linked checkouts see the
> repository a bit different from the main checkout. When you perform
> the command
>
> ------------
> git checkout --to <some-location> <some-branch>
> ------------
>
> The checkout at <some-location> will have a unique id that is also the
> branch name (e.g. "<some-branch>"). A number may be appended to the id

.. and I got my facts wrong. The above line should be:

last component of <some-location>. A number may be appended to the id

> to make it unique. All worktree-specific files of this new checkout
> are in $GIT_DIR/repos/<unique-id> of the main checkout. So "HEAD"
> inside the linked checkout will be resolved to
> "$GIT_DIR/repos/<some-branch>/HEAD", while "HEAD" from the main

s/<some-branch>/<unique-id>/

> checkout remains "$GIT_DIR/HEAD".



-- 
Duy
