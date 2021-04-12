Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CDC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E000761353
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbhDLRm6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Apr 2021 13:42:58 -0400
Received: from mut-mta1-se01b-zose1-fr.yulpa.io ([185.49.22.247]:53937 "EHLO
        mut-mta1-se01b-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238649AbhDLRm5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 13:42:57 -0400
X-Greylist: delayed 1742 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 13:42:57 EDT
Received: from [185.217.155.54] (helo=mut-zose1-mta-hub-outweb01a-fr.yulpa.io)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1lW07o-000Bhu-Dn; Mon, 12 Apr 2021 19:13:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 4EE9CC0EAE;
        Mon, 12 Apr 2021 19:13:22 +0200 (CEST)
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8jT93pqSatj2; Mon, 12 Apr 2021 19:13:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 759DAC0F04;
        Mon, 12 Apr 2021 19:13:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r8hkdEvVBQLN; Mon, 12 Apr 2021 19:13:21 +0200 (CEST)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 5009EC0EAE;
        Mon, 12 Apr 2021 19:13:21 +0200 (CEST)
Date:   Mon, 12 Apr 2021 19:13:21 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <926894000.404076765.1618247601502.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <patch-01.16-8e4b4a2a216-20210412T110456Z-avarab@gmail.com> <CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com>
Subject: Re: [PATCH 01/16] check-non-portable-shell: complain about "test"
 a/-o instead of &&/||
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_3980)
Thread-Topic: check-non-portable-shell: complain about "test" a/-o instead of &&/||
Thread-Index: 9tRzH2wdTZx0DCwZlic0Zryr4DS2iQ==
X-Originating-IP: 185.217.155.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.217.155.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.217.155.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.17)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9hyrnLamaeJG7k/zsHvgzKPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xxfjiWTy5uwSZibshlL5lYdJXcWyQvecOrNfJpOVYxbVyU
 6s8kF7ifSGnQ1M0vFvQ4DNzKBBAKaw9OT/ymAezslnLfUgFRHdtCU7g6NNn6j1yk//oElmKjZX3I
 fTLms3GwKm1mdat2P7nyddy32GU+N+4hJRlpcgTyk+RFCI1UCBgb4qHU7qdjHk+p65BWNojnx8ye
 plRO3sLIqUlSH7OG/RUgQnA/oENxlVL8MGgjbqXLiUIE6YYEAGkuz+2HoG2s1IGdxZ/uQmtqPfsS
 kmJfNeZFCUaAduycmXIw/MCfQQJdao7Rc2vmtBVSi7TkumMfYwLhXYxMpWJXH+com7Nagf53TQOI
 5mBI0WOALOc5tnMP0Ze/+sTNoQ65NpbSpHZLwpZp5yi2rjMHKlDX15TYCZnsBMPw+YITy6N+eeju
 MM04bFtBree8LQ4GfjuXim8ffCkCSYk617RJwTo+E3OoM21XQmXyv+tQ/nxQlPPKfFffcwPxtmN3
 AQj2Zz9yHEGKayqnXZmOGecCDLxbM/aBj0fVMiGDg3NcFYLhA/AX7t9fxN2oReTDHAyOynaY0CmM
 67DLyGtIuojn5YKPK/d4++aqWryE8T8z4BWjRYx+XiCv9TR+UxzLZWL8hwGBjhqawgGXZjXn3MP3
 9MZZOI3FObE1+4U45gRQbGfW7nwgxMGnlF7jEvlEc+6yXX6xwZOo1iG8wl8SLs5XEqOSh50Duhgd
 oLa0nMXdM4+63cQ5PWXPGEw+PpBhStayurNA4ntI2TFFaHMrI0S78ww+MkdnuLQClcb5dXy8WsBt
 iBWbckERL5ClHWCGN59gTJ8HcS5qrNZRa8QvHYd9vwWr3YCnq+r4ng1do0SP9tPDAtnHOzORl0x2
 2hajMhJiMvx+ayJm4zuNRcgRKiGg7nXFaZTxzZahikISoEYCARbil6B7bSDl1+/0Ae2zKLw/49Bo
 E/q9yyULb7qqi7SyP9X01KTa+EWLr4jU4FdpbDkGaW6BO7tZNFdnYafys+thEQwN42EcAjvU8saQ
 hcdg2g/DRIMfIy4vIFFXfOOTpx2HiEeuVlHsplMkkb/VBGfADMfD+gk8ti4OIo3M5Odh9pvot7sH
 ObaZtbNmimwBtfpphGQUt3zXX1hWATGZlqg99tdRW7E=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Sunshine" <sunshine@sunshineco.com> wrote:

> On Mon, Apr 12, 2021 at 7:09 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > Expand the t/check-non-portable-shell.pl checks to complain about the
> > use of "-a" and "-o" to the "test" shell built-in to to mean "and" and
> > "or", as opposed to using two "test" invocations with "&&" or "||".

> > There aren't any portability issues with using that construct that I
> > know of, but since Junio expressed a dislike of it in [1] and we've
> > currently got no such constructs let's add it to the lint checking. I
> > had various in-flight and WIP patches that used this construct.

> It's not only Junio's dislike of `-a` and `-o` but also that they have
> long been considered obsolescent by POSIX[1]. GNU has likewise warned
> against it[2] for a few decades.

> [1]:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16
> [2]:
> https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.70/html_node/Limitations-of-Builtins.html

And also in Git's Documentation/CodingGuidelines, which motivates the advice with an example:

     test -n "$x" -a "$a" = "$b"

   is buggy and breaks when $x is "=", but

     test -n "$x" && test "$a" = "$b"

   does not have such a problem.

-- 
Matthieu Moy
https://matthieu-moy.fr/
