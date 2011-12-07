From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/15] t1006 (cat-file): use test_cmp
Date: Wed, 7 Dec 2011 16:01:27 -0600
Message-ID: <20111207220127.GE2911@elie.hsd1.il.comcast.net>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
 <1323286611-4806-15-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPYZ-00005Q-0m
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab1LGWBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:01:34 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37942 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab1LGWBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:01:33 -0500
Received: by ghbz2 with SMTP id z2so940292ghb.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FcXG+xnQp+WabjJGTtWepNpH0WwT+tZkpka6YZyowcE=;
        b=nx91xgpbpOtjN7aOKqw7hDHyWfBpQzq57p6Dx+lUzCtOP5OUZY9LGRMrus+Ao2geHe
         QqKCHxvVT3HcSHS+nHFe8LdJyZoP+hsHhWirbwXLDFfPueyqCdwYo+ayp8Vn6+0hcgoH
         mQbG/PoCD6awJolQk4Ome9CMRDmpwo9qtQpAw=
Received: by 10.236.139.199 with SMTP id c47mr252735yhj.113.1323295293325;
        Wed, 07 Dec 2011 14:01:33 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o50sm5304345yhl.9.2011.12.07.14.01.32
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 14:01:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323286611-4806-15-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186507>

Ramkumar Ramachandra wrote:

> Use test_cmp in preference to repeatedly comparing command outputs by
> hand.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t1006-cat-file.sh |   53 +++++++++++---------------------------------------
>  1 files changed, 12 insertions(+), 41 deletions(-)

I guess test_cmp didn't exist yet when this code was written, though
that doesn't explain why "diff" or "cmp" was not used.

Doesn't this miss some other instances of the

	test $expect = $actual

idiom in the same test script?  What distinguishes the cases that you
fixed from the ones skipped, and is it worth an inconsistent style to
convert some without the others?
