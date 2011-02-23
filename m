From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] fetch/pull: Add the 'on-demand' value to the
 --recurse-submodules option
Date: Wed, 23 Feb 2011 17:12:10 -0600
Message-ID: <20110223231210.GC6819@elie>
References: <4D656F25.5090007@web.de>
 <4D656F77.7060306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:12:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNsc-0005f9-9g
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab1BWXMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:12:17 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61207 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1BWXMP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:12:15 -0500
Received: by vxi39 with SMTP id 39so3417641vxi.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=F8azQY8LD/65Xm1u6CZYvY+HnSyrLUMHXjJsrXraIAM=;
        b=ONSzptnUpIIvcIaHhsuwzUMUhFs3B2KDngwfFwuzx6XQ1RSILWoUllRFB5UFcQYBZ9
         yeL2rK05y91D7FgtbswD5DmKbr2S28SUpfdu47rQS/usJIBVjriZsCE1Biv/1To5OD2X
         1FYksoeoxeZtiBKSB7CjOFgRfQcIk+jKaQDsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f52kwThOvGGGkJxV4eI2hmBzY3nzCDq3JJd2Hs3D3o+ITQkRsIZjJ2yjIy/sc7rwxT
         MTz2BHLdTJjkwbqeA2ixIZiFXspmAlMcLQWBjuk/TbfdIs0R6xPLwDFpDqL1RLMCiDRw
         JT5g9mr4z+YwPS/9meJZxTYPgDpFryKZyuGeI=
Received: by 10.52.166.7 with SMTP id zc7mr150406vdb.289.1298502734890;
        Wed, 23 Feb 2011 15:12:14 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id o6sm3845077vcr.3.2011.02.23.15.12.13
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 15:12:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D656F77.7060306@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167735>

Jens Lehmann wrote:

>             As fetch and pull now by default just fetch those submodules
> for which new commits have been fetched in the superproject, a command
> line option to enforce that behavior is needed to be able to override
> configuration settings.

Probably this should go first in the series (the usual procedure:
first command line for easy testing, then configuration for routine
use, then defaults).

Aside from that, it looks sane from skimming this over.  I think I
prefer the name "changed" over "on-demand" since it is a little more
obvious what it will do.  Neither name captures that this only affects
checked-out submodules, unfortunately.
