Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E52202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 12:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754806AbdCIMMh (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 07:12:37 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:38117 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754771AbdCIMMa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 07:12:30 -0500
Received: by mail-it0-f54.google.com with SMTP id m27so64959250iti.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GIw6NTLXVkAROVPXbs2jLjvsr6tzN+P9tJ3Mu0maj44=;
        b=rSRZEgz7lymLSTdpmHlqXPEGJ/oyxp6BIaoV6J+V8J8Fem2x45/dNsRXXSz/Tr3evb
         nY47fswcZKxOizsydqpuRaaaltzlTqk3EJDjzf89H4zAXA+HwZ4vgA/ynnTGT7EfBRmU
         U6EOA6N6ZDL4ttDNArzfTf3abwBqaoUAC5DbbPeb/EPoZmKsz12i67Waea6bRvg/JgSh
         xfYGekAlhftSgRD0GSW3yfL/w3SMEixA5lnBagdzHkoqNnWAXp/CmvZNMGrjbl9H5Qbj
         zlcOT1Of/RQfSdCe8iEwKujnV4QYNwMn0Mz8DYbfxiko32nan9OSrF8tHIt9pLVj4VMO
         dV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GIw6NTLXVkAROVPXbs2jLjvsr6tzN+P9tJ3Mu0maj44=;
        b=MxS3Wo6uPIwvVvi24KYehrtfRs6AZEpa7/3nY+toEbKx3f6XKSvRf5wp2Mhac1NoSs
         pQXFXwSyXulApOHnaEbb8y9qOZA0PJj8ltN5bBomqHGLCR2O4m7hUiK4RuDXvnqryvT1
         JSzuFjoEeybOV2KSTTuIayaxyt2k5IPQwraeaA7YA3GDllK+SRQgHUTQSgWW2A3VvzyZ
         EoOHoCwCZxIJZXpfJdj+8MS66RpmEndvVtHAplDcnolNbxz8EeiGqryOuBU4QpgA7j5A
         bx21aNvzIftnUg3VdF0IINTNCEBvg67p7oNfXiQdlV/MTUQo5rUf3I3diznDH+FlUUMT
         8OhQ==
X-Gm-Message-State: AMke39kkvZukZycfqwtxcVak+B0RbaGHsFbxQR+R4dKY/cznSgz++Qd7ruYqIerXz7mkPPZI6V5NrqwptF1v/Q==
X-Received: by 10.36.103.9 with SMTP id u9mr28897296itc.91.1489061548705; Thu,
 09 Mar 2017 04:12:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 9 Mar 2017 04:12:08 -0800 (PST)
In-Reply-To: <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com> <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com> <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 9 Mar 2017 13:12:08 +0100
Message-ID: <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 11:46 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 09, 2017 at 11:41:59AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I almost suggested that there simply be an option to invert the match
>> > (like --invert-contains or something).  But what you have here is more
>> > flexible, if somebody ever wanted to do:
>> >
>> >   git tag --contains X --no-contains Y
>>
>> Yeah that's really useful. E.g. this shows the branches I branched off
>> (or have locally) from 2.6..2.8:
>>
>>     $ ./git branch --contains v2.6.0 --no-contains v2.8.0
>>       avar/monkeypatch-untracked-cache-disabled
>>       avar/uc-notifs21
>>       dturner/pclouds-watchman-noshm
>
> Oh, that's a clever application.
>
>> But I'd expect this to show all the tags between the two:
>>
>>     $ ./git tag --contains v2.6.0 --no-contains v2.8.0
>>     $
>>
>> But it just returns an empty list. Manually disabling the
>> contains_tag_algo() path (i.e. effectively locally reverting your
>> ffc4b8012d) makes it "work", but of course it's much slower now. I
>> haven't dug into why it's not working yet.
>
> I'm almost certain this is because the contains_tag_algo one doesn't
> clean up the flag bits it sets on the commit objects. So running it
> twice in the same process is going to give you nonsense results.

Yeah indeed.

I tried to hack something up to avoid this, but the
lookup_commit_reference_gently() we call will return the same
object.parent pointer for two invocations, i.e. the underlying
{commit,object}.c API has a cache of objects it returns, couldn't find
some way to quickly make it burst that cache.

The other approach of making contains_tag_algo() itself detect that
it's been called before (or us passing a flag) and going around
setting commit.object.flags on everything to 0 seemed even more
brittle, particularly since I think between filter->with_commit &
filter->no_commit we might end up visiting different commits, so it's
not easy to just clear it.

I'm happy to hack on it given some pointers, will visit it again, but
for now unless I'm missing something obvious / you can point out some
way to hack this up I'll just submit v2 with the combination of
--contains & --no-contains dying with a TODO message.

The patch without that functionality is still really useful, and we
can implement that later.

> Coincidentally, I've been looking into resurrecting the cleaner approach
> that I sent long ago:
>
>   http://public-inbox.org/git/20140625233429.GA20457@sigill.intra.peff.ne=
t/
>
> But it's sufficiently complex that it's probably worth fixing the
> existing algorithm to clean up its bits in the meantime.
>
>> Also I wonder if this should be an error:
>>
>>     $ ./git [tag|branch|for-each-ref] --contains A --no-contains A
>>
>> I.e. when you give the same argument to both, this can never return
>> anything for obvious reasons.
>
> It's clearly nonsense, but I don't think there's any need for it to be
> an error. GIGO.

Yeah, make sense.
