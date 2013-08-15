From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 11:20:39 +0700
Message-ID: <CACsJy8AJ4eTXXArvN0eTC-_j7oSE8V+8zCDYP3gm4KZUrH90jA@mail.gmail.com>
References: <520BAF9F.70105@googlemail.com> <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
 <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com> <vpq7gfnj38d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git <git@vger.kernel.org>, Fredrik Gustafsson <iveqy@iveqy.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 15 06:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9p3j-0005WA-4w
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 06:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab3HOEVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 00:21:11 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36660 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3HOEVK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 00:21:10 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so333562obc.31
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0U/Qeu7INZftDGlDD74aEbW9uJ5X/H3Srq+S+kZQAo0=;
        b=pG+fGY4HNa5x/MfIqWbw+nXJWYmmHq2quqIAAnrNvd6Ls/VkiOEvYVAds9Fiak3okg
         whPqP/T+2oHZ6BXJU2iYUZ6RaKpPwlt5Mckbds60DBSXuYBNrqarCn+MgdFpIdxLPJnS
         wWaoHLKdwHxlFcJ5XGL6R0rc1XtViooD2E3laCiqXgkrsm9qgtB9nJ1RZLfcBgz8sghl
         8z8M1Juuw6nnHrBBL6gIWAic8URfWm8D8wkrjQU1fpu2FV8TPeyZ/xmxMoehNRMEnzAn
         FWmxG8Vh5L52BsCl9QXd6OqGqkBVcmIlDBb9LVuXHjW0FJENSeiimbHpzI4dHDHfH61d
         R7HQ==
X-Received: by 10.182.250.163 with SMTP id zd3mr24265512obc.20.1376540469630;
 Wed, 14 Aug 2013 21:21:09 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 14 Aug 2013 21:20:39 -0700 (PDT)
In-Reply-To: <vpq7gfnj38d.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232330>

On Thu, Aug 15, 2013 at 5:51 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> There's a real problem with git-repack being shell (I already mentionned
> it in the previous thread about the rewrite): it creates dependencies on
> a few external binaries, and a restricted server may not have them.

There's also the Windows port. A POSIX shell environment is required
for using git on Windows, but I feel one should be able to use core
functionlity even without POSIX utilities. git-repack is part of this
core in my opinion.
-- 
Duy
