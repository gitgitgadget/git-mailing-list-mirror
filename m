Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25871F428
	for <e@80x24.org>; Sat, 30 Dec 2017 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbdL3T6J (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 14:58:09 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:46558 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdL3T6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 14:58:06 -0500
Received: by mail-wm0-f43.google.com with SMTP id r78so53118857wme.5
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 11:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O/QOddRY7lmB8l/C9Bqibf5iuCREzs6dz+h/8Vs+scY=;
        b=eFKSXoJxVZw8SwKZVTkzwI3iMkD60NHI093P/Uy0cBMPejzH1oR6g9B5EXp1yNyeHq
         zN+HnmKncUiNJfZXJFChjd+cWimxZL3Do9ublA79fTvS8ilRh4zrWGPYFxFvk5tQeXjS
         UM7OBrP38di61cUWhxplIb7Amx2ucXm87blHQDFbdIoJytrZq6WuQ690bK1vuG3nCmUF
         8EuKlZ3EsDH1KM8YzbJ6EqcWzurr4ZZcTpFzn1Boo1RtewZotOxLlOmqb6oRS3OPFzpD
         TlXkmzX6ci0C+NBo5Hf6H2BIWmwZ8QQAXAwXvTl2slpQ1aPJ8M3dLov9EQ6joa7Pr7q0
         zffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O/QOddRY7lmB8l/C9Bqibf5iuCREzs6dz+h/8Vs+scY=;
        b=oreXbR9aQPrks+MhfKW+WjlCqXUMFczL+hxOtqjBWUfxSunO3prNN6vj0zIfU30lvF
         Ow2xhFn8JlgKSdWgvNUV9cAXoYqt8BU3jhGBXmjHWAx5dlYOfCrp0wY9YeLP4dkJQ1eR
         jcNZ1zP0a080PRrXPS5XGdNfnKLtLQ8ACatNgaROS4I4GmE5Vf3dXhPdL6yCbh5eM7Dt
         T2U1q3+rvOBpmf/Zkzokg5+9vYG21S9dEiHX6k2Rii5dCZPlJGlkGHpWYkD3v3/ZY51w
         L/UEWKs8elzVje9rSrc18UPuR8vuuRkTV+vc+MoqU+AhUwwcibzp0NW1BbOIDRncQcjg
         Blwg==
X-Gm-Message-State: AKGB3mL6li8IdQJ2MuCTBik9XdiOBv0u6OW96fDbuyKCvFlgV/yhS86O
        rWzHkuaGSOcyhlCTYW3OyaqmpFfd
X-Google-Smtp-Source: ACJfBouJmGGGB2qGkcreyaQUMVqDA+TTe23+xpoaU5cR5GXtIeoA6qC52L2Bxo0/E5I3GNnPOXJp3Q==
X-Received: by 10.28.111.146 with SMTP id c18mr32984495wmi.123.1514663884771;
        Sat, 30 Dec 2017 11:58:04 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6007.dip0.t-ipconnect.de. [93.219.96.7])
        by smtp.gmail.com with ESMTPSA id t20sm14297258wra.16.2017.12.30.11.58.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Dec 2017 11:58:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 4/5] convert: add support for 'checkout-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171229172858.GB23935@tor.lan>
Date:   Sat, 30 Dec 2017 20:58:02 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, gitster@pobox.com,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <99B51DE1-0825-41FC-8DD3-677BCF7B52A5@gmail.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com> <20171229152222.39680-5-lars.schneider@autodesk.com> <20171229172858.GB23935@tor.lan>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Dec 2017, at 18:28, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> I probably need to look at convert.c more closer, some other comments =
inline.
>=20
>=20
> On Fri, Dec 29, 2017 at 04:22:21PM +0100, lars.schneider@autodesk.com =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Git and its tools (e.g. git diff) expect all text files in UTF-8
>> encoding. Git will happily accept content in all other encodings, =
too,
>> but it might not be able to process the text (e.g. viewing diffs or
>> changing line endings).
>=20
> UTF-8 is too strict, the text from below is more correct:
> +Git recognizes files encoded with ASCII or one of its supersets (e.g.
> +UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
> +interpreted as binary and consequently built-in Git text processing
> +tools (e.g. 'git diff') as well as most Git web front ends do not
> +visualize the content.

Agreed. I'll replace it.


>> Add an attribute to tell Git what encoding the user has defined for a
>> given file. If the content is added to the index, then Git converts =
the
>> content to a canonical UTF-8 representation. On checkout Git will
>=20
> Minor question about "canonical":
> Would this mean the same ?
> ...then Git converts the content into  UTF-8.

I feel the word canonical makes sense in this context to express
that UTF-8 is not some randomly chosen encoding. AFAIK UTF-8 and=20
LF are the canonical form for text in Git, no?


>> +In these cases you can teach Git the encoding of a file in the =
working
>                          teach ? tell ?=20

"tell", agreed!


>> +directory with the `checkout-encoding` attribute. If a file with =
this
>> +attributes is added to Git, then Git reencodes the content from the
>> +specified encoding to UTF-8 and stores the result in its internal =
data
>> +structure.
>=20
> Minor Q:
>> its internal data structure.
> Should we simply write "stores the result in the index" ?

This text is targeted at the end user and I know a lot of end users
that are confused by the word "index". How about:

  ...stores the result in its internal data structure ("the index").

Would that work?

>=20
>> On checkout the content is encoded back to the specified
>> +encoding.
>=20
>> +
>> +Please note that using the `checkout-encoding` attribute has a =
number
>> +of drawbacks:
>> +
>> +- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
>> +  errors as the conversion might not be round trip safe.
>> +
>> +- Reencoding content requires resources that might slow down certain
>> +  Git operations (e.g 'git checkout' or 'git add').
>> +
>> +- Git clients that do not support the `checkout-encoding` attribute =
or
>> +  the used encoding will checkout the respective files as UTF-8 =
encoded.
>> +  That means the content appears to be different which could cause
>> +  trouble. Affected clients are older Git versions and alternative =
Git
>> +  implementations such as JGit or libgit2 (as of January 2018).
>> +
>> +Use the `checkout-encoding` attribute only if you cannot store a =
file in
>> +UTF-8 encoding and if you want Git to be able to process the content =
as
>> +text.
>> +
>=20
> I would maybe rephrase a little bit (first things first):
>=20
> Please note that using the `checkout-encoding` attribute may have a =
number
> of pitfalls:
>=20
> - Git clients that do not support the `checkout-encoding` attribute
>  will checkout the respective files as UTF-8 encoded,  which typically
>  causes trouble.
>  Escpecialy when older Git versions are used or alternative Git
>  implementations such as JGit or libgit2 (as of January 2018).
>=20
> - Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
>  errors as the conversion might not be round trip safe.
>=20
> - Reencoding content requires resources that might slow down certain
>  Git operations (e.g 'git checkout' or 'git add').
>=20
> Use the `checkout-encoding` attribute only if you cannot store a file =
in
> UTF-8 encoding and if you want Git to be able to process the content =
as
> text.

Agreed!


> -----
> Side question: What happens if "the used encoding" is not supported by
> the underlying iconv lib ?
> Will Git fail, delete the file from the working tree ?
> That may be worth to mention. (And I need to do the code-review)

It should checkout the file in UTF-8 and print an error.
If you would try to add a file with an unsupported encoding,
then Git should die() and refuse the operation.
(see t0028: check unsupported encoding)


>=20
>> +Use the following attributes if your '*.txt' files are UTF-16 =
encoded
>> +with byte order mark (BOM) and you want Git to perform automatic =
line
>> +ending conversion based on your platform.
>> +
>> +------------------------
>> +*.txt		text checkout-encoding=3DUTF-16
>> +------------------------
>> +
>> +Use the following attributes if your '*.txt' files are UTF-16 little
>> +endian encoded without BOM and you want Git to use Windows line =
endings
>> +in the working directory.
>> +
>> +------------------------
>> +*.txt 		checkout-encoding=3DUTF-16LE text eol=3DCRLF
>> +------------------------
>> +
>> +You can get a list of all available encodings on your platform with =
the
>> +following command:
>> +
>> +------------------------
>> +iconv --list
>> +------------------------
>> +
>> +
>> `ident`
>> ^^^^^^^
>>=20
>> diff --git a/apply.c b/apply.c
>> index 321a9fa68d..c4bd5cf1f2 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, =
struct patch *patch,
>> 		 * should never look at the index when explicit crlf =
option
>> 		 * is given.
>> 		 */
>> -		convert_to_git(NULL, path, buf->buf, buf->len, buf, =
safe_crlf);
>> +		convert_to_git(NULL, path, buf->buf, buf->len, buf, =
safe_crlf, 0);
>=20
> Hm. Do we really need another parameter here?
> The only caller that needs it (and sets it to 1) is sha1_file.c.
> When an invalid encoding/content is used, it should be safe to die() =
always?
> Just loud thinking..

Unfortunately it is not safe to die() always. Peff described a situation =
here
where you could not "checkout away" from an error state:
=
https://public-inbox.org/git/20171215095838.GA3567@sigill.intra.peff.net/


> If really needed, it may need less changes in the code base, if a new =
function
> convert_to_git_or_die() is defined, which is called by =
convert_to_git()
>=20
> (and the other alternative would be to convert safe_crlf into a =
bitmap,
> see =
https://public-inbox.org/git/20171229132828.17594-1-tboegi@web.de/T/#u
> what do you think ?)

I still need to review your patch, but a bitmap sounds like a good idea.
But why do we need a special bitmap? Can't we just pass "flags" and
calculate get_safe_crlf() in convert.c?


>>=20
>> +
>> +	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
>> +		const char *error_msg =3D _(
>> +			"BOM is prohibited for '%s' if encoded as %s");
>> +		const char *advise_msg =3D _(
>> +			"You told Git to treat '%s' as %s. A byte order =
mark "
>> +			"(BOM) is prohibited with this encoding. Either =
use "
>> +			"%.6s as checkout encoding or remove the BOM =
from the "
>> +			"file.");
>> +
>> +		advise(advise_msg, path, enc->name, enc->name, =
enc->name);
>> +		if (write_obj)
>> +			die(error_msg, path, enc->name);
>> +		else
>> +			error(error_msg, path, enc->name);
>=20
> As said before, I would just die(). Or do I miss something ?
> Being strict with BOMs seams like a good idea.

See above, Peffs test case. We run convert in a lot of places
(e.g. 'git diff' or if checkout away from a bad state).


>>=20
>> diff --git a/t/t0028-checkout-encoding.sh =
b/t/t0028-checkout-encoding.sh
>> new file mode 100755
>> index 0000000000..1a329ab933
>> --- /dev/null
>> +++ b/t/t0028-checkout-encoding.sh
>> @@ -0,0 +1,197 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'checkout-encoding conversion via gitattributes'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup test repo' '
>> +
>> +	text=3D"hallo there!\ncan you read me?" &&
>=20
> Is this portable ? (the "\n")

I assume it as it is used in t0001, t0008, t0024 and others.


Thanks for the review,
Lars

