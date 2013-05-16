From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 15:23:18 +0700
Message-ID: <CACsJy8CrGTa2XdfFkkKDQQjF8gM3011RiUE6roe9L7yZZq5J2g@mail.gmail.com>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com> <5194921F.4080103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 16 10:23:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctTe-0005SX-Of
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab3EPIXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:23:50 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:52586 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab3EPIXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:23:49 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so3136030obc.29
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5up0/aBMyjIhcDB4tc1p7kZ1ZuZKNG7zLp3hQ6GE7cU=;
        b=blqBOhjyLobIA/wSTagHjYnAGBp+YNbBKuS48iuoGRSPJSZxJK9FaoU3XfiALsBxD4
         b9Dq08GLnLEjllk7ueW7KRO1IYTyXr7kXxATXmwdz/CvNpxlUJZW6NMt6gbb7w3suxNs
         g9NiO3M5WxRWTuYqMR+D59AlNTpSBDFHA6u4ntzIVuPV48OK+/gLk/nfZlYVe4CU3KMX
         i+AuoslliCAgo44mFih/+sSbi42NzV9t6Gx2scW8Lkktlxb7buoQQmvmgyzzXUT8EjLB
         pWF55qVq2POUvJUnDyMJMfNSQYvK7ZaFwv0KgGPgbP/7mnGtSTq3gGFLP0h1OrQpwNgf
         29Yw==
X-Received: by 10.60.60.73 with SMTP id f9mr9974494oer.43.1368692628317; Thu,
 16 May 2013 01:23:48 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 16 May 2013 01:23:18 -0700 (PDT)
In-Reply-To: <5194921F.4080103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224498>

On Thu, May 16, 2013 at 3:00 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I feel, though, that we're really exploding our option and config realm.
> For "git branch" in list mode, we are already able to stack "-v", i.e.
> "-v" and "-vv" do different things. How about maybe adding "-vvv" and
> arranging things so that the verbosity and the run time increases with
> the number of v's?
>
> -v list with sha1 + subject of last commit
> -vv add upstream branch name
> -vvv add ahead/behind info (the only costly mode)
> -vvvv same with "--cherry" (ahead/behind/same)
>
> Or maybe combine the middle two cases into "-vv", which means it would
> be the same as "-vv", with only "-v" changing what it does now.

What if I want something in -vvvv except some in -vv? I think to avoid
option explosion, maybe we can adopt --pretty=format:xxx from "git
log" and let the user decideswhat (and how) to display. "pretty" code
learns about alignment already, which may be useful here.
--
Duy
