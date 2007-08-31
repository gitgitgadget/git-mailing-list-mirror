From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-filter-branch: document --original option
Date: Fri, 31 Aug 2007 08:16:39 +0200
Message-ID: <851wdkcjp4.fsf@lola.goethe.zz>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
	<1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
	<11884938431525-git-send-email-giuseppe.bilotta@gmail.com>
	<7vy7fs7kmc.fsf@gitster.siamese.dyndns.org>
	<85d4x4d6oi.fsf@lola.goethe.zz>
	<7vodgo7jbn.fsf@gitster.siamese.dyndns.org>
	<7v3ay07h0h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 08:16:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQzoD-0007b0-A3
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 08:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbXHaGQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 02:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbXHaGQm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 02:16:42 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:53500 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903AbXHaGQl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 02:16:41 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 2A4072CAEDE;
	Fri, 31 Aug 2007 08:16:40 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 1A2952D3B30;
	Fri, 31 Aug 2007 08:16:40 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-068.pools.arcor-ip.net [84.61.55.68])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id EB9E530A9F3;
	Fri, 31 Aug 2007 08:16:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B86AB1D3DB8A; Fri, 31 Aug 2007 08:16:39 +0200 (CEST)
In-Reply-To: <7v3ay07h0h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 30 Aug 2007 16\:13\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4110/Fri Aug 31 01:49:40 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57121>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I agree we do not give the "portable to version 7" prize
>> anymore.  But you made me realize another thing.
>>
>> I think it should make sure orig_namespace has one and only one
>> trailing slash, because otherwise "--original refs/heads//"
>> would lead you to the same disaster.
>
> Perhaps,
>
> 	orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
>

See separate proposal which I find still prettier (and which does not
fork).

But I really don't think we should bend over backwards: multiple end
slashes have explicit manual origin.  People deserve what they get
then.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
