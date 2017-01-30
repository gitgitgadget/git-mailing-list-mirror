Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5802020D11
	for <e@80x24.org>; Mon, 30 Jan 2017 21:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbdA3VIo (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:08:44 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33455 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdA3VIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:08:43 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so24096881pfg.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YeEKZi8QZe4DyM76mdJLNVKLa8H+EgR9O5oDIj0RLjs=;
        b=cacou9b1HarSL8ZWwX55oWNoKWmUUUynaXB0W0JPTKd1/z+inP+SI3p4ImWeG5/VXK
         X8aIFz0AHUBEG5Vq4eRguD7dlu3GnADKMxbP6RqBShwYg91hDyOC2udTQ3vaBCkT5QBF
         2xOCGhnxKB4l2lA7/DlHwucw8KJRlfLQrgAjlyQnx5VijVeQF3d0g45aQMsKSsfZHutP
         mD8eum7Rs3F+i+kK59mXBYZpUelyw0LikeBa6bJDHVdPS9vsW4sKkZB4Dfzc5vYm7O5+
         sAJPoODskOmB5FgszTgU58TCfdzI/pCnlG2hxgLItiuKjlE55HH4UAK5baJOq45q17e1
         MlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YeEKZi8QZe4DyM76mdJLNVKLa8H+EgR9O5oDIj0RLjs=;
        b=BDij0ogDmHjDm4KVuqAP+cjxkNPcLQAxZ1z2M/oZluerLNKNiZoOJtqNMJEou9ogok
         wZgllqhtYmSE0bRy0+YRzaUFJPDAmjgg0ktsmg5d4xxsHox3raAVQga/5/Zj0ki6pJ8z
         4RED7i4fJzQ0SvTgpU4m9dBq3+DWiLbWk4kkzVw7BnvXCx9iDzY34gebxkDCnM+HP9C0
         KtY1KXnusy2P75z5wnaH4/jrpi/v4fH8WWOZknVjLQ518gH6y6Lf6oF7b4bbkfG48lYi
         iYC9G8WHqL87sWio4Zw5pw4U2HjcdPkQ19j9hzfUjKO5TJXdOCD9woU1oo9jkKDWQ4bU
         QB0g==
X-Gm-Message-State: AIkVDXI2G2XvjxUs2X1EV3nPuCF8B3Oas14oevpxmGeaToUWGabEN79fcS0MSv54M5XAcQ==
X-Received: by 10.99.143.18 with SMTP id n18mr25731489pgd.133.1485810522927;
        Mon, 30 Jan 2017 13:08:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id c204sm34853486pfb.51.2017.01.30.13.08.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 13:08:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: difflame
References: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
        <20170128035321.yrcqwkg2fiwadxj4@sigill.intra.peff.net>
Date:   Mon, 30 Jan 2017 13:08:41 -0800
In-Reply-To: <20170128035321.yrcqwkg2fiwadxj4@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 27 Jan 2017 22:53:21 -0500")
Message-ID: <xmqqd1f4uug6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 17, 2017 at 11:24:02PM -0600, Edmundo Carmona Antoranz wrote:
>
>> For a very long time I had wanted to get the output of diff to include
>> blame information as well (to see when something was added/removed).
>
> This is something I've wanted, too. The trickiest part, though, is
> blaming deletions, because git-blame only tracks the origin of content,
> not the origin of a change.

Hmph, this is a comment without looking at what difflame does
internally, so you can ignore me if I am misunderstood what problem
you are pointing out, but I am not sure how "tracks the origin of
content" could be a problem.

If output from "git show" says this:

	--- a/file
	+++ b/file
	@@ -1,5 +1,6 @@
	 a
	 b
	-c
	+C
	+D
	 d
	 e

in order to annotate lines 'a', 'b', 'd', and 'e' for their origin,
you would run 'blame' on the commit the above output was taken from
(or its parent---they are in the context so either would be OK).

You know where 'C' and 'D' came from already.  It's the commit you
are feeding "git show".

In order to run blame to find where 'c' came from, you need to start
at the _parent_ of the commit the above output came from, and the
hunk header shows which line range to find the final 'c'.

So...

