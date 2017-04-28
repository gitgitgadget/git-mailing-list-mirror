Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617CC207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 02:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164431AbdD1CI1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 22:08:27 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34601 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162764AbdD1CIY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 22:08:24 -0400
Received: by mail-pg0-f68.google.com with SMTP id t7so3010598pgt.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 19:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EMBawO8KQborDllb5snv63RZCpRZVVf4FtwZs87FYRw=;
        b=TAUhMCQEmZBJGdp4M/no6x1kGx/c7HLhSti9mYX9M+MfglB+pJ+rZQ+sV3TRxtJSkl
         37JNJVGl2pQqTCwKr/+DQ4sgmoU66FWkRDnfsg7V0dHKjJ4zqgKcyzmHvdTseV2S6pWM
         qeNVTFOXucnMKAClKDzGOqYYF25YG2hnaua1s7+0BPXETAXzSk5z6sFOD9zdzEx9Mqzg
         EumK2f/x48m/SjNsKHixBg6cJsd/wWrlv4pG21+lkvdIJQxShwwD25dNtPxkuU8irrQF
         xPWK+gvZUAuaMXkMZcWDjhkGEeJQFoSPfQg17i8pL04PwBTjhSUVAqhxT3pwSW3c5r6c
         TCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EMBawO8KQborDllb5snv63RZCpRZVVf4FtwZs87FYRw=;
        b=MmuzcnFifwjaqSTS3dPltftmzyvP22DX5rs6yPQcTlRWb2Ww7rINhTK/oGnqErZG/9
         KoI8Z50MqO2q0enKHVkLGRyc8ZUKck9r5Adlg7zHdGccA/Xg9VxeWqyYQrh0tNuuDZaW
         b/tlROMM8Fxoz+u/6qnalpk1MVCpcFpGTen9UBZAXiGbUZouKRbQL7zvi3JLXUrrUfNy
         azIvNArGxwYKjSH+92dcPKUl163DMWyykQfZZBscj9VhPMhnoxhxJXTnENQuE2334Fc+
         4ZEDk4WQjnQRT2y6KjonsNlCedSCNyLVKhCyJ1UaKj7rhuuIjA5dbh7Mbrx0H/NmKhC/
         yoyQ==
X-Gm-Message-State: AN3rC/4gaF9nG/riqXXNkkiA2zwlQBYHMf6pDY+QH/dODDFi6czOXv9F
        6BFqcfId3YEy+w==
X-Received: by 10.84.141.168 with SMTP id 37mr11692416plv.75.1493345303250;
        Thu, 27 Apr 2017 19:08:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:51c2:e137:8e5a:b68b])
        by smtp.gmail.com with ESMTPSA id h27sm6957435pgn.24.2017.04.27.19.08.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 19:08:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Stefan Beller" <sbeller@google.com>, "Jeff King" <peff@peff.net>,
        "Orgad Shaneh" <orgads@gmail.com>,
        "Dakota Hawkins" <dakotahawkins@gmail.com>,
        "git" <git@vger.kernel.org>,
        "Christoph Michelbach" <michelbach94@gmail.com>
Subject: Re: Submodule/contents conflict
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
        <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
        <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
        <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
        <C3A8A88B8DDD468095B7FD256330EEF7@PhilipOakley>
        <xmqqa873ubiw.fsf@gitster.mtv.corp.google.com>
        <DAB03BFCBBCA4C4F95D21A86E3B1DF2F@PhilipOakley>
Date:   Thu, 27 Apr 2017 19:08:21 -0700
In-Reply-To: <DAB03BFCBBCA4C4F95D21A86E3B1DF2F@PhilipOakley> (Philip Oakley's
        message of "Thu, 27 Apr 2017 23:07:57 +0100")
Message-ID: <xmqq37ctmgh6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> In the modern day, it might be useful if the "--working-tree-only"
>> mode added a new file as an intent-to-add entry to the index, but
>> that is not what "git apply (no other options)" (which is the gold
>
> did you mean `git add` ? Or am I missing something.

I did mean "git apply" that applies the patch (0) only to the
working tree by default, (1) to the index without touching the
working tree with the "--cached" option and (2) both to the working
tree and the index with the "--index" option.  As "git add" is all
about the index, having these three modes wouldn't make much sense
there.

>> +'git checkout' --working-tree-only <tree-ish> [--] <pathspec>...::
>> + Similar to `git checkout <tree-ish> [--] <pathspec>`, but
>> + the index file is left in the same state as it was before
>> + running this command.
>
> I feel that the docs should also contain a little of the commit
> message highlighting that `This complements the usual convention of
> "--cached" and "--index" options for other commands.`, and would pick
> up on Stefan's "I didn't know that" response - A little education of
> the reader goes a long way, maybe ;-)

I do not think "If we were building Git from scratch today without
having any existing user of `git checkout`, we probably would have
made this to be the default mode of operation, and instead required
the user to say `git checkout --index <tree-ish> <pathspec>' if the
user wants checkout to affect both the index and the working tree,
to be more consistent with other parts of the system" would help the
readers of the current system very much, even if we were promising
that such a more consistent system may come in a future (and we are
not, at least not yet, with this addition).
