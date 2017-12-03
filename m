Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B944320C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdLCWAe (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:00:34 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36091 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdLCWAd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:00:33 -0500
Received: by mail-wm0-f54.google.com with SMTP id b76so11220360wmg.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pgb7B5XOeoVz/g/5V7CmEkqKT+Vc8xiAJgNJqcRHxy0=;
        b=Paxil10SVW0l6gK+kQIVkz65edsRtUD20S28A5K1/BZWwRK9YssTRqEfZqMUoKbHwe
         lNP0qXliMmQUSG92WBEtBMgiWo6GBnNPbc26HURLPCe2sf3zYl0nZCi9+xlFH7Culslc
         Ku51d1ZPcRmanbOkrg0ZUALEl3qf0ikiog6UbXrlHM7mJUnNx8SbtoXBdWCpsKHP7/fq
         3ku6x5bwyFC5pHskZQiHlluG/BD6Cy9oB1LN3TANFAWCV+1rGHX5bQhe07jQzi9bX0zH
         39Fz1+hSogJ6ynpqsJkpNXKBmHei+mw9HGpOJ6zZaG7w6l4zvoofsthj13w8hWtzMTM6
         MDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pgb7B5XOeoVz/g/5V7CmEkqKT+Vc8xiAJgNJqcRHxy0=;
        b=SeYb0GCrlr2sk5wz0jXQpn6DAGdmVhxX6CmIg6fKmw0GqlSt5FYUCphj4Zop//jE/V
         /XMdE/oBjdamXfUbiLDtwZhaRcTqhSa/KHYIS0rXi1ynEaZbxFW6iN8/B4QbXxJUKGO3
         zakCqcbBfCJiLeDyy7SDMKnpj6DJyEfEJJgoPNUfVtNUxOxMAywLHmpmnOvE+00VjFAI
         a8zcQhqx20nfxXT+ZeGzx21wzrrskjuDqqlSgbrmb/bKBXL4uh4JRZHTdWrJSx8OYBm+
         kNTZ+jIM9k1Ms32H3OPFEwVcNLshCvOD5uSmcxVMACbFa723wG2CAeAOCaWHwJs+4FsY
         J+2A==
X-Gm-Message-State: AJaThX56eUOXP3/AHva7D1hMeK7hsjkS8p9TbencE7JwUMtVkRsqozSx
        MaK925x+qgT9lrrea/JK5DA=
X-Google-Smtp-Source: AGs4zMbrtYO0+x7H7FJckGsp85thyuxfyKJcTl+EI6unQN9j/WUJQSBnjy+zPIQ/FVY8QLBHk2/Tfg==
X-Received: by 10.80.159.239 with SMTP id c102mr27432042edf.46.1512338431871;
        Sun, 03 Dec 2017 14:00:31 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id q10sm1109549edc.32.2017.12.03.14.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Dec 2017 14:00:30 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eLcJJ-0003iI-Ia; Sun, 03 Dec 2017 23:00:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Payre Nathan <second.payre@gmail.com>
Cc:     git@vger.kernel.org, ryan@michonline.com, e@80x24.org,
        gitster@pobox.com, Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH] send-email: extract email-parsing code into a subroutine
References: <20171202170220.10073-1-second.payre@gmail.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171202170220.10073-1-second.payre@gmail.com>
Date:   Sun, 03 Dec 2017 23:00:29 +0100
Message-ID: <874lp7v5du.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 02 2017, Payre Nathan jotted:

> From: Nathan Payre <second.payre@gmail.com>
>
> The existing code mixes parsing of email header with regular
> expression and actual code. Extract the parsing code into a new
> subroutine 'parse_header_line()'. This improves the code readability
> and make parse_header_line reusable in other place.
>
> Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
> Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
> Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
> ---
>
> This patch is a first step to implement a new feature.
> See new feature discussion here: https://public-inbox.org/git/20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr/
>
>  git-send-email.perl | 106 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 80 insertions(+), 26 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2208dcc21..98c2e461c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -715,41 +715,64 @@ EOT3
>  	if (!defined $compose_encoding) {
>  		$compose_encoding = "UTF-8";
>  	}
> -	while(<$c>) {
> +
> +	my %parsed_email;
> +	while (<$c>) {
>  		next if m/^GIT:/;
> -		if ($in_body) {
> -			$summary_empty = 0 unless (/^\n$/);
> -		} elsif (/^\n$/) {
> -			$in_body = 1;
> -			if ($need_8bit_cte) {
> +		parse_header_line($_, \%parsed_email);
> +		if (/^\n$/i) {
> +			while (my $row = <$c>) {
> +				if (!($row =~ m/^GIT:/)) {
> +					$parsed_email{'body'} = $parsed_email{'body'} . $row;
> +				}
> +			}
> +		}
> +	}
> +	if ($parsed_email{'from'}) {
> +		$sender = $parsed_email{'from'};
> +	}
> +	if ($parsed_email{'in_reply_to'}) {
> +		$initial_reply_to = $parsed_email{'in_reply_to'};
> +	}
> +	if ($parsed_email{'subject'}) {
> +		$initial_subject = $parsed_email{'subject'};
> +		print $c2 "Subject: " .
> +			quote_subject($parsed_email{'subject'}, $compose_encoding) .
> +			"\n";
> +	}
> +	if ($parsed_email{'mime-version'}) {
> +		$need_8bit_cte = 0;
> +	}
> +	if ($need_8bit_cte) {
> +		if ($parsed_email{'content-type'}) {
> +				print $c2 "MIME-Version: 1.0\n",
> +					 "Content-Type: $parsed_email{'content-type'};",
> +					 "Content-Transfer-Encoding: 8bit\n";
> +			} else {
>  				print $c2 "MIME-Version: 1.0\n",
>  					 "Content-Type: text/plain; ",
> -					   "charset=$compose_encoding\n",
> +					 "charset=$compose_encoding\n",
>  					 "Content-Transfer-Encoding: 8bit\n";
>  			}
> -		} elsif (/^MIME-Version:/i) {
> -			$need_8bit_cte = 0;
> -		} elsif (/^Subject:\s*(.+)\s*$/i) {
> -			$initial_subject = $1;
> -			my $subject = $initial_subject;
> -			$_ = "Subject: " .
> -				quote_subject($subject, $compose_encoding) .
> -				"\n";
> -		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
> -			$initial_reply_to = $1;
> -			next;
> -		} elsif (/^From:\s*(.+)\s*$/i) {
> -			$sender = $1;
> -			next;
> -		} elsif (/^(?:To|Cc|Bcc):/i) {
> -			print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
> -			next;
> -		}
> -		print $c2 $_;
>  	}
> +	if ($parsed_email{'body'}) {
> +		$summary_empty = 0;
> +		print $c2 "\n$parsed_email{'body'}\n";
> +	}
> +
>  	close $c;
>  	close $c2;
>
> +	open $c2, "<", $compose_filename . ".final"
> +		or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
> +
> +	print "affichage : \n";
> +	while (<$c2>) {
> +		print $_;
> +	}
> +
> +	close $c2;
> +
>  	if ($summary_empty) {
>  		print __("Summary email is empty, skipping it\n");
>  		$compose = -1;
> @@ -792,6 +815,37 @@ sub ask {
>  	return;
>  }
>
> +sub parse_header_line {
> +	my $lines = shift;
> +	my $parsed_line = shift;
> +
> +	foreach (split(/\n/, $lines)) {
> +		if (/^From:\s*(.+)$/i) {
> +			$parsed_line->{'from'} = $1;
> +		} elsif (/^To:\s*(.+)$/i) {
> +			$parsed_line->{'to'} = [ parse_address_line($1) ];
> +		} elsif (/^Cc:\s*(.+)$/i) {
> +			$parsed_line->{'cc'} = [ parse_address_line($1) ];
> +		} elsif (/^Bcc:\s*(.+)$/i) {
> +			$parsed_line->{'bcc'} = [ parse_address_line($1) ];
> +		} elsif (/^Subject:\s*(.+)\s*$/i) {
> +			$parsed_line->{'subject'} = $1;
> +		} elsif (/^Date: (.*)/i) {
> +			$parsed_line->{'date'} = $1;
> +		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
> +			$parsed_line->{'in_reply_to'} = $1;
> +		} elsif (/^Message-ID: (.*)$/i) {
> +			$parsed_line->{'message_id'} = $1;
> +		} elsif (/^MIME-Version:$/i) {
> +			$parsed_line->{'mime-version'} = $1;
> +		} elsif (/^Content-Type:\s+(.*)\s*$/i) {
> +			$parsed_line->{'content-type'} = $1;
> +		} elsif (/^References:\s+(.*)/i) {
> +			$parsed_line->{'references'} = $1;
> +		}
> +	}
> +}
> +
>  my %broken_encoding;
>
>  sub file_declares_8bit_cte {

I haven't read the patches that follow. Completely untested, But just a
diff on top I came up with while reading this:

Rationale:

 * Once you start passing $_ to functions you should probably just give
   it a name.

 * !($x =~ m//) you can just write as $x !~ m//

 * There's a lot of copy/paste programming in parse_header_line() and an
   inconsistency between you seeing A-Header and turning it into either
   a_header or a-header. If you just stick with a-header and use dash
   you end up with just two cases.

   The resulting line is quite long, so it's worth doing:

   my $header_parsed   = join "|", qw(To CC ...);
   my $header_unparsed = join "|", qw(From Subject Message-ID ...);
   [...]
   if ($str =~ /^($header_unparsed)
   

diff --git a/git-send-email.perl b/git-send-email.perl
index 98c2e461cf..3696cad456 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -717,12 +717,12 @@ EOT3
 	}

 	my %parsed_email;
-	while (<$c>) {
-		next if m/^GIT:/;
-		parse_header_line($_, \%parsed_email);
-		if (/^\n$/i) {
+	while (my $line = <$c>) {
+		next if $line =~ m/^GIT:/;
+		parse_header_line($line, \%parsed_email);
+		if ($line =~ /^\n$/i) {
 			while (my $row = <$c>) {
-				if (!($row =~ m/^GIT:/)) {
+				if ($row !~ m/^GIT:/) {
 					$parsed_email{'body'} = $parsed_email{'body'} . $row;
 				}
 			}
@@ -731,7 +731,7 @@ EOT3
 	if ($parsed_email{'from'}) {
 		$sender = $parsed_email{'from'};
 	}
-	if ($parsed_email{'in_reply_to'}) {
+	if ($parsed_email{'in-reply-to'}) {
 		$initial_reply_to = $parsed_email{'in_reply_to'};
 	}
 	if ($parsed_email{'subject'}) {
@@ -820,28 +820,10 @@ sub parse_header_line {
 	my $parsed_line = shift;

 	foreach (split(/\n/, $lines)) {
-		if (/^From:\s*(.+)$/i) {
-			$parsed_line->{'from'} = $1;
-		} elsif (/^To:\s*(.+)$/i) {
-			$parsed_line->{'to'} = [ parse_address_line($1) ];
-		} elsif (/^Cc:\s*(.+)$/i) {
-			$parsed_line->{'cc'} = [ parse_address_line($1) ];
-		} elsif (/^Bcc:\s*(.+)$/i) {
-			$parsed_line->{'bcc'} = [ parse_address_line($1) ];
-		} elsif (/^Subject:\s*(.+)\s*$/i) {
-			$parsed_line->{'subject'} = $1;
-		} elsif (/^Date: (.*)/i) {
-			$parsed_line->{'date'} = $1;
-		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
-			$parsed_line->{'in_reply_to'} = $1;
-		} elsif (/^Message-ID: (.*)$/i) {
-			$parsed_line->{'message_id'} = $1;
-		} elsif (/^MIME-Version:$/i) {
-			$parsed_line->{'mime-version'} = $1;
-		} elsif (/^Content-Type:\s+(.*)\s*$/i) {
-			$parsed_line->{'content-type'} = $1;
-		} elsif (/^References:\s+(.*)/i) {
-			$parsed_line->{'references'} = $1;
+		if (/^(To|Cc|Bcc):\s*(.+)$/i) {
+			$parsed_line->{lc $1} = [ parse_address_line($2) ];
+		} elsif (/^(From|Subject|Date|In-Reply-To|Message-ID|MIME-Version|Content-Type|References):\s*(.+)\s*$/i) {
+			$parsed_line->{lc $1} = $2;
 		}
 	}
 }
