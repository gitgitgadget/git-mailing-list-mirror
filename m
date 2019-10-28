Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC261F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 11:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbfJ1LyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 07:54:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44506 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfJ1LyF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 07:54:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SBrOHU190600;
        Mon, 28 Oct 2019 11:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=eEajf5RT4wqywOOub1aSV/lmeAVUsv+I9+8MJ93dL2w=;
 b=YBxZpH1wpIPTa9ixiaROGR4mRZR9y0SXMgK4pn0zosuwgaM0ljXYqJPozvnp7tWsZgve
 +IIGvxcjgiUWCFCzDAFOb4t3s6hU7Qjqs/3hi6p4tFZ57lhkWyLWKH8/61g3aUc4ridY
 Qm546+084hXfqefY/3/shMW4tLfXHIulAZyHQFJqOwxwVTgJ2JvLjdA7+D7js+dhItDp
 43+uF2iTT9HCfsW4Q+XiitYAGc8PGpvsQf9qVnCb5pg7yLxnvcOjvD4cm7XFF4IZLspz
 hFa5P6ByxbfRd+g+cvM/jsGF8nrwFO18xwt+LtCfCrZ81J1evj/esbTEWQl/6t8V9t+n LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vve3q1fhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 11:53:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SBmox9097859;
        Mon, 28 Oct 2019 11:51:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vw09fjsqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 11:51:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9SBpfph012441;
        Mon, 28 Oct 2019 11:51:41 GMT
Received: from [10.175.8.149] (/10.175.8.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 04:51:41 -0700
Subject: Re: [RFC PATCH v2 2/3] mailinfo: collect commit metadata from mail
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20191022114518.32055-1-vegard.nossum@oracle.com>
 <20191022114518.32055-3-vegard.nossum@oracle.com>
 <20191027184449.55pk5ga4cjxaxpej@camp.crustytoothpaste.net>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <dd71ec21-5e41-1781-5d5c-f37f7f019fa7@oracle.com>
Date:   Mon, 28 Oct 2019 12:48:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027184449.55pk5ga4cjxaxpej@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/27/19 7:44 PM, brian m. carlson wrote:
> On 2019-10-22 at 11:45:17, Vegard Nossum wrote:
>> diff --git a/t/t5100/meta-meta0001 b/t/t5100/meta-meta0001
>> new file mode 100644
>> index 0000000000..1db7e9f715
>> --- /dev/null
>> +++ b/t/t5100/meta-meta0001
>> @@ -0,0 +1,23 @@
>> +commit 763f9b1cfd69ade5e22dcdcdc35d144697675a93
>> +tree 43a6b213a2891b5a863775771cab0c0dba3730dc
>> +parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
>> +author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
>> +committer Vegard Nossum <vegard.nossum@oracle.com> 1571599909 +0200
>> +gpgsig -----BEGIN PGP SIGNATURE-----
>> + Version: GnuPG v1
>> +
>> + iQIcBAABAgAGBQJdrLYmAAoJEAvO9Nj+mLpY5zIQAJkdnnZMrCVme64r43M/KMm0
>> + W1fmdeXiIMrI7i0McBdAsQ/KQ5yD4HBvaJWCyI0/g6IeLgVBf9//9xq4Y32iqsKn
>> + XRut2Pk3H3Az0WfUlpLpDJUgzz7er8t/glaKnESb94XR/ac59tEELbePh+bXsFLH
>> + 3+v8Y78zeHJd6ZLKrKmLyq/9ZaJQR+9xmGdKzZdnwM+8seE4aOhM1VtA8ik68Tn6
>> + Tbaofp1jbsXcyY4nBG9GxK14wnb/8OZmQlH4J40LsZT4KDWQNWighGig8ude7SJa
>> + 6FJXWJPLfOB6r2ThiJUnrf/UXeHbvYUWITiYoWOxEVb6c7RfNLqDbbGF9VQfTD0n
>> + SEFO5NqOs6KofaYzALprtgpMrqksRHeLc7Ouh9xgLyLZLx/669I9lo8M1aQ7RJMy
>> + V1KDG6sYbFrgy4gQ/4xqXj3NpBmMb/VcjOnCj3j040wo8q7hlpzb6ev5lcqAFEuP
>> + y1owwhljMjqAdGIBw6sLVn2on+6gEQuIjbkoapBktPDw7xEpOKe9rzTGcWRRyANs
>> + Z+pMWbn8c6TKonokNjERy0iPnu2t2j8x1YpqKdjY+oq8ApNZFMlU1U+UtXFfuLw5
>> + ZKR5DtmXxWzvd+nKBenjzXyOt33v5eq4I/WMfATauXBgFu75mbfiKIFVD5VeMfxq
>> + DoiIqvLtW+DDUkH99zXm
>> + =2APb
>> + -----END PGP SIGNATURE-----
> 
> First, let me say that I'm pleased to see this series.
> 
> It would be nice if we could use the test user and test keys, since this
> test data isn't going to work for SHA-256 and I'll need to generate
> suitable test data for this test as part of porting it.  I won't be able
> to forge a signature using your personal key.
> 
> If you wanted to generate that data yourself instead, you're welcome to
> rebase your changes onto the transition-stage-4 branch from
> https://github.com/bk2204/git.git and run the testsuite with
> GIT_TEST_DEFAULT_HASH=sha256 to see where it fails.
> 

Hi!

Thanks for the feedback.

I rebased on your branch and ran the tests without any problems.

t5100 is fine for me -- the file above is only used for testing the mail
splitting algorithm, so the choice of hashing algorithm should be
irrelevant for the test. That's also why I chose to use a personal key
for the signature, the other tests also use pregenerated emails to avoid
testing the email generation in those tests. (It could be useful to
include those "historical" test cases, which should still work in case
the format ever changes again in the future.)

The other tests generate the commits/emails within the test. Are you
sure you resolved the conflict in t4150 correctly (i.e. leaving out the
gitattributes test at the end)?


Vegard
