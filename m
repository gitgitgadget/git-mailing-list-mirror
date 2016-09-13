Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A585020984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759276AbcIMWE7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:04:59 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38512 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbcIMWE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:04:58 -0400
Received: by mail-wm0-f47.google.com with SMTP id 1so226044528wmz.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nJUbedIL7Lz4c1b1KMNVqKRwVRVn3FG8Aa+XcTU3Rvo=;
        b=VSeHGmmztNaBHhFi6QkAq1Ufkz0bod2UJ/pJM4WXkJOVQpUOBwt6GG8n89Eh0oE/ec
         YoYjtbPfrmoCUTqwn1tbK/5M3I5p9h86XwUBoFZFXjmogsta/XpylEHydALhzqTDPWBO
         twTXw+ecVAry9fp3+m6jZba8TVNcqxdAf8T4MmG3feilTYby8YrDKnudgRQUKGFRx2S5
         GoZ3W/badMw/98C2kJFRgDFZSKtzVvgsUCQGbY5fHAW026jVwrVwTIcA68xejwGiGR4C
         TMoDU6uczFshsBzmiBB+RzfzbomZ5eBYuDelSd29YoEymlbjG3y8aPUpWKReWzAItmdX
         C3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nJUbedIL7Lz4c1b1KMNVqKRwVRVn3FG8Aa+XcTU3Rvo=;
        b=h97LQcwV+Z5DfgmIxCPXWykzYQop9ZEB9q23EznNTDXQvF208v4/EBUzWj24pg0InA
         Y3kHZHI6EvItvwvYwJEUb0FHKcGeTGzDw33nD76JkeFacDJYVW4W5oZxn2HbGacQq6aL
         OeGjcSz8rYb0GVRU4wArZoe1M8eO0jmpKuwaXf01d4gD4V6rKyZtBpmjJE4D1rAuvqED
         vU3ZCFGh4AL3syZz62vChTYfjHzMZuWKf1d4ypMRkX2PHUoHEsNPBg+P6psRZpF3tV1i
         N/yjEzYyTkkzUJsXF3ykzAxyUsQ4rWLB17RLi2ZxpEzbZ0JHw7eB5HRLqRUk2ky8HenP
         +e1w==
X-Gm-Message-State: AE9vXwNg4vtO013bQombGlCD52cw7p85J18URRZr3ZA9GaODbyisSw6n9QgGQWOxAL40MQ==
X-Received: by 10.28.208.5 with SMTP id h5mr6912060wmg.17.1473804296836;
        Tue, 13 Sep 2016 15:04:56 -0700 (PDT)
Received: from [10.32.248.227] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m68sm846237wmg.6.2016.09.13.15.04.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Sep 2016 15:04:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160910164056.GA14646@tb-raspi>
Date:   Tue, 13 Sep 2016 23:04:49 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        jnareb@gmail.com, mlbright@gmail.com, jacob.keller@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CF905A2-3A06-42C8-8E28-463E50867036@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-11-larsxschneider@gmail.com> <20160910164056.GA14646@tb-raspi>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Sep 2016, at 17:40, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> []
>=20
> One general question up here, more comments inline.
> The current order for a clean-filter is like this, I removed the error =
handling:
>=20
> int convert_to_git()
> {
> 	ret |=3D apply_filter(path, src, len, -1, dst, filter);
> 	if (ret && dst) {
> 		src =3D dst->buf;
> 		len =3D dst->len;
> 	}
> 	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, =
checksafe);
> 	return ret | ident_to_git(path, src, len, dst, ca.ident);
> }
>=20
> The first step is the clean filter, the CRLF-LF conversion (if =
needed),
> then ident.
> The current implementation streams the whole file content to the =
filter,
> (STDIN of the filter) and reads back STDOUT from the filter into a =
STRBUF.
> This is to use the UNIX-like STDIN--STDOUT method for writing a =
filter.
>=20
> However, int would_convert_to_git_filter_fd() and =
convert_to_git_filter_fd()
> offer a sort of short-cut:
> The filter reads from the file directly, and the output of the filter =
is
> read into a STRBUF.

Are you sure? As far as I understand the code the filter does not read =
from=20
the file in any case today.  The functions =
would_convert_to_git_filter_fd() and=20
convert_to_git_filter_fd() just avoid avoid mapping the file in Git. The =
content=20
is still streamed via pipes:
=
https://github.com/git/git/commit/9035d75a2be9d80d82676504d69553245017f6d4=



> It looks as if the multi-filter approach can use this in a similar =
way:
> Give the pathname to the filter, the filter opens the file for reading
> and stream the result via the pkt-line protocol into Git.
> This needs some more changes, and may be very well go into a separate =
patch
> series. (and should).
>=20
> What I am asking for:
> When a multi-filter is used, the content is handled to the filter via =
pkt-line,
> and the result is given to Git via pkt-line ?
> Nothing wrong with it, I just wonder, if it should be mentioned =
somewhere.

That is most certainly a good idea and the main reason I added =
"capabilities"
to the protocol. Joey Hess worked on this topic (not merged, yet) and I =
would=20
like to make this available to the long-running filter protocol as soon =
as the
feature is available:
=
http://public-inbox.org/git/1468277112-9909-1-git-send-email-joeyh@joeyh.n=
ame/


>> +sub packet_read {
>> +    my $buffer;
>> +    my $bytes_read =3D read STDIN, $buffer, 4;
>> +    if ( $bytes_read =3D=3D 0 ) {
>> +
>> +        # EOF - Git stopped talking to us!
>> +        exit();
>> +    }
>> +    elsif ( $bytes_read !=3D 4 ) {
>> +        die "invalid packet size '$bytes_read' field";
>> +    }
>=20
> This is half-kosher, I would say,
> (And I really. really would like to see an implementation in C ;-)

Would you be willing to contribute a patch? :-)


> A read function may look like this:
>=20
>   ret =3D read(0, &buffer, 4);
>   if (ret < 0) {
>     /* Error, nothing we can do */
>     exit(1);
>   } else if (ret =3D=3D 0) {
>     /* EOF  */
>     exit(0);
>   } else if (ret < 4) {
>     /*=20
>      * Go and read more, until we have 4 bytes or EOF or Error */
>   } else {
>     /* Good case, see below */
>   }

I see. However, my intention was to provide an absolute minimal
example to teach a reader how the protocol works. I consider
all proper error handling an exercise for the reader ;-)


>> +#define CAP_CLEAN    (1u<<0)
>> +#define CAP_SMUDGE   (1u<<1)
>=20
> Is CAP_ too generic, and GIT_FILTER_CAP (or so) less calling for =
trouble ?

I had something like that but Junio suggested these names in V4:
=
http://public-inbox.org/git/xmqq8twd8uld.fsf@gitster.mtv.corp.google.com/


>> +
>> +	err =3D (strlen(filter_type) > PKTLINE_DATA_MAXLEN);
>=20
> Extra () needed ?
> More () in the code...

I thought it might improve readability, but I will remove them
if you think this would be more consistent with existing Git code.


Thanks,
Lars=
