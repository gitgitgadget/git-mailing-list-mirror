Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6696F1F45F
	for <e@80x24.org>; Tue,  7 May 2019 12:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEGMnW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 08:43:22 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38428 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGMnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 08:43:22 -0400
Received: by mail-yw1-f68.google.com with SMTP id b74so12958087ywe.5
        for <git@vger.kernel.org>; Tue, 07 May 2019 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cie3J5VUoAk8PsFrQqPLRbvUKYt122i72kNfKPspkPw=;
        b=BWS1IsBgDQ8PHWn/3lrQTxDtGic+xguDD+wXWoZKj7xulanv4joDVGfuR8d1G64wf0
         khvXH6qoo6B/UnoIiM7fYbXfF6Zd0Ha7vCoAfhG11bDPfkdwfTS6aYdOher3Wm7SeEu4
         NAEIjEsrFmhGwdBpDIcAXrdxb6rlRCi4tUW976u6hp+fDQbWjptcE36W30D7niJA4/oy
         4wlWpYSZBxbXxciWAtIux4B1KKbpFEBn5XHXdxV8zdtqT3upkTa0BuCR8bZreNXkQYlb
         zeMBWONj92q/lnUhz/CmnkBvysewzZG0eHtyRzgUdvsdaKu/fDdhYlVUpbSoXB7CimaQ
         vhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cie3J5VUoAk8PsFrQqPLRbvUKYt122i72kNfKPspkPw=;
        b=Da+fIrx69Zrls9PmtSluy9Oi/PpbYes7eMlrdYIdp3XlQo5hcIlTWDSiWcxTfwtcWU
         CS/RKiOpbwq4QEFeCHygtgJvo9KuqmtbzCa8wvTsvBrwMcFW4EgaIhjllPstf39wv7E4
         20eb4UGYEb4EA0aCTfvrtR8L5cNeWKrhYuFI0kCV6xryXF0rvRrsHMlxIs1f2ch32Dmq
         mnYtscj7VU34Va519GBUEv+TzCBe7YhqeO5R37MF9czz3bb+huW5nk9VhDPdAXwPG84t
         oHnpGqTzICGSFAxW0lxrPJCXuxtccuWEac16h5zVlwQacZGwYkvNmocFUQvyqV0vGaKw
         iIvw==
X-Gm-Message-State: APjAAAW6DJJQ+zb0SIwzFFbzdu3msirDxbz1Ypxt220fDV/lNhe6Facj
        ppgARW2BjzhpdsM+1ytTGtQt32wTJbgTTBWdpbiH8J7/Az0=
X-Google-Smtp-Source: APXvYqyosKIO5FNSg9lhGk+jUH6ma2T4lH14nlbhAghMQYeECcG8rboAzRdTUI/kybhztqIhxm5//OLB+Kl1YrPI6HM=
X-Received: by 2002:a25:d947:: with SMTP id q68mr21118720ybg.180.1557233001420;
 Tue, 07 May 2019 05:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190505081633.41157-1-liboxuan@connect.hku.hk> <xmqqy33iljo8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy33iljo8.fsf@gitster-ct.c.googlers.com>
From:   "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date:   Tue, 7 May 2019 20:42:45 +0800
Message-ID: <CALM0=-=5WeTJ2-r+u-8TYzOAih_3aCEESSpA4oKhxjRpK2yj6w@mail.gmail.com>
Subject: Re: [PATCH v2] t4253-am-keep-cr-dos: avoid using pipes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for your review! I can understand your point, but I've got a
quick question:

What if format-patch really breaks and 'am' magically does not break?
Then the two tests might still pass. On the contrary, with this patch,
we can verify the correctness of format-patch and safely rely on it.

Best regards,
Boxuan Li

On Tue, May 7, 2019 at 5:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Boxuan Li <liboxuan@connect.hku.hk> writes:
>
> > The exit code of the upstream in a pipe is ignored thus we should avoid
> > using it. By writing out the output of the git command to a file, we can
> > test the exit codes of both the commands.
>
> We are trying to catch breakages in "am" in these two tests (see the
> title of the test file), and we rely on format-patch to correctly
> produce its output---if we assume that the command being tested,
> i.e. "am", could be fed garbage, the tests become pointless.
>
> And once we decide to rely on the correctness of format-patch in
> these two tests, there no longer is a reason to fear that
> invocations of it upstream of a pipe would lose the exit status.
>
> So while the patch is not wrong per-se, but these two changes are
> borderline Meh.
>
> > Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> > ---
> > Thanks to Eric Sunshine's review, I've removed spaces after '>'
> > and changed 'actual' into 'output'.
> > ---
> >  t/t4253-am-keep-cr-dos.sh | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
> > index 553fe3e88e..6e1b73ec3a 100755
> > --- a/t/t4253-am-keep-cr-dos.sh
> > +++ b/t/t4253-am-keep-cr-dos.sh
> > @@ -51,14 +51,16 @@ test_expect_success 'am with dos files without --keep-cr' '
> >
> >  test_expect_success 'am with dos files with --keep-cr' '
> >       git checkout -b dosfiles-keep-cr initial &&
> > -     git format-patch -k --stdout initial..master | git am --keep-cr -k -3 &&
> > +     git format-patch -k --stdout initial..master >output &&
> > +     git am --keep-cr -k -3 output &&
> >       git diff --exit-code master
> >  '
> >
> >  test_expect_success 'am with dos files config am.keepcr' '
> >       git config am.keepcr 1 &&
> >       git checkout -b dosfiles-conf-keepcr initial &&
> > -     git format-patch -k --stdout initial..master | git am -k -3 &&
> > +     git format-patch -k --stdout initial..master >output &&
> > +     git am -k -3 output &&
> >       git diff --exit-code master
> >  '
