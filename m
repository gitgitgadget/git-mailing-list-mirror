Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72D11FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdBHW43 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:56:29 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34369 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdBHW41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:56:27 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so16005223pgv.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UUjhnT47UJfr3YgyxCjz2qQDYz67W0qSAVNe6yKhZYc=;
        b=dhYX/zlqKzZHS1duPoQJXjl9ePzcGyy2XqbIo5xrBf1OJXTkTye5n4tkaSwPVkjPpk
         xDbhMzIb4CKPwC395m2igROSflVJRoD2F/zgRZCRzAO4o1SVnF7tvd5iuo9owZjfveFI
         6cXGg1vjN41It3yKAVMGuuiIP9WXYXtJExet8qVrEbVcZjQZW4wMPtzKwSmrjPefzFOa
         DtGq8/GULG9T9V9GNPsJciKjRKB4CvQg6S4/wyxI9px6GqjLamquqLc6T3ju187iUP7M
         YoIM/epTcD5UHkvkuMqRGRJpKYRzm34VrMLb8gMzRiUoAr335/OSmclW7gylkXccSBQM
         fKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UUjhnT47UJfr3YgyxCjz2qQDYz67W0qSAVNe6yKhZYc=;
        b=P498nsXuuUUdwJ7THrYq/WemT7HqE9GQlwoKQEN7kLnXeQbdvkm8T3ErjXFtyuLfpW
         K+V+vrObDIKFZtR9aLy/fjcvjhf44IJOhFBLkIZYdeSYmlnStmwjqdMQQTAB5ltYakIs
         Ob3cKpilV2nx41KIfH4pL4VisXSfLci+HXGVmWTTHL5uIDqU3iidJ0N0o5JjvZ05LLLz
         5S6KgaEcvTmuuZivdilbl+gMWDMNMCJMupDWXJOOgDPOp/vDdrQk4zNs7o/wWmgmZYAc
         ktOcHd/n7vKya2YEpvy127D7ZDCHgIiHhw+86yV9354gM8FIzrCK7HzqM121PkP2c5oQ
         vRyQ==
X-Gm-Message-State: AIkVDXIVxnsGXWAyshX4Dh3/snSZMc/RJax+3gCl+Hgw035JkF0VBJ6DjPvLuUtTdqfGEw==
X-Received: by 10.84.151.9 with SMTP id i9mr27560387pli.122.1486588266428;
        Wed, 08 Feb 2017 13:11:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id y201sm22740567pfb.16.2017.02.08.13.11.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 13:11:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
        <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
        <alpine.LFD.2.20.1702071739060.17609@i7.lan>
        <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
        <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
        <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.20.1702072112160.25002@i7.lan>
        <CACsJy8AQmg+oRYATU8_gR6zY-=sPN3m9PKtk-kytkSKGK+GG1g@mail.gmail.com>
        <xmqqy3xgwpiq.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 08 Feb 2017 13:11:04 -0800
In-Reply-To: <xmqqy3xgwpiq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 08 Feb 2017 09:39:25 -0800")
Message-ID: <xmqqwpd0v15j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you know offhand which callers pass neither of the two
> PATHSPEC_PREFER_* bits and remember for what purpose you allowed
> them to do so, please remind me.  I'll keep digging in the meantime.

Answering my own questions, here are my findings so far and a
tentative conclusion.

With or without the patch in this thread, parse_pathspec() behaves
the same way for either CWD or FULL if you feed a non-empty
pathspec with at least one positive element.  IOW, if a caller feeds
a non-empty pathspec and there is no "negative" element involved, it
does not matter if we feed CWD or FULL.

There are only a handful of callers that pass neither preference
bits to parse_pathspec().  Here are my observations on them that
tells me that most of them are OK if we change them to prefer
either CWD or FULL:

 - archive.c::path_exists() feeds a pathspec with a single element
   to see if read_tree_recursive() finds any matching paths, to
   allow its caller to iterate over the original pathspec and see
   if there is a typo (i.e. an element that matches nothing).  It
   should prefer FULL to match what parse_pathspec_arg(), its
   caller, uses.

   The caller probably should refrain from passing ones with
   negative magic.  I.e. "git archive -- t :\!t/perf" errors out
   because checking each element independently in the loop means
   that ":\!t/perf" is checked alone, triggering "there is nothing
   to exclude from".

 - blame.c::find_origin() feeds a pathspec with a single element,
   which is a path in the history and does so as a literal, hence
   no room for "negative" to kick in.

 - builtin/check-ignore.c::check_ignore(), when argc==0, does not
   call parse_pathspec().  It does not take any magic other than
   FROMTOP, so "negative" won't come into the picture.

 - builtin/checkout.c::cmd_checkout(), when argc==0, does not call
   parse_pathspec().  This codepath will get affected by Linus's
   change ("cd t && git checkout :\!perf" would try to check out
   everything except t/perf, but what is a reasonable definition of
   "everything" in the context of this command).  We need to
   decide, and I am leaning towards preferring CWD for this case.

 - revision.c::setup_revisions() calls parse_pathspec() only when
   the caller gave a non-empty pathspec.  This pathspec is used for
   pruning log traversal (e.g. "only show commits that touch these
   paths") and is affected by Linus's change.  It should favor
   FULL.

 - tree-diff.c::try_to_follow_renames() feeds a pathspec with a
   single element as a literal, hence no room for "negative" to
   kick in.

So, I am tempted to suggest us doing the following:

 * Leave a NEEDSWORK comment to archive.c::path_exists() that is
   used for checking the validation of pathspec elements.  To fix it
   properly, we need to be able to skip a negative pathspec to be
   passed to this function by the caller, and to do so, we need to
   expose a helper from the pathspec API that gets a single string
   and returns what magic it has, but that is of lower priority.

 * Retire the PATHSPEC_PREFER_CWD bit and replace its use with the
   lack of the PATHSPEC_PREFER_FULL bit.

 * Keep most of the above callsites that currently do not pass
   CWD/FULL as they are, except the ones that should take FULL (see
   above).

Comments?
