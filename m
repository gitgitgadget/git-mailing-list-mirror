Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C552A2092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750730AbdAVWZi (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:25:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64549 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750715AbdAVWZi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:25:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABF5463244;
        Sun, 22 Jan 2017 17:25:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9RAog4Yhqc9o0Oc88ggMoyaQZi0=; b=mNJjFb
        Yj52bSfuBTzB52V8qVda6+jKd+b8vJk3hLR3KjX6h8Q+aNxPFRYo0ZnPBundjv0P
        JmdnenKWEqd+kXi5Vs1gIrfBUojZ9KpceZR18Fp6AQrgh+KEYANl3BM3FoYuRGpe
        ijho6m/nrGgFSXLHyaJ7xZ+aFMMOWrfSXod6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BkZT2WSDF3JmX2sM2F4qqkjU+TrDgC7W
        zgHO2IaIY0N5La/WswdqdsrZahrYjvTLMke+LDpKGfelPxfsNqVc3Nrvxvh9aRFn
        m3HO2sh9uxsbOTDD+DLL7bsTppADCY3T4AQioJoCmCnvpHCsPMx0Ey0rjXi1Y5hY
        yOBYGPvDDPk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AD1463243;
        Sun, 22 Jan 2017 17:25:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E515763240;
        Sun, 22 Jan 2017 17:25:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Does it make sense to show tips on blame?
References: <CAOc6etZ9QeJAf1CKh9Eraigwy45yR6eO-7Th+bZRnTa71BoPew@mail.gmail.com>
Date:   Sun, 22 Jan 2017 14:25:34 -0800
In-Reply-To: <CAOc6etZ9QeJAf1CKh9Eraigwy45yR6eO-7Th+bZRnTa71BoPew@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Fri, 20 Jan 2017 23:23:04
        -0600")
Message-ID: <xmqqefzuvijl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2011248-E0F1-11E6-8379-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Output is like this (from README.txt, taken from difflame on git
> itself, sorry if it's too wide):

It is not just too wide but it is line-wrapped and cannot see what
you wanted to say out of it.

What does the word "tip" mean in this context?  The word is often
used to mean the commits directly pointed at by branches (i.e. the
tip of history), but I do not think that is what you are interested
in showing in this butchered "diff" output.

> 2a113aee9b (Johan Herland 2009-12-07 12:27:24 +0100 2227)
>         405d7f4af fast-import: properly fanout notes when tree is imported
> +405d7f4af6 (Mike Hommey   2016-12-21 06:04:48 +0900 2228)      if (!root->tree)
> +405d7f4af6 (Mike Hommey   2016-12-21 06:04:48 +0900 2229)
>  load_tree(root);
> ...

Do you mean the one-line summary for the commit?  The commits that
are shown will not be at the tip most of the time (the "+" ones may
be if you happen to be running "git show" on the tip of a branch,
but that is minority if you also want to do "git log -p"), so I am
not sure it makes sense to call them "tips" in the above output.

If I were doing the above, I would probably do them as footnotes to
keep the body of the patch text (slightly) more readable.  E.g.

	@@ -l,k +m,n @@
         2a113aee9b  
        +405d7f4af6   if (!root-tree)    
        +405d7f4af6       load_tree(root)
         ...
        #2a113aee9b "fast-import: Proper notes tree manipulation", 2009-12-07
        #405d7f4af6 "fast-import: properly fanout notes when tree is imported", 2016-12-21

> The question is if you think it makes sense to add this option to
> git-blame itself.
>
> Something like:
> git blame --tips README.txt

I do not think I would use it personally, as it would make it hard
to pipe the output of "git blame" to less and then /search things,
as extra cruft added by the option will get in the way.  IOW, I do
not think we want it for human-oriented output.

On the other hand, when output from "blame" is used by scripts (or
GUI frontends), having the one-line summary would be very useful.
But I think the authors of "blame" already thought about that
usecase and included the "summary" field in the "--porcelain" output
that are meant to be consumed by scripts, so...
