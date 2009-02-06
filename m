From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] handle empty notes gracefully
Date: Fri, 06 Feb 2009 16:49:14 +0100
Message-ID: <498C5BFA.7030107@viscovery.net>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-3-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0902061636320.7377@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSyi-0005VD-SO
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZBFPtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbZBFPtU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:49:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32586 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZBFPtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:49:19 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LVSx8-0006TY-Cf; Fri, 06 Feb 2009 16:49:14 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 164614E4; Fri,  6 Feb 2009 16:49:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0902061636320.7377@intel-tinevez-2-302>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108744>

Johannes Schindelin schrieb:
> On Fri, 6 Feb 2009, Michael J Gruber wrote:
>> +test_expect_success 'handle empty notes gracefully' '
>>  	git notes show || test 1 = $?
> 
> Completely forgot to mention that I think you want to use test_must_fail 
> here.

Wouldn't work. We want to differentiate between different exit codes. But
after test_must_fail the exit code is gone. In this simple case this
should work:

	git notes show; test 1 = $?

-- Hannes
