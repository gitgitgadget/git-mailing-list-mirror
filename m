From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 3/3] Avoid non-portable strftime format specifiers in git-cvsimport
Date: Tue, 15 Jan 2013 19:53:37 -0600
Message-ID: <CAEUsAPZakGKUmQWrsTaF1cpbQm0Y4C3sDxCWD_i1gkQxeC-bRQ@mail.gmail.com>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
	<1358291405-10173-4-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, esr@thyrsus.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvICW-0002PA-A0
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 02:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810Ab3APBxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 20:53:39 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35564 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757607Ab3APBxj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 20:53:39 -0500
Received: by mail-lb0-f170.google.com with SMTP id j14so658344lbo.29
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 17:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=cfzn+MTqezHwfQsZ2XKz07zs42NMMRIgGnR1REhdztI=;
        b=o9FVEAR1dzG7/lfFhfkXG89IH8IinRx1ijPDMmuDGv4Khu01CN/g6LDumMhxXCnvix
         lFYuv82wvsU23WrmMhV8x9ZAn8Uq69bMdrdaIgG6pwyITnhn65VCcy7mk5dVTbn+e3xz
         N9QT8rKx/u8Jn/dZg2f889M2gHyygCtmMN2pDv0s6dnV7q/1vFJLiAYnkvJso7C27A1i
         cSw0FyYEJiBbcBUNPIPsrK0PykuB0CQJfQrqnX/1PFG9SHzxYB9zd2BTFWBuKHAIt6O5
         8dA7lwnffTWphRX471luKHpx4ZjBqnSzDP7vHfAZN8Ks2ACPO7F41mnSwtpckNeDS/3B
         zXtQ==
Received: by 10.152.114.42 with SMTP id jd10mr25896459lab.31.1358301217575;
 Tue, 15 Jan 2013 17:53:37 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Tue, 15 Jan 2013 17:53:37 -0800 (PST)
In-Reply-To: <1358291405-10173-4-git-send-email-bdwalton@gmail.com>
X-Google-Sender-Auth: wwLZwHNmRH4g3Lw4L77IXu8J6Xc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213702>

On Tue, Jan 15, 2013 at 5:10 PM, Ben Walton <bdwalton@gmail.com> wrote:
> Neither %s or %z are portable strftime format specifiers.  There is no
> need for %s in git-cvsimport as the supplied time is already in
> seconds since the epoch.  For %z, use the function get_tz_offset
> provided by Git.pm instead.

Out of curiosity, which platforms are affected?  Assuming DST is a 1
hour shift (patch 2/3) is not necessarily portable either, though this
currently appears to only affect a small island off of the coast of
Australia.  :-)

Chris
