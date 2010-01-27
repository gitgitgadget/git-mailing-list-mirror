From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH 0/4] Fix various integer overflows
Date: Wed, 27 Jan 2010 11:57:48 +0200
Message-ID: <20100127095748.GA9992@Knoppix>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vk4v4zlhg.fsf@alter.siamese.dyndns.org>
 <20100127085952.GA21535@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:57:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na4es-0002xp-OJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 10:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab0A0J5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 04:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674Ab0A0J5z
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 04:57:55 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:36669 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0A0J5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 04:57:54 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 505DE8C5D9;
	Wed, 27 Jan 2010 11:57:53 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A079A64D90D; Wed, 27 Jan 2010 11:57:53 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 368A741BF7;
	Wed, 27 Jan 2010 11:57:48 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100127085952.GA21535@cuci.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138123>

On Wed, Jan 27, 2010 at 09:59:52AM +0100, Stephen R. van den Berg wrote:
> Junio C Hamano wrote:
> >Looks trivially correct; thanks.
> 
> I'm just curious, but is this based on an actual bug which someone
> experienced, or is this just based on mere theoretical code analysis?

Theoretical at first, but I did construct packfile that hits one of
those overflows (the one in patch_delta(), 32 bits only).

In real world, hitting this bug would require hitting exactly 2^32-1
byte file, and that is quite rare size for file.

And what can happen with them in real world git usage is different
than what can happen with them if packs are suitably manipulated
("transport streams" and bundles both contain packs in them).

-Ilari
