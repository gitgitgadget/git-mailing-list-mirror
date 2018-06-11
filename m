Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88AF61F517
	for <e@80x24.org>; Mon, 11 Jun 2018 07:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeFKHrv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 03:47:51 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35226 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeFKHru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 03:47:50 -0400
Received: by mail-io0-f194.google.com with SMTP id u4-v6so22834099iof.2
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5GU54IY9PvZ46ux2k2tckq/NFaWo10P2zyZseBgWl0A=;
        b=baKj9wMZ/8V/SQJ6ZncJdlsqqYMoPA7ZOlkKRGjnaB4Xs5xBw8YXUkPOxBwfy+8N+3
         3z8CO2wHGF5a+QiXU1JToBMZnxn2r3QFxEULU8CAOGacyRPbYy0cYV/Exn2nGBVALP1v
         dk7oNuaHIu9baeEF/TnpNUtZsZLzosO8wGYkY8m8x1sn6iNfpOA0alqkywFKN0yNi9ZR
         7nLpazN/WVvm3OZxQ3W5bVzicnQZPGvkHd6MKQ93QIGCkuB0j1+XdAJ3tCXOj2a6Z/aA
         puYyu9HvaZiBw6XfpT83DlZIAtALm87nUJab7ppKl6mh9lwY2i0Fzknm01q799d5wyzt
         zzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GU54IY9PvZ46ux2k2tckq/NFaWo10P2zyZseBgWl0A=;
        b=jZfcoqX8hM87vHy5mdRLwyH504QJFT5P4RUP4Blsbw7d+zrlWmY4xtfBXp/eFZ/SdF
         oxKysxCCIlIXQPu72kSL4391+YWUyQA/4cm4SiC42kyMNO6LYS6yt8tHmehWuALkrgpm
         zCVgfF8AHJ35YdSpOLzcVBkEGdKlMPAkk2PwIaaSuu1N/HT/NBWC2d89hZDVK2yAjvWj
         xVjekIxeLeRT5myYLkMRJW/7kpkGJ6Hh92/PBDgrJiSSYrI+QmqRPf5uWddLMP7IDZx3
         8gef6BpQHH9flI+gdz7gJnq8gKibvcaIV7JUoAysy6Joj4HtPJLqbl3THkmZjn8zYoHT
         NR7w==
X-Gm-Message-State: APt69E1nal2K2L+RG0FoH9dULPs7IBjYMjzpXHe0yvHnSLgnW4s692GI
        a5pPJh3W6LdyHvJS8Ls0nmDD+g==
X-Google-Smtp-Source: ADUXVKJchLYfIUpkFjqUVW33nySqJjjAm19ymehqfh3kEWIbejkkCd+afhpe26MxGIu8gSsMG6ioIg==
X-Received: by 2002:a6b:1745:: with SMTP id 66-v6mr12875604iox.154.1528703269711;
        Mon, 11 Jun 2018 00:47:49 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k139-v6sm3983444itk.27.2018.06.11.00.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 00:47:48 -0700 (PDT)
Date:   Mon, 11 Jun 2018 03:47:43 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
Message-ID: <20180611074743.GA24066@flurp.local>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604235229.279814-2-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 11:52:20PM +0000, brian m. carlson wrote:
> Add a test function helper, test_translate, that will produce its first
> argument if the hash in use is SHA-1 and the second if its argument is
> NewHash.  Implement a mode that can read entries from a file as well for
> reusability across tests.

The word "translate" is very generic and is (at least in my mind)
strongly associated with i18n/l10n, so the name test_translate() may
be confusing for readers. Perhaps test_oid_lookup() or test_oid_get()
or even just test_oid()?

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -1147,3 +1147,43 @@ depacketize () {
> +test_translate_f_ () {
> +	local file="$TEST_DIRECTORY/translate/$2" &&
> +	perl -e '
> +		$delim = "\t";
> +		($hoidlen, $file, $arg) = @ARGV;
> +		open($fh, "<", $file) or die "open: $!";
> +		while (<$fh>) {
> +			# Allow specifying other delimiters.
> +			$delim = $1 if /^#!\sdelimiter\s(.)/;
> +			next if /^#/;
> +			@fields = split /$delim/, $_, 3;
> +			if ($fields[0] eq $arg) {
> +				print($hoidlen == 40 ? $fields[1] : $fields[2]);
> +				last;
> +			}
> +		}
> +	' "$1" "$file" "$3"
> +}

This is a very expensive lookup since it invokes a heavyweight command
(perl, in this case) for *every* OID it needs to retrieve from the
file. Windows users, especially, will likely not be happy about this.
See below for an alternative.

> +# Without -f, print the first argument if we are using SHA-1 and the second if
> +# we're using NewHash.
> +# With -f FILE ARG, read the (by default) tab-delimited file from
> +# t/translate/FILE, finding the first field matching ARG and printing either the
> +# second or third field depending on the hash in use.
> +test_translate () {
> +	local hoidlen=$(printf "%s" "$EMPTY_BLOB" | wc -c) &&
> +	if [ "$1" = "-f" ]
> +	then
> +		shift &&
> +		test_translate_f_ "$hoidlen" "$@"
> +	else
> +		if [ "$hoidlen" -eq 40 ]
> +		then
> +			printf "%s" "$1"
> +		else
> +			printf "%s" "$2"
> +		fi
> +	fi
> +}

This is less flexible than I had expected, allowing for only SHA1 and
NewHash. When you had written about OID lookup table functionality in
email previously, my impression was that the tables would allow values
for arbitrary hash algorithms. Such flexibility would allow people to
experiment with hash algorithms without having to once again retrofit
the test suite machinery.

Here's what I had envisioned when reading your emails about OID lookup
table functionality:

--- >8 ---
test_detect_hash () {
    test_hash_algo=...
}
    
test_oid_cache () {
    while read tag rest
    do
        case $tag in \#*) continue ;; esac

        for x in $rest
        do
            k=${x%:*}
            v=${x#*:}
            if test "$k" = $test_hash_algo
            then
                eval "test_oid_$tag=$v"
                break
            fi
        done
    done
}

test_oid () {
    if test $# -gt 1
    then
        test_oid_cache <<-EOF
        $*
        EOF
    fi
    eval "echo \$test_oid_$1"
}
--- >8 ---

test_detect_hash() would detect the hash algorithm and record it
instead of having to determine it each time an OID needs to be
"translated". It probably would be called by test-lib.sh.

test_oid_cache() reads a table of OID's and caches them so that
subsequent look-ups are fast. It would be called (possibly multiple
times) by any script needing to "translate" OID's. Each line of the
table has form "tag algo:value ...". Lines starting with '#' are
comments (as in your implementation). Since it reads stdin, it works
equally well reading OID tables from files and here-docs, which
provides extra flexibility for test authors. For instance:

    test_oid_cache <translate/hash-info

or:

    test_oid_cache <<-\EOF
    rawsz sha1:20 NewHash:32
    hexsz sha1:40 NewHash:64
    EOF

test_oid() does the actual OID lookup/translation. It looks up a
pre-cached value or, for convenience (as per your implementation), can
choose between values specified at invocation time. For example, the
simple case:

    $(test_oid hexsz)

And, when specifying values from which to choose based upon hash
algorithm:

    $(test_oid bored sha1:deadbeef NewHash:feedface)

A nice property of how this implementation caches values is that you
don't need test_oid() for really simple cases. You can just access the
variable directly. For instance: $test_oid_hexsz

Another nice property of how caching is implemented is that someone
testing a new hash algorithm doesn't have edit the existing tables to
tack the value for the new algorithm onto the end of each line. It
works equally well to place those values in a new file or new here-doc
or simply append new lines to existing files or here-docs. For
instance, someone testing algorithm "NewShiny" can just add those
lines without having to modify existing lines:

    test_oid_cache <<-\EOF
    rawsz sha1:20 NewHash:32
    hexsz sha1:40 NewHash:64
    # testing NewShiny algorithm
    rawsz: NewShiny:42
    hexsz: NewShiny:84
    EOF
