Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8224A1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeILAsM (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:48:12 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34842 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeILAsM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:48:12 -0400
Received: by mail-yw1-f65.google.com with SMTP id 14-v6so9703463ywe.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ir5bVyVZZ1FJQkw41HUf4iKHVtVZyWRiNsdWcK72pRg=;
        b=MbkIbnlkAWIFGDYARbRCUN0P7nDhphLRxo3tUNthwsWGtYWIjAZ+Tlm3QyPhPXJrly
         lQdnBgrooeoVKzu1KfWdMBFgS+q2KXtsjfGa8N0N/IScPjT2zZ2gjyRhkvjffkya1JPB
         Ie6GZU2UqW00gF07NZeAcvtn8M7MFGQT2nG9jeR0EjtDOHFljPk0UjCqqxJj8Pur/CUu
         S6RjX38wPLHWlavpcGnAn6zgYmVtoUf2hjNrDQEZLpiwIPXnaLxn22mEGGLwArCwJpnW
         v+9TLhexEOcSIrnizjJJjAlMvAFc2KgxbBBUOo5/JXzivnahQ1s+JCYo9Y5D4MHvcRf0
         NZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ir5bVyVZZ1FJQkw41HUf4iKHVtVZyWRiNsdWcK72pRg=;
        b=rr4/AjCQZKVhYgI1Hxt8PG8ow4zgC1xRunGESrvyAMZBqqVrUzwTkc6vhCRJod0Wwe
         cmiotxfHBHTbi13L+uac4V5po1E3V/EVk972D8Wo5WKzNzUaP8bD7Yzd8sq2JIp30AQR
         fSYdBrqTWPj7AYpNawA4gb4wgYvtXtCQUxcHy/YZgLSkoWLQ0Yvewc7HFvz93T9Qk4Zh
         CaZskkJFWeePuQ5nMmdc58kbxzarQb+qm8qkxyIDSno7I0J99dED9m52AJ0+5Cbgpn0a
         fYZXhHWc6Yd1DMNGrb+pa9z/VySOaAc1JuYcPtH3l7aRC4mlIs8jpCTDm4l0FWADurqv
         IWtA==
X-Gm-Message-State: APzg51CBJPVdnr0hB9dOkMdEDeIS1cSrW3q4dEAaX26mOj5zdNqJz36U
        9eAkKlowu3kr933Si0DpiwKx2/3sD9sAkuwnb4GzrA==
X-Google-Smtp-Source: ANB0VdbIWnRPwS6x63Fd2LOek+iVNWOqjerf2hEm6OdWdY7Kn+3y/io1j6/BM67m8EM2MMJhLKBOiYTiHVx2wQhobJM=
X-Received: by 2002:a81:5bc6:: with SMTP id p189-v6mr13126636ywb.370.1536695242313;
 Tue, 11 Sep 2018 12:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com> <20180911184850.24891-1-sbeller@google.com>
 <xmqq1s9zq1gm.fsf@gitster-ct.c.googlers.com> <xmqqworromq4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqworromq4.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Sep 2018 12:47:11 -0700
Message-ID: <CAGZ79kZZwH1sORNsBZORF_c5V0U2NVLQa9JBY-Z5ksRS3yBT7w@mail.gmail.com>
Subject: Re: [PATCH] string-list: remove unused function print_string_list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 12:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Stefan Beller <sbeller@google.com> writes:
> >
> >> The helper function stayed unused for 3 years. A removal of that function
> >
> > I think it stayed unused for more than that before the previous
> > proposal to remove it was written (I do not bother going back to my
> > earlier message that identified which exact commit this was
> > introduced at).  It has stayed that way for 3 more years since then.
> >
> >> was proposed before[1], but now time has proven we really do not need the
> >> function.
> >>
> >> [1] https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
> >> Signed-off-by: Stefan Beller <sbeller@google.com>
> >
> > I'll add a blank line before the sign-off.  Is this an example that
> > our "where is the existing trailer?" code misbehaving?
>
> I am still curious about this one.

No, it's me who is misbehaving. ;-)

While I do have format.signoff set, such that I never forget to sign off on
a patch, I have the habit to sign it off manually, in git-gui while editing the
commit message so I can see the whole message.

> In any case, I've reworded the above around "3 years".
>
>     string-list: remove unused function print_string_list
>
>     A removal of this helper function was proposed 3 years ago [1]; the
>     function was never used since it was introduced in 2006 back then,
>     and there is no new callers since.  Now time has proven we really do
>     not need the function.
>
>     [1] https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
>
>     Signed-off-by: Stefan Beller <sbeller@google.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks.

Thanks for rewording it.
Stefan
