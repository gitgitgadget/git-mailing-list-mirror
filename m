From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] connect: improve check for plink to reduce false
 positives
Date: Fri, 24 Apr 2015 08:41:13 +0200
Organization: gmx
Message-ID: <92bcca820a7ade286142458148d27bf3@www.dscho.org>
References: <20150422232306.GA32705@peff.net>
 <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
 <1429747595-298095-2-git-send-email-sandals@crustytoothpaste.net>
 <b6b4da1f7735b834043375e3d8eaa331@www.dscho.org>
 <20150423155304.GA26018@peff.net>
 <20150423231403.GC274681@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ngu?= =?UTF-8?Q?y=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 08:41:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlXIs-0006qy-0R
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 08:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbbDXGla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 02:41:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:59500 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932506AbbDXGl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 02:41:29 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXZNq-1YrUwX25xe-00WVsb; Fri, 24 Apr 2015 08:41:15
 +0200
In-Reply-To: <20150423231403.GC274681@vauxhall.crustytoothpaste.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:pB2wRKNkzZLoEAWoP/VdKY460xVkuD6F88zWNC0L5tdc+ZcXs2v
 qUv3to+r9wEtpnmcVPfzb/aEm54jnKpLgabKwMR2IDzIgdoG+VHetZl5mZZwUDFXP3fIyUr
 1fzUq3RSDWfY+oIQW6Blxhb5IJ2HvAr0HzurGbpTa/6KxABE97OVy64QRxxst/sIpaYE54u
 BfrJ2AomFtKfsOTIXTs8Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267725>

Hi Brian,

On 2015-04-24 01:14, brian m. carlson wrote:
> On Thu, Apr 23, 2015 at 11:53:04AM -0400, Jeff King wrote:
>
>> If I were writing from scratch, I would probably keep things as tight as
>> possible, like:
>>
>>   const char *base = basename(ssh);
>>   plink = !strcasecmp(base, "plink") ||
>>           !strcasecmp(base, "plink.exe");
>>   tplink = !strcasecmp(base, "tortoiseplink") ||
>>            !strcasecmp(base, "tortoiseplink.exe"));
>>
>> but maybe that is too tight at this point in time; we don't really know
>> what's out there and working (or maybe _we_ do, but _I_ do not :) ).
>>
>> At any rate, brian's patch only looks for a dir-separator anywhere, not
>> the actual basename. So:
>>
>>   /path/to/plink/ssh
>>
>> would match, and I'm not sure if that's a good thing or not.
> 
> This is true.  In hindsight, I think it's probably better to be a bit
> stricter, so I'll reroll to use the stricter format.

Thank you so much!
Dscho
