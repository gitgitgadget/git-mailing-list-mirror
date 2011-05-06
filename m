From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Fri, 06 May 2011 09:03:41 +0200
Message-ID: <4DC39D4D.1000709@viscovery.net>
References: <20110428022922.GC4833@camk.edu.pl> <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl> <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org> <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl> <4DC1653A.7000000@viscovery.net> <7v4o5afht7.fsf@alter.siamese.dyndns.org> <7vwri5c27e.fsf@alter.siamese.dyndns.org> <4DC23C80.6020401@viscovery.net> <7vy62l9l5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <kornet@camk.edu.pl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:03:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIF4p-0001q0-4M
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 09:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab1EFHDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 03:03:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4750 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1EFHDq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 03:03:46 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QIF4f-0007vM-Oc; Fri, 06 May 2011 09:03:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 769A11660F;
	Fri,  6 May 2011 09:03:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vy62l9l5l.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172950>

Am 5/5/2011 18:17, schrieb Junio C Hamano:
> The point of this approach is to make a progress without regressing, and
> the (minimum) progress needed to be made that comes from the beginning of
> this discussion is that setting $(prefix) from the command line of make
> works but it does not when it is set in config.mak (or config.mak.autogen
> which in turn is added by running "./configure --prefix=...").

Ah! That's a piece of informatin that I was missing.

To fix that, wouldn't it have been sufficient to just move the
ifeq($(prefix),/usr) conditional past -include config.mak, without any
other changes?

(But I'm mostly clueless about when which make variables from what source
override what.)

-- Hannes
