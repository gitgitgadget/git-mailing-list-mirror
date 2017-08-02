Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D826420899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdHBTyn (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:54:43 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34693 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHBTym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:54:42 -0400
Received: by mail-lf0-f46.google.com with SMTP id g25so24356414lfh.1
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lxeBBIXyqgzKDL5D7w+wWyJofb9U6UjSkApMRIqCydU=;
        b=h3XHmGQ53iKW02np+j9mFPQcFvWxqHH0F8SDmwqm7wIlPn/TSTcwjGNF6AtmFbIMHc
         YxfwpxqY02uAzsvwQWcu7n/YD7C7QufRnCh4Z1m8Pn1K0RTe+ABdmi/rbeBMWOeKRKy5
         IBfSWKbLLnH9iBFis4e0z02NESDVwoY+8oEqxc2Eki9L9vodDpP/GxvRKQIZTxlsxC+W
         fER+Oh3MryTyrSq+fPFp//2yDiBzQM+JEVEOpJ1Q60IFnZH66uCkRIM5wGGi9qopKKe0
         Oqs2IlUfvhq7MbXNylyNpikZlfhvuRjUMQC27mcRz/vx6bBJKdwntLmfNCm6lQhUOPr5
         yJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lxeBBIXyqgzKDL5D7w+wWyJofb9U6UjSkApMRIqCydU=;
        b=O9x+Yt8BKXSxmDczE3Ltlk5eUgYNZ9HHc2+FEV+Q4SyC37Oprd8TtA/EEyf+R11oSs
         FjSiVy5P7IAvbD0mFvhbH6nJzS3SkNyzP00x3Scnp+Dh0pot7xYLuhwaMSvkAzkBcFgz
         Yz8q8c/L+NbaeG1owM2tvK5ljijQZg380Ixyot/ykxynkzSYa52FXJsyB9mtMHlbL/kc
         JdxrEokr+HQIMv3zUDNLbtgY8zlUUZbWGdOR7hN4Q/QWxmOlhm8vLyA0p2B+pfwRlkkq
         vVxUxDa0fY7vvgm+e306qSfHSSV4CROX+kBjCzobh6Tn7X6kSXCGLFJbP++xsbsY04Fg
         8Usw==
X-Gm-Message-State: AIVw110nyy7iunzczHNWn1XlUn2/jF2p32hrZXGkDu0hkkYe98e2/MH7
        j+uDhMenx0RHz3BmXe2KrLEkFVi/EeU2
X-Received: by 10.46.20.88 with SMTP id 24mr8402330lju.51.1501703680922; Wed,
 02 Aug 2017 12:54:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 2 Aug 2017 12:54:39 -0700 (PDT)
In-Reply-To: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 Aug 2017 12:54:39 -0700
Message-ID: <CAGZ79kb5UjxQFpQWy-muCwkuQsmuxQcKfs4f5HGenGSb+SiOhw@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> ### Ref block format
>
> A ref block is written as:
>
>     'r'
>     uint24( block_len )
>     ref_record+
>     uint32( restart_offset )+
>     uint16( restart_count )
>     padding?
>

So I learned that your current writer is a two block pass,
i.e. the block is first written into memory and then once
the block looks complete it is written out to disk.

This would allow us to shuffle the data around during
the actual out-to-disk-phase, such as this:

  'r'
  uint24( restart_count )
  uint32( restart_offset )+
  ref_record+
  ref_record_endmarker
  padding?

(A) In nearby emails we discussed to have the restart offsets
to be 24 bit, but now they are 32-bit aligned to the start of a block
so we could keep them 32 bit for simplicity of reading.

(B) Note how there is no block_len encoding, which was originally
only needed to lookup the position of restart_count. (so even for that
we could rename it to padding_len, such that the position of
restart_count can be decoded easily)

We no longer need the block_len as the restart_count comes right
after the 'r'.

Instead we'll have a ref_record_endmarker that reads as a ref
with both prefix and suffix to '0', type deletion (such that there is
no further cost). The end marker would only need two '0's, which
makes it indistinguishable from padding.
