Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66A7201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 17:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBXRc3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:32:29 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34704 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdBXRc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:32:27 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so3747792pgb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e/V7lwl+vzGF+/FHTNh7iuKkrDQO5QV3IeeSvDh+N2s=;
        b=sGOFI8qEa2L8bPHc+OIVR64zqjap2fYSgaiePEJ8d8BCGAFWEY5dUgM71aAnqVUYWI
         fWJp9x41469TSzs2RjXTSFd93iwPP6zMWL+/JfEc4ASzcjBSTbYj0IONHbAQvMiy0ink
         CoNmDtoiS/ygv9aEVNBBxdjkCpNZa4hy9eK5k+gQEGzgFi9teFU9wnExHtZKCyu1aKZU
         HFbOiO3e35P36u17GDwhK2LU+phpHPqsTbU6DjtTGDvGW0TbMi6LKLG6PB0c4ZAmtFIR
         eJ41Vn7ezzaZnLldSvrnGY9JsyIvlnKuIl5Y/njr/025aZ/+dlA03xS5j75uP2Qwz51X
         4pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e/V7lwl+vzGF+/FHTNh7iuKkrDQO5QV3IeeSvDh+N2s=;
        b=PD+zrnc/s5MkqBVwDMks5KRPAHaw957tg+HMnYJ10fHySMItEU30gPsy4bYsDrle1M
         H41zj4ZcQO7E68MrWWhp5k53zqou2Iv/PhkieZog98Lx/jj3zFmPu7wcwA8KAg9wFkA7
         M1BNaTbyOLycdgfXLG+XQHGdsxOSaHZeFXV4yWeg9jmoS/AZeMkr2F1gP+EFhRxz8gU3
         cfjOMP4gyPNIMAeOX6++YajHmBkLc5iDAFxyB4C0imouGmI2DxgLgKolEDlcQu19JJNT
         b0RX+irTqoprK3s/WAd7fvCILpGaepAznFepAGV3NP6E5CHIz/EZngv/5qOZANKxcPVO
         kjyQ==
X-Gm-Message-State: AMke39lwcyEoubf3TlikIZf+/qorpa4VvZbEODDUkhL555HuCKZd7w1y62jgP82xs+mSCw==
X-Received: by 10.84.212.8 with SMTP id d8mr1925499pli.152.1487957534956;
        Fri, 24 Feb 2017 09:32:14 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id t6sm16346602pgt.8.2017.02.24.09.32.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 09:32:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
Date:   Fri, 24 Feb 2017 09:32:13 -0800
In-Reply-To: <22704.19873.860148.22472@chiark.greenend.org.uk> (Ian Jackson's
        message of "Fri, 24 Feb 2017 15:13:37 +0000")
Message-ID: <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

> I have been thinking about how to do a transition from SHA1 to another
> hash function.

Good.  I think many of us have also been, too, not necessarily just
in the past few days in response to shattered, but over the last 10
years, yet without coming to a consensus design ;-)

> I have concluded that:
>
>  * We can should avoid expecting everyone to rewrite all their
>    history.

Yes.

>  * Unfortunately, because the data formats (particularly, the commit
>    header) are not in practice extensible (because of the way existing
>    code parses them), it is not useful to try generate new data (new
>    commits etc.) containing both new hashes and old hashes: old
>    clients will mishandle the new data.

Yes.

>  * Therefore the transition needs to be done by giving every object
>    two names (old and new hash function).  Objects may refer to each
>    other by either name, but must pick one.  The usual shape of

I do not think it is necessrily so.  Existing code may not be able
to read anything new, but you can make the new code understand
object names in both formats, and for a smooth transition, I think
the new code needs to.

For example, a new commit that records a merge of an old and a new
commit whose resulting tree happens to be the same as the tree of
the old commit may begin like so:

    tree 21b97d4c4f968d1335f16292f954dfdbb91353f0
    parent 20769079d22a9f8010232bdf6131918c33a1bf6910232bdf6131918c33a1bf69
    parent 22af6fef9b6538c9e87e147a920be9509acf1ddd

naming the only object whose name was done with new hash with the
new longer hash, while recording the names of the other existing
objects with SHA-1.  We would need to extend the object format for
tag (which would be trivial as the object reference is textual and
similar to a commit) and tree (much harder), of course.

As long as the reader can tell from the format of object names
stored in the "new object format" object from what era is being
referred to in some way [*1*], we can name new objects with only new
hash, I would think.  "new refers only to new" that stratifies
objects into older and newer may make things simpler, but I am not
convinced yet that it would give our users a smooth enough
transition path (but I am open to be educated and pursuaded the
other way).


[Footnote]

*1* In the above toy example, length being 40 vs 64 is used as a
    sign between SHA-1 and the new hash, and careful readers may
    wonder if we should use sha-3,20769079d22... or something like
    that that more explicity identifies what hash is used, so that
    we can pick a hash whose length is 64 when we transition again.

    I personally do not think such a prefix is necessary during the
    first transition; we will likely to adopt a new hash again, and
    at that point that third one can have a prefix to differenciate
    it from the second one.
