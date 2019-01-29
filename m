Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12141F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfA2Xr1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:47:27 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:60898 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727342AbfA2Xr1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 18:47:27 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TNg2MR056044;
        Tue, 29 Jan 2019 15:47:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=t/dl1K7oO8P3hZDRlHnJO6VTwv0ufrtWnkZ43L8zEBU=;
 b=r5CRJffll/mDkZWrz2FErvzpSnAddUU2/djnJpJiUarkj6iiYnH3QanwjhpqllS+F2co
 LYpcNsPAr1wMiosrakGlSytE7ou/nCVvhCOm9kk6JCLO8opk2WSXu58a4+OU7+w/ZduM
 L3GyZjUGGgJCzKyZDRPQbvucRW5yq/1FVY6gzbT+Dzw/OYXGO36owsddffTvZ+WSydaO
 prJo4dzLW/Db8ZMTXlE79pG0C/mSOmsvGw/Am++YceTJQdK3JR8uiLTrt5hbudhixJm3
 6hoPmE1fMj1C2CMFKXtRoztEj2LvU1KRG3aC6ynCeLhXk39wg1SfiForECD6MZfafY1U xQ== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2q9832rssn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 15:47:18 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM4008Z5A2TD810@mr2-mtap-s03.rno.apple.com>; Tue,
 29 Jan 2019 15:47:18 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM400C00A2O9K00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 15:47:17 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 870e2c9ccb5cba399604c8bab4417fc4
X-Va-E-CD: 4df6244c4c4ff15bfbe305f6ad4f9707
X-Va-R-CD: f8942c0542b68b27555332fb83fef1a8
X-Va-CD: 0
X-Va-ID: 57e49c03-8d1f-4437-8e25-45617ac1501a
X-V-A:  
X-V-T-CD: 870e2c9ccb5cba399604c8bab4417fc4
X-V-E-CD: 4df6244c4c4ff15bfbe305f6ad4f9707
X-V-R-CD: f8942c0542b68b27555332fb83fef1a8
X-V-CD: 0
X-V-ID: 66878126-8dfe-4ced-8c75-f5ab86833c22
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM400900A0S0X00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 15:47:15 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_18:,, signatures=0
Received: from [17.114.130.22] (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM400M77A22HE70@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 15:46:50 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing
 git-svn
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 29 Jan 2019 15:46:07 -0800
Cc:     git@vger.kernel.org, peff@peff.net
Message-id: <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-3-jeremyhu@apple.com>
 <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_18:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 29, 2019, at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> 
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>> ---
>> t/test-lib.sh | 3 +++
>> 1 file changed, 3 insertions(+)
> 
> This obviously won't be acceptable as-is to my tree.  Shouldn't this
> be something to be dealt with in config.mak.uname or something that
> is meant to define platform-specific customization?

The issue here is that we're not locating relocatable perl modules during testing.  This is a general problem with testing RUNTIME_PREFIX configurations, and a more general solution to this sledgehammer would be appropriate.  I don't think config.mak.uname really makes sense since it's a general RUNTIME_PREFIX issue and not specifically a darwin issue.

> 
>> 
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 0f1faa24b2..4060a53f56 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1017,6 +1017,9 @@ fi
>> 
>> GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
>> export GITPERLLIB
>> +PERL_VERSION=$(grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$:\1:')
>> +PERL5LIB="$GIT_BUILD_DIR"/perl:"$(xcode-select -p)"/Library/Perl/$PERL_VERSION
>> +export PERL5LIB
>> test -d "$GIT_BUILD_DIR"/templates/blt || {
>> 	error "You haven't built things yet, have you?"
>> }

