Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F53202A7
	for <e@80x24.org>; Thu,  6 Jul 2017 09:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdGFJUP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 05:20:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51620 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdGFJUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 05:20:13 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0M1Fnc-1diexr38um-00tDJw; Thu, 06 Jul 2017 11:20:07 +0200
Subject: Re: [PATCH] t5534: fix misleading grep invocation
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <936f43ce2c993e545deaee5e196c018933375214.1499254650.git.johannes.schindelin@gmx.de>
 <xmqq1spukfyw.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <22feab0a-ca75-2aea-1ec9-2f71fe40c9d0@grubix.eu>
Date:   Thu, 6 Jul 2017 11:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq1spukfyw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:NvtBE0ErzSDruIzbmFG5wg22q4r7NIKb4wJjAbJK/cw3mYI/q8U
 6ptY9IuEhXyk7+A4qytndA3wLPqkGOZ3i9XhM06rBd6ppe/lYy31dESlOe9FcDfUIafS7Sx
 hrunpc4xXQBT3SeeYizzcz3++fiewFeoyyvZFsftAt7M9WKsjkI5hEIxHEusbiHfu+NsrPb
 G+1f7hLXsAw+4nnmzTNeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VigLFgB9yrk=:vie5nCF1OniZsU5tHlQR5Y
 M8pgqgFXIwt8SRWvwaEC8fGeIYgTy+qKPGQo16fvoJC3dnMUM/SJvHW+E/tUazUZWS3noBTFq
 m4I4zA5VsCl/9QIUqJkNQIB0ANFRpb8S3NQ3MBwlQSIryQEwRrUxj4N1a4963c7Cajy46iHmr
 RzStY30PKt0xBgWBBZQLRL1DuvqScY45zlqlDiVBOq0tOqw9II8k4obHLvIcLfWJAPPVxJcXF
 VEpch9rAMZPJC9FFCf/PwpGEhr4d2jQ/nSBL2B88flzFu5l5tpjGzijDWzFUDPKYN9yhHjZwu
 BSl6OUQYBknAEZ76bj6sJNqe+WU0x88N/IPbZf8ipG7HcD4CZqTgTlBVODiTOy1HJ1J8cw+79
 7RJ9OMv5BqChWiaa8FL3+zKiF+8wjNdlLulmgSwx2uG8TWk39X3zpmWSnQMaM2ki8KPJzauk4
 zQNuxxKdALjSHAVUa0UEjfZ/dp7LujKP5wjj03x9Js9V7RKwsAL5ZRv5vgUnPz1U92T+5ecvp
 cBI4iGanAMyxphUVrzShfwZE338GPX70KvYLg8cEQLapWtrmN/92uNWK15mn+X59XM42ImHKE
 XJfUpBvlfeLw97vLsynaPDK9Tfvz5qMJIbFm6kup4ro/fVs2MDOYiR+IK24Yvek4JOoraRf01
 pTh5T+9khosNJiWwVGrDUzeG1TkwrDi27LL3tvbOIEv9Zsbziicx4+mEE7lYZ/U3cX+0vhFjJ
 FTLqRwHqU65gh68Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 05.07.2017 18:26:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> It seems to be a little-known feature of `grep` (and it certainly came
>> as a surprise to this here developer who believed to know the Unix tools
>> pretty well) that multiple patterns can be passed in the same
>> command-line argument simply by separating them by newlines. Watch, and
>> learn:
>>
>> 	$ printf '1\n2\n3\n' | grep "$(printf '1\n3\n')"
>> 	1
>> 	3
>>
>> That behavior also extends to patterns passed via `-e`, and it is not
>> modified by passing the option `-E` (but trying this with -P issues the
>> error "grep: the -P option only supports a single pattern").
>>
>> It seems that there are more old Unix hands who are surprised by this
>> behavior, as grep invocations of the form
>>
>> 	grep "$(git rev-parse A B) C" file
>>
>> were introduced in a85b377d041 (push: the beginning of "git push
>> --signed", 2014-09-12), and later faithfully copy-edited in b9459019bbb
>> (push: heed user.signingkey for signed pushes, 2014-10-22).
>>
>> Please note that the output of `git rev-parse A B` separates the object
>> IDs via *newlines*, not via spaces, and those newlines are preserved
>> because the interpolation is enclosed in double quotes.
>>
>> As a consequence, these tests try to validate that the file contains
>> either A's object ID, or B's object ID followed by C, or both. Clearly,
>> however, what the test wanted to see is that there is a line that
>> contains all of them.
>>
>> This is clearly unintended, and the grep invocations in question really
>> match too many lines.
>>
>> Fix the test by avoiding the newlines in the patterns.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
> 
> The invocation this fixes is not just misleading but simply wrong.
> Nicely spotted.

In addition, the patch makes sure to catch any rev-parse failures which
the original invocation shove under the rug.

> Thanks, will queue.

Thanks from the faithful copy-editor ;)

How did you spot this? Are there grep versions that behave differently?

>>  t/t5534-push-signed.sh | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
>> index 5bcb288f5c4..464ffdd147a 100755
>> --- a/t/t5534-push-signed.sh
>> +++ b/t/t5534-push-signed.sh
>> @@ -119,8 +119,11 @@ test_expect_success GPG 'signed push sends push certificate' '
>>  		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
>>  	) >expect &&
>>  
>> -	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
>> -	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
>> +	noop=$(git rev-parse noop) &&
>> +	ff=$(git rev-parse ff) &&
>> +	noff=$(git rev-parse noff) &&
>> +	grep "$noop $ff refs/heads/ff" dst/push-cert &&
>> +	grep "$noop $noff refs/heads/noff" dst/push-cert &&
>>  	test_cmp expect dst/push-cert-status
>>  '
>>  
>> @@ -200,8 +203,11 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
>>  		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
>>  	) >expect &&
>>  
>> -	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
>> -	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
>> +	noop=$(git rev-parse noop) &&
>> +	ff=$(git rev-parse ff) &&
>> +	noff=$(git rev-parse noff) &&
>> +	grep "$noop $ff refs/heads/ff" dst/push-cert &&
>> +	grep "$noop $noff refs/heads/noff" dst/push-cert &&
>>  	test_cmp expect dst/push-cert-status
>>  '
>>  
>>
>> base-commit: 5116f791c12dda6b6c22fa85b600a8e30dfa168a
