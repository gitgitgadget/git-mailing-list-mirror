Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BA31FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 08:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbcLLIyZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 03:54:25 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:52695 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932185AbcLLIyY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 03:54:24 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 7A7FAC3442;
        Mon, 12 Dec 2016 09:54:21 +0100 (CET)
Received: from mx1.2b3w.ch (dilbert.2b3w.ch [92.42.186.250])
        by mx1.2b3w.ch (Postfix) with ESMTPA id 55735C33DD;
        Mon, 12 Dec 2016 09:54:21 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 12 Dec 2016 09:54:21 +0100
From:   Beat Bolli <dev+git@drbeat.li>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] =?UTF-8?Q?update=5Funicode=2Esh=3A=20update=20the?=
 =?UTF-8?Q?=20uniset=20repo=20if=20it=20exists?=
In-Reply-To: <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
 <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
Message-ID: <c96d013c38df7737cfd551a0fce87314@drbeat.li>
X-Sender: dev+git@drbeat.li
User-Agent: Roundcube Webmail/0.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-12 06:53, Torsten Bögershausen wrote:
> On 2016-12-12 00:34, Beat Bolli wrote:
>> We need to track the new commits in uniset, otherwise their and our 
>> code
>> get out of sync.
>> 
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>> 
>> Junio, these go on top of my bb/unicode-9.0 branch, please.
>> 
>> Thanks!
>> 
>>  update_unicode.sh | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/update_unicode.sh b/update_unicode.sh
>> index 4c1ec8d..9ca7d8b 100755
>> --- a/update_unicode.sh
>> +++ b/update_unicode.sh
>> @@ -14,6 +14,11 @@ fi &&
>>  		http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
>>  	if ! test -d uniset; then
>>  		git clone https://github.com/depp/uniset.git
>> +	else
>> +	(
>> +		cd uniset &&
>> +		git pull
> If upstream has accepted your patches, that's nice.
> 
> Minor question, especially to the next commit:
> Should we make sure to checkout the exact version, which has been 
> tested?
> In this case  cb97792880625e24a9f581412d03659091a0e54f
> 
> And this is for both a fresh clone and the git pull
> needs to be replaced by
> git fetch && git checkout cb97792880625e24a9f581412d03659091a0e54f
> 
> 
> (Which of course is a shell variable)

I was actually wondering what the policy was for adding submodules to 
the Git repo,
but then decided against it. Another option would be to fork uniset on 
GitHub and
just let it stay on a working commit.

Junio, what's your stance on this?

Beat
