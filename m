Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A432023D
	for <e@80x24.org>; Mon, 22 May 2017 20:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbdEVUhf (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 16:37:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36658 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933504AbdEVUhe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 16:37:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so8114130wrc.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3JSVpxU8gwPbE1w1vKtR5LT02A0D/WghepmhRcDK1nQ=;
        b=tCKX3o8NPXKQsjiORUutSZJKGbbFx+j1n3bqWfN5Tlldu7c6zFfjswdP2gDSoTBEf4
         NJCbMDqlw1OhW0pmGM0BgB0398L1ACXgq8q9wh9A8AxhlOuNxqsJHgwRk+XN7oZnphm9
         6KwPJKbdSDJFZ7nY8gQ1jJP5v5TcAFVERKQDg9VbKO7SDthJ4qofzWfxyM5BC1luTA3n
         g6Xlp76ZOQ8+AocdB3d0WerbeQ5j1+cvecDEORC+OvXVbman9ug1S2QAWWQ9WhDs3DLe
         lI8tBU+cG47qwV4RPyD6+S0aGRtmumKmCa9wyh0qpepQYQXcZ0OgQH9ZhHaiX3p/M0ry
         pjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3JSVpxU8gwPbE1w1vKtR5LT02A0D/WghepmhRcDK1nQ=;
        b=XAuzlnk30UM+J6UouNHT/5PQm/Qi0u3BSGwhh9YPA5Hrqec4p1AtRpceVM7S2IsNPy
         PN9xwU7c+6UDAnolbFRXxAeua9+op5r6+ri6ZitEiuUeM0Z6BTEGWZ68yST9vQHdJQtL
         sw2bR29WogcJbvsfpWnyf/uO4AhAaHiQvPh3sZ2cb0D/pfTiu+WQPv3wcuedbuuiW3Cu
         57MpMa3VPjwiugVYWFADST0BG3grXcfJthcbjhQHypVH6kOVBQAAycyz5i9F3MqPHfPx
         YctClMGVMIhnZ0G5OaHdy2Y5IbbxQuThfwEzGfiTNNSr15Ic6YIsB/5BUo8I3RYyBRnD
         Ipyw==
X-Gm-Message-State: AODbwcBMFAq5FQQUv7xbUxmkg1sHSEnYB3dOHzdY6XURgYqVk2x0aYTk
        4etf8igghwMszQ==
X-Received: by 10.223.135.187 with SMTP id b56mr13035790wrb.170.1495485452934;
        Mon, 22 May 2017 13:37:32 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB60CD.dip0.t-ipconnect.de. [93.219.96.205])
        by smtp.gmail.com with ESMTPSA id 2sm34735810wmk.20.2017.05.22.13.37.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 May 2017 13:37:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de>
Date:   Mon, 22 May 2017 22:37:29 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net, e@80x24.org,
        ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com>
References: <20170522135001.54506-1-larsxschneider@gmail.com> <20170522135001.54506-5-larsxschneider@gmail.com> <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 May 2017, at 21:58, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On 2017-05-22 15:50, Lars Schneider wrote:
>> +
>> +int async_query_available_blobs(const char *cmd, struct string_list =
*delayed_paths)
>> +{
>> +	int err;
>> +	char *line;
>> +	struct cmd2process *entry;
>> +	struct child_process *process;
>> +	struct strbuf filter_status =3D STRBUF_INIT;
>> +
>> +	entry =3D find_multi_file_filter_entry(&cmd_process_map, cmd);
>> +	if (!entry) {
>> +		error("external filter '%s' is not available anymore =
although "
>> +		      "not all paths have been filtered", cmd);
>> +		return 0;
>> +	}
>> +	process =3D &entry->process;
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +
>> +	err =3D packet_write_fmt_gently(
>> +		process->in, "command=3Dlist_available_blobs\n");
>> +	if (err)
>> +		goto done;
>> +
>> +	err =3D packet_flush_gently(process->in);
>> +	if (err)
>> +		goto done;
>> +
>> +	for (;;) {
>> +		const char* pre =3D "pathname=3D";
>> +		const int pre_len =3D strlen(pre);
>> +		line =3D packet_read_line(process->out, NULL);
>> +		if (!line)
>> +			break;
>> +		err =3D strlen(line) <=3D pre_len || strncmp(line, pre, =
pre_len);
>> +		if (err)
>> +			goto done;
>> +		string_list_insert(delayed_paths, =
xstrdup(line+pre_len));
>> +	}
>> +
>> +	read_multi_file_filter_status(process->out, &filter_status);
>> +	err =3D strcmp(filter_status.buf, "success");
>> +
>> +done:
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	if (err || errno =3D=3D EPIPE) {
>=20
> This looks strange, at first glance.
> Do we set errno to 0 before ?
> Or is there a trick that EPIPE can only be reached,
> if it is "our" error ?

You are right and I'll fix it!=20
Thanks for reminding me!=20
Peff also noticed that some time ago:
=
http://public-inbox.org/git/20170411200520.oivytvlzkdu7bfh5@sigill.intra.p=
eff.net/

Thanks,
Lars=
