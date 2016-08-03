Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DE31F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbcHCVvS (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:51:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32965 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176AbcHCVvR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 17:51:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so38261366wme.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 14:51:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V5+e2tVwnFMYxGssc8+0wWJEa6fLARtfM/dtJc/npfY=;
        b=TDp1XlWpMNN1sZxjhZmvHT0s/GWjfyje592scjlpH4UrrqXBzpCs0HbOFe0PDqhE8g
         hu5A2i/2C5Ja5Kx9p5UNfIv9XEbl/g16CDogtFMb+ExAVLi3XCW7eqaUX+rl5e0zj4WZ
         EaPWTq0zAJk5g/As1caTMQjeVYa6F1Vr8zVEfYKZg3/a53tMaHcRXN9TU27+vrgJNiTY
         niL3UjqqDxzgyPP3LEhjIVZvosnsIQK9BJ2Pl6+t9FlxWhOKBa1SnI9klMxUcqt0CPUQ
         c8zQ6C5oyi3YT0l8osmVmszkxJ+Ycg1KP2Gc1nnW6pir4b1bbOV4sNm5UuupjgHxl3Xf
         qV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V5+e2tVwnFMYxGssc8+0wWJEa6fLARtfM/dtJc/npfY=;
        b=Zk2CEp4Sk31ZOiZ1tJtOxTu5rYi22AKwuiwWSQ2PdrLz+x/t7jmHSboACECngYXVdJ
         0rJID7sDG4ZlXUMhJXZ4QwMafkZjslgCnrAuH0BBrKffSlBdVo8wpJgx8kZBG+EvCSw4
         51VMJHgAWoJ594ar6jq562zgv+5o5D18vkLcpbrgMBfP+Mt2TB6lcvfP06PbcflbCtHh
         0PBXoZizhjuaKgvxilZJFz6KUmz349MfqIs2posv/xVce2cTcaVZhQLdCZkJNKUqoS4C
         IHG7QaRrh1NzBqRIUlN7Zl7gMymKlIXF0Rfz3yVTIQd5tmhGJBRfPKh60fnLs/u57UOO
         EikQ==
X-Gm-Message-State: AEkoouvPBaNa1SEjqOOzFwLpLm8SCc1TfVCv5TNudidEIzIB3kjkmpcQnPohF/kh31hkog==
X-Received: by 10.28.167.144 with SMTP id q138mr67255686wme.83.1470260276666;
        Wed, 03 Aug 2016 14:37:56 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB674A.dip0.t-ipconnect.de. [93.219.103.74])
        by smtp.gmail.com with ESMTPSA id qe2sm9567496wjc.28.2016.08.03.14.37.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 14:37:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8twd8uld.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 3 Aug 2016 23:37:54 +0200
Cc:	git@vger.kernel.org, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <564CA3AD-EA8E-46D3-9564-BF468CAF32B0@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <xmqq8twd8uld.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 22:29, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> +#define FILTER_CAPABILITIES_CLEAN    (1u<<0)
>> +#define FILTER_CAPABILITIES_SMUDGE   (1u<<1)
>> +#define FILTER_SUPPORTS_CLEAN(type)  ((type) & FILTER_CAPABILITIES_CLEAN)
>> +#define FILTER_SUPPORTS_SMUDGE(type) ((type) & FILTER_CAPABILITIES_SMUDGE)
> 
> I would expect a lot shorter names as these are file-local;
> CAP_CLEAN and CAP_SMUDGE, perhaps, _WITHOUT_ "supports BLAH" macros?
> 
> 	if (FILTER_SUPPORTS_CLEAN(type))
> 
> is not all that more readable than
> 
> 	if (CAP_CLEAN & type)

OK. I will change that.


>> +struct cmd2process {
>> +	struct hashmap_entry ent; /* must be the first member! */
>> +	int supported_capabilities;
>> +	const char *cmd;
>> +	struct child_process process;
>> +};
>> +
>> +static int cmd_process_map_initialized = 0;
>> +static struct hashmap cmd_process_map;
> 
> Don't initialize statics to 0 or NULL.

OK, statics are initialized implicitly to 0.
I will fix it.


>> +static int cmd2process_cmp(const struct cmd2process *e1,
>> +                           const struct cmd2process *e2,
>> +                           const void *unused)
>> +{
>> +	return strcmp(e1->cmd, e2->cmd);
>> +}
>> +
>> +static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
>> +{
>> +	struct cmd2process key;
>> +	hashmap_entry_init(&key, strhash(cmd));
>> +	key.cmd = cmd;
>> +	return hashmap_get(hashmap, &key, NULL);
>> +}
>> +
>> +static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
>> +{
>> +	if (!entry)
>> +		return;
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	close(entry->process.in);
>> +	close(entry->process.out);
>> +	sigchain_pop(SIGPIPE);
>> +	finish_command(&entry->process);
> 
> I wonder if we want to diagnose failures from close(), which is a
> lot more interesting than usual because these are connected to
> pipes.

In this particular case we kill the filter. That means some error 
already happened, therefore the result wouldn't be of interest
anymore, I think. Wrong?

The other case is the proper shutdown (see 12/12). However, in
that case Git is already exiting and therefore I wonder what
we would do with a "close" error?


>> +static int apply_multi_file_filter(const char *path, const char *src, size_t len,
>> +                                   int fd, struct strbuf *dst, const char *cmd,
>> +                                   const int wanted_capability)
>> +{
>> +	int ret = 1;
>> + ...
>> +	if (!(wanted_capability & entry->supported_capabilities))
>> +		return 1;  // it is OK if the wanted capability is not supported
> 
> No // comment please.

OK!


>> +	filter_result = packet_read_line(process->out, NULL);
>> +	ret = !strcmp(filter_result, "result=success");
>> +
>> +done:
>> +	if (ret) {
>> +		strbuf_swap(dst, &nbuf);
>> +	} else {
>> +		if (!filter_result || strcmp(filter_result, "result=reject")) {
>> +			// Something went wrong with the protocol filter. Force shutdown!
>> +			error("external filter '%s' failed", cmd);
>> +			kill_multi_file_filter(&cmd_process_map, entry);
>> +		}
>> +	}
>> +	strbuf_release(&nbuf);
>> +	return ret;
>> +}
> 
> I think this was already pointed out in the previous review by Peff,
> but a variable "ret" that says "0 is bad" somehow makes it hard to
> follow the code.  Perhaps rename it to "int error", flip the meaning,
> and if the caller wants this function to return non-zero on success
> flip the polarity in the return statement itself, i.e. "return !errors",
> may make it easier to follow?

This follows the existing filter function. Please see Peff's later
reply here:

"So I'm not sure if changing them is a good idea. I agree with you that
it's probably inviting confusion to have the two sets of filter
functions have opposite return codes. So I think I retract my
suggestion. :)"

http://public-inbox.org/git/20160728133523.GB21311%40sigill.intra.peff.net/

That's why I kept it the way it is. If you prefer the "!errors" approach
then I will change that.


Thanks for looking at the patch,
Lars

