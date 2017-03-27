Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2DA91FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 16:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbdC0QcM (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 12:32:12 -0400
Received: from mx1.riseup.net ([198.252.153.129]:37244 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbdC0QcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 12:32:11 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 9340E1A214C;
        Mon, 27 Mar 2017 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490632280; bh=/XS2IB5pHdZ7/6oIol+fGsEqIkZZ+lCDwbHoF0QDm28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1BzsCoKro9ScRbQoX0VtH8wbIRAa4QG/MGUaSRlHsYcMQydMtenbIWUSE99aLnbo
         b/7O7HLyjeK7uYc3/HW49Uij2YjknK3susvk/ACzG1/Eo6B8ZxLgVTGIkEunaU2Aoc
         mFdPYCofEEkLPKjiXEFNoaE9a53pOSvan/Bsmzc0=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id E8AF51C02BD
Date:   Tue, 28 Mar 2017 00:31:08 +0800
From:   Pickfire <pickfire@riseup.net>
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: Re: Re: Re: GSoC Project | Convert interactive rebase
 to C
Message-ID: <20170327163108.QoV1fm8z7%pickfire@riseup.net>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net>
 <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com>
 <20170321060526.sXz0cdJwc%pickfire@riseup.net>
 <alpine.DEB.2.20.1703231827060.3767@virtualbox>
 <20170325021703.Tjq7i-hO7%pickfire@riseup.net>
 <alpine.DEB.2.20.1703271700130.14958@virtualbox>
In-Reply-To: <alpine.DEB.2.20.1703271700130.14958@virtualbox>
Mail-Followup-To: sbeller@google.com, Johannes.Schindelin@gmx.de,
 git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Sat, 25 Mar 2017, Ivan Tham wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Tue, 21 Mar 2017, Ivan Tham wrote:
> > > > Stefan Beller <sbeller@google.com> wrote:
> > > > > On Mon, Mar 20, 2017 at 9:41 AM, Ivan Tham <pickfire@riseup.net> =
wrote:
> > > > >
> > > > > > I am interested to work on "Convert interactive rebase to C"
> > > > >
> > > > > +cc Johannes, who recently worked on rebase and the sequencer.
> > >
> > > Glad you are interested! Please note that large parts of the
> > > interactive rebase are already in C now, but there is enough work left
> > > in that corner.
> >
> > Glad to hear that, I would really like to see interactive rebase in C.
>
> Please note that a notable part already made it into C in v2.12.1. There
> are still a few loose ends to tie, of course; it still makes for a great
> head start on your project, methinks.

Ah, that's great.

And while I was working on the microproject (shell patterns in user diff),
I can't produce the output of t/t4034-diff-words.sh manually with:

    mkdir cpp/ && cd cpp/ && git init

    cat > pre <<EOF
    Foo():x(0&&1){}
    cout<<"Hello World!\n"<<endl;
    1 -1e10 0xabcdef 'x'
    [a] a->b a.b
    !a ~a a++ a-- a*b a&b
    a*b a/b a%b
    a+b a-b
    a<<b a>>b
    a<b a<=3Db a>b a>=3Db
    a=3D=3Db a!=3Db
    a&b
    a^b
    a|b
    a&&b
    a||b
    a?b:z
    a=3Db a+=3Db a-=3Db a*=3Db a/=3Db a%=3Db a<<=3Db a>>=3Db a&=3Db a^=3Db =
a|=3Db
    a,y
    a::b
    EOF

    cat > post <<EOF
    Foo() : x(0&42) { bar(x); }
    cout<<"Hello World?\n"<<endl;
    (1) (-1e10) (0xabcdef) 'y'
    [x] x->y x.y
    !x ~x x++ x-- x*y x&y
    x*y x/y x%y
    x+y x-y
    x<<y x>>y
    x<y x<=3Dy x>y x>=3Dy
    x=3D=3Dy x!=3Dy
    x&y
    x^y
    x|y
    x&&y
    x||y
    x?y:z
    x=3Dy x+=3Dy x-=3Dy x*=3Dy x/=3Dy x%=3Dy x<<=3Dy x>>=3Dy x&=3Dy x^=3Dy =
x|=3Dy
    x,y
    x::y
    EOF

    echo '* diff=3D"cpp"' > .gitmodules
    git diff --no-index --color-words pre post > output

Surprisingly, it shows (which is very different from the expected output):

=1B[1mdiff --git a/pre b/post=1B[m
=1B[1mindex 23d5c8a..7e8c026 100644=1B[m
=1B[1m--- a/pre=1B[m
=1B[1m+++ b/post=1B[m
=1B[36m@@ -1,19 +1,19 @@=1B[m
=1B[31mFoo():x(0&&1){}=1B[m=1B[32mFoo() : x(0&42) { bar(x); }=1B[m
cout<<"Hello =1B[31mWorld!\n"<<endl;=1B[m
=1B[31m1 -1e10 0xabcdef 'x'=1B[m
=1B[31m[a] a->b a.b=1B[m
=1B[31m!a ~a a++ a-- a*b a&b=1B[m
=1B[31ma*b a/b a%b=1B[m
=1B[31ma+b a-b=1B[m
=1B[31ma<<b a>>b=1B[m
=1B[31ma<b a<=3Db a>b a>=3Db=1B[m
=1B[31ma=3D=3Db a!=3Db=1B[m
=1B[31ma&b=1B[m
=1B[31ma^b=1B[m
=1B[31ma|b=1B[m
=1B[31ma&&b=1B[m
=1B[31ma||b=1B[m
=1B[31ma?b:z=1B[m
=1B[31ma=3Db a+=3Db a-=3Db a*=3Db a/=3Db a%=3Db a<<=3Db a>>=3Db a&=3Db a^=
=3Db a|=3Db=1B[m
=1B[31ma,y=1B[m
=1B[31ma::b=1B[m=1B[32mWorld?\n"<<endl;=1B[m
=1B[32m(1) (-1e10) (0xabcdef) 'y'=1B[m
=1B[32m[x] x->y x.y=1B[m
=1B[32m!x ~x x++ x-- x*y x&y=1B[m
=1B[32mx*y x/y x%y=1B[m
=1B[32mx+y x-y=1B[m
=1B[32mx<<y x>>y=1B[m
=1B[32mx<y x<=3Dy x>y x>=3Dy=1B[m
=1B[32mx=3D=3Dy x!=3Dy=1B[m
=1B[32mx&y=1B[m
=1B[32mx^y=1B[m
=1B[32mx|y=1B[m
=1B[32mx&&y=1B[m
=1B[32mx||y=1B[m
=1B[32mx?y:z=1B[m
=1B[32mx=3Dy x+=3Dy x-=3Dy x*=3Dy x/=3Dy x%=3Dy x<<=3Dy x>>=3Dy x&=3Dy x^=
=3Dy x|=3Dy=1B[m
=1B[32mx,y=1B[m
=1B[32mx::y=1B[m

Instead of:

<BOLD>diff --git a/pre b/post<RESET>
<BOLD>index 23d5c8a..7e8c026 100644<RESET>
<BOLD>--- a/pre<RESET>
<BOLD>+++ b/post<RESET>
<CYAN>@@ -1,19 +1,19 @@<RESET>
Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RES=
ET> '<RED>x<RESET><GREEN>y<RESET>'
[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET=
><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RE=
SET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y =
x<RESET>&<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<=
RESET>%<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=3D<RED>b a<RESET><GREEN>y=
 x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=3D<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>=3D=3D<RED>b a<RESET><GREEN>y x<RESET>!=3D<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>&<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>^<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>|<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>&&<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>||<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
<RED>a<RESET><GREEN>x<RESET>=3D<RED>b a<RESET><GREEN>y x<RESET>+=3D<RED>b a=
<RESET><GREEN>y x<RESET>-=3D<RED>b a<RESET><GREEN>y x<RESET>*=3D<RED>b a<RE=
SET><GREEN>y x<RESET>/=3D<RED>b a<RESET><GREEN>y x<RESET>%=3D<RED>b a<RESET=
><GREEN>y x<RESET><<=3D<RED>b a<RESET><GREEN>y x<RESET>>>=3D<RED>b a<RESET>=
<GREEN>y x<RESET>&=3D<RED>b a<RESET><GREEN>y x<RESET>^=3D<RED>b a<RESET><GR=
EEN>y x<RESET>|=3D<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>,y
<RED>a<RESET><GREEN>x<RESET>::<RED>b<RESET><GREEN>y<RESET>

That's does not just happens to cpp builtins, it happens to bibtex as well.
Is it that I had missed some configuration since I have tested this on a
few machines?

> > > > > > aiming to port most builtins stuff to C in which we can reduce
> > > > > > the size of git. Additionally, I would also like to convert
> > > > > > scripts to builtins as an additional milestone.
> > >
> > > Careful. It is a ton of work to get the rebase -i conversion done, and
> > > then a ton of work to get it integrated. That will fill 3 months, very
> > > easily.
> >
> > My main aim is to reduce the extra dependency of perl, but planning to
> > start with rebase, can I make that an optional task where I can help out
> > after I had completed my main task during gsoc?
>
> Sure, you can make it an optional task, and I would be very happy if you
> followed up on it even after GSoC!

Yes, I can do that as well. I will be happy to have git be smaller. ^^

> As far as the Perl dependency is concerned, I actually think there is only
> one serious one left: git add -i.

Yes, that as well. But basically the core parts first.

> Granted, there is send-email, but it really does not matter all that much
> these days *except* if you want to use Git to contribute to projects that
> still use a mailing list-based patch submission process (the ones that
> come to mind are: Git, Linux and Cygwin). Most Git users actually do not
> submit any patches to mailing lists, therefore I tend to ignore this one.

I won't ignore that but I will do the others first since some package
manager pack it with git but instead let it be a subpackage.

> The rest of the Perl scripts interacts with foreign SCMs (archimport,
> cvsexportcommit, cvsimport, cvsserver, and svn). I *guess* that it would
> be nice to follow up on the remote-svn work (which has not really gone
> anywhere so far, AFAICT the main driving contributor pursues different
> projects these days), but IMHO none of these are really needed to run Git.

As far as I have concern, the conversion stuff are rarely runned, I
don't think it is worth converting to C.

Good luck and have a nice day!  - Ivan
