From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Mon, 23 Aug 2010 15:56:39 +0200
Message-ID: <4C727E17.5070707@ira.uka.de>
References: <4C6A1C5B.4030304@workspacewhiz.com>	<7viq39avay.fsf@alter.siamese.dyndns.org>	<20100818233900.GA27531@localhost> <vpqd3t9656k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 23 15:56:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnXVI-0003Rf-DV
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 15:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab0HWNzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 09:55:52 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57253 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751163Ab0HWNzv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 09:55:51 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1OnXUu-0008Ks-B7; Mon, 23 Aug 2010 15:55:41 +0200
Received: from i20smtp.iaks.uni-karlsruhe.de ([141.3.32.226])
	by irams1.ira.uni-karlsruhe.de with esmtps port 25 
	id 1OnXUu-0008UT-4y; Mon, 23 Aug 2010 15:55:36 +0200
Received: from throatwobbler.iaks.uka.de ([172.16.22.120])
	by i20smtp.iaks.uni-karlsruhe.de with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1OnXVz-0007ON-DX; Mon, 23 Aug 2010 15:56:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Lightning/1.0b2pre Thunderbird/3.0.6
In-Reply-To: <vpqd3t9656k.fsf@bauges.imag.fr>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1282571741.836967000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154226>

Am 23.08.2010 11:37, schrieb Matthieu Moy:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
>> By default, checkout and fast-forward merge will overwrite ignored
>> files. Make this behavior configurable.
> 
> Just mentionning an alternative, or complementary approach:
> 
> Instead of overwritting completely a .gitignore-d file, Git could
> rename it, and warn the user kindly. For example:


You've got my vote. This is the only option that combines safety with
minimal configuration hassle.

I didn't know about this subtle difference between .gitignore and
.git/info/exclude. And while this makes sense I expect a sizable
percentage of users will never even know that .git/info/exclude exists.

And in practice I guess a lot of files will get added to .gitignore even
though they only are relevant to one user (out of carelessness or
ignorance). I know I have added patterns without making a conscious
decision about their relevance to others.
