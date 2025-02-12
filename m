Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648D27183B
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330794; cv=none; b=fZPSJzhGXE9eMBlvtNvLSZteRnlrEOk2KHmRy6y2TmAXoI3qriMsX4ECesyzAcNNKISTsoMCdei+RiliPqGsHsU64qsZf95/tcVCJVv/nIPJGpV/bVBxisl19nHOo7XGWWofbYKG0JV+/7C0R1fn8/gGzqk8iR0Ib72kQWI+xqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330794; c=relaxed/simple;
	bh=+cViV08kv7m9UlbQZ+HVlq+x5luNkN6hiE22p+mhe2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLBbN6CS9joN8IVzwwEAK/UIsf7xae9lM2AeZ/cfHBB/K0myqmMlBT/bSRqY9Bc3hzdsUershSO/ok+YzQuyPifM+/1KNq9KKrKpeJVofwQkrw+tQZfds5ccRUYRHgA50kLK1a8IzcRY2NYsGGDiVLWBwPhwdWBnTxgFhL/VJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRiDW9+Z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRiDW9+Z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f5a224544so56248805ad.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330791; x=1739935591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVnq/feY6Lv4ZR1bZKWEzX/EMnT5fc38CMbPrXZ819Q=;
        b=XRiDW9+ZaUI+kI9I1zJ7bDhakKJrSJCGx+AvL52WYf0+l4XcrCJD1REhZ2oFsgCNX1
         JIbdIkrF94Jeg8IicuqURKFS3iQBTQ9MceMlmAlANYnGcRQRTtZ2LVhljswFfpaKlV5a
         /sO7cmnnj/l5NZapJ4OjoMQsHlXhTeKZ/yvxso30tc3aoykHR+ZmJRx/RPEoGebLTi1Z
         sh1FK0o3aLUoFhuy/PEJMncl/vyOygJuvqBBbLTEZVl4Imdx6E6Fu4VU0ahFLTiBBmBN
         GFkN2k+DDB6v4DPK/nCUmYkclVU65qn/r4kIwNDRM1E8u8UM3pGw4lWgKNjGQQUtvDD/
         cX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330791; x=1739935591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVnq/feY6Lv4ZR1bZKWEzX/EMnT5fc38CMbPrXZ819Q=;
        b=Q0WvpCC1U8nApKzMaNcfMPA05M9BuKziO8fmgRzTIpGLmDw8tqysba/+dCkFgZ7ky3
         o1emkiS8wBfuW9Ib1bIKfQyMWG71dhfFHghnz4337HI3mCl3Md+WpScz143TEWjCNxsq
         jV673XbbTUP81UpIff9gXM+BRjzTM4cYriJ3Bi8B7kTrEG6gPFFcvpoj9udatz1QU1i2
         E+3DSXycre//MjM5BFn4L+204SI7cFibJADVyjMUvRUiSc2Y/0hoklpTxEpAy6pNYa3U
         zD9a2QPnxliQVwn0666BBCQcC4Ns6Qf+E4y0oBJo2CTP1wE4JQkNqmrcfk2z9iKZXcjP
         Lagg==
X-Forwarded-Encrypted: i=1; AJvYcCX3O/pqPiV8oEwsVbMR1aUgnUm7mrBHsoUmYATooghamGjfQMJJRKMqkOycODhdU3gE8EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxib3mqwtUUkTamBdZ8/AE2Nz+IgExWGIuWNQXMiFaMN6EfdBue
	f/2KdQ7BU+ANCvBXhAO4548yW9i4wgRYyAVvJK5JXc3sOQyxS7op0CLOZzpCTko=
X-Gm-Gg: ASbGncsuCq3br7r4KUi01jnUThc4l1S7LJAbEzqEUfgPpfoq1/JM/YsicIG0nIm5TsA
	ZiiSpvyevLCwuJiIwpjWdiZayod8uJYN8+zCE7VjSiVRD3sCYE2h+Qbwcste7vsS1ZIFKkwrYeb
	RLM08JWFDPVIqsr5V46UPXaVR55g1Yj2c9LB4l8bfhvtiV5M+9vGIWeMUGUGFfAlBgzsfPSNcJ4
	OBB6Zm9kezxCZhBxB9Avlr64TKb1OJu+KitWSLRAzEEWwUvxCBtgx48DsrDg6espMHD6tYiPT/h
	PFXosAv+Si85ltGPyzgsDlKrFHf0cqpveqZ0ejaYFyUs1dYx9gNy1EYhvNAyNGsLEg==
X-Google-Smtp-Source: AGHT+IExNNoB0Pti1JKLB6fkeKS9gZ5iO+lZNYqPHq9A+xuCOAUDrYS3KHgVK3yldCN1DeFocP49vA==
X-Received: by 2002:a05:6a21:81:b0:1ee:6032:b1e8 with SMTP id adf61e73a8af0-1ee6032be02mr1217354637.18.1739330791473;
        Tue, 11 Feb 2025 19:26:31 -0800 (PST)
Received: from ?IPV6:2601:647:5580:5760:508a:741e:539b:1c5c? ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad54184a564sm6434593a12.56.2025.02.11.19.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:26:30 -0800 (PST)
Message-ID: <081272b5-b035-47a6-a951-eb923a9a5833@gmail.com>
Date: Tue, 11 Feb 2025 19:26:29 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 1/1] diff: --patch-{modifies,grep} arg names for -S and
 -G
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
 git@vger.kernel.org
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250206014324.1839232-2-illia.bobyr@gmail.com> <xmqqseoqiybi.fsf@gitster.g>
From: Illia Bobyr <illia.bobyr@gmail.com>
In-Reply-To: <xmqqseoqiybi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/25 12:59, Junio C Hamano wrote:
 > Illia Bobyr <illia.bobyr@gmail.com> writes:
 >
 >> Most arguments have both short and long versions.  Long versions are
 >> easier to read, especially in scripts and command history.
 >>
 >> Tests that check just the option parsing are duplicated to check both
 >> short and long argument options.  But more complex tests are updated to
 >> use the long argument in order to improve the test readability.
 >
 > While checking both may be a prudent thing to do, because the "-S"
 > option and the "-G" option have been there with us almost since the
 > beginning of time, the swapping all existing use of them with the
 > longhand is rather unwelcome and needless churn, I would have to
 > say.

My thinking is that as long version names improve readability, it also 
applies
to the test code.  When I see a short option, I often have to check the 
manual
to remember what exactly does it do.  Even for "-S"/"-G" I find myself 
sometimes
confused as to which of the two does what exactly.  While the "grep" 
mnemonic
helps, I do not always remember it.

But, I think, I understand your point of view as well.

In v5, patch 5 contains a relatively minimum amount of changes that add long
alternatives for "-S" and "-G" just to the command line parsing.

I do not have your experience with assessing the churn, but if my 
argument about
the readability changes your mind, I've moved the rest of the updates into
separate patches, at the end of the chain.  Patches 8 through 10. Making it
easier to discuss them in smaller chunks, if you wish so.  But also, I 
assume,
it should be easy for you to ignore those, if you do not want to include 
them?

 > [...]
 >
 >> diff --git a/Documentation/gitdiffcore.txt 
b/Documentation/gitdiffcore.txt
 >> index 642c5..e4b18 100644
 >> --- a/Documentation/gitdiffcore.txt
 >> +++ b/Documentation/gitdiffcore.txt
 >> @@ -245,33 +245,35 @@ diffcore-pickaxe: For Detecting 
Addition/Deletion of Specified String
 >>
 >>  This transformation limits the set of filepairs to those that change
 >>  specified strings between the preimage and the postimage in a certain
 >> -way.  -S<block-of-text> and -G<regular-expression> options are used to
 >> +way.  --patch-modifies=<block-of-text> and
 >> +--patch-grep=<regular-expression> options are used to specify
 >> +different ways these strings are sought.
 >
 > This is worse.  Here is the first part that describes the pickaxe,
 > so mentioning both may be more appropriate; showing only the
 > longhand nobody is familiar with (yet) does not make any sense.
 >
 >     ... certain way. `--patch-modifies=<block-of-text>`
 >     (`-S<block-of-text>` for short) and 
`--patch-grep=<regular-expression>`
 >     (`-G<regular-expression>` for short) are used to ...
 >
 > Once establishing the equivalence between the longhand and the
 > shorthand for these two options, we do not have to churn the
 > existing text at all.

Applied your suggestion.

I guess one difference in the way you look at it, is that you default to the
short version when you can.  While I default to the long one, as I 
assume it is
easier to understand.  Someone not that intimately familiar with git 
might need
to go to the previous paragraph to recall what "-S" and "-G" are, while 
if they
are spelled as "--patch-modifies" and "--patch-grep", it might be less
necessary.  So, the argument is that while we are reducing the diff, we 
might
also be reducing the improvement in readability.

Being the author, I could also be biased when assessing how much more 
readable
"--patch-modifies" and "--patch-grep" are compared to "-S" and "-G".

 >> diff --git a/diff.c b/diff.c
 >> index d28b41..09beb 100644
 >> --- a/diff.c
 >> +++ b/diff.c
 >> @@ -4877,15 +4877,17 @@ void diff_setup_done(struct diff_options 
*options)
 >>
 >>      if (HAS_MULTI_BITS(options->pickaxe_opts & 
DIFF_PICKAXE_KINDS_MASK))
 >>          die(_("options '%s', '%s', and '%s' cannot be used together"),
 >> -            "-G", "-S", "--find-object");
 >> +            "-G/--patch-grep", "-S/--patch-modifies", "--find-object");
 >>
 >>      if (HAS_MULTI_BITS(options->pickaxe_opts & 
DIFF_PICKAXE_KINDS_G_REGEX_MASK))
 >>          die(_("options '%s' and '%s' cannot be used together, use 
'%s' with '%s'"),
 >> -            "-G", "--pickaxe-regex", "--pickaxe-regex", "-S");
 >> +            "-G/--patch-grep", "--pickaxe-regex",
 >> +                        "--pickaxe-regex", "-S/--patch-modifies");
 >>
 >>      if (HAS_MULTI_BITS(options->pickaxe_opts & 
DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
 >>          die(_("options '%s' and '%s' cannot be used together, use 
'%s' with '%s' and '%s'"),
 >> -            "--pickaxe-all", "--find-object", "--pickaxe-all", 
"-G", "-S");
 >> +            "--pickaxe-all", "--find-object",
 >> +                        "--pickaxe-all", "-G/--patch-grep", 
"-S/--patch-modifies");
 >
 > The message change looks fine; the indentation is broken.
 >
 > .git/rebase-apply/patch:184: indent with spaces.
 >                         "--pickaxe-regex", "-S/--patch-modifies");
 > .git/rebase-apply/patch:190: indent with spaces.
 >                         "--pickaxe-all", "-G/--patch-grep", 
"-S/--patch-modifies");
 > warning: 2 lines applied after fixing whitespace errors.
 > Applying: diff: --patch-{modifies,grep} arg names for -S and -G
 >
 > These alone do not require a new iteration, as "git am --whitespace=fix"
 > already corrected them.

Sorry about this.  I did check the indentation manually, but did not use a
tool.  Reconfigured my editor to use tabs now.

 >> -        OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
 >> +        OPT_CALLBACK_F('S', "patch-modifies", options, N_("<string>"),
 >> -        OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
 >> +        OPT_CALLBACK_F('G', "patch-grep", options, N_("<regex>"),
 >
 > OK.  NOte that this says <regex>.  We may want to have a separate 
clean-up
 > patch so that Documentation/gitdifcore.txt that used <regular-expression>
 > and the placeholder used here match.

Makes sense.
I've added this fix as patch 5 in v5.
I've reformatted paragraphs in gitdifcore.adoc that were affected.
Let me know if you do not want me to reformat it, and just keep shorter 
lines as
is.

 >> -                   N_("look for differences that change the number 
of occurrences of the specified regex"),
 >> +                   N_("look for differences where a patch contains 
the specified regex"),
 >
 > This is an unrelated change that should not be in this patch.  If
 > you want to modify it, please do it in a separate clean-up patch,
 > just like the above <regex> vs <regular-expression> change.

Split it into patch 2 in v5.

 >> -              N_("show all changes in the changeset with -S or -G"),
 >> +              N_("show all changes in the changeset with 
-S/--patch-modifies or -G/--patch-grep"),
 >
 > This line is meant to be shown when the user requests list of
 > options and their meanings.  Growing the message from 47 columns or
 > so to 78 columns would make it wider than terminals when these
 > messages are indented.  Because earlier entries in this array have
 > already established the equivalence between the shorthand and the
 > longhand, I do not think the output is understandable without this
 > change.

A description for "-S" is already 81 characters long:

N_("look for differences that change the number of occurrences of the 
specified regex"),

So I was assuming if I grow another description to 77 characters, it is 
still OK.
While one can find the correspondence between "-S" and "--patch-modifies" by
reading the "-S" description, in my mind, the same argument applies as 
to the
test readability - it just makes it a bit easier for the reader.

This change is now part of a much smaller patch 9 in v5, which is only about
adding longer alternatives to the CLI help messages that currently 
contain only
"-G" and "-S".  This way you can decide if you want it or not as a complete
unit.  Or if you want me to change it in some way, we can discuss it 
separately
from the rest of the changes.

By the way, I must admit I can not find a way to look at a help message
generated from these strings.  Running `git diff -h` shows a message from

`diff.h` and running `git diff --help` shows the man page.

Thank you.

