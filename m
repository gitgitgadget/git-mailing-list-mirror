Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E48BECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 14:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiITO6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiITO6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 10:58:42 -0400
Received: from outbound6.mail.transip.nl (outbound6.mail.transip.nl [IPv6:2a01:7c8:7c9:ca11:136:144:136:128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27014F3B9
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:58:38 -0700 (PDT)
Received: from submission13.mail.transip.nl (unknown [10.103.8.164])
        by outbound6.mail.transip.nl (Postfix) with ESMTP id 4MX4Rw5hMkzwLHxN;
        Tue, 20 Sep 2022 16:58:36 +0200 (CEST)
Received: from [131.180.45.14] (x045014.tudelft.net [131.180.45.14])
        by submission13.mail.transip.nl (Postfix) with ESMTPA id 4MX4Rv5qQBz1yFR;
        Tue, 20 Sep 2022 16:58:35 +0200 (CEST)
Message-ID: <2c29ca18-4b45-af44-5690-0b9804a81461@fwdekker.com>
Date:   Tue, 20 Sep 2022 16:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
 <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
 <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
 <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
 <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
 <220920.86edw65ngv.gmgdl@evledraar.gmail.com>
Content-Language: en-GB
From:   "Florine W. Dekker" <florine@fwdekker.com>
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
In-Reply-To: <220920.86edw65ngv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission13.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=fwdekker.com; t=1663685915; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=GzWH91PG4jTwkEXXsCvHmPLv/CH/0vvdmA4XsHQrMe4=;
 b=FEjU9vmh9Br1kNjEwCTY96ny7EZNTVO1NJukcEu5O6foNLRz8rN2agtUtADPoxzYGHriBv
 lT8UibTdlvBYsF6mQtfo/vn0Lhg2HNs9o+HyaSOag8Pw+YsMtCxTROnBfuBd26lReM8IY7
 6w9jRF3NPMgZ1Xs3xu2DQSuHOku1quMgOncAjyjSuHfcx9cmjGbcWpRJvaKoMybXSK+FQL
 hdRCmz3jp6YIZsvkj9O7XNAoJf+zFNsCeHMkRnHkA481a3quEqrzv+2A4nHiJWvbOUPCeB
 u7vNpdQNnXaXLGatz6G/JQ+G26L1QYwoOEgg1i64B1gME38qKbxrywF6eWBCfA==
X-Report-Abuse-To: abuse@transip.nl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/2022 12:23, Ævar Arnfjörð Bjarmason wrote:
>> I'm happy to resurrect my SHA-256 hashed mailmap series if we're
>> all willing to agree to not implement trivial decoding features.
> I'd think you'd want to be really clear about what that forward promise
> would entail. E.g. I've sometimes wanted a way for "git log" to report
> when it munges commits due to adding notes, re-encoding the data etc. If
> someone submits that sort of feature should it always explicitly leave
> out mailmap-related rewrites?
>
> And even if it does, who do we think we're really helping in the end,
> given the trivial way you could get that with an external "diff" with
> the one-liner above?

I think the most important thing here is that the mailmap should not 
allow for even-more-trivial ways to discover old names than currently 
already exist. I've thought more about what you said, Ævar, and now I'm 
wary of a mailmap implementation that would entail having my old and new 
information next to each other, even if encoded (doesn't matter if it's 
URL-encoded or base64-encoded), because I think it's likely some 
external data mining tool will decode the address and place them next to 
each other, so that if you search for the email address in a search 
engine you'll also see the other address. I think a hash encoding will 
prevent these automated miners from doing that, since reversing a hash 
is too much effort for an untargeted attack (right? if you disagree, how 
about a salted hash?).

Either way, I think any mailmap-based solution will allow the old and 
new name to be linked to each other by an adversary, as you showed with 
your neat one-liner. However, I think a (salted?) hash in the mailmap 
will be sufficient for casual obfuscation where harassment is unlikely, 
but the user wants to prevent accidental disclosure or plain linkage.

>> I also have an alternate proposal which I pitched to some folks at Git
>> Merge and which I just finished writing up that basically moves personal
>> names and emails out of commits, replacing them with opaque identifiers,
>> and using a constantly squashed mailmap commit in a special ref to store
>> the mapping.  This doesn't address changing identities in existing
>> commits, which as we've seen are nearly impossible to fix, but it does
>> address new ones.  I've sent it out at
>> https://lore.kernel.org/git/20220919145231.48245-1-sandals@crustytoothpaste.net/.
> As I understand the difference in this scenario a hypothetical future
> repo's Y commit's authorship would have been opaque in the first place
> using this mechanism, and via your "refs/mailmap" you'd have mapped
> Y=Bob.
>
> You then make a future X commit, and map X=Alice, and have a .mailmap
> entry which mapped Y=X, but that entry would refer to the opaque value.
>
> That certainly changes things in a fundamental way, and goes most or all
> of the way to mitigating what I've been pointing out as a flaw in these
> proposals.
>
> I'd still be very much on the fence about whether we'd ever want to
> recommend that to someone concerned with "harassment" and the like (as
> opposed to a milder social preference), as all it would take to get to
> that point is someone having a copy of the older "refs/mailmap" to
> unmask the previous "Y".

I first want to say that I really like your proposal, Brian! I didn't 
think this subject would get the attention it did, but I'm happy it's 
being picked up the way it is, and to see this lively discussion going 
on between yall!

And Ævar, you're right that having an older copy would allow one to 
discover a mapping from the old to the new name. But this will happen in 
any way we can conceivably implement this because the adversary can 
always keep an old copy of the entire repo, clone the new one, and 
compare the two logs. (You can probably come up with a neat one-liner, 
but that's besides the point ;-).) I think that the most appropriate 
threat model here is to assume that everyone who has accessed the repo 
before the name change will notice the name change and will be able to 
create a mapping. Instead, our goal should be to create a system that 
ensures that people who first access the repo after the name change are 
unable to find the old name at all. I think Brian's proposal achieves 
this. This is analogous to the real world where people who knew me 
before my transition will probably never (completely) forget my old 
name, and it's useless to try to make that happen, but at least I can 
prevent new people I meet from finding out the old name.

- Florine


