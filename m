Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727C3E46B
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951507; cv=none; b=tWzgzd5XDz1v8D0uQHZ8fZVyvoa6vp5zbkuziwgg76PiJ4XHdqZh4bmUJWzNJ5y8TpJCYls3Wa1sPZ86fwShqPpxjI5B8mkTD21zruG7foR98aWXYmoqtJiD0RRoXep6/LrSPAPILjGati0gM6wKKx2jvFN1RNUeVao9W11jTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951507; c=relaxed/simple;
	bh=aT2y6Zl1X7gcALaBK4iloIHUmv27HrVAk+a3hpkltHM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PFlpr14sqX07BFdz2bGDMdszL1m7MMVXhITTTJx4m4al0xEJFKi5K7rRMOwuBHv7u+Eq0T2rUqcbZWsUQwFQjf4RigOooZgm632uOCEFeeJ4RE1eZr10/EW7A+os9PrzoaL6DinSB5kfToFHOCXoD15KUJQtzQd0OhrnOOryB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB6JBvDS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB6JBvDS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eab3912d5so15981715e9.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705951504; x=1706556304; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKPq5hatUhLb2uX+4nPQwNP9XpNYLs09BvPPjMfcAqA=;
        b=TB6JBvDSF0FTfRgVj55/I29r6t88YsKSIQPTI45ri1dovJVgs+2ab3EJ5lfpzCWEHw
         C1eLWW2A0BklysfPct7o29eNSJuI1/QRHCawMtXDqBmAfWGQCe/dcnwJ/NVNlRr5HKtj
         tHzeoiXi8bLGyyicZ4f8Xr7NKFp28+IaMhWD1XdEnwoSUE0oZq4T6X9Vt4inPawAhbBa
         3Ki7vVSeJ3jZAwjIODmjo/BGXpfGMH/YpUq5g7CorbcXrEJAaS5LGAoeI4eyA2xRZM9O
         VhP+Od9pNQ8dBoJ5ZyoWhJvybDVpVeurJKMjNpmh0pjpyWycNUTRodCroBrs2+WsmY0C
         ORbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951504; x=1706556304;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKPq5hatUhLb2uX+4nPQwNP9XpNYLs09BvPPjMfcAqA=;
        b=rw5G2LvbUnJKaZtUVHeCg2fRwr5R7CDBTTmdGtHE4Cj1A2zi5ISfm2fh8G/GZXXt1J
         DNoHFrUM+EuPOEMRpvvnH78eWCbVbiwXFGHXMWXDBIOC3rMPZ69yjlKzFs2eFeOR0ecZ
         G3qziTAyIXp0v9WKYwaDoPL+EvPeYxu94p6lvBlUbMlMIYKKe18rIritRjp93HCYzBJG
         mKhig+PnAwG13ynTeJVZEaLYWdTA0UZIUqnc4m6dxjXBaP/ANu2l5oFso+C9R+ejVckn
         eRU0aCcBfcDR64E8srZSFTOX4xJaMHcOr9PXwXPcLRS/ZESLvVgIIcXUHGhMOKM6Dxjg
         p44w==
X-Gm-Message-State: AOJu0YyCBhHvvZ1AXiE8CgAPzsodmFAFca5x4cK714LMpoId2fNwz1uZ
	je9q6QLmH9Z0rqt4bYL2+XCWuO9S6d/8pX+byS12X0sjHrLOI+7w
X-Google-Smtp-Source: AGHT+IFPPs27Tx3y9SK1BHgpoHCZFOd0kDzmr4VmdxDndT8yogEdzfewKvQWYMfx3t/NvLNCSgq0xA==
X-Received: by 2002:a05:600c:3847:b0:40e:66cf:81a9 with SMTP id s7-20020a05600c384700b0040e66cf81a9mr2984167wmr.111.1705951503623;
        Mon, 22 Jan 2024 11:25:03 -0800 (PST)
Received: from smtpclient.apple ([2a02:c7c:534b:4500:3561:21f4:29f0:53e4])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdd88000000b003392ae3aee8sm6650904wrl.97.2024.01.22.11.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 11:25:03 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Git Push Always uses Protocol Version 0
From: Zsolt Imre <imrexzsolt@gmail.com>
In-Reply-To: <xmqqa5oxurnj.fsf@gitster.g>
Date: Mon, 22 Jan 2024 19:24:53 +0000
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E121C312-5771-47EF-9099-BEC8EFC2B9BD@gmail.com>
References: <FD545E92-18EF-44B5-A7D5-61ECADD880E6@gmail.com>
 <xmqqa5oxurnj.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi. Thanks for your response. Yes, I saw those switch statements, but =
probably misunderstood the intent behind them.

Checking `determine_protocol_version_server` the in-code documentation =
says:

* Used by a server to determine which protocol version should be used =
based on
* a client's request, communicated via the 'GIT_PROTOCOL' environment =
variable

I explicitly set the `GIT_PROTOCOL` environment variable to `version=3D2`.=
 (Will share more at the end of this email why, as you asked anyways)

The client-side calls `discover_version` to check the version supported =
by the server. Which ultimately ends up being done as:


enum protocol_version determine_protocol_version_client(const char =
*server_response)
{
enum protocol_version version =3D protocol_v0;

if (skip_prefix(server_response, "version ", &server_response)) {
version =3D parse_protocol_version(server_response);

if (version =3D=3D protocol_unknown_version)
die("server is speaking an unknown protocol");
if (version =3D=3D protocol_v0)
die("protocol error: server explicitly said version 0");
}

return version;
}

The server, according to my understanding of the documentations so far, =
will not return a version identifier if the client is not talking the =
version 2 (or maybe even version 1) of the protocol.=20
The git clone I mentioned in my previous email was clearly using =
protocol version 2 and it set the appropriate header to indicate this =
when discovering capabilities. See full request headers below.

POST /testing.git/git-upload-pack HTTP/1.1
Host: 127.0.0.1:9000
Accept: application/x-git-upload-pack-result
Accept-Encoding: deflate, gzip
Accept-Language: en-GB, *;q=3D0.9
Content-Length: 122
Content-Type: application/x-git-upload-pack-request
Git-Protocol: version=3D2
User-Agent: git/2.43.0

The server, in this case did not return a version identifier as the =
first PKT-LINE either, but responded otherwise according to the V2 =
protocol. Everything was working well.

Then, the above request was followed by by a proper fetch command in =
which the client again specified the use of V2 protocol:

POST /testing.git/git-upload-pack HTTP/1.1
Host: 127.0.0.1:9000
Accept: application/x-git-upload-pack-result
Accept-Encoding: deflate, gzip
Accept-Language: en-GB, *;q=3D0.9
Content-Length: 160
Content-Type: application/x-git-upload-pack-request
Git-Protocol: version=3D2
User-Agent: git/2.43.0

Accordingly, the cloning worked perfectly fine.

But then, when I want to push to the repo, the client does not do any =
capabilities or version discovery, just goes with V0 of the protocol to =
get the refs:

GET /testing.git/info/refs?service=3Dgit-receive-pack HTTP/1.1
Host: 127.0.0.1:9000
Accept: */*
Accept-Encoding: deflate, gzip
Accept-Language: en-GB, *;q=3D0.9
Cache-Control: no-cache
Pragma: no-cache
User-Agent: git/2.43.0

What I was expecting, given things are going stateless, that on push the =
client first discovers the protocol supported by the server and picks =
the most recent - in this case, that would be version 2.

And to answer your question of what I cannot do with the "current =
versions" of the protocol: I could do everything, of course. But, if =
there's protocol 0, 1 and 2 and I wanted to implement only version 2, I =
thought I should be able to. If protocol V2 was complete, I would not =
have to worry about implementing V0 and V1 (saving some time and =
headache), especially because I do not care about supporting old =
clients. I may have misunderstood the word "version" and version 2 is =
more of an "extension" to V1?


> On 22 Jan 2024, at 18:52, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Zsolt Imre <imrexzsolt@gmail.com> writes:
>=20
>> I'm not entirely sure if this is a bug or I am missing something,
>> but I thought I would share in the hope someone can help out. I'm
>> playing around with Git and trying to implement a git server that
>> communicates over HTTP and supports Git protocol version 2 *only*.
>>=20
>> When I `clone` a repository, the Git client (version 2.43.0),
>> after fetching the capabilities using protocol version 2, it
>> proceeds to fetch the refs, again, via protocol version 2 using
>> the `ls-refs` command.  However, when I try to `push` my changes
>> to the repo, the Git client refuses to use protocol version 2 and
>> tries to obtain the ref list using protocol version 0, even if I
>> pass in the `-c protocol.version=3D2` command line argument.
>=20
> Given that v0 and v1 in the push direction behave exactly the same,
> and there has been no need to add features that were not supportable
> in v1 in the push direction, it is not surprising to see this code
>=20
>        int cmd_send_pack(int argc, const char **argv, const char =
*prefix)
>        {
> ...
>                switch (discover_version(&reader)) {
>                case protocol_v2:
>                        die("support for protocol v2 not implemented =
yet");
>                        break;
>=20
> in https://github.com/git/git/blob/master/builtin/send-pack.c#L282
> and also
>=20
>        int cmd_receive_pack(int argc, const char **argv, const char =
*prefix)
>        {
> ...
>                switch (determine_protocol_version_server()) {
>                case protocol_v2:
>                        /*
>                         * push support for protocol v2 has not been =
implemented yet,
>                         * so ignore the request to use v2 and fallback =
to using v0.
>                         */
>                        break;
>=20
> in https://github.com/git/git/blob/master/builtin/receive-pack.c#L2538
>=20
> that tells the receiving end to demote "v2" request down to "v0",
> and have the pushing end honor that choice.
>=20
> What specifically did you want to gain by using protocol version 2
> in the "push" direction that you cannot do with the current
> versions?
>=20
>=20

