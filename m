Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435841F461
	for <e@80x24.org>; Tue,  3 Sep 2019 14:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfICOV4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 10:21:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37688 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICOV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 10:21:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so16263062lji.4
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEnqv2wu+B81yRRZnhNWlBiCJSSjRkIZ8khKHi/49ZM=;
        b=YBSwz/s/07+Fh/0H/EcV2Bh+3CRMAgsfQ/F3Lf+fmA8+LoQVnosx0Jy3MJIbFzOZqR
         eAgKpm1oQKG5G1xTzXfXrSIk3pKWsIEC6WoO3g/1UWOfp9eXfsGisByEgOuNfkF3QWVV
         lqkbE9OE700IhwcGQ28P+KAoWGqDNiPEsAJseq0E6kwRNrEf1or1W92fY+0bZ4B8jy5g
         vSS4+C/giVMW704QCH1Mi09IEYvTZU3w8yX1O84mrCktcOTmuGHPC1QbVAUjeGAvtCyg
         E82nkEvpTw0H+kft8LVAw5YIJH9qILCBqZnet7Vf1T6QY7409B/ozgMEf0L/6CoavtPM
         ynUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEnqv2wu+B81yRRZnhNWlBiCJSSjRkIZ8khKHi/49ZM=;
        b=SguYx4qsbNsX5rL4VivqtSag36hndIqRnchIe05f6tTYVv3kv3Op6K9VOwltPF2INS
         VAVrpmw0FkJPop6B+DfvQD4nmfP4Jzgim1PK6FO06F0aKM54UHrZQXiN06XWSJl64I07
         4/sIhAz/j1rIcZ3co0Kh9PGG5FnNlhMeQMcABG6sKnMYHD+mjbJ4i+twk7iADwXzDLoV
         8gkOcr4KPw9juiKEJ2tP6zjnywWcPUozPI/rxINCm3TcQQJE9aaE7smgYB5xLB3fZA7e
         4qlCXcSeqJ0G5jxdr5uIMz/uA1LV6fTiY0fBDG0vNCGAEaj9cfHSIV5Xpwx+FsaSt7oi
         clqQ==
X-Gm-Message-State: APjAAAUwEZCM2r70B58PfBL6LY9coKYU8n4gfi2I1bWeudV6RE9JiirQ
        iWG5AFn6I8Qrqku0xG6Jlok0Fq80wyX5F8azlfzAORfEd3M=
X-Google-Smtp-Source: APXvYqxWxmbRemcvaXkq9QUsD8AsIt30KPB5XEl5WZ/0Qv39dKy1wpGuRUPY+UMLpkvwjcBam2l+Aw/SEmVRS6sku7Q=
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr18995520ljm.94.1567520514102;
 Tue, 03 Sep 2019 07:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
 <20190901193652.21086-1-birger.sp@gmail.com> <CAKPyHN0LtOG9mFQ6qxc-w-EdpJ3HGJmHAGdrGp2FKkq4uCf55A@mail.gmail.com>
In-Reply-To: <CAKPyHN0LtOG9mFQ6qxc-w-EdpJ3HGJmHAGdrGp2FKkq4uCf55A@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 3 Sep 2019 16:21:42 +0200
Message-ID: <CAGr--=L=iUxAOGwwbQwVB5OwmNoXorBXgehMfiC5gvfgUQEa9g@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,


On Mon, Sep 2, 2019 at 9:42 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> So we only remember the lno in the widget, that could mean, that we
> select the wrong file after a rescan, which shifted the previous path
> one down. Can we remember the pathname instead, and try to find this
> again in the file list?

Seems to me like a rescan makes git-gui select the first file in the
list, regardless of this feature (patch) or not. Ideally, git-gui
would not do this. It should select the same file that was selected
before (if it can). But honestly it seems like a separate (perhaps
broader) issue. My biggest issue is not having the hotkeys, and that's
what I'm trying to mend :-)


> can we name it 'focus_and_select_path_in', as the main job ob this
> function is to focus the widget. It makes also the 'bind' command
> below more readily, because than all bind commands start with 'focus'.

Agreed.


> > +       global file_lists_last_clicked
> > +
> > +       set _list_length [llength $file_lists($widget)]
> > +       if {$_list_length > 0} {
> > +
> > +               set _index $file_lists_last_clicked($widget)
>
> I have the impression that variables starting with '_' are mainly used
> as read-only global variables, see the list at line 158, and not that
> often as temporal local variables.

Agreed, I'll rename it. It's been almost a year since I wrote this
patch so I can't really remember my reasoning for putting the
underscore there.


> I would like to bring up a proposal: AFAICS, more or less all CTRL
> bindings have a menu entry. But it does not make sense to have a menu
> entry for these bindings. And I think we could add more bindings for
> keyboard-afine users. Thus I would like to propose to use ALT as the
> modifier for these bindings, which would give us a nice binding
> classification.
>
> How about that?

Makes sense. And the ALT+1/2/3/4 seems to be unused for anything else.
At least on Windows, maybe on other systems those keystrokes are
already in use?


Birger
