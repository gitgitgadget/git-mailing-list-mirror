From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary
 commits
Date: Wed, 22 Feb 2012 23:10:16 +0100
Message-ID: <4F4567C8.2030809@kdbg.org>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch> <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch> <20120222205500.GD6781@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0KOJ-0005tG-Er
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab2BVWKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:10:22 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:24516 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755739Ab2BVWKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 17:10:21 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4057113004A;
	Wed, 22 Feb 2012 23:10:16 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A445D19F678;
	Wed, 22 Feb 2012 23:10:16 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.26) Gecko/20120124 SUSE/3.1.18 Thunderbird/3.1.18
In-Reply-To: <20120222205500.GD6781@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191296>

Am 22.02.2012 21:55, schrieb Jeff King:
> On Wed, Feb 22, 2012 at 08:34:23PM +0100, Thomas Rast wrote:
>> +	printf "abcdefghijkl %s\n" $(seq 1 100) | git commit -F - &&
> 
> Seq is not portable.

Thanks for pointing this out.

> I usually use either
> 
>   perl -le "print for (1..100)"
> 
> or just do:
> 
>   z16=zzzzzzzzzzzzzzzz
>   z256=$z16$z16$z16$z16$z16$z16$z16$z16
>   z1024=$z256$z256$z256$z256$z256$z256$z256$z256

If a sequence of ASCII zeros is good enough, you can also do:

  printf %02134d 0

-- Hannes
