Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CC01F6C1
	for <e@80x24.org>; Tue, 16 Aug 2016 04:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbcHPEG6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 00:06:58 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35649 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcHPEG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 00:06:57 -0400
Received: by mail-io0-f174.google.com with SMTP id m101so97049331ioi.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 21:06:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l0Lo9EpruCEZNXW/nBBKNlIiPAjOBeZWzP3/iy+9RT8=;
        b=PokaeTaWjuQpGVYPV0Dj6iI0wa4fN9fjQm9GpFlhuIrq5wcvQaijDWBuHhWC5mEM4H
         Fbg8UwxL0kIvIRGbXhJJ24jlO4vytmYQI2GC4pBvJz9Yn/O0PW7g13sXJZg8JSsuBoyc
         8OxVBI8ffngc4p+HhmpYyyh3uldg3D5uJQYFCNS7ZqrFBmLB5ZN5w8XQ1ZPZzJEt4tGb
         sEfN1LIP12SKFfdBoShh27N4zNTXIS00VLuJ9PN1TOjikaA+za/rnHjuRWnislIxa7IM
         pjYNHM31BJFy0eHE0jP5oh/J05n4q/Q6sUqkc7FoARGMBUjkOz3xqlD2xQAF0dMrXNV3
         Z9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l0Lo9EpruCEZNXW/nBBKNlIiPAjOBeZWzP3/iy+9RT8=;
        b=MMqHilPiFWeooxOY/akW73sFXu6MvBw/oRhRaSSeZmtuwPREyLRpaVHT0BKTfnaXWG
         QzTDypJmeAtr35QbS5otCX6g4534gb4KZbBVXHM0byib91dh3pc7209FxNU8qFhwX9IR
         aydl1IQaAJbKHsd14ZfcH/dRZpAhL0dmP7DuQMS44+hw7kncqvaCKehB/QcQ1670WVcd
         v3aBqdf3naefKw1FT2CSiLCfIRenMpl4bWRXbiSHgken3kRIF7sgae3ftTaV/euJBdlx
         Ttw76BC1PLQkYd5EnL6Aims0yviYcddnwj0JEhRy2MEPMaQIf7ixZkWmhQL2jwZoOV/y
         7iKQ==
X-Gm-Message-State: AEkooutuy2QrSgJ2rhJmW+v6bv0PBFTV/vYUInlx+Pe9iJn2eSwXUEs3epndOFXNdo2FCA9kwmpEKxt0chrRxg==
X-Received: by 10.107.146.195 with SMTP id u186mr36333473iod.112.1471320416690;
 Mon, 15 Aug 2016 21:06:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.32.147 with HTTP; Mon, 15 Aug 2016 21:06:56 -0700 (PDT)
In-Reply-To: <20160815185500.htgrz3t2wkztg4ww@sigill.intra.peff.net>
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
 <20160815120916.6iobqirqbg76exms@sigill.intra.peff.net> <8737m63phh.fsf@linux-m68k.org>
 <20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net> <xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
 <20160815185500.htgrz3t2wkztg4ww@sigill.intra.peff.net>
From:	Eli Barzilay <eli@barzilay.org>
Date:	Tue, 16 Aug 2016 00:06:56 -0400
Message-ID: <CALO-guvVMFitNdGYEonXZ9rh8g8=L9gZojXVUu7FO2_0ki24EQ@mail.gmail.com>
Subject: Re: Minor bug: git config ignores empty sections
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:55 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 15, 2016 at 11:28:20AM -0700, Junio C Hamano wrote:
>
>> I notice that we have thought about all the issues when we last
>> discussed it in 2013.  Refining a message from the earlier thread,
>> as it illustrates tricky cases in which we have to be careful.
>
> Thanks for digging up the threads that I was too lazy to find.
>
> I agree with most everything here, though I would be happy if somebody
> even wrote a patch to handle the "easy" cases.

So it sounds like removing an empty header is problematic in most cases,
but adding a new variable to an existing empty header should not be...?

I looked at the code, and had a rough sketch that works as follows:

* Make git_parse_source() call the callback in a special way to note
  that a section header is seen (I hacked it by passing a special value,
  a pointer to a global string, as the second argument)

* Add a new store.last_section_offset field

* In store_aux(), if it's getting the special value, and the section
  name matches, save the offset in store.last_section_offset

* In git_config_set_multivar_in_file_gently() right before the "write
  the first part of the config" comment, test that
      (store.seen == 1 && copy_begin == 0 && copy_end == contents_sz
       && store.last_section_offset > 0)
  and if so, write the contents up to that point, and set copy_begin;
  if the condition is false, do the same thing it does now

* A bit after that, add "&& store.last_section_offset == 0" to the
  condition that decides whether to call store_write_section()

It looks to me like something like this can work, but it's very hacky
because I wanted to see if it can work quickly, and because I don't know
if this kind of a solution will be wanted, and because I don't know
enough about that code in general.  Making it be an actual solution
involves a better way to call the callback in a special way (my hack
does the special thing only if `fn==store_aux`, but it shouldn't),
calling it after the last variable in a section is seen so it's added
after that.

So, will something like this be acceptable?  If so, is there anyone who
I can ask questions about the code?

-- 
                   ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
