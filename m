Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC58B1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 19:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeDRT6n (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 15:58:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45192 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeDRT6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 15:58:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id u11-v6so7955445wri.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wVMhXIswpo6B1X7RX0szJ2OuJsNRDW5f7gzx2wy5isk=;
        b=O1rLkePRXe6lAW/e11Pn8nrS8XahZnGvnRxlAWafEFBmQYCm2Uj2uXflE4pkbldUh2
         mIhctaijRBz9EfdTRgNZ5xQ/NbzCxTlXVaRL1O1ZsIN3p+720+qa8fUIcrd1tTX9egxL
         PHQeGJvQj37cwy+gfYNmSWQnBl8gN3jr9Wqh7kNbC7OIznsnQq+iJEcba+a6QdiNquDf
         qGI4Qx+54KyrpiXkBg77kA7lJRRZCU19xkRNW467W+0O0gOZ799/BAGm/IGlheYqJYKd
         VedZoolBx0zyQ/TEA5fsNFw6gNazUlACMMA8HMG9FZDrUE7YvnXmjeuTRfycE17UgDT7
         vA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wVMhXIswpo6B1X7RX0szJ2OuJsNRDW5f7gzx2wy5isk=;
        b=MMabrplnXTCdkpf4LQ+n/nCuALdHTJkne7KQw3osfY+v/TZrLs3UdbAC2cKpBGtzGP
         +H9tiTfbFYP3wNr6ecyQlU8UPPlOLnCa3/36CIoQDUZ2bVBxb09+Jd7GnE8C4NQCgAFD
         LuVV57KFEjQSzBU5H4aOMa+Bvsacin22xTZCc3+9qUY9k8OZUAa5BuvswwaBVOnJQCKG
         b+LTyEz9ihRSy89eim58+w4bnpzaOvZS2cHPQszBqtBR/ufwxOa1dH0oLWaQHY4kef7W
         bIxXSO2EjW7v/Z9lZG7skOB6U+P0OcNFoNTkoMxSA6s3LFSK5lY+mH/pXu6ShN3MIhlf
         o1mA==
X-Gm-Message-State: ALQs6tDrN46bTdw+bnY8ooOmc5XZU76EfXT9GQXiYmPqc8XhVMjxcgP0
        QacxcfZQ2xP03pfGdofo+y8=
X-Google-Smtp-Source: AIpwx4+YI0SSJfK3wHa8lryx6Vh3kwUsRTG2eTnHIWKU3Swh0y6AkEaPuAS+Zs9ajpHChDCh2+pOvw==
X-Received: by 2002:adf:9a27:: with SMTP id z36-v6mr2519021wrb.47.1524081521153;
        Wed, 18 Apr 2018 12:58:41 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o20-v6sm2355493wro.7.2018.04.18.12.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 12:58:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     git@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] git-send-email: Cc more people
References: <20180418140503.GD27475@bombadil.infradead.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180418140503.GD27475@bombadil.infradead.org>
Date:   Wed, 18 Apr 2018 21:58:39 +0200
Message-ID: <87tvs8e174.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 18 2018, Matthew Wilcox wrote:

> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> Several of my colleagues (and myself) have expressed surprise and
> annoyance that git-send-email doesn't automatically pick up people who
> are listed in patches as Reported-by: or Reviewed-by: or ... many other
> tags that would seem (to us) to indicate that person might be interested.
> This patch to git-send-email tries to pick up all Foo-by: tags.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2fa7818ca..926815329 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1665,7 +1665,7 @@ foreach my $t (@files) {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^(Signed-off-by|Cc): (.*)/i) {
> +		if (/^([A-Z-a-z]*-by|Cc): (.*)/i) {
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			# strip garbage for the address we'll use:

I like this direction, I've actually been meaning to take this further
and try to parse out SHA1s in the commit message, look those up, and add
their authors to CC one of these days.

But IMO this patch is really lacking a few things before being ready:

1. You have no tests for this. See t/t9001-send-email.sh for examples,
   i.e. stuff like

       (body) Adding cc: C O Mitter <committer@example.com> from line
       'Signed-off-by: C O Mitter <committer@example.com>'

   Should have corresponding tests for "Reviewed-by" "Seen-by"
   etc. These are easy to add, just edit the raw messages and test that
   for the output about adding CCs.

2. Just a few lines down from your quoted hunk we have this:

	# strip garbage for the address we'll use:
	$c = strip_garbage_one_address($c);
	# sanitize a bit more to decide whether to suppress the address:
	my $sc = sanitize_address($c);
	if ($sc eq $sender) {
		next if ($suppress_cc{'self'});
	} else {
		next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
		next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
	}
	push @cc, $c;
	printf(__("(body) Adding cc: %s from line '%s'\n"),
		$c, $_) unless $quiet;

   So before we just supported Signed-off-by as a special case, but now
   your patch adds WHAT-EVER-by without updating the the corresponding
   --[no-]signed-off-by-cc command-line options.

   Your change should at least describe why those aren't being updated,
   but probably we should add some other command-line option for
   ignoring these wildcards, e.g. --[no-]wildcard-by-cc=reviewed
   --[no-]wildcard-by-cc=seen etc, and we can make --[no-]signed-off-by
   a historical alias for --[no-]wildcard-by-cc=signed-off.

3. Ditto all the documentation in "man git-send-email" about
   "signed-off-by", "sob" etc, and the "signedoffbycc" variable
   documented both there and in "man git-config".

Style comment: First time I've seen someone write a charclass as
[A-Z-a-z] and mean it, usually it's usually it's [A-Za-z-] to clarify
that the "-" isn't a range. Makes sense (to me) to have ranges first &
stray chars last.
