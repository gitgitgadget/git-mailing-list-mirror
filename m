From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 17:20:09 +0200
Message-ID: <53972229.5040104@viscovery.net>
References: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com> <xmqq7g4obypt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:20:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuNqf-0000mT-HO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 17:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbaFJPUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 11:20:20 -0400
Received: from so.liwest.at ([212.33.55.14]:44272 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbaFJPUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 11:20:18 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WuNqL-0008RD-U3; Tue, 10 Jun 2014 17:20:10 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A18D016613;
	Tue, 10 Jun 2014 17:20:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqq7g4obypt.fsf@gitster.dls.corp.google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251196>

Am 6/10/2014 16:55, schrieb Junio C Hamano:
> Elia Pinto <gitter.spiros@gmail.com> writes:
> 
>> @@ -832,7 +832,7 @@ Maybe you want to use 'update --init'?")"
>>  			continue
>>  		fi
>>  
>> -		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>> +		if ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
> 
> Which part of test conditions does that "!" apply in the original,
> and in the updated? 
> 
> I think the new test after || also needs negation, no?

Not just that; the || must be turned into && as well.

I noticed a similar construct later in the patch in a review of an earlier
iteration, but missed this one.

-- Hannes
