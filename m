Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF7C1F405
	for <e@80x24.org>; Sat, 29 Dec 2018 17:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeL2Ryw (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 12:54:52 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:34885 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeL2Ryv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 12:54:51 -0500
Received: from [192.168.1.12] ([92.29.14.72])
        by smtp.talktalk.net with SMTP
        id dIoygRg1xoI6LdIoygC8jh; Sat, 29 Dec 2018 17:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1546106088;
        bh=/qqdPi/4U9C1usTg4dt5Xr7HpiGpn1b9sFPPSvuGYag=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To;
        b=C0efNu8590Q0Bm4uK3QRPTKIkRCpHH+FVTZleu+5QLxkbtgVwIf8C9xpaHM8eth1h
         q6EuwjL7KG8RoKdYShgfiju09usjdN6IQNsmDKSuTjNy0jalIEyJbDOOZRfBY2yyUi
         4fpwXonvCmkTuyH5AzCAqCW8LmZidv6/6srlcsoA=
X-Originating-IP: [92.29.14.72]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=U7W/PrDwRYoztbkIcndy/g==:117
 a=U7W/PrDwRYoztbkIcndy/g==:17 a=IkcTkHD0fZMA:10 a=UlqV6C1OAAAA:20
 a=UyraoAtndU2R4cPIn8QA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH/RFC v1 1/1] Support working-tree-encoding "UTF-16LE-BOM"
To:     =?UTF-8?Q?Adri=c3=a1n_Gimeno_Balaguer?= <adrigibal@gmail.com>,
        tboegi@web.de, git@vger.kernel.org
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181229110924.26598-1-tboegi@web.de>
 <CADN+U_OccLuLN7_0rjikDgLT+Zvt8hka-=xsnVVLJORjYzP78Q@mail.gmail.com>
 <CADN+U_Mo4Ui-rmZe1+xoHOMA4koXGNpJ5XEGYoYZfYPGqP9VPQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <27bb049b-265f-7fec-06ef-5e8e29c2d7f7@talktalk.net>
Date:   Sat, 29 Dec 2018 17:54:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CADN+U_Mo4Ui-rmZe1+xoHOMA4koXGNpJ5XEGYoYZfYPGqP9VPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEdstjQSeuF07nFlluAmbPcCPXgJpvVR2p1RFn8A4l4/kPw595fw6U05RjeU2dl/A4OyTPnLxux3TJ4AmN0Kk8hLLLa33oWtYTZJN+qzRdnIlhYIFhoQ
 0MfGakvXNJOpmlgyXB/p1FdvANgoevu3Up7Jamur9GKdRHWYJ7ucaGDNTvVo+54XUCnIrBvHPl1Giyxnmb/+b86qYEKhir+kBaVHa0VdD6sN331dRl0GTk5z
 FsRxjYBcFnq4fSF5plgtlvqoEcdQtYkPcn1YR2ACDZM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(adding Brian as cc who was in the original thread)

On 29/12/2018 15:48, Adrián Gimeno Balaguer wrote:
> Hello again.
> 
> I appreciate the grown interest in this issue.
> 
> Torsten, may I know what is the benefit on your code? My PR solved it
> by only tweaking the utf8.c's function 'has_prohibited_utf_bom', which
> is likely the shortest way:
> 
> https://github.com/git/git/pull/550/files

My main complaint with the PR would be the lack of documentation updates.

As the discussion has highlighted, whatever our solution, we will need 
to tell the users in plain and simple terms which parts of which 
standards are being used, and why we need to be somehow 'different'.

That is because a revision control system must be able to recover the 
original, for use in the original software tool, not just interpret it 
is some alternate form. The standards generally abdicate responsibility 
for the last step ;-)

I did not fully understand the conversion process you proposed, as I 
assumed(?) that on receipt of the source file, the Git conversion to 
utf-8 would convert the 16-bit BOM to the three byte utf-8 BOM byte 
sequence `EF BB BF` which has lost any knowledge of the original BE/LE 
coding.

Or, are we saying that the the 16-bit BOM is being interpreted as, a) 
the BE/LE indicator and b) a genuine "ZERO WIDTH NON-BREAKING SPACE" 
which is stored as the two byte utf-8 character code, again loosing 
(once stored as a blob object) the BE/LE indication.

Or, we see the BOM, note the endianness and then loose the BOM character 
when converting to utf-8. My ignorance of this step is starting to show. 
Regular users are probably even more confused, hence my hope for some 
documentation.

Given the above confusions, and many more when exploring the internet, 
the provision of a new, extra, clear, name for the encoding, as 
suggested by Torsten does offer an advantage in that it explicitly 
(rather than implicitly) makes plain what we are trying to do, without 
squeezing it in 'under the radar'.

That said, assuming an appropriate internal utf-8 Git coding that does 
remember the BE/LE state [if so how?] then the PR is a neat trick.

Torsten's patch also suffers from the lack of user facing documentation.

> 
> In order to make sure everything is clear, here is a case list of
> current Git behaviour and new one after my PR, regarding this issue.
> 
> Current behaviour:
> 
> - Placing 'test.txt working-tree-encoding=UTF-16' for a new test.txt
> file with either UTF-16 BE or LE BOM, and comitting everything -> The
> file gets re-encoded from UTF-8 (as stored internally), to UTF-16 and
> the default system/libiconv endianness -> Problem (as long as user
> required the opposite endianness for any reason on his project). As a
> note, user can see however human-readable diffs on that file.
> 
> - Placing  'test.txt working-tree-encoding=UTF-16LE' or 'test.txt
> working-tree-encoding=UTF-16BE' for a new test.txt file with either
> UTF-16 BE or LE BOM, and comitting everything: we assume user is doing
> this because he requires that exact endianness, thus he writes it in
> order to attempt preserving it -> Git prohibites commiting it, also no
> human-readable diff is shown in the diff viewer/tool being used, but
> file is simply shown as binary.
> 
> New behaviour:
> 
> -  Just got too lazy to repeat it all over, read my PR description:
> https://github.com/git/git/pull/550

"In this PR: Git only prohibites the opposite BOM than the one in 
working-tree-encoding (e.g. if declared LE, then it denies BE BOM 
presence within the associated file, of the declared UTF-16/UTF-32). 
This way the user can now make Git operations which were previously 
impossible, with the only requisite being to match the endianness of 
working-tree-encoding attribute with the associated file/s."

> 
> - Git translations may need to be tweaked to in order to be consistent
> with new behaviour.
> 
> Thanks for your attention.
> 
-- 
Philip
