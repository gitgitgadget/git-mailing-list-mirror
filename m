Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4601F744
	for <e@80x24.org>; Sat,  2 Jul 2016 11:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbcGBLVA (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 07:21:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:57954 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbcGBLU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 07:20:59 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LsTDk-1bUD3u0PdI-011yqw; Sat, 02 Jul 2016 13:20:46
 +0200
Date:	Sat, 2 Jul 2016 13:20:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	David Turner <novalis@novalis.org>,
	Git Mailing List <git@vger.kernel.org>,
	Keith McGuigan <kamggg@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 04/20] index-helper: new daemon for caching index
 and related stuff
In-Reply-To: <CACsJy8DuTsDAYzRVk=mW7WX5CZb0Z5bAPnzV_2KXK-BcX=tcVg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607021312210.12947@virtualbox>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org> <1466914464-10358-4-git-send-email-novalis@novalis.org> <alpine.DEB.2.20.1606301457340.12947@virtualbox> <CACsJy8DuTsDAYzRVk=mW7WX5CZb0Z5bAPnzV_2KXK-BcX=tcVg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VRVz6EP4nj6BgUytRofaC1G+tVipAwmgOWGnB3OLKzSvSAbbUAz
 fkeufKBssz2+ae1/PUNhfEHWcK4am4/E4Vmli70zkzKyEjinz5wPuGLJ4zvq5+nuxkyA6aG
 LoAMNSWnB9DK8Wo4zn8sjTyMSD7n+y1unmfI7VYh3Ls5XPvCvmxG2BgT3+8+Cz+0kODyG/e
 Qq1T+fPTjTmpoISAHL1/g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pVN3Sp29cO0=:g1ylGFoL3C6HpQd0sRd4m0
 x2rD8bt/BrVb42Mab05gfuzayHsAqRwHLD7zXaBMh2eSSk+VCrk95qXrgTO7lWnkZQ1FUhemC
 BJeDvZI6O2XpsOcN8j/etvepy7QOZY0kNGkh6l07jIIwtEQE5x30Zj+BKxibB/H4PVZ+ZKEA7
 2C/a0oLhahZE9/X7kIJOXPYoHXRQMbFznlYm842kzvG/csKn1OlofknsmHEw8YKbWY42k4KO9
 /DV7wAo8m0lCtBkyklaOX+khmoMJaBsU5K4TWoWEeTDdCOlBF+rdrI+FH6VKFZH4PlXn1EBS+
 usKTcKWjG3BlGIaqNv+O5zBnANZ/ioKgiisriPGgv4DpOnl3HqAY0vMzVUKaLEyjnBt/kv9uh
 joquAPsdaHb3FUIEuTXjcywPc8fN0hYhu3H9bWMIRFvlR6K8e3MehwgGvGX17GoPU/uRC8oxv
 2evDlaIo6rE+TRGTudBr/Csr/QNY7FofZ0I+dQGBn0HQZ5sn4fhDveJMN2NC5cs3UkBcuRB4/
 WeuqhkcnI28occDURAMk7GgL2r5jHlKJspC/1+c8g556KcCOJX6b9FPU+cbzOtNNnBYLamtI5
 aaCl1Jz7LjYvcWv05zo3S1MTZCbEQPyyKgL9rM55Tk6spSmEMmKx1IOtT98WR9oxg3U4jujZh
 RghBMhJbnozUUewoQjwR8m2Ay61cgBz/QLVkk1jMKZB32R1BfsiZesj+9r/3zrmbyOhCPcrRS
 urkiQ7xP5VzeaMs9iO/5xH/TJ79+WMdNv+Cnvfi7gBgAfvuXO7FpYHgA5V85SeA0+XGe+M0/9
 0NVyEat
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Thu, 30 Jun 2016, Duy Nguyen wrote:

> On Thu, Jun 30, 2016 at 3:06 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Even when NO_MMAP is empty, there might be no Unix sockets available (such
> > as is the case on Windows). In any case, you really only want to skip
> > these tests when index-helper is not available, so would you mind
> > squashing this patch in?
> >
> > -- snipsnap --
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Subject: [PATCH] fixup! index-helper: new daemon for caching index and related
> >  stuff
> >
> > ---
> >  t/t7900-index-helper.sh | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
> > index 6c9b4dd..12b5bf7 100755
> > --- a/t/t7900-index-helper.sh
> > +++ b/t/t7900-index-helper.sh
> > @@ -10,8 +10,10 @@ Testing git index-helper
> >
> >  . ./test-lib.sh
> >
> > -test -n "$NO_MMAP" && {
> > -       skip_all='skipping index-helper tests: no mmap'
> > +git index-helper -h 2>/dev/null
> > +test $? = 129 ||
> 
> So when NO_MMAP is set, "git index-helper -h" will set $? to 1.

Not quite.

When NO_MMAP is set, index-helper will not be compiled. Or at least it
should not be:

> +ifndef NO_MMAP
> +ifndef NO_UNIX_SOCKETS
> +       PROGRAM_OBJS += index-helper.o
> +endif
> +endif

If it is *unset*, *and* if NO_UNIX_SOCKETS is *also* unset, index-helper
gets compiled, and -h triggers code in parse-options.c or usage.c that
exits with status 129.

So I do not think that this is subtle.

But it just occurred to me that the #ifndef NO_MMAP in index-helper.c is
unnecessary and that its #else clause (containing a loop() that fails)
contains dead code: we never compile this code with NO_MMAP, and neither
should we.

Dave, would you mind taking that #ifndef NO_MMAP out of "index-helper: new
daemon for caching index and related stuff" when you re-roll?

Thanks,
Dscho
