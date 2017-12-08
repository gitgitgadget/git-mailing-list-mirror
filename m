Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F9320C32
	for <e@80x24.org>; Fri,  8 Dec 2017 09:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbdLHJ4T (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 04:56:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47854 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbdLHJyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 04:54:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.21/8.16.0.21) with SMTP id vB89oO13011044;
        Fri, 8 Dec 2017 09:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=M8jUeoDIUNkedAst/y8uR1FqCLPhinEGuJakirIVYsk=;
 b=REpe2pTGpddqvwSkyj5/Z1XAmihLvxQcE7Wpit3MJOWvDXoDTgs8qD8A27uepMnLW/jM
 72ji4Lv0fW7RrzRUg26eskhvOW7y/L7xZRxG9jDpw174GjzN1w3weBL84wlCeRkGMi/R
 6K70ib4WTGv+jinf743SPHmOYftI4UKJfab/JnWYS3Z0gwMB71vn/9yX0oHoNAc7U3y/
 8cSVeXxLyJNITq8MhU0O6yDGdyK3n4rCronQTnLadOwJv8PlipgV/vYaTtXAnmrD9YZk
 0LM6dW8fI0+ebAstbbq+CVDodvg2q+vMCDXeTlc7WCXLUrx+i3wR9UQjODyWYGC3p2i8 NQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2eqrey01ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2017 09:54:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id vB89mir9017323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2017 09:48:44 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id vB89mhTp012192;
        Fri, 8 Dec 2017 09:48:44 GMT
Received: from [10.0.0.5] (/79.183.66.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Dec 2017 01:48:43 -0800
Subject: Re: Unfortunate interaction between git diff-index and fakeroot
To:     Junio C Hamano <gitster@pobox.com>
References: <0190ae30-b6c8-2a8b-b1fb-fd9d84e6dfdf@oracle.com>
 <xmqqzi6ueern.fsf@gitster.mtv.corp.google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        idan brown <idan.brown@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Eyal Moscovici <eyal.moscovici@oracle.com>,
        nikita.leshchenko@oracle.com
From:   Elazar Leibovich <elazar.leibovich@oracle.com>
Message-ID: <a770d158-c472-206f-dcdc-55cea0cf308f@oracle.com>
Date:   Fri, 8 Dec 2017 11:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi6ueern.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8738 signatures=668644
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1712080144
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/07/2017 05:31 PM, Junio C Hamano wrote:
> Correct.  fakeroot would report that the files that are actually
> owned by the user who is running fakeroot are owned by root; the
> cached stat information in the index would be "corrected" to say
> that they are owned by root.  So once the index is refreshed like
> so, things will become consistent.
I still fail to understand, what's the benefit of storing the owner ID in
the index, where no one seems to use this information.
I mean, one could store many other meta information in the index, such as
ACL lists,  number of blocks allocated, etc, but the code seems to
ignore unused information, such as commit 
2cb45e95438c113871fbbea5b4f629f9463034e7
which ignores st_dev, because it doesn't actually matter, or
commit e44794706eeb57f2ee38ed1604821aa38b8ad9d2 which ignores
mode changes not relevant to the owner.

In which situation does anyone care about the owner UID?
What's the difference between that, and, e.g., st_dev?
> If you are using "diff-index" for the "is the tree dirty?" check
> without running "update-index --refresh", then you are not using
> the command correctly.
Just want to clarify. It seems like the linux kernel is using diff-index
to do just that, in scripts/setlocalversion

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/setlocalversion#n77

Do I understand correctly that linux should update the index
first, or better, use porcelain "git diff --name-only" instead?

It seems to be the case previously, but in commit 
cdf2bc632ebc9ef512345fe8e6015edfd367e256
git update-index was removed, to prevent error messages on
read-only linux tree.

Do I understand correctly that the more correct solution
for modern git, is to use git diff --name-only instead? It should
work on read-only as well as on read-write trees, and
would not break if anyone uses git under fakeroot.

Did I understand you correctly?
