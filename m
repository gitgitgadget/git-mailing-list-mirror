From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Thu, 30 Sep 2010 17:07:05 +0200
Message-ID: <4CA4A799.2060302@web.de>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <7v4od8ma0j.fsf@alter.siamese.dyndns.org> <4CA47478.6030207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 17:08:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Kjr-0001lm-80
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab0I3PH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 11:07:57 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:39546 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab0I3PH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 11:07:57 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id DEA26162F272C;
	Thu, 30 Sep 2010 17:07:05 +0200 (CEST)
Received: from [93.240.117.111] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P1Kiv-00011A-00; Thu, 30 Sep 2010 17:07:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CA47478.6030207@viscovery.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/BO2yn3/ATo1AqtQtRecBvnk0g79SDRTiJvuZA
	SOXa/AJJCJcDo8wjTombZwUyefDShMtMjl8eHk3NTB5+mmrZgF
	jlCiorvd4IDvlp9CLfNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157677>

Am 30.09.2010 13:28, schrieb Johannes Sixt:
> Am 9/30/2010 0:59, schrieb Junio C Hamano:
>> A few more things to think about.
>>
>> 1. What does this mean:
>>
>>     $ git grep --recursive -e frotz master next
>>
>> It recurses into the submodule commits recorded in 'master' and 'next'
>> commits in the superproject, right?
> 
> And what does it mean if you add --cached? Does it grep in the index of
> the submodules, or does it grep in the rev of the submodule that is
> recorded in the index of the supermodule?

Hmm, as you told grep to use the index of the superproject it should
use the rev of the submodule that is recorded in the index of the
superproject. Thus the "--cached" should be removed from and the
appropriate rev must be added to the arguments of the grep forked in
the submodule.
