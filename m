From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently
 processed
Date: Thu, 20 Jun 2013 10:10:02 +0200
Message-ID: <51C2B8DA.6040400@viscovery.net>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr> <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se> <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr> <alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se> <0b88af05ea8d4723a870476036992abc@ensibm.imag.fr> <51BF26F9.1080900@viscovery.net> <7vvc5cg0i8.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1306200853250.7267@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Mathieu_Li=E9nar?= =?ISO-8859-1?Q?d--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>, git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpZwq-0007TR-8W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab3FTIKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:10:15 -0400
Received: from so.liwest.at ([212.33.55.13]:45406 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754182Ab3FTIKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 04:10:09 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UpZwQ-0005rS-Si; Thu, 20 Jun 2013 10:10:03 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6B63A1660F;
	Thu, 20 Jun 2013 10:10:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <alpine.DEB.2.00.1306200853250.7267@ds9.cixit.se>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228448>

Am 6/20/2013 9:56, schrieb Peter Krefting:
> Junio C Hamano:
> 
>> But my understanding is that the reordering using printf() is the
>> mechanism we suggest l10n folks to use when the order of parameters
>> given to printf does not match the preferred word order in the message
>> in their language.
> 
> It's documented in the gettext manual, and seems to be used in the
> zh_CN.po to change the word order in quite a few places.

It is fine to use %n$ in translated strings as long as gettext is enabled
only on systems that have a sufficiently capable printf and these formats
are not used in the source code.

But you can't have this string:

  "Splitting a commit while rebasing branch '%2$s' on '%3$s'."

neither in the template nor in the translation, because the numbers must
begin at 1 (and must be used without gaps).

-- Hannes
