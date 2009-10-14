From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] change throughput display units with fast links
Date: Wed, 14 Oct 2009 09:07:41 +0200
Message-ID: <4AD578BD.7080201@viscovery.net>
References: <alpine.LFD.2.00.0910132256280.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 09:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxy7l-0000xy-Vn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 09:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbZJNHI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 03:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756076AbZJNHI0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 03:08:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37812 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363AbZJNHIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 03:08:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MxxxW-0005N1-Ar; Wed, 14 Oct 2009 09:07:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E4B8E9F88; Wed, 14 Oct 2009 09:07:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LFD.2.00.0910132256280.20122@xanadu.home>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130264>

Nicolas Pitre schrieb:
> +	if (rate > 1 << 10) {
> +		int x = rate + 5;  /* for rounding */
> +		snprintf(tp->display + sizeof(tp->display) - l, l,
> +			 " | %u.%2.2u MiB/s",

Shouldn't the fractional part be "%02.2u" (leading zeros instead of blanks)?

> +			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> +	} else if (rate)
>  		snprintf(tp->display + sizeof(tp->display) - l, l,
>  			 " | %u KiB/s", rate);
>  }

-- Hannes
