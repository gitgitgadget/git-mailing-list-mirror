Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280851F404
	for <e@80x24.org>; Sun,  1 Apr 2018 13:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeDANZI (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 09:25:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32773 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbeDANZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 09:25:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id f15so7965439pfn.0
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AV2JseIUEW2YbKAAIhJ1RIgzFUKHCV3ZlNNIBCvouow=;
        b=Lm6xQGZBHTVsAFYJaFOnSxERF75oPaL+fMR7Wf9ZVOCtY0tvuwtV+33OIwo77FKXKI
         FXpsiMGk59ctJlfT6ZshiP5TVOIaWv+XStbQnBwi2Ftqr9ccSRio97Symu1q0Ve3aUsX
         0qCxJu7JP3X1WSFBzcaVaC3eyOc35nGJ1242rOq/WEHYv+oCoCPIPPuS7LVAsgBSGkTw
         hIWaPKyubd6zGIQHH2neyhuZ0bvMR2lkZOy9LgJGivoCDaxV2HEKSuJQI/5tMBPzgSz/
         oTTMm8eO9GP7tSISPHsmAOqYtoMXFtIVCvtGPjSodSH70T39DlSU4ukO/dNf1lyTitCZ
         Ai0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AV2JseIUEW2YbKAAIhJ1RIgzFUKHCV3ZlNNIBCvouow=;
        b=ErikjL7WQjZ0Iq1D3ESSQ4lmSBXCcNnHaY7fSi8QRySf45xvVWT6fyySh7GFX4irTx
         HVu61D0Wc0VNbeVQY2X3lhBZj6ODv/uGgkr4PFKkLEQTszcM2+ApYDWFCvneIIOMTgWy
         pdLHMNJ3zYUlZ9+krAOrARkGDRdNvF4xRQRq4Tl7o2p88n+/NzuQlTSpurj0jx72SaMC
         XCUOCNIlXgOXzmsx5kgHdr4uCad3qqGqV1fxe5wb6kUYKOkV7HEHRNNWbilsjztXXRcJ
         x1KX2hq69RBp4/znDWW7jO7NG8JEsqjdfrhirekraQUqA0EEZVozdDKVMsfa0xbZ55nt
         6pCw==
X-Gm-Message-State: AElRT7Enp8IvxLWRCcnZRKUt90YDiF8Q3sgBqOiDG56UA3zoiADWTSXu
        140FVJjjfpaiUZzFDlVLvBY=
X-Google-Smtp-Source: AIpwx4+v8RxoxSJXcZqOzH6M3b9j4h/yf1VJFwL2mzxRX+t1lrWdnED7hVD8XC9p0zHugQzEPP1VBg==
X-Received: by 10.99.165.22 with SMTP id n22mr3935817pgf.53.1522589106587;
        Sun, 01 Apr 2018 06:25:06 -0700 (PDT)
Received: from rempc0jmh7t.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id z21sm22305371pge.42.2018.04.01.06.24.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Apr 2018 06:25:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v11 06/10] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180318072435.GA24190@tor.lan>
Date:   Sun, 1 Apr 2018 15:24:54 +0200
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FEBEFB2-46D6-4688-AF07-654B56FFF9D8@gmail.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com> <20180309173536.62012-7-lars.schneider@autodesk.com> <20180318072435.GA24190@tor.lan>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18 Mar 2018, at 08:24, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> Some comments inline
>=20
> On Fri, Mar 09, 2018 at 06:35:32PM +0100, lars.schneider@autodesk.com =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Git recognizes files encoded with ASCII or one of its supersets (e.g.
>> UTF-8 or ISO-8859-1) as text files. All other encodings are usually
>> interpreted as binary and consequently built-in Git text processing
>> tools (e.g. 'git diff') as well as most Git web front ends do not
>> visualize the content.
>>=20
>> Add an attribute to tell Git what encoding the user has defined for a
>> given file. If the content is added to the index, then Git converts =
the
>=20
> Minor comment:
> "Git converts the content"
> Everywhere else (?) "encodes or reencodes" is used.
> "Git reencodes the content" may be more consistent.

OK, will change.


>>=20
>> +static const char *default_encoding =3D "UTF-8";
>> +
>> +static int encode_to_git(const char *path, const char *src, size_t =
src_len,
>> +			 struct strbuf *buf, const char *enc, int =
conv_flags)
>> +{
>> +	char *dst;
>> +	int dst_len;
>> +	int die_on_error =3D conv_flags & CONV_WRITE_OBJECT;
>> +
>> +	/*
>> +	 * No encoding is specified or there is nothing to encode.
>> +	 * Tell the caller that the content was not modified.
>> +	 */
>> +	if (!enc || (src && !src_len))
>> +		return 0;
>=20
> (This may have been discussed before.
> As we checked (enc !=3D NULL) I think we can add here:)
> 	if (is_encoding_utf8(enc))
> 		return 0;

This should be covered in git_path_check_encoding(),
introduced in v12:

        /* Don't encode to the default encoding */
	if (same_encoding(value, default_encoding))
		return NULL;

In that function the encoding of a certain file is read from
the .gitattributes. If the encoding matches the compile-time
defined default encoding (=3D UTF-8), then the encoding is set
to NULL.


>>=20
>> +
>> +static int encode_to_worktree(const char *path, const char *src, =
size_t src_len,
>> +			      struct strbuf *buf, const char *enc)
>> +{
>> +	char *dst;
>> +	int dst_len;
>> +
>> +	/*
>> +	 * No encoding is specified or there is nothing to encode.
>> +	 * Tell the caller that the content was not modified.
>> +	 */
>> +	if (!enc || (src && !src_len))
>> +		return 0;
>=20
> Same as above:
> 	if (is_encoding_utf8(enc))
> 		return 0;
>=20
>> +
>> +	dst =3D reencode_string_len(src, src_len, enc, default_encoding,
>> +				  &dst_len);
>> +	if (!dst) {
>> +		error("failed to encode '%s' from %s to %s",
>> +			path, default_encoding, enc);
>> +		return 0;
>> +	}
>> +
>> +	strbuf_attach(buf, dst, dst_len, dst_len + 1);
>> +	return 1;
>> +}
>> +
>> static int crlf_to_git(const struct index_state *istate,
>> 		       const char *path, const char *src, size_t len,
>> 		       struct strbuf *buf,
>> @@ -978,6 +1051,25 @@ static int ident_to_worktree(const char *path, =
const char *src, size_t len,
>> 	return 1;
>> }
>>=20
>> +static const char *git_path_check_encoding(struct attr_check_item =
*check)
>> +{
>> +	const char *value =3D check->value;
>> +
>> +	if (ATTR_UNSET(value) || !strlen(value))
>> +		return NULL;
>> +
>=20
>=20
>> +	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
>> +		error(_("working-tree-encoding attribute requires a =
value"));
>> +		return NULL;
>> +	}
>=20
> TRUE or false are values, but just wrong ones.
> If this test is removed, the user will see "failed to encode "TRUE" to =
"UTF-8",
> which should give enough information to fix it.

I see your point. However, I would like to stop the processing right
there for these invalid values. How about=20

  error(_("true/false are no valid working-tree-encodings"));

I think that is the most straight forward/helpful error message
for the enduser (I consider the term "boolean" but dismissed it
as potentially confusing to folks not familiar with the term).

OK with you?

>=20
>> +
>> +	/* Don't encode to the default encoding */
>> +	if (!strcasecmp(value, default_encoding))
>> +		return NULL;
> Same as above ?:
> 	if (is_encoding_utf8(value))
> 		return 0;

Yes, that was fixed in v12 as mentioned above :-)

- Lars=
