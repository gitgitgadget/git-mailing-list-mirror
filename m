Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B91B64C
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410034; cv=none; b=c+iIuRFGDpBCsGfFQkuMgTyqtrGFkBnfHtw1/ve2ZCdE9QTLzWNFWpwtSUgMpiTO1NUO6KaHnknGAHxLppH8KvOXRXbbI6WRUNrI9hGzJidg9wnGkLrg8C0TljNP5sdbg4XuZAd6RSyByWSBeWmEKGxLDVjeOemC0J5eAfWFTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410034; c=relaxed/simple;
	bh=mz4pD/WYJyPXnzBIPD+RAZjsT9pStHzS2M9w6RPoMts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFytNJJ1pTP+nK8kSQDll2J1y3Wfjoat68bwIj90irkeMxY8Yok1yWbAFPDCkLrlamqrsyDsI43RdXAf43epV5EqL8l/zw+uNdqBdYBvi3j/9TPElGdvsGJlpygoUvS9WNZKnyWIeQlKMGISh8G11efmJc70+k8i3laIjKpyHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5daf5ea91so20304736d6.1
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 20:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720410031; x=1721014831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QjBu+tvZJK3DibipYrn6etZAFDbTVG10C5ITg1wZ34=;
        b=UiF0ueQZ9izxReR8yOWnuohao5211tGK8JyrnJigOS4wlRT0IODxj9oR6MG+EwNXJk
         M8eoKZjkAc4zvFEfQjPciUrbK5MefrNGOxJz6mKQVAPsqiZB0/nJCnKgFR9mXeB7M4NV
         Ug7Jg1odzyldoU060H9p054dR3Jnw6j4rl/uJ+hqJhZTCXsP7VEgGzfORqkwL0CMrZkg
         rBBLBtzYG900dhNcfLb5FK8NyBCIMRe9XFTxzqNhEsRlvwREUS23juzs/YVe/4HfFf65
         8w2lYOghkGP2YNtSkif3qClBDbPU2Az0da6yGejopHYd+KT1qqy7qAxOZQzSG0TRxLGi
         sjdA==
X-Forwarded-Encrypted: i=1; AJvYcCUMbu414dLTaEhSPsxw8Y2EJBiiiQy6mqALc1KIPDHQwOfYFRK1/bejTj8amHm2lPmKcBVP2Wro/WtoBiYMob3zNiaT
X-Gm-Message-State: AOJu0Yx6AA7ijGN1RBRBAAAA0rBvYmguuJP02gPSqlOEUXAVijwNmbUH
	wIIss0JF3Ha5d7EszztcH5gKJCYF7pmgW7XLorto7EI8fJZRW5OPlXdYzayJUvaw6UaR7CMjaN3
	shgxylwTUGC6+Pk65y/23AJN76vs=
X-Google-Smtp-Source: AGHT+IERM+IE0uiXGjeoDfT6NZ3xJXJvJ5OlT4ET1ZJj6kxbn7WTKNSaxUAKIELir8iZvQNyToIaydTlgdmeuli8sNM=
X-Received: by 2002:a05:6214:3986:b0:6b5:a945:ec51 with SMTP id
 6a1803df08f44-6b5ed2549cemr132265176d6.51.1720410031065; Sun, 07 Jul 2024
 20:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net> <20240706060143.GD698153@coredump.intra.peff.net>
In-Reply-To: <20240706060143.GD698153@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Jul 2024 23:40:19 -0400
Message-ID: <CAPig+cRUOSHuNezZfVUT43JGT5BWA3LTbQvKCkD37DxXn=L6Jg@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 2:01=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Tue, Jul 02, 2024 at 07:50:34PM -0400, Eric Sunshine wrote:
> I'll post some patches in a moment:
>
>   [1/3]: chainlint.pl: fix line number reporting
>   [2/3]: t/chainlint: add test_expect_success call to test snippets
>   [3/3]: t/chainlint: add tests for test body in heredoc
>
> with the idea that we'd apply your patch here on top of what Junio has
> queued in jk/test-body-in-here-doc, and then these three on top. For
> Junio's sanity, I'll roll it all up into one series. But I wanted to
> show it to you incrementally first, especially because I think the fixes
> from patch 1/3 above should probably just get squashed in (or even
> rewritten). I'll discuss the bugs they fix below.

Considering the excellent explanation you crafted in your patch, I'd
like to say that it should remain separate from mine. However, since
you caught the problems in review, it would be irresponsible of us to
let my patch into the permanent history as-is. So, feel free to squash
your fixes into my patch. Perhaps add a Co-authored-by:? The bit from
your [1/3] commit message about incrementing $lineno for the
heredoc-body case might be worth squashing in too?

I wrote one minor (perhaps non-actionable) comment in response to
patch [3/3]. The patches all looked fine to me, so:

    Acked-by: Eric Sunshine <sunshine@sunshineco.com>

> > @@ -232,7 +234,8 @@ sub new {
> >       my $self =3D bless {
> >               buff =3D> [],
> >               stop =3D> [],
> > -             output =3D> []
> > +             output =3D> [],
> > +             heredocs =3D> {},
> >       } =3D> $class;
> >       $self->{lexer} =3D Lexer->new($self, $s);
> >       return $self;
>
> I think initializing is not strictly necessary here, since we'd only try
> to read tags if we saw a here-doc. But there might be some invalid cases
> where we could convince higher-level code to look for tags even though
> there were none (and generate a perl warning about trying to dereference
> undef as a hashref).

You're right, it's not necessary to initialize here, but it feels more
consistent to do so. That said, I don't feel strongly either way.

> On the flip side, what about cleaning up? The "heretags" array is
> emptied as we parse the heredocs in swallow_heredocs(). But I think once
> a ShellParser's $self->{heredocs}->{FOO} is written, it will hang around
> forever (even though it's valid only for that one command). Probably not
> a big deal, but there's probably some correct spot to reset it.

There are a few reasons I wasn't overly concerned about cleaning up in
this case:

(1) The parsers are all short-lived, so the collected heredoc bodies
won't stick around long anyhow. For each test checked, a TestParser is
created and destroyed. For each script mentioned on the command-line,
a ScriptParser is created and destroyed. None of these parsers stick
around for long, though, a ScriptParser outlives a TestParser.

(2) The heredoc bodies in question tend to be pretty small, so it's
not consuming an inordinate amount of memory even if a single parser
latches bodies of multiple heredocs.

(3) We tend to be quite consistent about naming our heredoc tag (i.e.
"EOF", "EOT"), so a latched body in the parser's %heredocs hash is
very likely to get overwritten, thus the hash is probably not going to
eat up a lot of memory. Given the entire test suite, I'd be quite
surprised if any one parser ever latches more than three heredoc
bodies at a time, and the vast majority of parsers are likely latching
zero or one heredoc body.

(4) I couldn't really think of a correct spot to reset %heredocs.

That said, after reading your message, I did try implementing an
approach in which the heredoc body gets attached to the `<<` or `<<-`
token. That way, a heredoc body would be cleaned along with its
associated lexer token. However, the implementation got too ugly and
increased cognitive load too much for my liking, so I abandoned it.

> >  sub check_test {
> >       my $self =3D shift @_;
> > -     my ($title, $body) =3D map(unwrap, @_);
> > +     my $title =3D unwrap(shift @_);
> > +     my $body =3D unwrap(shift @_);
> > +     $body =3D shift @_ if $body eq '-';
> >       $self->{ntests}++;
> >       my $parser =3D TestParser->new(\$body);
> >       my @tokens =3D $parser->parse();
>
> This has two problems related to line numbers. You can't see it in the
> context, but we later do:
>
>   my $lineno =3D $_[1]->[3];
>
> Now that we're shifting @_, that array item is gone.

Ugh, this is embarrassing. I did run chainlint.pl on t0600 in which I
had intentionally broken some &&-chains, so I saw the output, but
somehow I overlooked that it broke the line numbering entirely.

> The second is that the line number for the here-doc is actually one past
> the initial line number of the test_expect_success. That works
> automatically for hanging single-quotes, since the newline from that
> line is inside the quoted area. But for a here-doc, we have to account
> for it manually. In my original patch I prepended "\n", but you can also
> just increment $lineno (which is what I did in the fix I'm about to
> send).

Nicely spotted. Simply incrementing $lineno does feel a bit hacky, but
I agree that it is probably good enough for now; it doesn't seem
likely that it will break any time soon. But I also agree with the
commentary you wrote in patch [1/3] that it probably would be easy
enough to latch the line number of the beginning of the heredoc body
and employ that value. That would certainly be more robust.

> > @@ -649,8 +654,13 @@ sub parse_cmd {
> >       return @tokens unless @tokens && $tokens[0]->[0] =3D~ /^test_expe=
ct_(?:success|failure)$/;
> >       my $n =3D $#tokens;
> >       $n-- while $n >=3D 0 && $tokens[$n]->[0] =3D~ /^(?:[;&\n|]|&&|\|\=
|)$/;
> > -     $self->check_test($tokens[1], $tokens[2]) if $n =3D=3D 2; # title=
 body
> > -     $self->check_test($tokens[2], $tokens[3]) if $n > 2;  # prereq ti=
tle body
> > +     my $herebody;
> > +     if ($n >=3D 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =
=3D~ /^<<-?(.+)$/) {
> > +             $herebody =3D $self->{heredocs}->{$1};
> > +             $n--;
> > +     }
> > +     $self->check_test($tokens[1], $tokens[2], $herebody) if $n =3D=3D=
 2; # title body
> > +     $self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  =
# prereq title body
> >       return @tokens;
> >  }
>
> OK, mostly as expected. I think the check for "-" here is redundant with
> what's in check_test(). We could just feed the heredoc body either way,
> and in the nonsense case of:
>
>   test_expect_success 'title' 'test body' <<EOT
>   nobody reads this!
>   EOT
>
> the heredoc data would just be ignored.

Right. I went back and forth with this, never sure if this code was
overkill. On the other hand, we could make this more paranoid and
complain if we see either of these cases:

(1) "-" but no heredoc
(2) heredoc present but something other than "-"

> Requiring "<<" at the end is somewhat limiting. E.g. this is valid:
>
>   test_expect_success <<EOT 'title' -
>   the test body
>   EOT

True, I didn't even think about that.

> I don't expect anybody to do that, but it would be nice to be more
> robust if we can. I think the tokens are still wrapped at this point, so
> we could read through all of them looking for "<<" anywhere, without
> getting confused by "$(cat <<INNER_HEREDOC)". I think, anyway (I didn't
> test).

Correct. The stuff inside "$(...)" does get parsed and linted, but by
the time ScriptParser::parse_cmd() sees it, `$(cat <<INNER_HEREDOC)`
is just a single (string) token.
