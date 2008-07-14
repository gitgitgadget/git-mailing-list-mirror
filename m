From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 14:16:31 +0200
Message-ID: <487B439F.8040902@op5.se>
References: <20080713011512.GB31050@spearce.org>	<1216001267-33235-1-git-send-email-spearce@spearce.org>	<alpine.LFD.1.10.0807132220570.12484@xanadu.home>	<20080714031242.GA14542@spearce.org>	<alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de> <m31w1wu1hc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIN0d-0002OZ-QL
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYGNMR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYGNMR0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:17:26 -0400
Received: from mail.op5.se ([193.201.96.20]:38619 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615AbYGNMRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:17:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 521C324B0C54;
	Mon, 14 Jul 2008 14:17:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sKa3bY0ZMv7; Mon, 14 Jul 2008 14:17:22 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.188])
	by mail.op5.se (Postfix) with ESMTP id 4D30524B0C51;
	Mon, 14 Jul 2008 14:17:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <m31w1wu1hc.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88419>

Jakub Narebski wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> 
>>> The only other alternative I can come up with is to change pack-objects 
>>> (or at least its defaults) so we don't generate these massive delta 
>>> chains.  But there are already packs in the wild that use these chains, 
>>> resulting in performance problems for clients.
>> But the long chains make the pack actually as efficient as it is...
> 
> Perhaps Shawn thought here about limiting delta chain not by its
> *length*, but by its *size* (as required when unpacking last object
> in a delta chanin).
> 
> What do you think about this idea?

Sorry for being clueless here, but why does the older versions need
to be kept in-memory anyway? Aren't we applying the delta each time
we find one, repeatedly creating a new base-object in-memory for
each delta? If we aren't doing that, why do we need more than just
a small amount of memory just for keeping the delta?

Feel free to tell me to go away if I'm being stupid. I'm just
curious and probably won't be able to hack up any patches anyway.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
