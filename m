Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB8A1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 14:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfDZOc2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 10:32:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 10:32:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so4695499wmb.5
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6UQsjNAZ/HudlY5vjeqJCuK2Z0OeuNlEuoHpk++Gjws=;
        b=jbdbUEtdzGJYwND8oLtUosmN+hl7g796vqNzMORhhiVfnNyXoqY4uJJzEgA+Fq446U
         GgZeJuA9tRdfd4/f71cFAs4PX5fGZkCy1sesY1rUuRIp92ipZ//kkNH+7aNdgxIysWBA
         hes9j7mtMFXvjd+aBRux1vbCkeIS76Fq+/pjg/bb5jxQFw2IE2/94LP7Lg77zYqtJEOu
         UZxuv0NSFvW1dbMVu0SpDNqvIwF3U8knvvfYPH7wQGoKXVCRRvYFpMrZPy+pr6z8GBjj
         /+qqyp39ZDFwv60WP53m3MTXMJaTWGYvLflKDlSlXNMPTl8ZBL7nvGYq42+3ewl59nc6
         bdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6UQsjNAZ/HudlY5vjeqJCuK2Z0OeuNlEuoHpk++Gjws=;
        b=Nm+7Hx5vS10bLm74pXwBGGiSoIGrhOkChQslLJeDlGIaX19vxLA+QFtGZZxuv23ulV
         fq9a7maaQmBbMwoQYDvbUJdZAi0aHyylzVlFch1+B2X2VEE1Bi3Bd2PBpsmd9ksKcsIV
         NIeP8x6QUqNtSBymRGgJSqkGxLAxIoDiagncjCGBoB5yBmwkkhoMsOTMicM2Dua5hf/f
         7uT58rnebvRS1FrHTdpDjC2QRnvMB3vyqMtlhhttkPsbtSPcBBU6gZ6w88pA6MyNtBAC
         HZDPTYYA15Bij+5V/PEpGKLquBn7DeGdaUvu8pqEMEsRyPUYc8yXsPkFrA68nO28Z6fC
         wyuQ==
X-Gm-Message-State: APjAAAVrnWSvjWJBbCcmUcEzd9TUH6FdZpL2iVY6o5HfTEBVp1nGXa8G
        0809/utMM4zQ3aiIqxejiviL/tjkjQo=
X-Google-Smtp-Source: APXvYqyp4olsWtynrzcip1QmzRRTytIdaQl+KbveZr6lcjzguZj4SgOMegzfYqSlnI4BKxfkvqYzCw==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr8350465wme.53.1556289146140;
        Fri, 26 Apr 2019 07:32:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 10sm11692449wmd.25.2019.04.26.07.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:32:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Schwartz <jefftschwartz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Request to add option to interactive rebase to preserve latest commit date
References: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com>
Date:   Fri, 26 Apr 2019 23:32:25 +0900
In-Reply-To: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com>
        (Jeff Schwartz's message of "Thu, 25 Apr 2019 09:00:07 -0400")
Message-ID: <xmqq4l6kvnuu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Schwartz <jefftschwartz@gmail.com> writes:

> Using interactive rebase has one flaw IMHO and that is the way it
> handles dating its commit. Can you add an option to interactive rebase
> that would make it use the date from the commit that is most recent
> and not the date from the commit that is the oldest?

I am not sure what you mean by this.  If you interactively rebase
the topmost two commits (assuming that since three commits ago, you
have a linear history):

	$ git rebase -i HEAD~2

and tell the editor that you want to 'edit' both instead of just
'pick'ing, the command will give you control back for both of these
two commits, and you can say "git rebase --continue".


    o----X----Y (original history)
     \
      \
       X'----Y' (rebased history)

After the exercise, the two new commits that replaced the two
commits from the original history

 (1) retain their own author timestamp; and

 (2) record the time when these new commits are created as the
     committer timestamp.

So there is no "most recent" or "oldest" timestamp in the series
involved.  The author timestamp of commit X' (which corresponds to
the commit X in the original history) in the rewritten history is
the same as the author timestamp of commit X.  Same for the author
timestamps of commit Y and Y'.

The committer timestamp of commit X' and commit Y' are the actual
time each step of your "rebase -i" operation creates them, which
should be more recent than those of commit X and commit Y, unless
your clock or the clock on the machine on which X and Y were created
are not in sync with the real world.

