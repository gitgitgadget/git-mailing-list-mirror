Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513D920248
	for <e@80x24.org>; Wed,  3 Apr 2019 09:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDCJTV (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 05:19:21 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:3818 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCJTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 05:19:20 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id Bc3Bh4qGfdraxBc3BhUuBw; Wed, 03 Apr 2019 10:19:19 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aILHwLAuNCR56Mpr4MoA:9 a=QEXdDO2ut3YA:10
Subject: Re: Fw: git describe issue
To:     Bryan Turner <bturner@atlassian.com>,
        Amiel Elboim <amielel@matrix.co.il>
Cc:     Git Users <git@vger.kernel.org>
References: <AM6PR08MB41993844F57794DDF4B33B8F8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
 <AM6PR08MB4199B076CB886AE814AFF4528D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
 <CAGyf7-HUAoYURDnnp+nq+4EQkysoTE+f_WK8cEVPCHP065rv6A@mail.gmail.com>
 <AM6PR08MB4199EE3834CBF84D28244D9E8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
 <CAGyf7-GcrWX-TRP89a1SqKu4h74Mbezq0ifHpS305epfmKxJvw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <16a9780d-9c3e-673a-4567-f0c4d93f88bc@iee.org>
Date:   Wed, 3 Apr 2019 10:19:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGyf7-GcrWX-TRP89a1SqKu4h74Mbezq0ifHpS305epfmKxJvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfHagWmlPEaG5ngJsiw9WEYEan5mflyS86utgpZwLCtYjXiuJVM7q3iV/x2+4gri8TEBG115Bfrx4zg04cQi0IqA9X0kUuGJW53hRyN08Qji5r9koPvV3
 G3i60b/0Dc7559kt7G9agl1vco299CpMhOq66OQZ5a6GC5AKQYy/Ci7a1ogW64ZdLlHhAMpJlNRnLh4xstO84h7hP3qqyHlTvnJBehnPRugQYbOfNtZLyDI2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04/2019 09:11, Bryan Turner wrote:
> On Wed, Apr 3, 2019 at 1:00 AM Amiel Elboim <amielel@matrix.co.il> wrote:
>> Very helpful!  annotated tag is good solution for us.
>>
>> However fix of this issue is important, because it's confusing when you want to track on your version using git tags.
> Lightweight tags have no metadata to allow for ordering, so I'm not
> sure there's something to "fix" here.
wouldn't the 'fix'  be to the documentation that Amiel quoted to clarify 
that 'annotated tags' can be date sorted but lightweight tags can't.

Maybe Amiel could suggest a short documentation patch to that effect 
that would have helped as a new reader of that doc. In this case it's 
the omission that is easily missed.

>   Given the tags have identical
> timestamps, Git simply displays the one that's first alphabetically.
>
> Git does have some ability to parse versions and sort them, on newer
> versions, but there's no way to activate that via "git describe
> --tags", at least as far as I'm aware (and I'm not sure how reliable
> it can be, given tag names are essentially free-form text).
>
> You can try Git's version sorting with a command like "git tag
> --sort=-v:refname" (The "-" before "v:refname" sorts in descending
> order)
>
> incom@Jael MINGW64 /c/Temp/fourth.git (BARE:master)
> $ git tag
> v1
> v2
> incom@Jael MINGW64 /c/Temp/fourth.git (BARE:master)
> $ git tag --sort=-v:refname
> v2
> v1
>
> Since you can't enable that for "git describe --tags", though, I'm not
> sure it's helpful. (Someone else can correct me if there is a way to
> make "git describe" do that.)
>
> Bryan
>
> (Re-added the list on CC)
Philip

