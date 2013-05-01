From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] sha1_name.c: don't waste cycles in the @-parsing loop
Date: Thu, 2 May 2013 00:18:29 +0530
Message-ID: <CALkWK0nERh_PRWgpPEgim_M1=oPXR03f343u1TLwiwqgi4JpSQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-3-git-send-email-artagnon@gmail.com> <CAMP44s1j6GdQBjgCdBrG3xvXr_XifCTRZWJAQUrzts-MzFg--g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXc5b-0005Jw-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab3EAStL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:49:11 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:65402 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab3EAStK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:49:10 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so1643041iak.29
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9kr6TtM5F+ydRTXR2vPFDCn5E8MspwkkGzlrUYEL0kI=;
        b=rD7HWQ6EVQ5mTwB9GvNzCYqlJumnQEqvZLg4b9eHXEAYQgbWvA0WP4vo2+erXY2NcV
         bi8bkjDHLk+0yuy/Crqegn2W2tRPNE1zIX9QTId2KUBEL37a4uccNZTmdTcCXAhthVsL
         aDESa75PIk4YbXQR6CWNJeJakOcmMifuYjiv2vJwQzp8SghFh/Z8gNr4Cy2PA2FGStfY
         h3u2ygIDBiSafEF7OESz9dw+7Lr5RA8/6Cbhu4q0srHoYVacgTquaSjCxJzoRQswoMbQ
         JuG/Zbppil8E2WXsHibjHtxNAKwQAOZih7tvVMMp72FoXBGn5GpEY8n+rVA5vBhvL2zP
         mNOw==
X-Received: by 10.43.125.199 with SMTP id gt7mr1919745icc.48.1367434149483;
 Wed, 01 May 2013 11:49:09 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 11:48:29 -0700 (PDT)
In-Reply-To: <CAMP44s1j6GdQBjgCdBrG3xvXr_XifCTRZWJAQUrzts-MzFg--g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223122>

Felipe Contreras wrote:
> I think this comment is overkill.

That's not for one line.  It's for the whole logic following it: there
are things like (len-1) - (at+2) which are easy to visualize with this
picture.  They're int, not char *.
