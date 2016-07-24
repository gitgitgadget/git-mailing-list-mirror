Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62908203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 19:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbcGXTLs (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 15:11:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33524 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbcGXTLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2016 15:11:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so13796131wme.0
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 12:11:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jzKPw6ELGUJ0HscoFzllNiUerKt3JFmqGz3RCJWnIlE=;
        b=j7W86Zu11W1M3gwI6TeEYVYIJ1yeyYZMxs8jB5U+0kgsl8QLPkTjBuZ3sc9/fWcBkQ
         etZYZMwwID3KGVMqtSbQhxiOHZ87lVXdMwxgNywEsuWEsa+uBBvNrZWcmLT5rinE0DHD
         E9EiJJJi+TFtOPzu02i+/O068b8YcFVUqJZhV5BQW+4ZHjH3jEEQPpj5qks0fvNFuXZr
         KaOhQAtDluvz6qExnQF1flGlEMKXzhuoAbd1WhEzeRiB5+ih+lgGM7+nYflhioFlBo5s
         HG/P6Y7tqKT7uoO518YX/16IruF4l39rlqlubDlj69DFqPM97Q5QDGKER1sY5nwKafzD
         VdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jzKPw6ELGUJ0HscoFzllNiUerKt3JFmqGz3RCJWnIlE=;
        b=hHRTYVWvmmNd6Pj+/t4g8xWqsYovVTzoNg0O7Z+yy90qIHJPU+5XEhGUzwY3lx+RLs
         4FNNfrkL43OjQcTmxNAthcwbPPpdItZMpDz/8aG+sCWw/PzE5/VZ6AI5oXkBSmuAQv0l
         EkEVsVjvtuoGsxNVDDDB3f45tHuCUVNnIG2MqMjwhrs1wx04WL+uTN2s3a4RKTwIDiM0
         LZQdrSsAQPB23CSDb90B6GrGwnagReyLqRwtMdEoJ+fh15xxF1WvpVurIm7ZtD5IiRYq
         wR1wodYNpk8D48IaN9jkMZCciEcZ75pVJJpdM7xL0sHZjKzrENzjDSM+YsRgu4OpAklL
         Hh4Q==
X-Gm-Message-State: AEkoouvU793itMOltw7M8Bz7GD1sUy2B19IgpK5GOzLUbmz9DuOE6s5EHazqVQoO5qkLSA==
X-Received: by 10.28.52.142 with SMTP id b136mr15852480wma.35.1469387505982;
        Sun, 24 Jul 2016 12:11:45 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5F1D.dip0.t-ipconnect.de. [93.219.95.29])
        by smtp.gmail.com with ESMTPSA id cx1sm11911825wjb.6.2016.07.24.12.11.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jul 2016 12:11:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160723081447.GA24318@starla>
Date:	Sun, 24 Jul 2016 21:11:42 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jnareb@gmail.com,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <121F8453-3A12-47AE-AE10-021EADC4D995@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <20160723081447.GA24318@starla>
To:	Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 23 Jul 2016, at 10:14, Eric Wong <e@80x24.org> wrote:

> larsxschneider@gmail.com wrote:
>> Please note that the protocol filters do not support stream processing
>> with this implemenatation because the filter needs to know the length of
>> the result in advance. A protocol version 2 could address this in a
>> future patch.
> 
> Would it be prudent to reuse pkt-line for this?

Peff suggested that, too, in $gmane/299902. However, this would make the
protocol a bit more complicated and it wouldn't buy us anything for Git
large file processing filters (my main motivation for this patch) as these 
filters can't leverage streaming anyways.


>> +static void stop_protocol_filter(struct cmd2process *entry) {
>> +	if (!entry)
>> +		return;
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	close(entry->process.in);
>> +	close(entry->process.out);
>> +	sigchain_pop(SIGPIPE);
>> +	finish_command(&entry->process);
>> +	child_process_clear(&entry->process);
>> +	hashmap_remove(&cmd_process_map, entry, NULL);
>> +	free(entry);
>> +}
>> +
>> +static struct cmd2process *start_protocol_filter(const char *cmd)
>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry = NULL;
>> +	struct child_process *process = NULL;
> 
> These are unconditionally set below, so initializing to NULL
> may hide future bugs.

OK. I thought it is generally a good thing to initialize a pointer with 
NULL. Can you explain to me how this might hide future bugs?
I will remove the initialization.


>> +	struct strbuf nbuf = STRBUF_INIT;
>> +	struct string_list split = STRING_LIST_INIT_NODUP;
>> +	const char *argv[] = { NULL, NULL };
>> +	const char *header = "git-filter-protocol\nversion";
> 
> 	static const char header[] = "git-filter-protocol\nversion";
> 
> ...might be smaller by avoiding the extra pointer
> (but compilers ought to be able to optimize it)

Agreed!


>> +	entry = xmalloc(sizeof(*entry));
>> +	hashmap_entry_init(entry, strhash(cmd));
>> +	entry->cmd = cmd;
>> +	process = &entry->process;
> 
> <snip>
> 
>> +	ret &= strncmp(header, split.items[0].string, strlen(header)) == 0;
> 
> starts_with() is probably more readable, here.

OK, will fix.


>> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
>> +						int fd, struct strbuf *dst, const char *cmd,
>> +						const char *filter_type)
>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry = NULL;
>> +	struct child_process *process = NULL;
> 
> I would leave process initialized, here, since it should
> always be set below:

OK, will fix.


>> +	struct stat fileStat;
>> +	struct strbuf nbuf = STRBUF_INIT;
>> +	size_t nbuf_len;
>> +	char *strtol_end;
>> +	char c;
>> +
>> +	if (!cmd || !*cmd)
>> +		return 0;
>> +
>> +	if (!dst)
>> +		return 1;
>> +
>> +	if (!cmd_process_map_init) {
>> +		cmd_process_map_init = 1;
>> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
>> +	} else {
>> +		entry = find_protocol_filter_entry(cmd);
>> +	}
>> +
>> +	if (!entry){
>> +		entry = start_protocol_filter(cmd);
>> +		if (!entry) {
>> +			stop_protocol_filter(entry);
> 
> stop_protocol_filter is a no-op, here, since entry is NULL

Oops - a result of my own refactoring :-) Thank you!


>> +			return 0;
>> +		}
>> +	}
>> +	process = &entry->process;
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	switch (entry->protocol) {
>> +		case 1:
>> +			if (fd >= 0 && !src) {
>> +				ret &= fstat(fd, &fileStat) != -1;
>> +				len = fileStat.st_size;
> 
> There's a truncation bug when sizeof(size_t) < sizeof(off_t)

OK. What would you suggest to do in that case? Should we just let the
filter fail? Is there anything else we could do?


> (and mixedCase is inconsistent with our style)

OK, will fix.


>> +    my $filelen  = <STDIN>;
>> +    chomp $filelen;
>> +    print $debug " $filelen";
>> +
>> +    $filelen = int($filelen);
> 
> Calling int() here is unnecessary and may hide bugs if you
> forget to check $debug.   Perhaps a regexp check is safer:
> 
> 	$filelen =~ /\A\d+\z/ or die "bad filelen: $filelen\n";

OK, will fix!


Thanks for your review,
Lars


