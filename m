Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D54201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 00:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdBYAcc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 19:32:32 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36245 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdBYAcb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 19:32:31 -0500
Received: by mail-qt0-f172.google.com with SMTP id r45so29504853qte.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 16:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6CbB5zsRNgMc3F4B0Jemuz5LZUFnSA1NUEdNBpFlrjE=;
        b=LbAdn9Xu5zIR1YzCtGSPN270NMdEpqvJdTdbqPmTbPql9dvYXFa4/A8oWrqV1l3hZI
         tlgOdQuqYMaxz6q4HtCjWbEq7JoD4+yxaYxaZQOOj7qmzlUQHXHOU9iRWuVQMDqej6zm
         VBIYiW7awMtkk5X5HPVMd1NilmOJrczR5ciniQOPItQbyEwwdzsOqB3u+iIImeFnHS0s
         UT5Ys+Q6zCsUU05dUVfU2z7LWUtwhWG2JaJQJ/LXIHJyl3LgQjvIAZ/bRbblfSj6XsiN
         ZTVk90K9LLS+KHBaO7R4tCbDfgLAeZT+YcIkkRSq0F2+nfBo4C+A2/Ixfkf4Ss5r7ya8
         A5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6CbB5zsRNgMc3F4B0Jemuz5LZUFnSA1NUEdNBpFlrjE=;
        b=AGWmurQ16TtsKgnb2im1zR2/jsOunVo6zR22lcsneRauYFwMVw4u9jjsMlaUmE3hOp
         Gs2UERuT9SC7Acqz+0sn8aB62MD0yUSTYrGNkZq4QxX9/lQRkgfVNvJid4YKHdJZp2N7
         YbwntuNSntv3zpnh9y+Exw/4S7TIoZ4axFb+jHhekRDcY65CQ/PmnHbnYeQPHYDrZ1uv
         IN+4xCOVrLM7zHk5YPSewBsrdquIED4TSCNOTT/6XxL7xrIKqNPkONjxuYvV4xedyisQ
         ZaxxpnMlZWJFMGAkujzydn6NbzXfmbiu3coJ3S2pi6urggOtwOxlQs7UFg1ft80MIuV3
         9DWQ==
X-Gm-Message-State: AMke39kLyBQ5AlzFk29pIF6qr+Ib1T8IB6VOPAl4202LeiK7v75Zf9zOKjdcJIhr9CQ0gG/QotHL+JsNGtivDg==
X-Received: by 10.200.47.88 with SMTP id k24mr6189137qta.67.1487982723082;
 Fri, 24 Feb 2017 16:32:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.218 with HTTP; Fri, 24 Feb 2017 16:31:32 -0800 (PST)
In-Reply-To: <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
 <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com> <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
 <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com> <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
From:   ankostis <ankostis@gmail.com>
Date:   Sat, 25 Feb 2017 01:31:32 +0100
Message-ID: <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@lakedaemon.net
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 February 2017 at 21:32, Junio C Hamano <gitster@pobox.com> wrote:
> ankostis <ankostis@gmail.com> writes:
>
>> Let's assume that git is retroffited to always support the "default"
>> SHA-3, but support additionally more hash-funcs.
>> If in the future SHA-3 also gets defeated, it would be highly unlikely
>> that the same math would also break e.g. Blake.
>> So certain high-profile repos might choose for extra security 2 or more hashes.
>
> I think you are conflating two unrelated things.

I believe the two distinct things you refer to below are these:

  a. storing objects in filesystem and accessing them
     by name (e.g. from cmdline), and

  b. cross-referencing inside the objects (trees, tags, notes),

correct?

If not, then please ignore my answers, below.


>  * How are these "2 or more hashes" actually used?  Are you going to
>    add three "parent " line to a commit with just one parent, each
>    line storing the different hashes?

Yes, in all places where references are involved (tags, notes).
Based on what what the git-hackers have written so far, this might be doable.

To ensure integrity in the case of crypto-failures, all objects must
cross-reference each other with multiple hashes.
Of course this extra security would stop as soon as you reach "old"
history (unless you re-write it).


>    How will such a commit object
>    be named---does it have three names and do you plan to have three
>    copies of .git/refs/heads/master somehow, each of which have
>    SHA-1, SHA-3 and Blake, and let any one hash to identify the
>    object?

Yes, based on Jason Cooper's idea, above, objects would be stored
under all names in the filesystem using hard links (although this
might not work nice on Windows).


>    I suspect you are not going to do so; instead, you would use a
>    very long string that is a concatenation of these three hashes as
>    if it is an output from a single hash function that produces a
>    long result.
>
>    So I think the most natural way to do the "2 or more for extra
>    security" is to allow us to use a very long hash.  It does not
>    help to allow an object to be referred to with any of these 2 or
>    more hashes at the same time.

If hard-linking all names is doable, then most restrictions above are
gone, correct?


>  * If employing 2 or more hashes by combining into one may enhance
>    the security, that is wonderful.  But we want to discourage
>    people from inventing their own combinations left and right and
>    end up fragmenting the world.  If a project that begins with
>    SHA-1 only naming is forked to two (or more) and each fork uses
>    different hashes, merging them back will become harder than
>    necessary unless you support all these hashes forks used.

Agree on discouraging people's inventions.

That is why I believe that some HASH (e.g. SHA-3) must be the blessed one.
All git >= 3.x.x must support at least this one (for naming and
cross-referencing between objects).


> Having said all that, the way to figure out the hash used in the way
> we spell the object name may not be the best place to discourage
> people from using random hashes of their choice.  But I think we
> want to avoid doing something that would actively encourage
> fragmentation.

I guess the "blessed SHA-3 will discourage people using the other
names., untill the next crypto-crack.
