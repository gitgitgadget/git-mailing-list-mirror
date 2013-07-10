From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/10] cat-file: split --batch input lines on whitespace
Date: Wed, 10 Jul 2013 20:59:51 +0530
Message-ID: <CALkWK0mGMZPWowZ0ULNuGKD8w2Q=kN0nEGaOkuWoYKmzD5zGrw@mail.gmail.com>
References: <20130710113447.GA20113@sigill.intra.peff.net> <20130710114828.GH21963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 17:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwwLo-0005wg-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 17:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab3GJPaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 11:30:35 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58208 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab3GJPab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 11:30:31 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so16083479ied.28
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sEuuVBmHZfaU+8rMFGYwXl0fybSGmhbTUdMZ7Vw2Rks=;
        b=JLCJ75ViZEl6beYfvl3eR9JoClLmjGDe/YFu2VFKl2LYLC207AJp4Hq0crT2IMsB27
         O5Um/eYmxePwSJwRMnxPT4KwYkrNAV3ZhVQ7901FyaaGrCTiRhXrul9N65XI7x63kQfU
         KOraxMqDxtPAA8gXI8Pn2pSTg+j1EZIaC/CDg0fiv56eNRp5IGqS5f5lpOW0gV65XInV
         vNYetRiepnZ2+eWxRUpE/CSHVMxTFDQ8pvg1F/1/BKTzSP5y2fyGYuX6vX1glLxdcp9R
         Coze3224jCqFx9G9dWH7pVlgTSwjJx5MNtcPQPTgULUJBm50WctVEb0N20I6+7SG7M3M
         O3rA==
X-Received: by 10.50.225.66 with SMTP id ri2mr11879326igc.55.1373470231350;
 Wed, 10 Jul 2013 08:30:31 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 10 Jul 2013 08:29:51 -0700 (PDT)
In-Reply-To: <20130710114828.GH21963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230058>

Jeff King wrote:
>   git rev-list --objects HEAD |
>   git cat-file --batch-check='%(objectsize) %(text)'

If anything, I would have expected %(rest), not %(text).  This atom is
specific to commands that accept input via stdin (i.e. not log, f-e-r,
branch, or anything else I can think of).

Also, this makes me wonder if %(field:0), %(field:1), and probably
%(field:@) are good ideas.  Even if we go down that road, I don't
think %(rest) is a problem per-se.
