From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: 1.7.2 cycle will open soon
Date: Thu, 06 May 2010 09:06:43 +0200
Message-ID: <4BE26A83.4010708@viscovery.net>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org> <20100506055236.GA16151@coredump.intra.peff.net> <20100506064428.GA29360@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 09:06:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9vAY-0004En-MH
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 09:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab0EFHGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 03:06:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27344 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751171Ab0EFHGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 03:06:45 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O9vAS-0002a6-6X; Thu, 06 May 2010 09:06:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DE8401660F;
	Thu,  6 May 2010 09:06:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100506064428.GA29360@progeny.tock>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146451>

Am 5/6/2010 8:44, schrieb Jonathan Nieder:
>  test_when_finished () {
> 	test_cleanup="$* && $test_cleanup"
>  }

I'm wondering why you want this test_cleanup at all?

Is it so that subsequent tests can succeed even if an earlier test failed
before its regular cleanup?

I don't see what this buys you. If a test case uncovers a regression, you
got to fix it - who cares how many later tests fail or not? Once you are
finished with your change, all tests will pass anyway (including their
regular cleanups).

-- Hannes
