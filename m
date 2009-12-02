From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 20:47:23 +0200
Message-ID: <20091202184723.GA10228@Knoppix>
References: <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org>
 <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
 <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org>
 <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
 <7vskbtfdvo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:47:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuEi-00019T-1t
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbZLBSrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 13:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbZLBSrX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:47:23 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:36323 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbZLBSrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 13:47:23 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 7E9C2EF54A;
	Wed,  2 Dec 2009 20:47:28 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04FCB6F671; Wed, 02 Dec 2009 20:47:28 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 5779A404E;
	Wed,  2 Dec 2009 20:47:24 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vskbtfdvo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134368>

On Wed, Dec 02, 2009 at 10:07:55AM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> The "modular" setup is a good thing to do, but I do not know how it
> relates to the change Ilari did. 

Removing core dependency on NO_CURL is required for that. 6/8 is one
way to do that given support for dispatching <scheme>:// to remote
helpers (1/8).

> Isn't it simply a matter of excluding
> git-remote-curl from the current set of binaries to be shipped with
> git-core.rpm and making a separate git-remote-http.rpm to contain it, or
> does it involve a lot more than that from the packager's side?

See above. There's also issues with git remote helper execution, namely
inability to properly handle failure before cap exchange.

With properly fixed main git binary, it is just matter of splitting
remote-xxx executable(s) relating to HTTP to seperate package.

-Ilari
