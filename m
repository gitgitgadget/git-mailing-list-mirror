Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE461F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeCFU3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:29:49 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35901 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbeCFU3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:29:48 -0500
Received: by mail-wr0-f196.google.com with SMTP id v111so22277507wrb.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkydanO2otAMXy/bfHIIlSLhqEu0dQVnbBjkrEPWi/g=;
        b=NZveB7YS0k8gTVtGcTrxu9URcCf8mg8MxtcesJ8HxVDtgrGXnnTShlGjFtBZO2/QcW
         qdKRPs7TOaHrNL6yLqL5HSANyaOVVBC625S2gQzhWA01Ba8wGjQQEdccem/EYG7WnHVs
         bSj1WJ3e8eaghuTLY3nqLfpeT0cQSSzCwRc3TY1DX4Ecr+6vPR6+KQwkkfCPN14x3//N
         vnfCn2TYXGqDWVZWKKr0LbrR5nMdHYjT0W7v5YHb0NNWmPK/E4rj3aEgrGaq/35yyarT
         OVjsI+rZETmY2Zsvm+DkEKES+4X6WGzlPCulFb7Am0v8iK28MBLiQHoz//naL+5xeuAM
         944Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkydanO2otAMXy/bfHIIlSLhqEu0dQVnbBjkrEPWi/g=;
        b=hHvjEuVP+UsRYQ2A98tQ4zKqu7T4xZFQIlZkViGd3x8w7LRji1f7HK8xR4IyohUucP
         9qcWEiV9y5kUllerQoB5aqJjmabuRUOIXVWpINojbSPdAEzXJTnfNm8pWVFqLoZbeYQW
         baYus2uLtU30kRuAEZGxwTPk819cJFfyGCB8YTQ0RXjIXwKPEJlWS8xnOGvT4sIDjWVp
         ZXCUgYaTPk43uz/cAE7cGvE/qQrbCZc/gq3nXm+l4PyJ+Zc9GTQDRhvNiPUihfQURdVt
         9g5gPA7MybeKD5BJzTZVlVCa2EQfoZAhI+Eild+t9QUukcu0UKPq8nTQ/JBA0dqGL/WL
         VqGw==
X-Gm-Message-State: APf1xPAIavRb+b2IBpnaze9KGYRr7DXHnQwgGsGdsbg3D3vbRgtrjxOZ
        7uKy2MUPg5C5+TbYMdUCoI4=
X-Google-Smtp-Source: AG47ELuYT8Uessj7RTJ6H8LwN0Ld5x78Ekjx3iZb5GbNChp83ZNs1T59Dd4BnPkMqeu9rLUKvl23KA==
X-Received: by 10.223.133.140 with SMTP id 12mr16164218wrt.192.1520368187227;
        Tue, 06 Mar 2018 12:29:47 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id p104sm21908033wrb.47.2018.03.06.12.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 12:29:46 -0800 (PST)
Subject: Re: [PATCH v2 1/3] add -p: select individual hunk lines
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <20180306101750.18794-2-phillip.wood@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <a6f70938-0834-8109-6b94-d93639bb6d0c@gmail.com>
Date:   Tue, 6 Mar 2018 21:29:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306101750.18794-2-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2018 11:17, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When I end up editing hunks it is almost always because I want to
> stage a subset of the lines in the hunk. Doing this by editing the
> hunk is inconvenient and error prone (especially so if the patch is
> going to be reversed before being applied). Instead offer an option
> for add -p to stage individual lines. When the user presses 'l' the
> hunk is redrawn with labels by the insertions and deletions and they
> are prompted to enter a list of the lines they wish to stage. Ranges
> of lines may be specified using 'a-b' where either 'a' or 'b' may be
> omitted to mean all lines from 'a' to the end of the hunk or all lines
> from 1 upto and including 'b'.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-add.txt  |   7 +++
>  git-add--interactive.perl  | 143 +++++++++++++++++++++++++++++++++++++++++++++
>  t/t3701-add-interactive.sh |  65 +++++++++++++++++++++
>  3 files changed, 215 insertions(+)
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index d50fa339dc..ad33fda9a2 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -332,10 +332,17 @@ patch::
>         J - leave this hunk undecided, see next hunk
>         k - leave this hunk undecided, see previous undecided hunk
>         K - leave this hunk undecided, see previous hunk
> +       l - select hunk lines to use

Might be more surrounding context aligned to say "stage hunk lines" 
here (phrase "stage", instead of "select to use").

>         s - split the current hunk into smaller hunks
>         e - manually edit the current hunk
>         ? - print help
>  +
> +If you press "l" then the hunk will be reprinted with each insertion
> +or deletion labelled with a number and you will be prompted to enter
> +which lines you wish to select. Individual line numbers should be

Likewise, s/you wish to select/you wish to stage/.

> +separated by a space or comma, to specify a range of lines use a dash
> +between them.
> ++
>  After deciding the fate for all hunks, if there is any hunk
>  that was chosen, the index is updated with the selected hunks.
>  +
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index f83e7450ad..a273b41e95 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1013,6 +1013,133 @@ sub color_diff {
>  	} @_;
>  }
>  
> +sub label_hunk_lines {
> +	local $_;
> +	my $hunk = shift;
> +	my $i = 0;
> +	my $labels = [ map { /^[-+]/ ? ++$i : 0 } @{$hunk->{TEXT}} ];
> +	if ($i > 1) {
> +		@{$hunk}{qw(LABELS MAX_LABEL)} = ($labels, $i);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +sub select_hunk_lines {

This is just something I`ve spotted, but I have no actual idea if 
renaming this to "stage_hunk_lines" might be better, too, or not 
(depending on the surrounding code context), so please take this with 
a big grain of salt.

> +	my ($hunk, $selected) = @_;
> +	my ($text, $labels) = @{$hunk}{qw(TEXT LABELS)};
> +	my ($i, $o_cnt, $n_cnt) = (0, 0, 0);
> +	my ($push_eol, @newtext);
> +	# Lines with this mode will become context lines if they are
> +	# not selected
> +	my $context_mode = $patch_mode_flavour{IS_REVERSE} ? '+' : '-';
> +	for $i (1..$#{$text}) {
> +		my $mode = substr($text->[$i], 0, 1);
> +		if ($mode eq '\\') {
> +			push @newtext, $text->[$i] if ($push_eol);
> +			undef $push_eol;
> +		} elsif ($labels->[$i] and $selected->[$labels->[$i]]) {
> +			push @newtext, $text->[$i];
> +			if ($mode eq '+') {
> +				$n_cnt++;
> +			} else {
> +				$o_cnt++;
> +			}
> +			$push_eol = 1;
> +		} elsif ($mode eq ' ' or $mode eq $context_mode) {
> +			push @newtext, ' ' . substr($text->[$i], 1);
> +			$o_cnt++; $n_cnt++;
> +			$push_eol = 1;
> +		} else {
> +			undef $push_eol;
> +		}
> +	}
> +	my ($o_ofs, $orig_o_cnt, $n_ofs, $orig_n_cnt) =
> +					parse_hunk_header($text->[0]);
> +	unshift @newtext, format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
> +	my $newhunk = {
> +		TEXT => \@newtext,
> +		DISPLAY => [ color_diff(@newtext) ],
> +		OFS_DELTA => $orig_o_cnt - $orig_n_cnt - $o_cnt + $n_cnt,
> +		TYPE => $hunk->{TYPE},
> +		USE => 1,
> +	};
> +	# If this hunk has previously been edited add the offset delta
> +	# of the old hunk to get the real delta from the original
> +	# hunk.
> +	if ($hunk->{OFS_DELTA}) {
> +		$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
> +	}
> +	return $newhunk;
> +}
> +
> +sub check_hunk_label {
> +	my ($max_label, $label) = ($_[0]->{MAX_LABEL}, $_[1]);
> +	if ($label < 1 or $label > $max_label) {
> +		error_msg sprintf(__("invalid hunk line '%d'\n"), $label);
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +sub parse_hunk_selection {
> +	local $_;
> +	my ($hunk, $line) = @_;
> +	my $max_label = $hunk->{MAX_LABEL};
> +	my @selected = (0) x ($max_label + 1);
> +	my @fields = split(/[,\s]+/, $line);
> +	for (@fields) {
> +		if (/^([0-9]*)-([0-9]*)$/) {
> +			if ($1 eq '' and $2 eq '') {
> +				error_msg __("range '-' missing upper or lower bound\n");
> +				return undef;
> +			}
> +			my $lo = $1 eq '' ? 1 : $1;
> +			my $hi = $2 eq '' ? $max_label : $2;
> +			check_hunk_label($hunk, $lo) or return undef;
> +			check_hunk_label($hunk, $hi) or return undef;
> +			if ($hi < $lo) {
> +				($lo, $hi) = ($hi, $lo);
> +			}
> +			@selected[$lo..$hi] = (1) x (1 + $hi - $lo);
> +		} elsif (/^([0-9]+)$/) {
> +			check_hunk_label($hunk, $1) or return undef;
> +			$selected[$1] = 1;
> +		} else {
> +			error_msg sprintf(__("invalid hunk line '%s'\n"), $_);
> +			return undef;
> +		}
> +	}
> +	return \@selected;
> +}
> +
> +sub display_hunk_lines {
> +	my ($display, $labels, $max_label) =
> +				@{$_[0]}{qw(DISPLAY LABELS MAX_LABEL)};
> +	my $width = int(log($max_label) / log(10)) + 1;
> +	my $padding = ' ' x ($width + 1);
> +	for my $i (0..$#{$display}) {
> +		if ($labels->[$i]) {
> +			printf '%*d %s', $width, $labels->[$i], $display->[$i];
> +		} else {
> +			print $padding . $display->[$i];
> +		}
> +	}
> +}
> +
> +sub select_lines_loop {
> +	my $hunk = shift;
> +	display_hunk_lines($hunk);
> +	my $selection = undef;
> +	until (defined $selection) {
> +		print colored $prompt_color, __("select lines? ");
> +		my $text = <STDIN>;
> +		defined $text and $text =~ /\S/ or return undef;
> +		$selection = parse_hunk_selection($hunk, $text);
> +	}
> +	return select_hunk_lines($hunk, $selection);
> +}
> +
>  my %edit_hunk_manually_modes = (
>  	stage => N__(
>  "If the patch applies cleanly, the edited hunk will immediately be
> @@ -1255,6 +1382,7 @@ j - leave this hunk undecided, see next undecided hunk
>  J - leave this hunk undecided, see next hunk
>  k - leave this hunk undecided, see previous undecided hunk
>  K - leave this hunk undecided, see previous hunk
> +l - select hunk lines to use

s/select hunk lines to use/stage hunk lines/

>  s - split the current hunk into smaller hunks
>  e - manually edit the current hunk
>  ? - print help
> @@ -1471,6 +1599,9 @@ sub patch_update_file {
>  		if ($hunk[$ix]{TYPE} eq 'hunk') {
>  			$other .= ',e';
>  		}
> +		if (label_hunk_lines($hunk[$ix])) {
> +			$other .= ',l';
> +		}
>  		for (@{$hunk[$ix]{DISPLAY}}) {
>  			print;
>  		}
> @@ -1610,6 +1741,18 @@ sub patch_update_file {
>  					next;
>  				}
>  			}
> +			elsif ($line =~ /^l/) {
> +				unless ($other =~ /l/) {
> +					error_msg __("Cannot select line by line\n");
> +					next;
> +				}
> +				my $newhunk = select_lines_loop($hunk[$ix]);
> +				if ($newhunk) {
> +					splice @hunk, $ix, 1, $newhunk;
> +				} else {
> +					next;
> +				}
> +			}
>  			elsif ($other =~ /s/ && $line =~ /^s/) {
>  				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
>  				if (1 < @split) {
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index a9a9478a29..65c8c3354b 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -360,6 +360,63 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
>  	! grep "^+31" actual
>  '
>  
> +test_expect_success 'setup expected diff' '
> +	cat >expected <<-\EOF
> +	diff --git a/test b/test
> +	index 0889435..341cc6b 100644
> +	--- a/test
> +	+++ b/test
> +	@@ -1,6 +1,9 @@
> +	+5
> +	 10
> +	 20
> +	+21
> +	 30
> +	 40
> +	 50
> +	 60
> +	+61
> +	\ No newline at end of file
> +	EOF
> +'
> +
> +test_expect_success 'can stage individual lines of patch' '

Here, you`re actually using "stage lines" yourself, good ;)

> +	git reset &&
> +	printf 61 >>test &&
> +	printf "%s\n" l "-2 4" |
> +	EDITOR=: git add -p 2>error &&
> +	test_must_be_empty error &&
> +	git diff --cached HEAD >actual &&
> +	diff_cmp expected actual
> +'
> +
> +test_expect_success 'setup expected diff' '
> +	cat >expected <<-\EOF
> +	diff --git a/test b/test
> +	index 0889435..cc6163b 100644
> +	--- a/test
> +	+++ b/test
> +	@@ -1,6 +1,8 @@
> +	+5
> +	 10
> +	 20
> +	 30
> +	 40
> +	 50
> +	 60
> +	+61
> +	\ No newline at end of file
> +	EOF
> +'
> +
> +test_expect_success 'can reset individual lines of patch' '
> +	printf "%s\n" l 2 |
> +	EDITOR=: git reset -p 2>error &&
> +	test_must_be_empty error &&
> +	git diff --cached HEAD >actual &&
> +	diff_cmp expected actual
> +'
> +
>  test_expect_success 'patch mode ignores unmerged entries' '
>  	git reset --hard &&
>  	test_commit conflict &&
> @@ -576,4 +633,12 @@ test_expect_success 'add -p patch editing works with pathological context lines'
>  	test_cmp expected-2 actual
>  '
>  
> +test_expect_success 'add -p selecting lines works with pathological context lines' '

Maybe s/selecting lines/staging lines/ ?

> +	git reset &&
> +	printf "%s\n" l 2 y |
> +	GIT_EDITOR=./editor git add -p &&
> +	git cat-file blob :a >actual &&
> +	test_cmp expected-2 actual
> +'
> +
>  test_done
> 
