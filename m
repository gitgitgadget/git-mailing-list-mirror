Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A2F1F462
	for <e@80x24.org>; Wed, 29 May 2019 17:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE2RzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 13:55:06 -0400
Received: from mout.web.de ([212.227.15.4]:36837 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2RzG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 13:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559152497;
        bh=ZBpOw0bA/0FXirXYiDfqpc9NGZSgszOKEd+E1g2+Fkc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jXdBJoY0bfwf71Etot7m4dlTxQYKe/pU0MDAEfOsjYWhnmZ4vkVMYAnxMaKMl29zs
         sP2bLEnhLL0mPGbydGjRTz0DcShY0VE2nhm8rZhLA8BoEkwbGSPKOtCCUVUEntv9TM
         XLtAYuPEiRVdDPFovTagd0ALLoPOFfce8xyS6r+s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOS6H-1hZd9Y1hlF-005ph7; Wed, 29
 May 2019 19:54:57 +0200
Subject: Re: git archive generates tar with malformed pax extended attribute
To:     Jeff King <peff@peff.net>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <20190528055805.GB7946@sigill.intra.peff.net>
 <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
 <20190528190815.GA20499@sigill.intra.peff.net>
 <5f9ac691-4cb1-a15d-ca44-63fb64994d59@web.de>
 <20190529011744.GA22340@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <24574d74-b6ca-6d36-759f-32cf26b36c3f@web.de>
Date:   Wed, 29 May 2019 19:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529011744.GA22340@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwhY0OVsdWKj5jskb/nLqisrXtecc4f7Sd2bQ0MGxPA42f0Imby
 EKCjF+O2pr1hGnCagyjv7FPFZPuF+dv9RfXjlJGSnMwAjVYWwgdi3+k2/sRD3TUjheAUmR9
 EmNRKl0CEH/2akIosWwHAw1CEHJwW3LvR8QSFWLVrzHs+qEpPaav+Kbxdju3wDahzNlJ+17
 RVyO9BpJSeFK4mkIBBeGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zlRw/UQBHaE=:nsyBj0Iwhnp5VDf9VM7fo6
 YvVxxhTJrZNKPeeo3HfkYvbvXG8pPbx9iN++TGeS4nNcERlm7J4H+pcwFfbylL8QDZ0hytdzU
 +PdarIis17OzDvqpCSx3kxe+vaSQ/7oi1rTaHo2qQaF5b+BJ+SDL9sZysJwQrnHpX8LLgJQzp
 QargdxnJUEs57WUqNYcc5LaU0noYJwK8SBxpPutN1IvRc5+H28AOpIk5rksJCf43JHRYNB1WI
 3z3HGMVq2b6ecm6PxF17Irh7b6D2T077nM71XjlDJtwVOUKG5UbuGPdrmhWVfhRGBd0iAvOC+
 zH5YVkbsWSBFngFqD1itHBzhBxFhckDn33oqOU2OJ0J7WkXAqxGp89H4FuKEVoLzMiTqpMe7I
 EYm3yGTQpLvXg5fSfZuFi3hw7hFTr7ZffSNU5Fv4AiwqoB1h375CeXHUKy/++rQI5XgDdBe9v
 7ogHizW+dEbHPSLsDTDfJOc6P5n6IKYWdF9KoKXe96tO4OTSQFgRPFR4qATCnFq2MJ0Bwz+AY
 5wT1EbMFnEEC4Za35trZR1tHyXuLLqmaHKxW0zm0Ucj9Ego03bvfSdfNxpGwu6dWYPDRpjF0A
 wJARwGbzWYr04V9C3C8HByOkCwfZ+SRU24SHk/yyfpSlHvY4lpMPUa2qRmAiigQeJkkvFNEYw
 5ANwssc3DVgqLZfIWrbkuxpnwxdTFv7ii6Ar+48b8IfJWI6XkiK6X8DvS3QByJCbGi2+5rAjd
 f4BMwjRQ33jX4N/gKpUMXhbCmNFb4nrjUXfRkaAqPSaR/bEUz5ICF2IDqINP2oQVcKH1nphFC
 KDnU2uuYlq4I4PYSCYnWn1DLfj0R13yJnIKiQNZZJK7PqLvPJ5/D4V7re/5KQfBYAFFQj5WfY
 Sk1VIbe4TVHzvDfv9wbJmgSjcyyiU7LTLQyOSCMFiieqUpVKFoVmfzaj7IBXfyvJvHUIdFUlt
 PoXzePMUqPHkbCIbS79gFZkx0lhW1F9E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.05.19 um 03:17 schrieb Jeff King:
> On Wed, May 29, 2019 at 01:34:32AM +0200, Ren=C3=A9 Scharfe wrote:
>> Parsing trees with symlinks twice is not ideal, but keeps the set
>> structure simple -- a standard oidset suffices.
>
> If blobs comes after trees (and they usually do in a pack), you can do
> it in a single pass by marking the blob as a symlink target, and then
> when we actually see that blob's contents, marking it as either OK or
> problematic. And then the finish() step just correlates those with the
> tree.

Good idea.  Is that ordering guaranteed?  (Stumbling about the "usually"
in your first sentence.)

An ordering where dependent objects (like trees) follow the objects they
reference would be better suited for these kinds of checks..

> It does require O(n) storage in the number of symlinked blobs, but also
> O(n) in the number of symlinked tree entries (number of trees with
> symlinks times the number of entries in each such tree, _even if they're
> the same entry/blob as another tree).
>
> That makes it a lot worse than the existing gitmodules check. There we
> only care about finding the .gitmodules blobs. So even though you have a
> ton of trees that mention .gitmodules (basically every root tree), the
> the .gitmodules file itself doesn't change much. So we only end up with
> a small oidset (and a small worst case for looking at objects twice).
>
> But here the problem is in the tree, not the blob. So we're not finding
> suspect blobs, but rather re-checking each tree. And no matter what we
> do (whether it's visiting the object again, or creating a set or mapping
> with the object names) is going to be linear there. And a repository
> with a symlink in the root tree is going to revisit or put in our
> mapping every single root tree.

That's true, potentially it needs remember and/or reprocess all trees,
meaning this check may double the run time of fsck in the worst case.
Example from the wild: The kernel repo currently has 36 symlinks and
6+ million objects are checked in total, and the symlink check processes
18943 trees_with_symlinks entries there.

> TBH, I'm not sure this fsck check was worth it even without the
> implementation complexity.

Hmm.  git status reports such truncated symlinks as changed, so the
issue *is* already detectable.

Ren=C3=A9
