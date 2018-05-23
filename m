Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5CA1F51C
	for <e@80x24.org>; Wed, 23 May 2018 02:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeEWCe4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 22:34:56 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:39678 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeEWCez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 22:34:55 -0400
Received: by mail-wm0-f44.google.com with SMTP id f8-v6so4825893wmc.4
        for <git@vger.kernel.org>; Tue, 22 May 2018 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ClvvOppInp1yJdAO+HJ6XJJm+9dxS4RucHaPCFi4wAQ=;
        b=YGR6CBIz5U5EG5XR3bZROuhbuH12lJi7YjCUnNxAA1vngr08iINvz96AU4F48ETV3A
         qOGHmZNm1+5mEpK8nGdKB9BT+Z49oux+vb/i0SUO8s9P8Ae5JBviGYNLH8/2z5UW+nik
         ZjvKLMyGPyfQrnV4nWWcmlEvRAmV1oSDMlf6UiXLpjpveLT44rS9u2JoD9dCaFaMY72/
         tLcsDShDrZvDxTczA3zlsZ7GKOOzr6fgyOkgdpM1zZ2FCDRShs+Ue7XoVpf7+nzTtQ0N
         7gBksbld/r76UC+RmBd+eVGcWGoEul7unAQFS5qkpWMpy2/4Gj8rGdLjN47HSjN0ZPIm
         1Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ClvvOppInp1yJdAO+HJ6XJJm+9dxS4RucHaPCFi4wAQ=;
        b=Endi12hDgiAeUIFwAw5H6Ep+SLZ5o0UD14APtoqFPM6naQx0T47/9H1A7PY6seNdhr
         IGxG7mCnd85+PdYnWykN5yjKcq1Q+icuRUg7+XvCPDWpJYJQGAgmhteS4BkjzBLKw5zq
         CFnkP6udldEqhVyy606PpujfBwurSWV4bLpN8iKcoC0IdKIw6qNQV01xX4m7i2NE6QqF
         SAMwkSoj3c4qNjBE5zJpMBSJTgBXOc8X6O/xCh1eU5aM29JWiOw19h6HIqOSDL8Sod4h
         ibEhl5ilw2cqsFnsAcPEjcZqVMwzGDoqhchR/WfHr35AuWLAnp73emtr8C4WpUw1ImkL
         ioIg==
X-Gm-Message-State: ALKqPwefJDE6ZcftgYeFI167pevbWKAcBhY50zHOFb2oSXRDRIv723gc
        wWjQdOI4WZRxLAXMigU8UdI=
X-Google-Smtp-Source: AB8JxZr0k4ztexVfhIyeYGSpXjxZhjynNZhIbOMlENCUgf6gaHTOnbyxYkhELZFBvH9nVimUMvSRbQ==
X-Received: by 2002:a1c:904b:: with SMTP id s72-v6mr2717501wmd.85.1527042893360;
        Tue, 22 May 2018 19:34:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u69-v6sm1449015wma.37.2018.05.22.19.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 19:34:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pedro Alvarez <pedro.alvarez@codethink.co.uk>
Cc:     git@vger.kernel.org,
        Pedro Alvarez Piedehierro <palvarez89@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add initial support for pax extended attributes
References: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk>
Date:   Wed, 23 May 2018 11:34:52 +0900
In-Reply-To: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk> (Pedro
        Alvarez's message of "Tue, 22 May 2018 11:05:48 +0100")
Message-ID: <xmqqd0xnw14j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pedro Alvarez <pedro.alvarez@codethink.co.uk> writes:

> From: Pedro Alvarez Piedehierro <palvarez89@gmail.com>
> Subject: [PATCH] Add initial support for pax extended attributes

Lead it with the name of the area you are adding support for pax ext
header, e.g.

    Subject: [PATCH] import-tars: read overlong names from pax extended header

or something.

> Sometimes the tar files will contain pax extended attributes to deal
> with cases where the information needed doesn't fit in a standard
> ustar entry.
>
> One of these cases is when the path is larger than 100 characters. A
> pax entry will appear containing two standard ustart entries. The first

u-start? us-tart? sound yummy.  I think s/ustart entries/ustar headers/

> entry will have an 'x' typeflag, and contain the the extended attributes.

s/contain/&s/

>
> The pax extended attributes contain one or multiple records constructed as
> follows:
>
>     "%d %s=%s\n", <length>, <keyword>, <value>

> This commit makes sure that we always read the extended attibutes from

s/This commit makes sure/Make sure/;

> pax entries, and in the case of finding one, we parse its records
> looking for 'path' information. If this information is found, it's
> stored to be used in the next ustar entry.
>
> Information about the Pax Interchange Format can be found at:
>
>     https://www.freebsd.org/cgi/man.cgi?manpath=FreeBSD+8-current&query=tar&sektion=5.

> Before this change, importing gcc tarballs[1] would fail with the
> following error:
>
>     fast-import crash report:
>         fast-import process: 82899
>         parent process     : 82897
>         at 2018-05-21 12:35:27 +0000
>
>     fatal: Unsupported command: 29 atime=1516870168.93527949

Drop "Before this change, " and move the above to the very beginning
of the proposed log message.  The problem description is always
"without this patch applied, we have this problem that needs to be
fixed", so "Before this change" is an unnecessary thing to say.

The remainder of the crash log may or may not be in the problem
description, if we want to shoot for brevity.  If I were writing a
log message for this patch, I'd go for even shorter version, e.g.

	Importing gcc tarballs[1] with import-tars script (in
	contrib/) fails when hitting a pax extended header that
	records a long pathname.

	Teach the code to parse and grab information from pax
	extended headers, and reconstruct a long pathname that is
	split into multiple records, to correct this problem.

        The code to parse pax extended headers were written,
        consulting the Pax Interchange Format documentation [2].

	[1] http://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz
	[2] https://www.freebsd.org/cgi/man.cgi?manpath=FreeBSD+8-current&query=tar&sektion=5

> index d60b4315ed..c2e54ec7a3 100755
> --- a/contrib/fast-import/import-tars.perl
> +++ b/contrib/fast-import/import-tars.perl
> @@ -63,6 +63,8 @@ foreach my $tar_file (@ARGV)
>  	my $have_top_dir = 1;
>  	my ($top_dir, %files);
>  
> +	my $next_path = '';
> +
>  	while (read(I, $_, 512) == 512) {
>  		my ($name, $mode, $uid, $gid, $size, $mtime,
>  			$chksum, $typeflag, $linkname, $magic,
> @@ -70,6 +72,13 @@ foreach my $tar_file (@ARGV)
>  			$prefix) = unpack 'Z100 Z8 Z8 Z8 Z12 Z12
>  			Z8 Z1 Z100 Z6
>  			Z2 Z32 Z32 Z8 Z8 Z*', $_;
> +
> +		unless ($next_path eq '') {
> +			# Recover name from previous extended header
> +			$name = $next_path;
> +			$next_path = '';
> +		}
> +
>  		last unless length($name);
>  		if ($name eq '././@LongLink') {
>  			# GNU tar extension
> @@ -90,13 +99,32 @@ foreach my $tar_file (@ARGV)
>  			Z8 Z1 Z100 Z6
>  			Z2 Z32 Z32 Z8 Z8 Z*', $_;
>  		}
> -		next if $name =~ m{/\z};
>  		$mode = oct $mode;
>  		$size = oct $size;
>  		$mtime = oct $mtime;
>  		next if $typeflag == 5; # directory
>  
> -		if ($typeflag != 1) { # handle hard links later
> +		if ($typeflag eq 'x') { # extended header
> +			# If extended header, check for path
> +			my $pax_header = '';
> +			while ($size > 0 && read(I, $_, 512) == 512) {

Would we ever get a short-read (i.e. we ask to read 512 bytes,
syscall returns after reading only 256 bytes, even though next call
to read would give the remaining 256 bytes and later ones)?

If we do get a short-read, would that be an error (in which case,
how are we handling it)?  If it is not an error, should we continue
reading, instead of leaving the loop?

> +				$pax_header = $pax_header . substr($_, 0, $size);
> +				$size -= 512;
> +			}
> +
> +			my @lines = split /\n/, $pax_header;
> +			foreach my $line (@lines) {
> +				my ($len, $entry) = split / /, $line;
> +				my ($key, $value) = split /=/, $entry;
> +				if ($key eq 'path') {
> +					$next_path = $value;
> +				}
> +			}
> +			next;
> +		} elsif ($name =~ m{/\z}) {
> +			# If it's a folder, ignore

It is a very good idea to add comment on why we are ignoring and
doing 'next' here, but the tar format documentation you cited never
uses the word 'folder'.  s/folder/directory/, probably.

> +			next;
> +		} elsif ($typeflag != 1) { # handle hard links later
>  			print FI "blob\n", "mark :$next_mark\n";
>  			if ($typeflag == 2) { # symbolic link
>  				print FI "data ", length($linkname), "\n",

Thanks.
