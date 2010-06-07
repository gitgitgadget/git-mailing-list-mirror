From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/2] commit.c - provide commit-type to the hooks/pre-commit
 script
Date: Sun, 06 Jun 2010 20:21:22 -0400
Message-ID: <4C0C3B82.3030504@gmail.com>
References: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com> <20100606221037.GE6993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 07 02:22:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLQ6v-0007Et-QH
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 02:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0FGAV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 20:21:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63830 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab0FGAV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 20:21:26 -0400
Received: by gwb15 with SMTP id 15so806816gwb.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=SM/pGI2dWjnhjWybjw0BD83peUKq/7Nqw4PKyFw3+B0=;
        b=EKbvZqnbYmgySRGEUGEVZb+ySDHsMEPwN0iDkaqkx5H1pkw9Epv0Na9XCicSRhbIEU
         ivj5payqoHCvq/q39li74JDFdYVQJfSHJOjN9sKVruEHSwrClB8gHC6qu9u7qVjazKSd
         Xywtl1JFel7JGz8eL0hQXwnfag2Bfqp52eSvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hnv3M8ECWcI/M0mRHvmbLVSDrOcQJsV4KZ+q5mcuU0OtODpubxo0KVIxzdASQ80pmE
         p8UZBUucIgSPJ3eZ7Zj6AWCfWYcYcj4WmkMaa9bEoUcCGftC5pOLiLvR9j4/zc1UkKoq
         sGHI64a68jGHQ7T0tq8JhH+cJ4sJTc4JLtHo0=
Received: by 10.229.181.138 with SMTP id by10mr1754498qcb.257.1275870084948;
        Sun, 06 Jun 2010 17:21:24 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id v12sm13296775vch.21.2010.06.06.17.21.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 17:21:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
In-Reply-To: <20100606221037.GE6993@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148564>

On 06/06/2010 06:10 PM, Jeff King wrote:
> On Sat, Jun 05, 2010 at 01:39:50PM -0400, Mark Levedahl wrote:
>
>    
>> -	if (!no_verify&&  run_hook(index_file, "pre-commit", NULL))
>> +	if (!no_verify&&  run_hook(index_file, "pre-commit", amend ? "amend" : "normal", NULL))
>> [...]
>> -	against=HEAD
>> +	if test "$1" = "amend"
>> +	then
>> +		against=HEAD~1
>> +	else
>> +		against=HEAD
>> +	fi
>>      
> Is there a reason to use the magic "amend" and "normal" words, if
> scripts are just going to end up changing them back into HEAD~1 and HEAD
> anyway?
>
> -Peff
>
>    
Well, git-gui's internal $commit_type variable has the values 
normal|amend, so I went with those. So , yes there is a reason, but 
maybe not a great one :^). Given some consensus, this is trivial to 
change. I'll let things cook a while longer before sending a new patch.

Mark
