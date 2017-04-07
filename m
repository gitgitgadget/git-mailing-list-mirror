Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA9720966
	for <e@80x24.org>; Fri,  7 Apr 2017 14:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933390AbdDGOOf (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 10:14:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933344AbdDGOOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 10:14:32 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0Lxrpw-1c08mt1AO4-015Kjg; Fri, 07 Apr 2017 16:14:27 +0200
Subject: Re: [PATCH] status: show in-progress info for short status
To:     Junio C Hamano <gitster@pobox.com>
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
 <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <1389252d-c744-b389-85c5-fb19e984048f@grubix.eu>
Date:   Fri, 7 Apr 2017 16:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8fbtTgVROe7j3T1hN9xsLdEOrTZ+TGE0we2RVcnZG5jCKY/GmuW
 lqj0tZf3kxDOBYN1vaRMckkWTQ3I8Vg40xsfva1F522U07YG5M9P/gW4otD2QvujW37D80+
 hCBEfbq1g2ltw7bqlaIXPCU6i1CuzxfYPYsyKa0otK+j+jpkbMux32DfRY3Qg+Xq/wr5jbc
 xvIDnNUd4pqCIaxkUx76A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VtH5mN0JTco=:mHL7QZN+NFMedoO3cBXFTv
 Mhwhcp+a+aG3oypA3pJwdnPJSJYU0m3e2IesoeMt8gCpyYtNrwxHRSGtmeLu5SYy2KaGfPbO9
 F2oG1ycV1FIqbP46b2PcDmovvcwKd01ZA5L/gTwliROxNqfX/0W25DXYnRiXtnGzFb/MXGKOQ
 lEHkHw4t81Ptw58JqTMcV1Yam3AsovnXBHEL3VkY7+ZVAqERQQ28pDFPSUrmDUPoEUDhK7z2S
 PgjGYvW01MEyGsrNLllwVEL5HaRvxQGUTBzoexYFwEgO1gYP87YIU/gkAwD6wem8I9C6d767w
 sHzZDASRT4pztChePVhXO7FoC1yWLHupk/KngdzkjHPA3em1oj5YhdUi9ohOmSGcZNcHtP7SI
 IxfRzoHjltNwk1AEQClS2f8vSuxlXnpO5AZoJaWOUj+ohImiNkW6Xm+eFFBNdcQt4o5bFHg93
 Pxh/7dGfwwRMvDGUU4SC4UZCK4aZlOa8hgnQSyrytqyEAzjWhrlC6re7d+1NrcTMmXxA2ZRXK
 LzTEHNSdW9g+a++CoaNDL2g1dbEFFU4Bx3WXU588oUaaIEzYUjeEpKcv2EqIqgQGC+GHrdd1h
 cvk5kmAGZkShsDvsVZYR15zpsWFt2VSwq4cc/T/U9BfQD4cQNKl8TMjx/Aoxny2nJ298GtNVo
 T5hSwJswPjj1kX+fNsQh25S/bF7zy/sZ5DJ7HCXZuBIWVMzx+T5Ufp+NCREngFjpPakad45/R
 UhC8wJcLLHbyQJO9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 31.03.2017 20:14:
> Michael J Gruber <git@grubix.eu> writes:
> 
>> Ordinary (long) status shows information about bisect, revert, am,
>> rebase, cherry-pick in progress, and so does git-prompt.sh. status
>> --short currently shows none of this information.
>>
>> Introduce an `--inprogress` argument to git status so that, when used with
>> `--short --branch`, in-progress information is shown next to the branch
>> information. Just like `--branch`, this comes with a config option.
>>
>> The wording for the in-progress information is taken over from
>> git-prompt.sh.
>>
>> Signed-off-by: Michael J Gruber <git@grubix.eu>
> 
> I haven't formed an opinion on the feature itself, or the way it is
> triggered, so I won't comment on them.  I just say --porcelain (any
> version) may (or may not) want to be extended in backward compatible
> way (but again I haven't formed an opinion on the issue--I just know
> and say there is an issue there that needs to be considered at this
> point).

With my change, "git status --porcelain" output does not change at all
(and neither does that of "git status --short"). They change only when
"--inprogress" (and "--branch") is requested, just like with "--branch".

I don't know the v2 format - it seems that it's built to be extensible,
but I have not checked whether that#s documented somewhere, and I didn't
change it anyways.

>> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
>> index 458608cc1e..103e006249 100755
>> --- a/t/t7512-status-help.sh
>> +++ b/t/t7512-status-help.sh
>> @@ -74,7 +74,6 @@ test_expect_success 'prepare for rebase conflicts' '
>>  
>>  
>>  test_expect_success 'status when rebase in progress before resolving conflicts' '
>> -	test_when_finished "git rebase --abort" &&
>>  	ONTO=$(git rev-parse --short HEAD^^) &&
>>  	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
>>  	cat >expected <<EOF &&
>> @@ -96,6 +95,15 @@ EOF
>>  	test_i18ncmp expected actual
>>  '
>>  
>> +test_expect_success 'short status when rebase in progress' '
>> +	test_when_finished "git rebase --abort" &&
>> +	cat >expected <<EOF &&
>> +## HEAD (no branch); REBASE-m
>> +UU main.txt
>> +EOF
>> +	git status --untracked-files=no --short --branch --inprogress >actual &&
>> +	test_i18ncmp expected actual
>> +'
> 
> This is not a good way to structure the test.  If the one in the
> previous hunk is what creates a conflicted state by running
> "rebase", check the status output from within that test, after the
> conflicting "rebase" fails and other things the existing test checks
> are tested.  That way, you do not have to worry about this new check
> getting confused if the previous one fails in the middle.
> 
> Likewise for the most (if not all---I didn't check very carefully)
> of the remaining hunks in this test script.

All followed the same structure. I did it that way so that it's clearer
which test is failing, but I don't mind putting things together as you
describe. Most of the time, one has to check where in the &&-chain a
test failed, anyways.

Michael
