Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25AE420357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbdGJWcY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:32:24 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34001 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbdGJWcW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:32:22 -0400
Received: by mail-pg0-f43.google.com with SMTP id t186so56539415pgb.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vVRwwa1Dx0Nn7hI0EMAaaGJ+bqEWBclG0h8Aqmlp9/U=;
        b=vX/YtcpM4G6P+ZY1k0PgcnDhf1VNgHCzI3j0XnvpWdFDuCWyxsbY5hNWbriaCM1GOx
         H7C2pfm5EoHCAo8TF7/FFq0r0X27lHVJNzzlV3/Wb3ZWj4wZmdAVj7lIHxcrApikATrq
         y3ZaioSP8FNSMlKxS/4yEqK7q1CUXDhyn7h6e94O9dIDA0QKcABxRhvdSe+07kZQGoYE
         ZqzzTbJefzbhHRJmG6fkXsIZO93aM71wKi37UxOF9088MZsfYlaDOnu3vc9V5hV24tG2
         0fIUv9WzBe5CLyrVYYrtjyET/4t/2G+XGTz11MoaYRkSGz7phnlfNL/lwiHiLblDXdJs
         VUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vVRwwa1Dx0Nn7hI0EMAaaGJ+bqEWBclG0h8Aqmlp9/U=;
        b=qDhcMkwgYKGCsUgKidkNO6OWG76/y3poEy2+qrC2l5r/JhwnqT8IwwLUQ10N2DTdeS
         44hn0VxlipOPcz+udvDf/c4h0eGW3rKlQHQR+rG1lCf2iGM/C2YpmvmFDW66tS+I6soA
         DFH4SzcFEaVNzA/V1m+M8nc612nof+Mp0p72iSOfIc7fZKTDwWl8uDty+BHYqtPpZb4z
         F10UObmilFr3fIK/QBYn1gQtUqJ4iQbrW/4OZTn88NTXvP+gvdMZL36YAt0kLn79S9WB
         Zulsh3E+IMSohvzBwMPbxUFHCGv7KXH7ynUaPj644nNuiEg9A4e0ibAw+88wGH+6arMM
         b4gw==
X-Gm-Message-State: AIVw112HzySZtiEftHz4I9dII/GjEyftjX+saVnrOZhvi+d1r/KGGieF
        rAZUBhrTVs0TizSse7nVAhtw4EOF80u8
X-Received: by 10.99.54.73 with SMTP id d70mr17219332pga.195.1499725942017;
 Mon, 10 Jul 2017 15:32:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 10 Jul 2017 15:32:21 -0700 (PDT)
In-Reply-To: <xmqqk23ldwbv.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
 <1n47so5.9e6qvf1bbqww4M%haller@ableton.com> <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
 <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
 <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
 <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com>
 <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com> <CAGZ79kbCo3EjRGR_iE=6CJ2ou=4gMv3=t+s1ctGhUbZg8UDixA@mail.gmail.com>
 <xmqqk23ldwbv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Jul 2017 15:32:21 -0700
Message-ID: <CAGZ79ka3ZA_9kE+b=bC28dG5fW3REgC0Ecfn7vie1eRiExxOjg@mail.gmail.com>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Haller <haller@ableton.com>, Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 6, 2017 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>>> index 0a639664fd..1fa01210a2 100644
>>> --- a/Documentation/git-push.txt
>>> +++ b/Documentation/git-push.txt
>>> @@ -212,8 +212,9 @@ must not already exist.
>>>  +
>>>  Note that all forms other than `--force-with-lease=<refname>:<expect>`
>>>  that specifies the expected current value of the ref explicitly are
>>> -still experimental and their semantics may change as we gain experience
>>
>> This indicates that this feature is not 'experimental' any more, but disabled
>> (for safety reasons as described below). This implies we will not change the
>> heuristic for push.allowLazyForceWithLease easily.
>
> I actually wanted to say it was a failed experiment, but I see your
> point.  Let's leave the "still experimental" label.
>

After rethinking this feature and how to make it safer, we could actually
*ask* the user to confirm the sha1:

    # implicit lease:
    $ git push --force-with-lease <remote/refspec>
    # either do an implicit fetch for the refspec first
    # or use the remote tracking branch:
    This would lose HEAD=27956ac767, including
    the following commits on <remote/refspec> :
    27956ac767 Merge branch 'js/rebase-i-final' into pu
    a1b1c5eb04 Merge branch 'sb/hashmap-cleanup' into pu
    ... and 13 more
    Confirm to lose commits by typing yes: yes
    ... normal push

But that may be more effort than this patch originally intended to be,
but I would think this makes the lease effective.

Downside is the I/O (Have we any command that is taking
user input as such? -p option for reset/add may come to mind)
and the unfriendlyness to scripts, but scripting may rely on the
non-lazy form of leases.
