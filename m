From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Tue, 03 Mar 2015 16:51:05 +0100
Message-ID: <54F5D869.4010104@drmicha.warpmail.net>
References: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu> <xmqq385nb2yg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:51:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSp6I-0002lB-20
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 16:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbbCCPvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 10:51:09 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49899 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756646AbbCCPvH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 10:51:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2D9B220AC8
	for <git@vger.kernel.org>; Tue,  3 Mar 2015 10:51:06 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 03 Mar 2015 10:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=35vMyUNPh7K9i/7uhdsJtw
	TLMCM=; b=KfpfetixXnh/uRixLyAgI8LaX2LdD+jNEtmMhaH24x6rXvn55E2rgm
	gDilHrQ0vGtfk3eDmIx1wIDEFyLdMT6RbukCLThTB4TGMzKba0hBeAxmvLE2wKsQ
	oCSoE+odTtezt0T1UXGBMVMc9C67HqAwXzen92jcPa49QcfkTNES8=
X-Sasl-enc: WOh0Gcejl7SLpEmyhYUO9H47rdBg1clPFxiF/2NtedzE 1425397867
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A833C680158;
	Tue,  3 Mar 2015 10:51:06 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq385nb2yg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264665>

Junio C Hamano venit, vidit, dixit 02.03.2015 20:43:
> Anders Kaseorg <andersk@mit.edu> writes:
> 
>> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
>> ---
>>  t/t5516-fetch-push.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 85c7fec..594d7a6 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -238,7 +238,7 @@ test_expect_success 'push with pushInsteadOf' '
>>  test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
>>  	mk_empty testrepo &&
>>  	test_config "url.trash2/.pushInsteadOf" testrepo/ &&
>> -	test_config "url.trash3/.pusnInsteadOf" trash/wrong &&
>> +	test_config "url.trash3/.pushInsteadOf" trash/wrong &&
>>  	test_config remote.r.url trash/wrong &&
>>  	test_config remote.r.pushurl "testrepo/" &&
>>  	git push r refs/heads/master:refs/remotes/origin/master &&
> 
> Interesting.
> 
> Now an obvious and natural question after seeing this change is how
> the original test passed with misspelled configuration.  Is a test
> that pushes into "trash/wrong" checking the right outcome?  If the
> reason why the existing tests passed without this patch is because
> they do not test the right thing, then shouldn't they be corrected
> together with the above fix?
> 

Ha, I was look there, too, just today and was wondering the same.

I guess the test wanted to make sure (among other things) that
url.trash3/.pushInsteadOf does not affect the push to remote r (which
has an explicit pushurl)...

Michael
