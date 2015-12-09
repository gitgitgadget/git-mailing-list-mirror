From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: Re: rebase has no --verify-signatures
Date: Thu, 10 Dec 2015 00:20:15 +0100
Message-ID: <20151209232015.GA1923@blarch>
References: <20151207140015.GA14956@netblarch.tu-darmstadt.de>
 <20151208012125.GD990758@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 23:04:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6mqI-0007i3-42
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbLIWEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 17:04:04 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34148 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbLIWEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:04:02 -0500
Received: by mail-wm0-f45.google.com with SMTP id v187so5872602wmv.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PDg0GZb1w2uDJDFrjoRT5cKA7l7pMFTGweO+beta4pg=;
        b=ATt/L55QOg5DDd6MIIgclcmKWI59ftFIf2chexZOYU2pANla9ZHHYBsVK8wkORkZRD
         anH4zRokU33GsEu7TAxSjb5XD6P1YVShcwwsbxJdY0VH0fsaWuXVA1dNJTYrd/VbDv24
         xuGWapNCZwj7MGJiGyi4J3riU74lgaOURH8LSkhWe5gdHnLxd32lrEF21CDItmWB4Uv1
         GezgD9+3isKy9rhFDW+IFf1es5/MyeB3OfcpMfJj8L+mAyxvhdbWvJeZq4mcBidhozCx
         lwCa6AkI25F2rGzVGogbhLG8l0xlHEt29tvwI/vBxjsIsTbm64Oqh2LbfxrgtCad43zz
         /92A==
X-Received: by 10.28.194.7 with SMTP id s7mr31260234wmf.29.1449698641446;
        Wed, 09 Dec 2015 14:04:01 -0800 (PST)
Received: from blarch (dslb-084-059-154-159.084.059.pools.vodafone-ip.de. [84.59.154.159])
        by smtp.gmail.com with ESMTPSA id an7sm9515406wjc.44.2015.12.09.14.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 14:04:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151208012125.GD990758@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282198>

On Tue, Dec 08, 2015 at 01:21:25AM +0000, brian m. carlson wrote:
> On Mon, Dec 07, 2015 at 03:00:15PM +0100, Alexander 'z33ky' Hirsch wrote:
> > Is there any technical reason why rebase should not have a
> > --verify-signatures flag? I have written a patch to git-rebase--am
> > which enables it to do such a check. If there is no reason not to
> > include it I'd add documentation and a test and submit it.
> 
> As far as I know, there is no technical reason that it shouldn't.  It's
> probably that nobody has implemented it yet.  I'd certainly be
> interested in such a patch.
> 
> For a thorough change, you'd probably want to make it work with
> git-rebase--merge and git-rebase--interactive as well.  I'm sure I'm not
> the only person who frequently uses rebase -m.

Ah, rebase -m. That sounds nice, I didn't know about this feature.
In fact, I first tried to write the code in git-rebase--merge, thinking this is the default rebase script.

git-rebase--interactive sounds a bit more difficult since you could easily modify commits, thereby removing previously GPG signed commits. Although this sounds like all the more reason why it would be useful to check for it.

I'll look at the script and ponder about it. I'll post whatever I come up with on Thursday (probably) or Friday.
I'll put you in the CC when I post the patch.

Regards,
Alexander Hirsch
