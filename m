Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C792520986
	for <e@80x24.org>; Fri, 30 Sep 2016 19:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbcI3TjR (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:39:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33627 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbcI3TjO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:39:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id p138so4811316wmb.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Loync6T+zC904EjVwHcX3D+BQaCRqL963LJEhB4vzSQ=;
        b=xQpssky7+rKcHi/nAt1VTH7ZkViP7ZQijNrn5y1PNVhH1jZQXv5WjCDQXzRShrGfuz
         g2CABEq6ToRFvxfjwfKE+M302vJIQO0k2VRcP1QAsn5jqxoZKjlqwJTcwTruyIXIKFtH
         5kqLWDjqqF60C8c4KYMBvnYnllSQqjGBa4eDlWfaVRQKUsjSx3yz0m3eGYouv7CQlQdG
         7NXZeKdscqqtX4A1sX7oRQK0Rk+2Yb/LQ9CbjSCA6XC/caHlUDmD4J/nCDaPTUKIfUgf
         jKXxuX3bT8YwBCqh6ljPcylBFUsjWMyNAHrtNhNB0T+U9IS7Xns68aEmpuvtkncaXvHq
         paOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Loync6T+zC904EjVwHcX3D+BQaCRqL963LJEhB4vzSQ=;
        b=MMWwl48BzyX/KWM1R/oQx7UQmi0OHG80AGw2ModaB+2TFkjUum98ddLhXtF4brg+07
         TRFOWig7OMUb3ffuFF4uu+hkvuFZzWldAxNnn+TB+ucd7v0uaSsUKnQaTC9k79kRoe1q
         MBff8wXrkRAi1yMilfOcNta/v1q9pzgS5BL+ODS0r4X8W0jefY2UzaNZmr+5c98P1UVM
         qw8KLuwZ1bfg7YWfBwklqAwwql0R7vlGpaD+Z3u5Q0ZxEvq0XRhmQBEktzTvyB4KvKoJ
         JGQilMdwehk77eTNY4fAXEKnraN5osiaBz6bJNXkihsef9X6hFTHHIUXqMPCGK08IhOP
         pdnw==
X-Gm-Message-State: AA6/9RkcJ7L/r1lDmaj3Wd/b19XGqWmgkMpUYH/YOIJ+jxGYzBV3WA4SxLiTkGPxR1TyLA==
X-Received: by 10.194.190.37 with SMTP id gn5mr8293727wjc.168.1475264313457;
        Fri, 30 Sep 2016 12:38:33 -0700 (PDT)
Received: from remjtf6f32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id y2sm21137920wji.42.2016.09.30.12.38.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Sep 2016 12:38:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <2a604438-b6cd-876d-0ec2-90027dea99b9@gmail.com>
Date:   Fri, 30 Sep 2016 21:38:31 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF3723DE-B34A-4314-94C9-E3EB38EAB92A@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-12-larsxschneider@gmail.com> <2a604438-b6cd-876d-0ec2-90027dea99b9@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Sep 2016, at 17:37, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> Part second of the review of 11/11.
>=20
> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>=20
>> +
>> +	if (!drv->process && (CAP_CLEAN & wanted_capability) && =
drv->clean)
>=20
> This is just a very minor nitpicking, but wouldn't it be easier
> to read with those checks reordered?
>=20
>  +	if ((wanted_capability & CAP_CLEAN) && !drv->process && =
drv->clean)

OK


>> +
>> +	if (start_command(process)) {
>> +		error("cannot fork to run external filter '%s'", cmd);
>> +		kill_multi_file_filter(hashmap, entry);
>> +		return NULL;
>> +	}
>=20
> I guess there is a reason why we init hashmap entry, try to start
> external process, then kill entry of unable to start, instead of
> trying to start external process, and adding hashmap entry when
> we succeed?

Yes. This way I can reuse the kill_multi_file_filter() function.


>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>=20
> I guess that this is here to handle errors writing to filter
> by ourself, isn't it?

Yes.


>> +		error("external filter '%s' does not support long =
running filter protocol", cmd);
>=20
> We could have described the error here better.
>=20
>  +		error("external filter '%s' does not support filter =
protocol version 2", cmd);

OK


>> +static void read_multi_file_filter_values(int fd, struct strbuf =
*status) {
>=20
> This is more
>=20
>  +static void read_multi_file_filter_status(int fd, struct strbuf =
*status) {
>=20
> It doesn't read arbitrary values, it examines 'metadata' from
> filter for "status=3D<foo>" lines.

True!


>> +		if (pair[0] && pair[0]->len && pair[1]) {
>> +			if (!strcmp(pair[0]->buf, "status=3D")) {
>> +				strbuf_reset(status);
>> +				strbuf_addbuf(status, pair[1]);
>> +			}
>=20
> So it is last status=3D<foo> line wins behavior?

Correct.


>=20
>> +		}
>=20
> Shouldn't we free 'struct strbuf **pair', maybe allocated by the
> strbuf_split_str() function, and reset to NULL?

True. strbuf_list_free() should be enough.


>>=20
>> +	fflush(NULL);
>=20
> Why this fflush(NULL) is needed here?

This flushes all open output streams. The single filter does the same.


>>=20
>> +	if (fd >=3D 0 && !src) {
>> +		if (fstat(fd, &file_stat) =3D=3D -1)
>> +			return 0;
>> +		len =3D xsize_t(file_stat.st_size);
>> +	}
>=20
> Errr... is it necessary?  The protocol no longer provides size=3D<n>
> hint, and neither uses such hint if provided.

We require the size in write_packetized_from_buf() later.


>> +
>> +	err =3D strlen(filter_type) > PKTLINE_DATA_MAXLEN;
>> +	if (err)
>> +		goto done;
>=20
> Errr... this should never happen.  We control which capabilities
> we pass, it can be only "clean" or "smudge", nothing else. Those
> would always be shorter than PKTLINE_DATA_MAXLEN.
>=20
> Never mind that that is "command=3Dsmudge\n" etc. that needs to
> be shorter that PKTLINE_DATA_MAXLEN!
>=20
> So, IMHO it should be at most assert, and needs to be corrected
> anyway.

OK!


> This should never happen, PATH_MAX everywhere is much shorter
> than PKTLINE_DATA_MAXLEN / LARGE_PACKET_MAX.  Or is it?
>=20
> Anyway, we should probably explain or warn
>=20
>   		error("path name too long: '%s'", path);

OK


>> +			/*
>> +			 * Something went wrong with the protocol =
filter.
>> +			 * Force shutdown and restart if another blob =
requires filtering!
>=20
> Is this exclamation mark '!' here necessary?
>=20

No.


Thanks,
Lars

