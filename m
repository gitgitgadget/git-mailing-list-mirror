From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/6] parse-options: sanity check PARSE_OPT_NOARG flag
Date: Thu, 02 Dec 2010 23:35:35 -0800
Message-ID: <4CF89DC7.2050806@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com> <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino> <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino> <20101024081316.GA29630@burratino> <20101130025223.GA5326@burratino> <20101130025551.GB5326@burratino> <4CF4B21B.5030401@gmail.com> <7v7hftt7vy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTg==?= =?UTF-8?B?Z+G7jWMgRHV5?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 08:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQBw-00006L-UH
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 08:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab0LCHgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 02:36:23 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45127 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab0LCHgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 02:36:22 -0500
Received: by qwb7 with SMTP id 7so9296794qwb.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 23:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=O1Su1EUDbrpTG9G26tCPkkyc0emKKFOszFYCtvBOg40=;
        b=atu5GaFycawPecZKx/oqnbxOIXroqwA7v1OkXiWljf5v+AIKA/KWeCV9kV7uqCNSRO
         3MsYFp2VeKZGofuMe2nsh1r5JPlkSokB/S7ziqpaQzOkK7TDjuwfegJIQpYVdg7ND/k/
         WeYdsp10krBrSH+aG5nNcyHprFoSIA/eUimfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EAYCH25b8KaP0wozBSRR0XjHzvMnyBHfwA61goALJ2c8uYB9mk+X5tECbqQxv8qsY3
         fiUAIlY+fLZ2nFEtOcAe16YH0Q+avjIDP6NFf9CjftoGXhSVr5uY/b5gaEEf+fHkmV7v
         33OAzKHetf0o0Mav/Auka+wDs90rwsuqOalBU=
Received: by 10.224.67.212 with SMTP id s20mr969610qai.118.1291361781586;
        Thu, 02 Dec 2010 23:36:21 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id s34sm1026860qcp.44.2010.12.02.23.35.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 23:36:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7v7hftt7vy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162764>

On 12/01/10 15:01, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
> 
>> Looks like parse_options_check() is being called for each
>> parse_options_step(). Here's a patch to fix that. Junio, this can
>> probably be applied to maint.
> 
> Looks correct, but why is it a maint material?
> 

Possible performance regression? Which is why its qualified with probably.
