From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fact-import: failed to apply delta
Date: Wed, 11 Feb 2009 10:30:25 -0800
Message-ID: <7vwsbweshq.fsf@gitster.siamese.dyndns.org>
References: <20090210191220.GT30949@spearce.org>
 <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
 <20090210201203.GU30949@spearce.org>
 <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
 <20090210212539.GV30949@spearce.org>
 <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
 <20090210213612.GW30949@spearce.org>
 <7vprhqkjrr.fsf@gitster.siamese.dyndns.org>
 <7vfxillxiu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0902111247300.19665@iabervon.org>
 <20090211181530.GO30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:32:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJsS-0001ex-Tr
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbZBKSai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZBKSah
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:30:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbZBKSah (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:30:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4139998010;
	Wed, 11 Feb 2009 13:30:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8859F9800E; Wed,
 11 Feb 2009 13:30:27 -0500 (EST)
In-Reply-To: <20090211181530.GO30949@spearce.org> (Shawn O. Pearce's message
 of "Wed, 11 Feb 2009 10:15:30 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 115A476A-F86A-11DD-9CC7-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109475>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
>> 
>> I think free_pack_by_name() also needs to drop the entries that are from 
>> the freed pack, to avoid having repack able to get the same problem, 
>> although I wouldn't be surprised if repack happened to never allocate a 
>> new pack after freeing an old pack with stale delta cache entries, or 
>> never used the delta cache after that, simply because it does one thing 
>> and then exits.
>
> Oy.  I missed that we added this function.  Patch follows.

Thanks, both.
