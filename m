From: Ben Aveling <bena.001@optusnet.com.au>
Subject: Re: [RFC/PATCH] fsck: do not canonicalize modes in trees we are checking
Date: Sun, 19 Oct 2014 23:40:22 +1100
Message-ID: <5443B136.4060009@optusnet.com.au>
References: <20140923154751.GA19319@peff.net> <20140923162343.GA20379@debian> <20140923163008.GA21591@peff.net> <543B02A7.9040807@optusnet.com.au> <20141014082120.GA16686@peff.net> <543F074B.2050907@optusnet.com.au> <20141016002021.GA27509@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 14:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfpml-0004eX-R2
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 14:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbaJSMkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 08:40:32 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34099 "EHLO
	mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810AbaJSMkb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 08:40:31 -0400
Received: from [10.1.1.8] (d220-237-37-95.mas801.nsw.optusnet.com.au [220.237.37.95])
	(Authenticated sender: bena.001@optusnet.com.au)
	by mail105.syd.optusnet.com.au (Postfix) with ESMTPSA id B9A7110419C3;
	Sun, 19 Oct 2014 23:40:26 +1100 (AEDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20141016002021.GA27509@peff.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=dMCfxopb c=1 sm=1 tr=0
	a=ZO94Wbt7xQQy/jpR1p8Lkg==:117 a=ZO94Wbt7xQQy/jpR1p8Lkg==:17
	a=PO7r1zJSAAAA:8 a=tcnv99F1KMcA:10 a=IkcTkHD0fZMA:10
	a=rrLvikDJ3v-vVmkBU1UA:9 a=QEXdDO2ut3YA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/10/14 11:20, Jeff King wrote:
> On Thu, Oct 16, 2014 at 10:46:19AM +1100, Ben Aveling wrote:
>
> I have a corrupt repository, and every time I run fsck, it
> reports one corrupt object, then stops.
> Corrupt how? Bit-corruption, or a malformed object?

Bit-corruption, in multiple places.

> If you have a non-corrupted version of the repository, the simplest 
> thing is to just pack it, copy the resulting packfile to the broken 
> repository (again, using "cp" or "rsync" and not git), and then repack 
> there. 

This seems to have worked. I also had to move away the existing .idx and 
copy in a new one before it was happy.

I'm not sure that what I've done is so different from simply copying the 
other version of the repository - there shouldn't have been anything in 
the corrupt version that wasn't also in the good one. But any rate, it 
worked.

Thanks, Ben
