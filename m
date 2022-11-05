Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A0C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKER1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiKER1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:27:03 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6DB12622
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667669218; bh=E+hfoWebH/oMglOXEDsBJaHh3o1GCReCJTlcOnqHhq0=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=SC2Jn31gzkFidGhEbewRfcmjt1e98z/6oAdkswdCWEHmmkKCmYBJFz9vgYfrOFbKA
         O4JwTL3O2nE/7Z/eDLGJx8NIE7em2SbeGKkXpW881KgRNGGh5JaUKzxQfB2Y3iq2IG
         CbpzsL2tAnWzcP2wuhsGRPzaF/lIhGkQ1XwEM4aONtxHZKb0JeLiPhJQ4aJdrtxnnb
         U7kNeYYj6vgAfrpgKWQzwUSp1SpZwJi6dMHSbqky7ri6zJDYvBXk6Hosd0IbCFOb/z
         jYKfI93GDvXNlHYGx//UaoQnDUhDx3TglwMZozCvXOChO7C4R5AhgnvwcB3cmAw6oj
         XWSfSl+fi4vzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.51]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Ij-1pFCUj133T-00yIXM; Sat, 05
 Nov 2022 18:26:58 +0100
Message-ID: <5dbd5dd1-3a50-c0ce-d06a-227ec0a89bc6@web.de>
Date:   Sat, 5 Nov 2022 18:26:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: compat/fsmonitor/fsm-listen-darwin warning on macOS Ventura
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJcRvBCxNTYEU2PK39I5n6cWWWNqZWeDK/kC5oJ08cw8FLeZgJR
 7Dj0fvKe/wFdqvBMnEZK35ykGgrZiy1hBrl1sMuLW03O5Tqi0/YNS0NezlzGRbqPQbjQJ1S
 GdkizUlxhrBjFgdTiUZoBZrYTDMzAkt10Jg+AlCEG921472q/TC0o5mUy3ZGXgpYEFczmTA
 5wZ7CIXu+UgmXcjMu+5AA==
UI-OutboundReport: notjunk:1;M01:P0:nb3Z8cCeRLI=;VpzllTr/lq1yTMEmWQUPYx7BoLu
 xmpvIYkmCfLytbdvp0pQRO1MATZt4WLEgxxE4fJReTlFIixSOXNMlle4anOw244cKXSgy3s8d
 qc9Ufdh32suFBumevL+irtifauj2RI8ULwFzn93PMFnUdmgOOOHWxHAv89xdb/SwEJ81y5jEK
 NFEzMMS8fMAxWhiDz2lsIPneL0m37umOyUB0EpHbXq9mXFTX9dbEdNG37ZjQpALtmHHuggTAg
 qmkUU1rHt7Wvqi2PBTUQHqSikjJFBhT+tctt9Hfhb0q8/7s1dm3GYeywy+22gbL20Jpt7FSeY
 FbFpsHiiLfEC/47aBT0Hs5/vBL7+Wfue0fq7WEIDmCoR7x0JiLfz/PAd+RSRQxZsKkTbrbOyi
 1f76WAC+b1nQGDHRjtHVdvZKzQEJWwHSuXFY1jO91Wu+3N9hAC3lPpEX0gjRzadNvBRM2jrzw
 BC9XQXfKfmXnBa5/2WcgOV90C5aAPbkkCpEP7JazZyVAu5q4FGk9xvGuR1SMggcsjxH0+1b89
 Wwe63o9PUx6ZxJlJy2VXfOEB3Pm4a0AfCjbSAy/OIrjaBtjXmpOCoRz+yALXKC1ZR4Vl61NHD
 fxHT4AzU82xMd6m2O68vffm6oj5yG88qotTc/AB5iTSzJ24SdZ/0JuqXVP9JWiAUqLnx5McAK
 VENGAsai7kPO1ZtQuk2zuniWZ9Gz5k+YfrW7ZoRpLDO/owGNTtIeROgYneJqQJy3pcKzUZ1Hk
 OIJVZvC9J6nq2ZVg1NDa04na4qxSHmxlSPoEqQUB0x/yR1LmK28PRMPnGVJhZfNrpFbvkOW88
 sBysgfUnZ/YwWiVntjWV2jNKYVGYw9grkGv9aoMU25LJgfmrHNAC7otuUHdEJDUHVMNFI7lWn
 jK4lkWddE0iUY55X5wIYlqn7ZsS5R+KVKvycZNA2GsVFd1qmWnSi8QYJXFSm5EzuWb9mrLRL/
 kjLrGbkGZB1Asmn1/Kdqc42Bvzs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

on macOS 13.0 Ventura I get the following warning-turned-error when
compiling the fsmonitor code:


compat/fsmonitor/fsm-listen-darwin.c:495:2: error: 'FSEventStreamScheduleW=
ithRunLoop' is deprecated: first deprecated in macOS 13.0 - Use FSEventStr=
eamSetDispatchQueue instead. [-Werror,-Wdeprecated-declarations]
        FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoo=
pDefaultMode);
        ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Devel=
oper/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreServices.framework/Fram=
eworks/FSEvents.framework/Headers/FSEvents.h:1138:1: note: 'FSEventStreamS=
cheduleWithRunLoop' has been explicitly marked deprecated here
FSEventStreamScheduleWithRunLoop(
^
1 error generated.
make: *** [compat/fsmonitor/fsm-listen-darwin.o] Error 1


No idea how to use FSEventStreamSetDispatchQueue.  I could run tests
if that helps.

Ren=C3=A9

