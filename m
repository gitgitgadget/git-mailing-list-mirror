Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48EC41F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437047AbfJRQve (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:51:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408813AbfJRQve (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 12:51:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IGn7mY049343;
        Fri, 18 Oct 2019 16:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=O7V4elaNIbSH0wKYSAOUn9HVaqwPB2Utmp8F+rA0ti0=;
 b=XjxQLBK9EU0uUAHSKorhS24mZ6D881ENgja4NfiQRf1rv6HmPhJZhmApQP/VPpTiOof2
 w0SH3QiIq7HhvxD/Ek8a7nd13eBb0u5pYrYmVbGefcf+AVM8X6qRhyjtbKAzgwb02wGH
 DPfuww4W5VhwQ9pqLT0UIgQRkEURQYRR7a35vh/EyFuEaUhNNZm3fSIS1f7qAokoJce4
 FDVrYJqM0QfjPoxkClgMGOn0SyXsX4/pAElObOKhn6b+5bej8bWztQRvbm24iCStZni5
 z5Fl3S9LJd7y7ihexBOkPjGjXHb1dsW48gHCPWukhGE/CX9Pfnpfs0rwebK5cvjdSbcc 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vq0q4515t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 16:51:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IGmF62092320;
        Fri, 18 Oct 2019 16:51:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vq0ewsp0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 16:51:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9IGoxLx011321;
        Fri, 18 Oct 2019 16:50:59 GMT
Received: from [10.175.21.59] (/10.175.21.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 16:50:59 +0000
Subject: Re: email as a bona fide git transport
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018161547.GG21137@mit.edu>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <de49fe5e-85cb-9fb0-f9f4-c294d72e356c@oracle.com>
Date:   Fri, 18 Oct 2019 18:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018161547.GG21137@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180153
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/18/19 6:15 PM, Theodore Y. Ts'o wrote:
> On Fri, Oct 18, 2019 at 04:27:48PM +0200, Vegard Nossum wrote:
>> commit ac30b08065cd55362a7244a3bbc8df3563cefaaa
>> tree 8f09d9d6ed78f8617b2fe54fe9712990ba808546
>> parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
>> author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
>> committer Vegard Nossum <vegard.nossum@oracle.com> 1571408340 +0200
>> gpgsig -----BEGIN PGP SIGNATURE-----
> 	...
> 
> Would it perhaps be possible to put some or all of these headers after
> the patch, as a set of "trailers"?  That would make it easier for
> human readers of the e-mail to get the bits that they most care
> about.... namely, the patch itself.  :-)
> 

Yes, agreed.

I started out using this approach, but I changed it because the
implementation was a bit annoying: 'git am' runs 'git mailsplit',
which just splits the email into two parts:

1) headers, changelog, and diffstat;
2) diff and signature.

One of my PoC patches changes mailsplit to split the extra metadata into
a third file.

The problem I ran into with putting the metadata at the end was
detecting where the diff ends. A comment in 'git apply' suggested that
detecting the difference between "--" as a diff/signature separator and
as part of the diff is nontrivial in the sense that you need to actually
do some parsing and keep track of hunk sizes.

I can try to put it at the end, but maybe the git people have some hints
that would make the implementation easier? Is it okay to reimplement a
simple diff parser in mailsplit?

Thanks,


Vegard
