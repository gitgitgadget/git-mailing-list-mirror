Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E117201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 00:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbdKNAoe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 19:44:34 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:48589 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbdKNAmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 19:42:40 -0500
Received: by mail-qk0-f175.google.com with SMTP id a142so22112195qkb.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 16:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BkvIiG+EhUJJkvWFvgFpQ1zKqfIRngdqEfdxlsFzmuA=;
        b=NAoAtz5cmHJlW6yhPua9Km5rLYA1q9gtHsU0WJIjo2YdhuLkxRplnpGMyZ+HCuYAI+
         lL85hbNU3L+tLFgMUVZUd1/MTq9XG7KDSGQ3b0nUBNxA0m3QpiEC1esKGn7phmNr4IDU
         Kk8Tmx4cihqV+XcpUUw9/J+8fkKhIlIK8pMxxVVJqh2jqyvphtzWWbmC++fyl9S9QV0Q
         9UxpJaLm5yLOhhlKYz36dmbkAGWnEKD6KOROqWNFPl0Jj5Tfj/wpeAG0zEOkRNjWfGKJ
         5iJYuu3b+GPW8nrpfsQ6BZxV65RwrU1Iojr9nUGQhcpzBLfagsXiRCCidCkHQy6Td1aG
         Jhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BkvIiG+EhUJJkvWFvgFpQ1zKqfIRngdqEfdxlsFzmuA=;
        b=MfnfME4xPuMAKufiLFZ4ujaP/cuXhIoYWtGPQkLX5Z2+j+ef/tlAfO1BBRoffaTMe+
         ryh/VYNCiY3fruBBLjg7bi8K7gVUOOjf0vNZROz4JGdGuJONpt6SeM/HlxG9F6Y1NLGn
         lf4rkWACq0DffSl9vhgFujWmYAmw7uS2UEUW8usqeWRcNAOClkfaogd6K8WEnU5nSjWr
         YQ3Yxe1T7aL7wtMP5eaiBEPY9nY8otr3K4qSbEkeVnMWa4toWYt13zQ2xtsyla2hQ7c5
         VH8tuoqgzU+jC/owXkOVjwvxUFeNre2AnfViCxKvRKzq2Il3xjHPtvMBn1/E7kiVY6wy
         /Ukw==
X-Gm-Message-State: AJaThX5r4Y/iHVBdvtviIyW1XyFXrlxBTgH1IuaN/RosvEcnNU2lq08w
        0Jm6n74It6dNd6c1c4hzN1+nXjKA2keE8yttz8SNsg==
X-Google-Smtp-Source: AGs4zMbqM+vhXN2s/6I9NTsF3VhXA1VdNs3mqeNEsZ+Kjm+T0fH1eMtEBAP2fuvsZ1DKfJtf+9V2fsNrLNYEjmq+fYI=
X-Received: by 10.55.125.196 with SMTP id y187mr17803578qkc.180.1510620158916;
 Mon, 13 Nov 2017 16:42:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 16:42:38 -0800 (PST)
In-Reply-To: <20171110190550.27059-11-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-11-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 16:42:38 -0800
Message-ID: <CAGZ79kaDWxx2g2OMY-VKJZD0-0t7V33644aqPLHq5Hppo_Be+w@mail.gmail.com>
Subject: Re: [PATCH 10/30] directory rename detection: more involved
 edge/corner testcases
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:

> +# In my opinion, testcases that are difficult to understand from this
> +# section is due to difficulty in the testcase rather than the directory
> +# renaming (similar to how t6042 and t6036 have difficult resolutions due
> +# to the problem setup itself being complex).  And I don't think the
> +# error messages are a problem.

"In my opinion" ... sounds like commit message?

> +# On the other hand, the testcases in section 8 worry me slightly more...

The aforementioned section 8... :)

> +# Testcase 7a, rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file
> +#   Commit A: z/{b,c}
> +#   Commit B: y/{b,c}
> +#   Commit C: w/b, x/c, z/d
> +#   Expected: y/d, CONFLICT(rename/rename for both z/b and z/c)
> +#   NOTE: There's a rename of z/ here, y/ has more renames, so z/d -> y/d.

But the creator of C intended to have z/d, not {w,x}/d, and as {w,x} == y,
I am not sure I like this result. (I have no concrete counter example, just
messy logic)


> +# Testcase 7b, rename/rename(2to1), but only due to transitive rename
> +#   (Related to testcase 1d)
> +#   Commit A: z/{b,c},     x/d_1, w/d_2
> +#   Commit B: y/{b,c,d_2}, x/d_1
> +#   Commit C: z/{b,c,d_1},        w/d_2
> +#   Expected: y/{b,c}, CONFLICT(rename/rename(2to1): x/d_1, w/d_2 -> y_d)

Makes sense.

> +# Testcase 7c, rename/rename(1to...2or3); transitive rename may add complexity
> +#   (Related to testcases 3b and 5c)
> +#   Commit A: z/{b,c}, x/d
> +#   Commit B: y/{b,c}, w/d
> +#   Commit C: z/{b,c,d}
> +#   Expected: y/{b,c}, CONFLICT(x/d -> w/d vs. y/d)

CONFLICT(x/d -> y/d vs w/d) ?

> +#   NOTE: z/ was renamed to y/ so we do not want to report
> +#         either CONFLICT(x/d -> w/d vs. z/d)
> +#         or CONFLiCT x/d -> w/d vs. y/d vs. z/d)

"neither ... nor" instead of "not either or"?

> +# Testcase 7d, transitive rename involved in rename/delete; how is it reported?
> +#   (Related somewhat to testcases 5b and 8d)
> +#   Commit A: z/{b,c}, x/d
> +#   Commit B: y/{b,c}
> +#   Commit C: z/{b,c,d}
> +#   Expected: y/{b,c}, CONFLICT(delete x/d vs rename to y/d)
> +#   NOTE: z->y so NOT CONFLICT(delete x/d vs rename to z/d)


> +# Testcase 7e, transitive rename in rename/delete AND dirs in the way
> +#   (Very similar to 'both rename source and destination involved in D/F conflict' from t6022-merge-rename.sh)
> +#   (Also related to testcases 9c and 9d)
> +#   Commit A: z/{b,c},     x/d_1
> +#   Commit B: y/{b,c,d/g}, x/d/f
> +#   Commit C: z/{b,c,d_1}
> +#   Expected: rename/delete(x/d_1->y/d_1 vs. None) + D/F conflict on y/d
> +#             y/{b,c,d/g}, y/d_1~C^0, x/d/f
> +#   NOTE: x/d/f may be slightly confusing here.  x/d_1 -> z/d_1 implies
> +#         there is a directory rename from x/ -> z/, performed by commit C.
> +#         However, on the side of commit B, it renamed z/ -> y/, thus
> +#         making a rename from x/ -> z/ when it was getting rid of z/ seems
> +#         non-sensical.  Further, putting x/d/f into y/d/f also doesn't
> +#         make a lot of sense because commit B did the renaming of z to y
> +#         and it created x/d/f, and it clearly made these things separate,
> +#         so it doesn't make much sense to push these together.

This is confusing.
