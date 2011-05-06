From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Fri, 06 May 2011 11:14:19 +0200
Message-ID: <4DC3BBEB.1050502@drmicha.warpmail.net>
References: <20110505191027.GA3242@camk.edu.pl> <7vsjss6hmf.fsf@alter.siamese.dyndns.org> <4DC3A685.4080300@drmicha.warpmail.net> <20110506085107.GB3719@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri May 06 11:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIH7E-0002xE-OM
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 11:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab1EFJOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 05:14:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45229 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755344Ab1EFJOW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 05:14:22 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 244FE208C1;
	Fri,  6 May 2011 05:14:21 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 06 May 2011 05:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=f/HwBqS3I/jpOwJC0fxb4RDLqOw=; b=f2Gv3xZrpC8OqHeX5I+nHmKZhsn2hQ9V85H7kF+IMIJsid6PnwiNwvm2qaX4OgAujA4ngthwEM2DTgUy33KEbO6OhNhpupE50UIfB2kgHS7dlvPPDLpMiaaIqpNjxHYjmqDhtryDLKUN+ldkS5GzqFqioa/V+y7gjS2CUvfLBAU=
X-Sasl-enc: zJQNFKS0mY6Qc4wEep9BjegIgbcpeZKiLK05FVULAHWX 1304673260
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8274B40C0A2;
	Fri,  6 May 2011 05:14:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110506085107.GB3719@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172961>

Kacper Kornet venit, vidit, dixit 06.05.2011 10:51:
> On Fri, May 06, 2011 at 09:43:01AM +0200, Michael J Gruber wrote:
>> Junio C Hamano venit, vidit, dixit 05.05.2011 22:02:
>>> Kacper Kornet <draenog@pld-linux.org> writes:
>>>> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
>>>> ---
>>>>  t/t1506-rev-parse-diagnosis.sh |    4 ++--
>>>>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
>>>> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
>>>> index 4a6396f..bad09f9 100755
>>>> --- a/t/t1506-rev-parse-diagnosis.sh
>>>> +++ b/t/t1506-rev-parse-diagnosis.sh
>>>> @@ -8,8 +8,8 @@ exec </dev/null
> 
>>>>  test_did_you_mean ()
>>>>  {
>>>> -	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
>>>> -	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
>>>> +	printf "fatal: Path '$2$3' $4, but not ${5:-\'$3\'}.\n" >expected &&
>>>> +	printf "Did you mean '$1:$2$3'${2:+ aka \'$1:./$3\'}?\n" >>expected &&
>>>>  	test_cmp expected error
>>>>  }
> 
>>>> -- 
>>>> 1.7.5
> 
>>> [Reference]
> 
>>> *1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
> 
>> Other than that, I have no objections if this patch makes more shells
>> happy and no happy ones unhappy.
> 
>> Is your ksh OK with all other tests?
> 
> Yes. The only other patch which is applied during our building process
> is: 
> 
> diff -ur git-1.7.0.3.orig/t/t1304-default-acl.sh
> git-1.7.0.3/t/t1304-default-acl
> .sh
> --- git-1.7.0.3.orig/t/t1304-default-acl.sh     2010-03-22
> 01:35:03.000000000 +0
> 000
> +++ git-1.7.0.3/t/t1304-default-acl.sh  2010-03-23 19:53:49.069813289
> +0000
> @@ -9,6 +9,8 @@
>  # => this must come before . ./test-lib.sh
>  umask 077
> 
> +LOGNAME=$(whoami)
> +
>  . ./test-lib.sh
> 
>  # We need an arbitrary other user give permission to using ACLs. root
> 
> 
> But it is specific to our build environment.
> 

Thanks for the info (and for responding despite my botched to/cc).

In a different context I noticed that systems don't agree wrt. the
presence of USER/USERNAME/LOGNAME in the environment. We use LOGNAME in
t1304 only (and never USER nor USERNAME), but still we might want to do
something like

LOGNAME=${LOGNAME:-$USERNAME}
LOGNAME=${LOGNAME:-$USER}
LOGNAME=${LOGNAME:-$(whoami)}

there, or simpler with ${LOGNAME:=...}, although I don't know what to
take for granted.

Michael
