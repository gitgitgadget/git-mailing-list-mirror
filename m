From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git on HP NonStop
Date: Mon, 20 Aug 2012 12:56:50 +0200
Message-ID: <503217F2.5070105@viscovery.net>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de> <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr> <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 'Jan Engelhardt' <jengelh@inai.de>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 12:57:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3PfM-0003K6-Fs
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 12:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2HTK47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 06:56:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59294 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751256Ab2HTK45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 06:56:57 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1T3PhI-0003TO-4d; Mon, 20 Aug 2012 12:59:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7689A1660F;
	Mon, 20 Aug 2012 12:56:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203768>

Am 8/20/2012 12:36, schrieb Joachim Schmitz:
> int var = var;
> char *othervar = othervar;
> 
> ... 
>
> What is the reason for using that self-init stuff? I don't think it is
> really portable, is it?

It is used to avoid "var may be used uninitialized" warnings for some
compilers. Officially (according to the C standard), it is undefined
behavior. But I've observed considerable resistance by Junio to fix this
properly. Therefore, unless you can show that your compiler generates
unusable code you better live with the "self-initialization" warnings.

-- Hannes
