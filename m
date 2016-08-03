Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0251F858
	for <e@80x24.org>; Wed,  3 Aug 2016 13:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbcHCNLG (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 09:11:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36722 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbcHCNLC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 09:11:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so36231754wma.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 06:10:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qe8xhSHDnCsfgTKeWDHrWubxrxEoDsVDerMc2jZng3U=;
        b=MQ4sO7NPexUm1hqnygUEM2575aGz2r8ARow6aPobrBcXwKSMm94NvrdICZMRF1zwBV
         748mp2DxWxgGodhYj/Oh+4+CGqqyDDCZ8X43ApucxLMmdBKCIT0c3KWrtBmMaGzNWk8O
         BJilnKJNuTxuiB7+hdwG/UteC9hhQTYJyk/Bt5vpnQ4v6JVe8VWBSLbaynQFf9OYd8mk
         t8hqPwunOlONfZrRZRG0IkZsynGL0wTSIzILL3bU+PY2DsrzYPX+1v9zeobj+kTDhuZ5
         WwzoCKLaA1QzQgoa1pMwaKfas6vfboN7Yy0UiOwSVVfaHY7yKqrQdrqSZfrGeI4dJBPi
         20qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qe8xhSHDnCsfgTKeWDHrWubxrxEoDsVDerMc2jZng3U=;
        b=ZnRQiUCcvM+atc37L86/EWZElKyjAvVIaZTh+Fy7+J93gaSopFeUGN00bem6NMkKgb
         cuaoqLwdAVJkX5j/1S46KkxEkSiD6ysHS/WEUGohlDjBd2KSTGyRyf4wcHs0FH8jIbVS
         4n7vrCy/ay4JwfPgZg5Vd0Qb35IWgvkG1VY+YHAILc2lrMdxykNhxR9btcLUjLpjpBUM
         5671GIgofLlVA74jRs5Zu7umxd3x1JKG3xrXRjIEX0g6uOnh7lkgvjAx6yFxhTmw8WOq
         hySSfvnVsshGTZp11X107nZ//lJkgmB/oEvcYrGUZ3J2ys/fn2F1o//cHxncY/wcXHTu
         iEpA==
X-Gm-Message-State: AEkoouvC58FnF8b1lZ+6dCRkjODNq68Qnvhyyiu48APBz4RFPTuIqpHhATfOeR+xpoM1/A==
X-Received: by 10.28.228.132 with SMTP id b126mr25709170wmh.93.1470229821066;
        Wed, 03 Aug 2016 06:10:21 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qe2sm7698519wjc.28.2016.08.03.06.10.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 06:10:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com>
Date:	Wed, 3 Aug 2016 15:10:19 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <9DDA993E-2AFD-4C69-8E22-58601EEC8A40@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-11-larsxschneider@gmail.com> <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 01 Aug 2016, at 00:19, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
> 

[LONG SNIP]

First part answered here:
http://public-inbox.org/git/5180D54D-92C4-4875-AEB3-801663D70A8B%40gmail.com/

> 
>> +	}
>> +	process = &entry->process;
>> +
>> +	if (!(wanted_capability & entry->supported_capabilities))
>> +		return 1;  // it is OK if the wanted capability is not supported
>> +
>> +	if FILTER_SUPPORTS_CLEAN(wanted_capability)
>> +		filter_type = "clean";
>> +	else if FILTER_SUPPORTS_SMUDGE(wanted_capability)
>> +		filter_type = "smudge";
>> +	else
>> +		die("unexpected filter type");
> 
> Style: it should be
> 
>  +	if (FILTER_SUPPORTS_CLEAN(wanted_capability))
>  +		filter_type = "clean";
>  +	else if (FILTER_SUPPORTS_SMUDGE(wanted_capability))
>  +		filter_type = "smudge";
>  +	else
>  +		die("unexpected filter type");
> 
> even though by accident the macro provides the parentheses to "if".

Agreed.


> Can we make an error/die message more detailed?  Maybe it is
> not possible...

Yeah, I don't see an easy way...

> 
>> +
>> +	if (fd >= 0 && !src) {
>> +		if (fstat(fd, &file_stat) == -1)
>> +			return 0;
>> +		len = file_stat.st_size;
>> +	}
> 
> All right, when fstat() can fail?  Could we then send contents without
> size upfront, or is it better to require size to make it more consistent
> for filter drivers scripts?

If fstat() fails then there is clearly something wrong and the filter
should fail.


> Could this whole "send single file" be put in a separate function?
> Or is it not worth it?

This function would have almost the same signature as apply_protocol2_filter
and therefore I would say it's not worth it since the function is not
crazy long.


> 
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
> 
> Hmmm... ignoring SIGPIPE was good for one-shot filters.  Is it still
> O.K. for per-command persistent ones?

Very good question. You are right... we don't want to ignore any errors
during the protocol... I will remove it.


> 
>> +
>> +	packet_buf_write(&nbuf, "%s\n", filter_type);
>> +	ret &= !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
>> +
>> +	if (ret) {
>> +		strbuf_reset(&nbuf);
>> +		packet_buf_write(&nbuf, "filename=%s\n", path);
>> +		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
>> +	}
> 
> Perhaps a better solution would be
> 
>        if (err)
>        	goto fin_error;
> 
> rather than this.

OK, I change it to goto error handling style.

> 
>> +
>> +	if (ret) {
>> +		strbuf_reset(&nbuf);
>> +		packet_buf_write(&nbuf, "size=%"PRIuMAX"\n", (uintmax_t)len);
>> +		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
>> +	}
> 
> Or maybe extract writing the header for a file into a separate function?
> This one gets a bit long...

Maybe... but I think that would make it harder to understand the protocol. I
think I would prefer to have all the communication in one function layer.


>> +
>> +	if (ret) {
>> +		if (fd >= 0)
>> +			ret = !multi_packet_write_from_fd(fd, process->in);
>> +		else
>> +			ret = !multi_packet_write_from_buf(src, len, process->in);
>> +	}
> 
> This is not streaming.  The above sends whole file, or whole string to
> the filter process, without draining filter output.  If the filter were
> to read some, then write some, it might deadlock on full buffers, isn't it?
> Or am I mistaken?

Correct.


>> +
>> +	if (ret && !FILTER_SUPPORTS_STREAM(entry->supported_capabilities)) {
>> +		strbuf = packet_read_line(process->out, NULL);
>> +		if (strlen(strbuf) > 5 && !strncmp("size=", strbuf, 5)) {
>> +			expected_bytes = (off_t)strtol(strbuf + 5, &strtol_end, 10);
>> +			ret = (strtol_end != strbuf && errno != ERANGE);
>> +		} else {
>> +			ret = 0;
>> +		}
>> +	}
>> +
>> +	if (ret) {
>> +		strbuf_reset(&nbuf);
>> +		ret = !multi_packet_read(process->out, &nbuf, expected_bytes,
>> +			FILTER_SUPPORTS_STREAM(entry->supported_capabilities));
>> +	}
> 
> What happens if the output of filter does not fit in size_t?  I see that
> (I think) this problem is inherited from the original implementation.

Correct. And therefore I would prefer not to change this in this series.


>> +
>> +	if (ret) {
>> +		filter_result = packet_read_line(process->out, NULL);
>> +		ret = !strcmp(filter_result, "success");
>> +	}
>> +
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	if (ret) {
>> +		strbuf_swap(dst, &nbuf);
>> +	} else {
>> +		if (!filter_result || strcmp(filter_result, "reject")) {
>> +			// Something went wrong with the protocol filter. Force shutdown!
>> +			error("external filter '%s' failed", cmd);
>> +			kill_protocol2_filter(&cmd_process_map, entry);
>> +		}
>> +	}
> 
> So if Git gets finish signal "success" from filter, it accepts the output.
> If Git gets finish signal "reject" from filter, it restarts filter (and
> reject the output - user can retry the command himself / herself).
> If Git gets any other finish signal, for example "error" (but this is not
> standarized), then it rejects the output, keeping the unfiltered result,
> but keeps filtering.
> 
> I think it is not described in this detail in the documentation of the
> new protocol.

Agreed, will add!

> 
>> +	strbuf_release(&nbuf);
>> +	return ret;
>> +}
> 
> I wonder if this point might be start of the new patch... but then you
> would have no way to test what you wrote.
> 
>> +
>> static struct convert_driver {
>> 	const char *name;
>> 	struct convert_driver *next;
>> 	const char *smudge;
>> 	const char *clean;
>> +	const char *process;
>> 	int required;
>> } *user_convert, **user_convert_tail;
> 
> All right.
> 
>> 
>> @@ -526,6 +871,10 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>> 	if (!strcmp("clean", key))
>> 		return git_config_string(&drv->clean, var, value);
>> 
>> +	if (!strcmp("process", key)) {
>> +		return git_config_string(&drv->process, var, value);
>> +	}
>> +
> 
> All right.
> 
>> 	if (!strcmp("required", key)) {
>> 		drv->required = git_config_bool(var, value);
>> 		return 0;
>> @@ -823,7 +1172,12 @@ int would_convert_to_git_filter_fd(const char *path)
>> 	if (!ca.drv->required)
>> 		return 0;
>> 
>> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
>> +	if (!ca.drv->clean && ca.drv->process)
>> +		return apply_protocol2_filter(
>> +			path, NULL, 0, -1, NULL, ca.drv->process, FILTER_CAPABILITIES_CLEAN
>> +		);
>> +	else
>> +		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> 
> Could we augment apply_filter() instead, so that the invocation is
> 
>        return apply_filter(path, NULL, 0, -1, NULL, ca.drv, FILTER_CLEAN);
> 
> Though I am not sure if moving this conditional to apply_filter would
> be a good idea; maybe wrapper around augmented apply_filter_do()?

Yes, a wrapper makes it way cleaner!


>> }
>> 
>> const char *get_convert_attr_ascii(const char *path)
>> @@ -856,17 +1210,24 @@ int convert_to_git(const char *path, const char *src, size_t len,
>>                    struct strbuf *dst, enum safe_crlf checksafe)
>> {
>> 	int ret = 0;
>> -	const char *filter = NULL;
>> +	const char *clean_filter = NULL;
>> +	const char *process_filter = NULL;
>> 	int required = 0;
>> 	struct conv_attrs ca;
>> 
>> 	convert_attrs(&ca, path);
>> 	if (ca.drv) {
>> -		filter = ca.drv->clean;
>> +		clean_filter = ca.drv->clean;
>> +		process_filter = ca.drv->process;
>> 		required = ca.drv->required;
>> 	}
> 
> All right (assuming un-augmented apply_filter()).
> 
>> 
>> -	ret |= apply_filter(path, src, len, -1, dst, filter);
>> +	if (!clean_filter && process_filter)
>> +		ret |= apply_protocol2_filter(
>> +			path, src, len, -1, dst, process_filter, FILTER_CAPABILITIES_CLEAN
>> +		);
>> +	else
>> +		ret |= apply_filter(path, src, len, -1, dst, clean_filter);
> 
> I wonder if it would be more readable to write it like this
> (and of course elsewhere too):
> 
>  +	if (!clean_filter && process_filter)
>  +		ret |= apply_protocol2_filter(
>  +			path, src, len, -1, dst, process_filter, FILTER_CAPABILITIES_CLEAN
>  +		);
>  +	else
>  +		ret |= apply_filter(
>  +			path, src, len, -1, dst, clean_filter);
>  +		);
> 
> 
> Though it would screw up "git blame -C -C -w"

Obsolete with the wrapper mentioned above.


>> 	if (!ret && required)
>> 		die("%s: clean filter '%s' failed", path, ca.drv->name);
>> 
>> @@ -885,13 +1246,21 @@ int convert_to_git(const char *path, const char *src, size_t len,
>> void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
>> 			      enum safe_crlf checksafe)
>> {
>> +	int ret = 0;
> 
> Right, 'ret' is needed because we now have two possibilities:
> `clean` filter and `process` filter.
> 
>> 	struct conv_attrs ca;
>> 	convert_attrs(&ca, path);
>> 
>> 	assert(ca.drv);
>> -	assert(ca.drv->clean);
>> +	assert(ca.drv->clean || ca.drv->process);
>> +
>> +	if (!ca.drv->clean && ca.drv->process)
>> +		ret = apply_protocol2_filter(
>> +			path, NULL, 0, fd, dst, ca.drv->process, FILTER_CAPABILITIES_CLEAN
>> +		);
>> +	else
>> +		ret = apply_filter(path, NULL, 0, fd, dst, ca.drv->clean);
>> 
>> -	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
>> +	if (!ret)
>> 		die("%s: clean filter '%s' failed", path, ca.drv->name);
>> 
>> 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
>> @@ -902,14 +1271,16 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>> 					    size_t len, struct strbuf *dst,
>> 					    int normalizing)
>> {
>> -	int ret = 0, ret_filter = 0;
>> -	const char *filter = NULL;
>> +	int ret = 0, ret_filter;
> 
> Why the change:
> 
>  -	int ret = 0, ret_filter = 0;
>  +	int ret = 0, ret_filter;

Reverted with the wrapper.


>> +	const char *smudge_filter = NULL;
>> +	const char *process_filter = NULL;
>> 	int required = 0;
>> 	struct conv_attrs ca;
>> 
>> 	convert_attrs(&ca, path);
>> 	if (ca.drv) {
>> -		filter = ca.drv->smudge;
>> +		process_filter = ca.drv->process;
>> +		smudge_filter = ca.drv->smudge;
>> 		required = ca.drv->required;
>> 	}
> 
> All right, the same.
> 
> [...]
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 34c8eb9..e8a7703 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -296,4 +296,409 @@ test_expect_success 'disable filter with empty override' '
>> 	test_must_be_empty err
>> '
>> 
>> +test_expect_success PERL 'required process filter should filter data' '
>> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge shutdown" &&
>> +	test_config_global filter.protocol.required true &&
>> +	rm -rf repo &&
>> +	mkdir repo &&
>> +	(
>> +		cd repo &&
>> +		git init &&
>> +
>> +		echo "*.r filter=protocol" >.gitattributes &&
>> +		git add . &&
>> +		git commit . -m "test commit" &&
> 
> This is more of "Initial commit", not that it matters
> 
>> +		git branch empty &&
>> +
>> +		cat ../test.o >test.r &&
> 
> Err, the above is just copying file, isn't it?
> Maybe it was copied from other tests, I have not checked.

It was created in the "setup" test.


>> +		echo "test22" >test2.r &&
>> +		mkdir testsubdir &&
>> +		echo "test333" >testsubdir/test3.r &&
> 
> All right, we test text file, we test binary file (I assume), we test
> file in a subdirectory.  What about testing empty file?  Or large file
> which would not fit in the stdin/stdout buffer (as EXPENSIVE test)?

No binary file. The main reason for this test is to check multiple files.
I'll add a empty file. A large file is tested in the next test.

> 
>> +
>> +		rm -f rot13-filter.log &&
>> +		git add . &&
> 
> So this runs "clean" filter, storing cleaned contents in the index.

Correct.


>> +		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >uniq-rot13-filter.log &&
>> +		cat >expected_add.log <<-\EOF &&
>> +			1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
>> +			1 IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
>> +			1 IN: clean testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
> 
> And we check the "know size upfront" case (mistakenly called non-"stream").

Correct - however, I removed non-stream


>> +			1 IN: shutdown -- [OK]
> 
> And test "shutdown" capability (not as separate test).

Fixed.


>> +			1 start
>> +			1 wrote filter header
>> +		EOF
> 
> And we are required to keep the expected_add.log file sorted by hand???

Well, the clean invocations (and therefore their order of appearance)
are not deterministic. See my discussion with Junio here:
http://public-inbox.org/git/xmqqshv18i8i.fsf%40gitster.mtv.corp.google.com/

> 
>> +		test_cmp expected_add.log uniq-rot13-filter.log &&
>> +
>> +		>rot13-filter.log &&
> 
> Truncate log. Still in the same test.
> 
>> +		git commit . -m "test commit" &&
> 
> This is test commit with files undergoing "clean" part of filter.
> 
>> +		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
>> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >uniq-rot13-filter.log &&
> 
> There is known performance regression, in that filter is run more
> than once on given file.
> 
> Actually... why it does not use cleaned-up contents from the index?

See discussion here: http://public-inbox.org/git/20160722152753.GA6859%40sigill.intra.peff.net/


>> +		cat >expected_commit.log <<-\EOF &&
>> +			x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
>> +			x IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
>> +			x IN: clean testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
>> +			1 IN: shutdown -- [OK]
>> +			1 start
>> +			1 wrote filter header
> 
> Right, this is the goal of the patch series: for filter to be started
> only once per git command invocation.
> 
>> +		EOF
>> +		test_cmp expected_commit.log uniq-rot13-filter.log &&
>> +
> 
> Still in the same test, even though we would be testing "smudge"
> capability now.  
> 
> It's a pity that t/test-lib.sh does not support subtests from
> the TAP specification (Test Anything Protocol that Git testsuite
> uses).
> 
>> +		>rot13-filter.log &&
>> +		rm -f test?.r testsubdir/test3.r &&
>> +		git checkout . &&
> 
> All right, we removed some files so that "git checkout ." could
> restore them to life.
> 
>> +		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
> 
> Useless use of cat
> 
>  +		grep -v "IN: clean"  rot13-filter.log  >smudge-rot13-filter.log &&

Fixed, thanks!


> Also: why 'git checkout <path>' would run "clean" filter?
> Is it existing strange behaviour?

AFAIK, that's existing behavior.


>> +		cat >expected_checkout.log <<-\EOF &&
>> +			start
>> +			wrote filter header
>> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
>> +			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
>> +			IN: shutdown -- [OK]
>> +		EOF
> 
> This time without 'sort | uniq -c'.

Yes, because the smudge calls are deterministic!


>  Is it really needed for the
> "good" case, or is it there for two cases to look similar?

I am not sure what you mean?!


>> +		test_cmp expected_checkout.log smudge-rot13-filter.log &&
>> +
>> +		git checkout empty &&
> 
> Shouldn't we check that switching to branch 'empty' does not run
> filters, or is it covered by other tests?  Or perhaps this simply
> does not matter here, is it?

Easy enough to check. I will add this.

> 
>> +
>> +		>rot13-filter.log &&
>> +		git checkout master &&
> 
> Does it test different callpath than 'git checkout .'?  Well, the
> set of files is different...
> 
>> +		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
>> +		cat >expected_checkout_master.log <<-\EOF &&
>> +			start
>> +			wrote filter header
>> +			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
>> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
>> +			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
>> +			IN: shutdown -- [OK]
>> +		EOF
>> +		test_cmp expected_checkout_master.log smudge-rot13-filter.log &&
>> +
> 
> And here we start checking that the filter did filter,
> that is the content in the repository is "clean"ed-up.
> Still the same test.
> 
>> +		./../rot13.sh <test.r >expected &&
>> +		git cat-file blob :test.r >actual &&
>> +		test_cmp expected actual &&
>> +
>> +		./../rot13.sh <test2.r >expected &&
>> +		git cat-file blob :test2.r >actual &&
>> +		test_cmp expected actual &&
>> +
>> +		./../rot13.sh <testsubdir/test3.r >expected &&
>> +		git cat-file blob :testsubdir/test3.r >actual &&
>> +		test_cmp expected actual
>> +	)
>> +'
>> +
>> +test_expect_success PERL 'required process filter should filter data stream' '
>> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl stream clean smudge" &&
>> +	test_config_global filter.protocol.required true &&
> 
> Errr... I don't see how it is different from the previous test.
> [...]

stream/non-stream ... but this is obsolete in the next roll. fixed!

> 
>> +
>> +test_expect_success PERL 'required process filter should filter smudge data and one-shot filter should clean' '
> 
> All right, so this tests the precedence... well, it doesn't.
> 
> It tests that `process` filter with "smudge" capability only works well
> with one-shot `clean` filter.

True. Isn't that what the test description indicates?


>> +	test_config_global filter.protocol.clean ./../rot13.sh &&
>> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl smudge" &&
> 
> Why the difference in pathnames (the directory part) between those two?

rot13.sh is generated in the header of the file.
rot13-filter.pl is part of the test suite


>> +	test_config_global filter.protocol.required true &&
>> +	rm -rf repo &&
>> +	mkdir repo &&
>> +	(
>> +		cd repo &&
>> +		git init &&
>> +
>> +		echo "*.r filter=protocol" >.gitattributes &&
>> +		git add . &&
>> +		git commit . -m "test commit" &&
>> +		git branch empty &&
>> +
>> +		cat ../test.o >test.r &&
>> +		echo "test22" >test2.r &&
>> +		mkdir testsubdir &&
>> +		echo "test333" >testsubdir/test3.r &&
>> +
>> +		rm -f rot13-filter.log &&
>> +		git add . &&
>> +		test_must_be_empty rot13-filter.log &&
>> +
>> +		>rot13-filter.log &&
>> +		git commit . -m "test commit" &&
>> +		test_must_be_empty rot13-filter.log &&
> 
> All right, these tests that `process` filter is not ran.  But we don't
> know if it is because it lacks capability, or because it is overriden
> by one-shot filter (well, that comes later).

Only the clean one shot filter is configured. Therefore that shouldn't be a
problem, right?


>> +
>> +		>rot13-filter.log &&
>> +		rm -f test?.r testsubdir/test3.r &&
>> +		git checkout . &&
>> +		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
>> +		cat >expected_checkout.log <<-\EOF &&
>> +			start
>> +			wrote filter header
>> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
>> +			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
>> +		EOF
>> +		test_cmp expected_checkout.log smudge-rot13-filter.log &&
> 
> This part is repeated many, many times.  Maybe add some helper
> shell function for this?

Good idea! Will add!


> [...]
>> +		./../rot13.sh <test.r >expected &&
>> +		git cat-file blob :test.r >actual &&
>> +		test_cmp expected actual &&
>> +
>> +		./../rot13.sh <test2.r >expected &&
>> +		git cat-file blob :test2.r >actual &&
>> +		test_cmp expected actual &&
>> +
>> +		./../rot13.sh <testsubdir/test3.r >expected &&
>> +		git cat-file blob :testsubdir/test3.r >actual &&
>> +		test_cmp expected actual
> 
> Here we test that equivalent one-shot cleanup filter was run.
> Here also we have repeated contents; maybe some helper function
> would make it shorter?

Agreed!


>> +	)
>> +'
> 
> Here I am stopping examining tests in detail.
> 
>> +test_expect_success PERL 'required process filter should clean only' '
>> +test_expect_success PERL 'required process filter should process files larger LARGE_PACKET_MAX' '
> 
> Those two tests do not depend on being required or not; it is only
> that without required they would fail softly in case of latter test
> (which we can detect too).

True, but since they fail hard it is easier to check.


>> +test_expect_success PERL 'required process filter should with clean error should fail' '
>> +test_expect_success PERL 'process filter should restart after unexpected write failure' '
> 
> So these two are sort of complimentary.  When `process` is required,
> then it should fail if it cannot filter some file.  If it is not,
> it should keep processing other files.

True.


>> +test_expect_success PERL 'process filter should not restart after intentionally rejected file' '
> 
> Uh... all right, so "reject" means that filter cannot continue?
> Strange meaning for 'reject', though ;-)

No, with reject a filter can say "I don't want to process that file". This is a legitimate
response and I don't Git to restart the filter in that case.


>> test_done
>> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
>> new file mode 100755
>> index 0000000..cb0925d
>> --- /dev/null
>> +++ b/t/t0021/rot13-filter.pl
>> @@ -0,0 +1,177 @@
>> +#!/usr/bin/perl
>> +#
>> +# Example implementation for the Git filter protocol version 2
>> +# See Documentation/gitattributes.txt, section "Filter Protocol"
>> +#
>> +# The script takes the list of supported protocol capabilities as
>> +# arguments ("stream", "clean", and "smudge" are supported).
> 
> What about "shutdown"?

Will fix.


>> +#
>> +# This implementation supports three special test cases:
>> +# (1) If data with the filename "clean-write-fail.r" is processed with
>> +#     a "clean" operation then the write operation will die.
>> +# (2) If data with the filename "smudge-write-fail.r" is processed with
>> +#     a "smudge" operation then the write operation will die.
> 
> All right, so it is hard failure with filter script dying.

Correct.

> 
>> +# (3) If data with the filename "failure.r" is processed with any
>> +#     operation then the filter signals that the operation was not
>> +#     successful.
> 
> All right, so it is failure detected by filter script and signalled to Git.
> 
>> +#
>> +
>> +use strict;
>> +use warnings;
> 
> So no more "use autodie", because of compatibility with old Perls.
> 
>> +
>> +my $MAX_PACKET_CONTENT_SIZE = 65516;
>> +my @capabilities            = @ARGV;
> 
> No autoflush this time?

Eric recommended to disable it:
http://public-inbox.org/git/20160723072721.GA20875%40starla/


>> +
>> +sub rot13 {
>> +    my ($str) = @_;
>> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
>> +    return $str;
>> +}
>> +
>> +sub packet_read {
>> +    my $buffer;
>> +    my $bytes_read = read STDIN, $buffer, 4;
>> +    if ( $bytes_read == 0 ) {
>> +        return;
>> +    }
>> +    elsif ( $bytes_read != 4 ) {
>> +        die "invalid packet size '$bytes_read' field";
>> +    }
>> +    my $pkt_size = hex($buffer);
>> +    if ( $pkt_size == 0 ) {
>> +        return ( 1, "" );
> 
> Unusual return convention.  Though it is a test script, so
> it doesn't matter much.
> 
>> +    }
>> +    elsif ( $pkt_size > 4 ) {
>> +        my $content_size = $pkt_size - 4;
>> +        $bytes_read = read STDIN, $buffer, $content_size;
>> +        if ( $bytes_read != $content_size ) {
>> +            die "invalid packet";
> 
> More detailed error message, maybe?

OK


>> +        }
>> +        return ( 0, $buffer );
>> +    }
>> +    else {
>> +        die "invalid packet size";
>> +    }
>> +}
>> +
>> +sub packet_write {
>> +    my ($packet) = @_;
>> +    print STDOUT sprintf( "%04x", length($packet) + 4 );
>> +    print STDOUT $packet;
>> +    STDOUT->flush();
>> +}
>> +
>> +sub packet_flush {
>> +    print STDOUT sprintf( "%04x", 0 );
>> +    STDOUT->flush();
>> +}
>> +
>> +open my $debug, ">>", "rot13-filter.log";
>> +print $debug "start\n";
>> +$debug->flush();
>> +
>> +packet_write("git-filter-protocol\n");
>> +packet_write("version 2\n");
>> +packet_write( "capabilities " . join( ' ', @capabilities ) . "\n" );
>> +print $debug "wrote filter header\n";
>> +$debug->flush();
>> +
>> +while (1) {
>> +    my $command = packet_read();
>> +    unless ( defined($command) ) {
>> +        exit();
>> +    }
>> +    chomp $command;
>> +    print $debug "IN: $command";
>> +    $debug->flush();
>> +
>> +    if ( $command eq "shutdown" ) {
>> +        print $debug " -- [OK]";
>> +        $debug->flush();
>> +        packet_write("done\n");
>> +        exit();
>> +    }
>> +
>> +    my ($filename) = packet_read() =~ /filename=([^=]+)\n/;
>> +    print $debug " $filename";
>> +    $debug->flush();
>> +    my ($filelen) = packet_read() =~ /size=([^=]+)\n/;
>> +    chomp $filelen;
> 
> I think this chomp is not needed, as "\n" is not included.
> Though the regexp should probably be anchored.

Agreed.


>> +    print $debug " $filelen";
>> +    $debug->flush();
>> +
>> +    $filelen =~ /\A\d+\z/ or die "bad filelen: $filelen";
>> +    my $output;
>> +
>> +    if ( $filelen > 0 ) {
> 
> So here is a special case for $filelen = 0.
> Negative $filelen is not allowed, via regexp.

Obsolete in v4.


>> +        my $input = "";
>> +        {
>> +            binmode(STDIN);
>> +            my $buffer;
>> +            my $done = 0;
>> +            while ( !$done ) {
>> +                ( $done, $buffer ) = packet_read();
>> +                $input .= $buffer;
>> +            }
>> +            print $debug " [OK] -- ";
>> +            $debug->flush();
>> +        }
>> +
>> +        if ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
>> +            $output = rot13($input);
>> +        }
>> +        elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
>> +            $output = rot13($input);
>> +        }
> 
> These two conditionals could be shortened, but then they would be less
> readable.  Or not:
> 
>           if ( grep { $_ eq $command } @capabilities ) {
>           	$output = rot13($input);
>           }

I would like to keep it that way for readability since
the test script also serves as example implementation.


>> +        else {
>> +            die "bad command $command";
>> +        }
>> +    }
>> +
>> +    my $output_len = length($output);
>> +    if ( $filename eq "reject.r" ) {
>> +        $output_len = 0;
>> +    }
>> +
>> +    if ( grep( /^stream$/, @capabilities ) ) {
>> +        print $debug "OUT: STREAM ";
>> +    }
>> +    else {
>> +        packet_write("size=$output_len\n");
>> +        print $debug "OUT: $output_len ";
>> +    }
>> +    $debug->flush();
>> +
>> +    if ( $filename eq "reject.r" ) {
>> +        packet_write("reject\n");
>> +        print $debug "[REJECT]\n";    # Could also be an error
> 
> How if could be an error?

Removed.


> 
>> +        $debug->flush();
>> +    }
>> +
>> +    if ( $output_len > 0 ) {
>> +        if (( $command eq "clean" and $filename eq "clean-write-fail.r" )
>> +            or
>> +            ( $command eq "smudge" and $filename eq "smudge-write-fail.r" ))
> 
> Perhaps simply:
> 
>  +        if ( $filename eq "${command}-write-fail.r" ) {

Nice! Will fix!


>> +        {
>> +            print $debug "[WRITE FAIL]\n";
>> +            $debug->flush();
>> +            die "write error";
>> +        }
>> +        else {
>> +            while ( length($output) > 0 ) {
>> +                my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
>> +                packet_write($packet);
>> +                if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
>> +                    $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
>> +                }
>> +                else {
>> +                    $output = "";
>> +                }
>> +            }
>> +            packet_flush();
>> +            packet_write("success\n");
>> +            print $debug "[OK]\n";
>> +            $debug->flush();
>> +        }
>> +    }
>> +}
>> 
> 


Thank you very much (again!) for your extensive review,
Lars


