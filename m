From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [REROLL PATCH 5/8] Support taking over transports
Date: Wed, 9 Dec 2009 23:42:16 +0200
Message-ID: <20091209214216.GA17474@Knoppix>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-6-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vljhd597h.fsf@alter.siamese.dyndns.org>
 <20091209151718.GE15673@Knoppix>
 <7vein3onxf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 22:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIUJ3-0000ZV-8P
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 22:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523AbZLIVmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755200AbZLIVmR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 16:42:17 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:33321 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbZLIVmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 16:42:16 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 44E51EBC97;
	Wed,  9 Dec 2009 23:42:21 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0485020C20; Wed, 09 Dec 2009 23:42:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 0189427D85;
	Wed,  9 Dec 2009 23:42:17 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vein3onxf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134999>

On Wed, Dec 09, 2009 at 01:08:44PM -0800, Junio C Hamano wrote:
> 
> Is data->out only used inside get_helper() to read the capabilities
> response?  I was confused by it being keft open until disconnect time.
 
Its used for all incoming communications from remote helper until connect
request (and even after it if falling back to dumb transport).

- In smart transport case, that includes possible servpath option.
- In non-smart case, it includes a lot more.

In fact, recvline uses exactly helper->out as stream to read.

-Ilari
