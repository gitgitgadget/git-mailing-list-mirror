Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E415F1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeB0UAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:00:04 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37082 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeB0UAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:00:03 -0500
Received: by mail-wm0-f52.google.com with SMTP id 139so876442wmn.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgiTWbjSWoQBs32Ra+WYngSu0yzFKipI4A6ddb8uKyc=;
        b=ZXRilQCJXgbTBchb8tS/129cbAmAfV62URO6bumW/I2l9VrMk3xJw1RAWePNunk439
         5eDIoVr1bH1aDwzgaHbdMeUvCZgtIJdjXBcegVD4g3qF7cezRpsdQpbOt36YZXkuQf8+
         eQlMWrXcWLGhh3Ph8e3kALRdGiuD22ku9txzUhi5HR1pOwJYFO+ky8wUai9GqtD5hr6M
         kQjdY8TqdztKdiah7j5XhI4V/3+HCTn4wjmc4NNn3EoWZ+ef1nCYM0lIRIRg03n/96kw
         sTK7YAXhCvKstLz9oyDzMTKMj3vBSsQN+CtAPwB3WEcZJljE8K5t9mPFywJ0X4F2w6Ty
         15qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgiTWbjSWoQBs32Ra+WYngSu0yzFKipI4A6ddb8uKyc=;
        b=ol5I9Hv5cnfl75lZjmMZzJsI4NENDB24P8SU9LBRevXAVAPCu39kCt9K/nCBm9krxV
         PXmWbLL9KUy3yM4xm5PyvvyKGhTZq7OvdossosAXQmBAT178PneurKmHDKTh4/0arRnv
         uAgE7qikPpiEdD3h5n/VQLLFbhz3EIoW3mhENZznaiKMxheifrDX86Rb7NQstC/VEoa4
         NjR47jThx/JOSfg7wAC6kprJCoWHvZPdyAIW1m8rvU6BBD89Y6KhiJXHu3ZE7FKuU1oK
         rh8XwNnDswNKG8mQLcMtDNQc0TREkuUKg5jQ5+44k30lATG9BBEyL02SW/iygrzmKczT
         g7Ew==
X-Gm-Message-State: APf1xPDkkUUT/UDkkkQuHiiVq9qsg5jKKIue9lY5wQUNCrYaMBtP+iRi
        FYwbethq2ixTZPBu5Hw9MQQ=
X-Google-Smtp-Source: AG47ELsPBAIfkUiDrPrcecbqG7DcpfH7RjZoLn4UX6QFJQg8+a1NDZb1HykTpGPlGJOQu9X/S+yI1w==
X-Received: by 10.28.53.130 with SMTP id c124mr11019910wma.110.1519761602434;
        Tue, 27 Feb 2018 12:00:02 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id u22sm12894859wrf.86.2018.02.27.12.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 12:00:01 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
Message-ID: <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
Date:   Tue, 27 Feb 2018 20:59:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/02/2018 19:55, Igor Djordjevic wrote:
> 
> It would be more along the lines of "(1) rebase old merge commit parents, 
> (2) generate separate diff between old merge commit and each of its 
> parents, (3) apply each diff to their corresponding newly rebased 
> parent respectively (as a temporary commit, one per rebased parent), 
> (4) merge these temporary commits to generate 'rebased' merge commit, 
> (5) drop temporary commits, recording their parents as parents of 
> 'rebased' merge commit (instead of dropped temporary commits)".
> 
> Implementation wise, steps (2) and (3) could also be done by simply 
> copying old merge commit _snapshot_ on top of each of its parents as 
> a temporary, non-merge commit, then rebasing (cherry-picking) these 
> temporary commits on top of their rebased parent commits to produce 
> rebased temporary commits (to be merged for generating 'rebased' 
> merge commit in step (4)).

For those still tagging along (and still confused), here are some 
diagrams (following what Sergey originally described). Note that 
actual implementation might be even simpler, but I believe it`s a bit 
easier to understand like this, using some "temporary" commits approach.

Here`s our starting position:

(0) ---X1---o---o---o---o---o---X2 (master)
       |\
       | A1---A2---A3
       |             \
       |              M (topic)
       |             /
       \-B1---B2---B3


Now, we want to rebase merge commit M from X1 onto X2. First, rebase
merge commit parents as usual:

(1) ---X1---o---o---o---o---o---X2
       |\                       |\
       | A1---A2---A3           | A1'--A2'--A3'
       |             \          |
       |              M         |
       |             /          |
       \-B1---B2---B3           \-B1'--B2'--B3'


That was commonly understandable part. Now, for "rebasing" the merge 
commit (keeping possible amendments), we do some extra work. First, 
we make two temporary commits on top of old merge parents, by using 
exact tree (snapshot) of commit M:

(2) ---X1---o---o---o---o---o---X2
       |\                       |\
       | A1---A2---A3---U1      | A1'--A2'--A3'
       |             \          |
       |              M         |
       |             /          |
       \-B1---B2---B3---U2      \-B1'--B2'--B3'


So here, in terms of _snapshots_ (trees, not diffs), U1 = U2 = M.

Now, we rebase these temporary commits, too:

(3) ---X1---o---o---o---o---o---X2
       |\                       |\
       | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
       |             \          |
       |              M         |
       |             /          |
       \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'


As a next step, we merge these temporary commits to produce our 
"rebased" merged commit M:

(4) ---X1---o---o---o---o---o---X2
       |\                       |\
       | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
       |             \          |                  \
       |              M         |                   M'
       |             /          |                  /
       \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'


Finally, we drop temporary commits, and record rebased commits A3' 
and B3' as our "rebased" merge commit parents instead (merge commit 
M' keeps its same tree/snapshot state, just gets parents replaced):

(5) ---X1---o---o---o---o---o---X2
       |\                       |\
       | A1---A2---A3---U1      | A1'--A2'--A3'
       |             \          |             \
       |              M         |              M'
       |             /          |             /
       \-B1---B2---B3---U2      \-B1'--B2'--B3'


And that`s it, our merge commit M has been "rebased" to M' :)

(6) ---X1---o---o---o---o---o---X2 (master)
                                |\
                                | A1'--A2'--A3'
                                |             \
                                |              M' (topic)
                                |             /
                                \-B1'--B2'--B3'


Important thing to note here is that in our step (3) above, still in 
terms of trees/snapshots (not diffs), U1' could still be equal to 
U2', produced merge commit M' tree thus being equal to both of them 
as well (merge commit introducing no changes to either of its 
parents, originally described by Sergey as "angel merge").

But it doesn`t have to be so - if any of the rebased commits A1 to A3 
or B1 to B3 was dropped or modified (or extra commits added, even), 
that would influence the trees (snapshots) produced after rebasing U1 
and U2 to U1' and U2', final merge M' reflecting all these changes as 
well, besides keeping original merge commit M amendments (preserving 
"evil merge").


Well, that`s some theory, now to hopefully confirm/test/polish all 
this... or trash it, if flawed beyond correction :P

Regards, Buga
