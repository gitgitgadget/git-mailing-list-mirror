Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB259C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 19:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKCTua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCTu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 15:50:29 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C011838
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 12:50:28 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oqgEN-0001zQ-6W;
        Thu, 03 Nov 2022 19:50:27 +0000
Message-ID: <7baed8ab-075f-52d4-52d2-3e555ea59c5d@iee.email>
Date:   Thu, 3 Nov 2022 19:50:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC/PoC 2/5] Documentation Bundles: ignore artifact files from
 creating doc bundles
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-3-philipoakley@iee.email>
 <221103.86zgd81jtm.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <221103.86zgd81jtm.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11/2022 09:12, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Nov 02 2022, Philip Oakley wrote:
>
>> The Git documentation contains many examples that can be prepared as
>> repository bundles for users to clone and explore without any language
>> or translation confusions between the written word and intended code.
> I just find this commit entirely confusing, we're adding .gitignore
> entries, but nothing generates these yet (but I'll read on). All to
> describe some seeming future feature...

Probably could be squashed in with the others once the PoC has matured a
bit.
>
>> There are also a large number of example repositories in the t/ test
>> system can can also be exposed to users to highlight the critical
>> distinctions tested therein.
>>
>> These documentation bundles will be prepared ar part of the test system.
> s/ar/as/

Ok
>
>> Start by ignoring those parts which will be considered build artifacts,
>> the GIT-BUNDLE-DIR, and the `.bndl` bundle files themselves.
>>
>> The artifacts themselves will later be manipulated by the `make` elements
>> of the documentation system.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  .gitignore | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 6ded10067a..b96a4ce5df 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -3,6 +3,7 @@
>>  /fuzz-pack-headers
>>  /fuzz-pack-idx
>>  /GIT-BUILD-OPTIONS
>> +/GIT-BUNDLE-DIR
>>  /GIT-CFLAGS
>>  /GIT-LDFLAGS
>>  /GIT-PREFIX
>> @@ -250,3 +251,4 @@ Release/
>>  *.dSYM
>>  /contrib/buildsystems/out
>>  CMakeSettings.json
>> +*.bndl
> We've been putting quite a few things in .build/ recently, so whatever
> this is, if you put it in .build/test-bundles/ or whatever you don't
> need to write "clean" rules for it, or add this ignore entry.
Ok. I'd also hadn't considered the 'clean' rules for the make file.

Philip
