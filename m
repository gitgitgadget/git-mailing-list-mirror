Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C02E1F462
	for <e@80x24.org>; Tue, 28 May 2019 14:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfE1OJ0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 10:09:26 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:62847 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1OJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 10:09:25 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id Vcn4hgYfRniZTVcn4h4nWG; Tue, 28 May 2019 15:09:22 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=aulWLQ49AAAA:20 a=bt3WUTiwAAAA:8
 a=B3W9N2MpwPy2nFnYWPgA:9 a=QEXdDO2ut3YA:10 a=_Qo28uX402cA:10
 a=xts0dhWdiJbonKbuqhAr:22 a=OXx4ngWzwLx9h_IvVXMu:22
Subject: Re: [PATCH] compat/vcbuild/README: clean/update 'vcpkg' env for
 Visual Studio updates
To:     Jeff Hostetler <git@jeffhostetler.com>,
        GitList <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190528120846.1056-1-philipoakley@iee.org>
 <a48d5f62-081a-de14-5dbb-4726908a4179@jeffhostetler.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <dbf74f4d-b63c-53f2-dbce-009da34d1050@iee.org>
Date:   Tue, 28 May 2019 15:09:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a48d5f62-081a-de14-5dbb-4726908a4179@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfMNpW35Bv9BtpRYmdKyqDnCOz25+T6ZgzLEdQs55fBv9haHJLLZoI2lSaOWpF6zCMjGveYlFebdXoyhAWSVS4HGys0mnuatxKcn0yXlum+qdVSU2DULs
 J1Wg1FP4R1dkLXG4ngqduuOqCLkJ4oRcb30fc4nsgIntgvIhtqvDZ9SpaKbD2f9VOkQbfptzPMpZpMDrAAbScgYbbaAsR3sy7dDymysAcPPOFG5S3msmU927
 nGzM9+sJdNed75itnzTXyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On 28/05/2019 14:56, Jeff Hostetler wrote:
> On 5/28/2019 8:08 AM, Philip Oakley wrote:
>> When the user installs an updated version of Visual Studio, the 
>> previously
>> generated MSVC-DEFS-GEN will need to be deleted to allow updating.
>>
>> Alternatively the whole vcpkg download may be cleaned allowing it to be
>> reloaded, though this may take much longer on slower connections.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>
>> In response to discussions at:
>> https://github.com/git-for-windows/git/issues/2186
>>
>> cc: Jeff Hostetler <git@jeffhostetler.com>
>> cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>
>>   compat/vcbuild/README | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
>> index 81da36a93b..40695fc1cc 100644
>> --- a/compat/vcbuild/README
>> +++ b/compat/vcbuild/README
>> @@ -18,6 +18,13 @@ The Steps to Build Git with VS2015 or VS2017 from 
>> the command line.
>>      Makefile:
>>         <repo_root>/compat/vcbuild/MSVC-DEFS-GEN
>>   +   - If you update your Visual Studio version, then delete the 
>> MSVC-DEFS-GEN
>> +   file so that fresh environment variables can be discovered.
>> +
>> +   Or clean the "vcpkg" environment with:
>> +
>> +   $ make MSVC=1 clean
>> +
>>   2. OPTIONALLY copy the third-party *.dll and *.pdb files into the repo
>>      root to make it easier to run and debug git.exe without having to
>>      manipulate your PATH.  This is especially true for debug 
>> sessions in
>>
>
> Did you mean to send this upstream or to Git for Windows?
>
> I didn't think that the VS2015/VS2017 vcpkg-aware version of
> compat/vcbuild/* had made it upstream yet, so this patch might not
> apply upstream.
Ah, that would be my mistake.
>
>
> BTW, the Makefile (when MSVC=1 is defined) will take care of deleting
> the MSVC-DEFS-GEN, so all we really need to say here is to do:
>
>     $ make MSVC=1 clean
> or  $ make MSVC=1 DEBUG=1 clean
>
> after upgrading to a new version of VS.
It (my suggestion) was the difference between a deep clean of all the 
1.05GB of vcpkg files, vs  the 847 bytes of just the MSVC-DEFS-GEN file 
that was a concern.

The need to repeat the download of 1GB just because of a VS version 
change felt a bit excessive, hence the initial suggestion.
>
> Jeff
>
> PS. I have a TODO item to fix the Makefile to automatically detect
> and take care of this.
Thanks.
IIUC download of the vcpkg files are separate from the generation of the 
MSVC-DEFS-GEN file - or are their inter-linkages?
--
Philip
