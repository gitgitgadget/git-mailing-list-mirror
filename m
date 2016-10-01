Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D8B20986
	for <e@80x24.org>; Sat,  1 Oct 2016 15:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbcJAPe3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 11:34:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33436 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbcJAPe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 11:34:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id p138so7643367wmb.0
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QMEkyh6htl46JmcfR8LsASj9h4BUomZoLTGghwCfcw0=;
        b=g7xCg2j7PC9MOaE8wKStavD1VyBQH4e7BrXFHFuvQlREts1tH2GS0ZUTgn014bPAr7
         YCPmonmk4O/CPhh23r0d8XbRp/qCOdSmniQge7VsGeCre1+Qg18bf5DKCSNIrliI7SRQ
         /oxiAFPN98EADvG/p+sGUMaqw957admByUXdUY8NneBw1E0hwCjqq4iSDtDkYHCA5gs6
         ZkCkbOBEVTrlfYgvDfVhali/a5hiJ8gh1mZID9KGgMbwAhDvKlyP0CkKOOpvQe2ngLzI
         nKhz+lTOQ2dcK/mk6VsfxpFOXIcd1l4FlhM9e/lyDK6U6EFEer4KzAoHjkwm/b2Z3Pml
         ipxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QMEkyh6htl46JmcfR8LsASj9h4BUomZoLTGghwCfcw0=;
        b=cZieShmICFqSWxPhcmWozkFI08G1f01qjz1rNMQI9ssLXlCZlS9BqQQNgJK9Cz8rRx
         qCOTR8/MW71BQqxK79DFjEJq8A7XmtIgtHPzJ5g6z0LzidrgRgRyd6xXgF5POODN7Ssl
         bujwb6atqznQnD9IIBE5ZPhUO/ppw2WXFLgTL8SjdCVxTKUm95ej41xgcpfL/dgw6k0Q
         TCDRTpCPM0T+g8Ek7FU9kP+mKfOI8Ype2KFr/ui0Fz7zIBOwexE91dYXfB07z7e2DLA8
         s5c1w2P5soho6Y8dlQ+oJZINKvFakoKVNAPBPrmysvpl3ZPB9dK6Dhii1PWHAOUaukl7
         okmQ==
X-Gm-Message-State: AA6/9RkGSfozInajpzXxXjcTSa4PvVerCzF0zzCmtviwVvgNkk/f/j2V58V79Ge2Z63irA==
X-Received: by 10.28.206.75 with SMTP id e72mr2840805wmg.65.1475336065902;
        Sat, 01 Oct 2016 08:34:25 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA8B3.dip0.t-ipconnect.de. [80.139.168.179])
        by smtp.gmail.com with ESMTPSA id w203sm9658355wmw.7.2016.10.01.08.34.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Oct 2016 08:34:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <e8815048-212e-64c6-8811-9185f595aaf6@gmail.com>
Date:   Sat, 1 Oct 2016 17:34:23 +0200
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C680AE2-7F5A-47E4-8E79-6C3F4AEBD39B@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-12-larsxschneider@gmail.com> <e8815048-212e-64c6-8811-9185f595aaf6@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Sep 2016, at 01:14, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> Part third (and last) of the review of v8 11/11.
>=20
> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com napisa=C5=82:
>=20
>=20
>> @@ -31,7 +31,10 @@ test_expect_success setup '
>> 	cat test >test.i &&
>> 	git add test test.t test.i &&
>> 	rm -f test test.t test.i &&
>> -	git checkout -- test test.t test.i
>> +	git checkout -- test test.t test.i &&
>> +
>> +	echo "content-test2" >test2.o &&
>> +	echo "content-test3 - subdir" >"test3 - subdir.o"
>=20
> I see that you prepare here a few uncommitted files, but both
> their names and their contents leave much to be desired - you
> don't know from the name and contents what they are for.
>=20
> And the '"subdir"' file which is not in subdirectory is
> especially egregious.

These are 3 files with somewhat random test content. I renamed
"subdir" to "spaces".


>> +check_filter () {
>> +	rm -f rot13-filter.log actual.log &&
>> +	"$@" 2> git_stderr.log &&
>> +	test_must_be_empty git_stderr.log &&
>> +	cat >expected.log &&
>=20
> This is too clever by half.  Having a function that both tests
> the behavior and prepares 'expected' file is too much.
>=20
> In my opinion preparation of 'expected.log' file should be moved
> to another function or functions.
>=20
> Also, if we are running sort on output, I think we should also
> run sort on 'expected.log', so that what we write doesn't need to
> be created sorted (so we don't have to sort expected lines by hand).
> Or maybe we should run the same transformation on rot13-filter.log
> and on the contents of expected.log.

Agreed. Very good suggestion!


>> +check_filter_ignore_clean () {
>> +	rm -f rot13-filter.log actual.log &&
>> +	"$@" &&
>=20
> Why we don't check for stderr here?

Because this function is used by "git checkout" which writes all
kinds of stuff to stderr. I added "--quiet --no-progress" to
disable this behavior.=20


>> +check_rot13 () {
>> +	test_cmp "$1" "$2" &&
>> +	./../rot13.sh <"$1" >expected &&
>=20
> Why there is .. in this invocation?

Because this script is located in the root of the current test =
directory.


>> +	git cat-file blob :"$2" >actual &&
>> +	test_cmp expected actual
>> +}
>> +
>> +test_expect_success PERL 'required process filter should filter =
data' '
>> +	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
>> +	test_config_global filter.protocol.required true &&
>> +	rm -rf repo &&
>> +	mkdir repo &&
>> +	(
>> +		cd repo &&
>> +		git init &&
>=20
> Don't you think that creating a fresh test repository for each
> separate test is a bit too much?  I guess that you want for
> each and every test to be completely independent, but this setup
> and teardown is a bit excessive.
>=20
> Other tests in the same file (should we reuse the test, or use
> new test file) do not use this method.

I see your point. However, I am always annoyed if Git tests are
entangled because it makes working with them way way harder.
This test test runs in 4.5s on a slow Travis CI machine. I think
that is OK considering that we have tests running 3.5min (t3404).


>> +		echo "*.r filter=3Dprotocol" >.gitattributes &&
>> +		git add . &&
>> +		git commit . -m "test commit" &&
>> +		git branch empty &&
>=20
> Err... I think it would be better to name it 'empty-branch'
> (or 'almost-empty-branch', as it does include .gitattributes file).
> See my mistake below (marked <del>...</del>).

"empty-branch". OK


>> +
>> +		cp ../test.o test.r &&
>> +		cp ../test2.o test2.r &&
>=20
> What does this test2.o / test2.r file tests, that test.o / test.r
> doesn't?  The name doesn't tell us.

This just tests multiple files with different content.


> Why it is test.r, but test2.r?  Why it isn't test1.r?

test.r already existed (created in setup test).


>> +		mkdir testsubdir &&
>> +		cp "../test3 - subdir.o" "testsubdir/test3 - subdir.r" =
&&
>=20
> Why it needs to have different contents?

To check that the filer does the right thing with multiple files
and contents.



>> +		>test4-empty.r &&
>=20
> You test ordinary file, file in subdirectory, file with filename
> containing spaces, and an empty file.
>=20
> Other tests of single file `clean`/`smudge` filters use filename
> that requires mangling; maybe we should use similar file?
>=20
>        special=3D"name  with '\''sq'\'' and \$x" &&
>        echo some test text >"$special" &&

OK.


> In case of `process` filter, a special filename could look like
> this:
>=20
>        process_special=3D"name=3Dwith equals and\nembedded newlines\n" =
&&
>        echo some test text >"$process_special" &&

I think this test would create trouble on Windows. I'll stick to
the special characters used in the single shot filter.


>> +				<<-\EOF &&
>> +					1 IN: clean test.r 57 [OK] -- =
OUT: 57 . [OK]
>> +					1 IN: clean test2.r 14 [OK] -- =
OUT: 14 . [OK]
>> +					1 IN: clean test4-empty.r 0 [OK] =
-- OUT: 0  [OK]
>> +					1 IN: clean testsubdir/test3 - =
subdir.r 23 [OK] -- OUT: 23 . [OK]
>> +					1 START
>> +					1 STOP
>> +					1 wrote filter header
>> +				EOF
>=20
> First, this indentation level confirms that the check_filter
> function is too clever by half, and that preparing expected.log
> file should be a separate step.

Agreed.


> Second, if we run "sort" on contents to be in expected.log, we
> can write it in more natural, and less fragile way:

Agreed.


> Third, why the filter even writes output size? It is no longer
> part of `process` filter driver protocol, and it makes test more
> fragile.

I would prefer to leave that in. I think it is good for the test to
check that we are transmitting the amount of content that what we=20
think we transmit.


> If we are to keep sizes, then to make test less fragile with
> respect to changes in contents of tested files, we should use
> variables containing file size:
>=20
>   		test_r_size=3D$(wc -c test.r)
>   		...
>   		sort >expected.log <<-EOF &&
>   		...
>   			1 IN: clean test.r $test_r_size [OK] -- OUT: =
$test_r_size . [OK]

Agreed.


>>=20
>> +		rm -f test?.r "testsubdir/test3 - subdir.r" &&
>=20
> Why 'test?.r' when we are removing only 'test2.r'; why not be =
explicit?

True!


>> +				<<-\EOF &&
>> +					START
>> +					wrote filter header
>> +					STOP
>> +				EOF
>=20
> Why is even filter process invoked?  If this is not expected, perhaps
> simply ignore what checking out almost empty branch (one without any
> files marked for filtering) does.
>=20
> Shouldn't we test_expect_failure no-call?

Because a clean operation could happen. I added a clean operation to
the expected log in order to make this visible (expected log is stripped
of clean operations in the same way as the actual log per your =
suggestion
above).


>> +
>> +		check_filter_ignore_clean \
>> +			git checkout master \
>=20
> Does this checks different code path than 'git checkout .'? For
> example, does this test increase code coverage (e.g. as measured
> by gcov)?  If not, then this test could be safely dropped.

We checked out the "empty-branch" before. That's why we check here
that the smudge filter runs for all files (smudge filter did not run
for all files with `git checkout .`).


>> +				<<-\EOF &&
>> +					START
>> +					wrote filter header
>> +					IN: smudge test.r 57 [OK] -- =
OUT: 57 . [OK]
>> +					IN: smudge test2.r 14 [OK] -- =
OUT: 14 . [OK]
>> +					IN: smudge test4-empty.r 0 [OK] =
-- OUT: 0  [OK]
>> +					IN: smudge testsubdir/test3 - =
subdir.r 23 [OK] -- OUT: 23 . [OK]
>=20
> Can we assume that Git would pass files to filter in alphabetical
> order?  This assumption might make the test unnecessary fragile.

I have never experienced another behavior. If we see fragility we could
sort the result...


>>=20
>> +test_expect_success PERL 'required process filter should clean only =
and take precedence' '
>=20
> Trying to describe it better results in overly long description,
> which probably means that this test should be split into few
> smaller ones:
>=20
> - `process` filter takes precedence over `clean` and/or `smudge`
>   filters, regardless if it supports relevant ("clean" or "smudge")
>   capability or not
>=20
> - `process` filter that includes only "clean" capability should
>   clean only (be used only for 'clean' operation)

Agreed!


> In my opinion all functions should be placed at beginning,
> or even in separate file (if they are used in more than
> one test).

OK


>> +generate_test_data () {
>=20
> The name is not good, it doesn't describe what kind of data
> we want to generate.

"generate_random_characters" ok?!

>> +		perl -pe "s/./chr((ord($&) % 26) + 97)/sge" =
>../$NAME.file &&
>=20
> Those constants (26 and 97) are a bit cryptic; magical constants.
> I guess this is
>=20
>  +		perl -pe "s/./chr((ord($&) % (ord('z') - ord('a') + 1) + =
ord('a'))/sge" >../$NAME.file &&
>=20
> or
>=20
>  +		perl -pe "s/./chr((ord($&) % 26 + ord('a'))/sge" =
>../$NAME.file &&

OK!


> Do we re-generate this file each time?
>=20
>> +	./../rot13.sh <../$NAME.file >../$NAME.file.rot13
>=20
> Anyway, I wonder if taking the last two lines out of the function
> (as they are not about _generating_ a file) would make it more
> readable or not.

Agreed.


>> +
>> +		echo "*.file filter=3Dprotocol" >.gitattributes &&
>> +		check_filter \
>> +			git add *.file .gitattributes \
>=20
> Should it be shell expansion, or git expansion, that is
>=20
>   			git add '*.file' .gitattributes

Both have the same output. Would the difference matter?


>> +					1 START
>> +					1 STOP
>> +					1 wrote filter header
>> +				EOF
>> +		git commit . -m "test commit" &&
>=20
> Is this needed / necessary?

Yes, to test the smudge afterwards!

>=20
>> +
>> +		rm -f *.file &&
>> +		git checkout -- *.file &&
>=20
> Is this necessary?  I guess this checks that it doesn't crash, but
> we do not check that smudge operation works correctly, as we did
> for clean.

Good point. Smudge check added!


>> +		for f in *.file
>> +		do
>> +			git cat-file blob :$f >actual &&
>> +			test_cmp ../$f.rot13 actual
>> +		done
>=20
> Wasn't there helper function for this?

True :-)


>> +test_expect_success PERL 'required process filter should with clean =
error should fail' '
>                                                     ^^^^^^             =
     ^^^^^^
>=20
> Errr... what?  You have 'should' twice here.

Fixed


> Also, does it matter that the error is during clean operation?
> We don't test that error during smudge operation is handled in
> the same way, do we?

Clean and smudge should hit the same code paths here. Therefore I think
it is sufficient to test clean only.


>> +	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
>=20
> Do we need to pass 'clean smudge', or does it provide both by
> default?

We need to pass them. Default is empty.


>> +		git add . &&
>> +		git commit . -m "test commit" &&
>=20
> You don't need to commit for 'git checkout <path>' (e.g. for .)
> or 'git cat-file -p :<file>' to work.

True!


>> +	)
>> +'
>> +
>> +test_expect_success PERL 'process filter should not restart in case =
of an error' '
>=20
> Errr... what? This description is not clear.  Did you mean
> that filter should not be restarted if it *signals* an error
> with file (either before sending anything, or after sending
> partial contents)?

OK renamed to "process filter should not be restarted if it signals an =
error"


>> +test_expect_success PERL 'process filter should be able to signal an =
error for all future files' '
>=20
> Did you mean here that filter can abort processing of
> all future files?

"process filter signals abort once to abort processing of all future =
files", better?


>> +
>> +		cp ../test.o test.r &&
>> +		test_must_fail git add . 2> git_stderr.log &&
>> +		grep "not support long running filter protocol" =
git_stderr.log
>=20
> Shouldn't this use gettext poison (or rather C locale)?
> This error message could be translated in the future.

I would prefer to adjust that when we translate it.


>> +    $str =3D~ y/A-Za-z/N-ZA-Mn-za-m/;
>=20
> Why not use tr/// version of this quote-like operation?
> Or do you follow prior art here?

I am not Perl expert. That worked for me :-)


>> +sub packet_bin_read {
>> +    my $buffer;
>> +    my $bytes_read =3D read STDIN, $buffer, 4;
>> +    if ( $bytes_read =3D=3D 0 ) {
>> +
>> +        # EOF - Git stopped talking to us!
>> +        print $debug "STOP\n";
>> +        exit();
>> +    }
>> +    elsif ( $bytes_read !=3D 4 ) {
>> +        die "invalid packet size '$bytes_read' field";
>=20
> Errr, $bytes_read is not packet size field.  It is $buffer.
> Also, error message looks strange
>=20
>   		invalid packet size '004' field
>=20
> Shouldn't it be at end?

True. Fixed!


>> +        }
>> +        return ( 0, $buffer );
>> +    }
>> +    else {
>> +        die "invalid packet size";
>=20
> Is keep-alive packet valid ("0004")?

No.


>>=20
>> +packet_flush();
>> +print $debug "wrote filter header\n";
>=20
> Or perhaps "handshake end"?

"init handshake complete", ok?


>> +    print $debug " $pathname";
>=20
> No " pathname=3D$pathname" ?

Yes, otherwise it gets too verbose in the tests.


>> +        while ( length($output) > 0 ) {
>> +            my $packet =3D substr( $output, 0, =
$MAX_PACKET_CONTENT_SIZE );
>> +            packet_bin_write($packet);
>> +            print $debug ".";
>=20
> All right, so number of dots is the number of packets.  This is
> surprisingly opaque.

I added a comment.


>=20
>> +            if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
>> +                $output =3D substr( $output, =
$MAX_PACKET_CONTENT_SIZE );
>> +            }
>> +            else {
>> +                $output =3D "";
>> +            }
>> +        }
>> +        packet_flush();
>> +        print $debug " [OK]\n";
>> +        $debug->flush();
>> +        packet_flush();
>=20
> Should we test partial contents case?  Or failure during printing?
> What happens then - is file cleared by Git, or left partially =
converted?

Git will clear the file on any error (it doesn't matter when the error =
happens).

---

I am astonished how many valuable suggestion you were able to make
even though I am working with this code for months now.

Thanks a lot for taking the time to review my code that thoroughly.

- Lars=
