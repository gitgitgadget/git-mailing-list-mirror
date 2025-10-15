Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7123314B
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542131; cv=none; b=jObc/8bqZXGYDRb7W3/4ytpMd+3waLCvIB5cA/C5S/pVmNDsOfLE9arn4QeHBMu6YLjO6QXx+IPtTAirF32Tyj5RUpTa2zMJ6UMhhpsTYFeAqdNij6l9Gxv/DiiOp2i+nu8kPJXHWN6nJoZW9U6eTurhXCgiNQCNfW8AcelUFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542131; c=relaxed/simple;
	bh=FPtKssvHslMHu6p35/cSvt7jtAG7lAjtShKT+CeNDRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCARLXL+2X3Xf0w4wIiJV2FrTlkKT3VJ5QuWvViNuY4taOq5VMM+KHERlddAjOPYffINK6GuapoObA/lnp83+y47ovCp6meBRdU8mHbZ+UiQZoKk9Z7wnWkXmMJXY/nTdLPunooOk8Io80rIvfDHD84/gHV0Io7WxeEHbF5SXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCjhuY0M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCjhuY0M"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b41870fef44so562366366b.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760542127; x=1761146927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lneQjlCdTbb4rDohC4+fj0zRp5lbX3Y7bJ9O1a578NI=;
        b=VCjhuY0Mdr/wKhLYP0qRpqHtYMAC3orr9TUSh2rW9Zhl0oHMYkoAXz1o3PXamQ3ylB
         YD7E+Qu9y03PB1UQUHnqYkvDMadI1N3G6pvX5tBPB2cjbIZg3GnbBaQl8O7UZx2Xws/V
         A4n1H8aVYEnkJN3Ay1YYTRawtP4ypFxJgMGISmIvgvL8HpvyQXY+Pdj54xpsMiOinDcB
         MBp5Iv7nUXj5UshcsAWE6fmYNBJGZLYgF93J87FScfZDHOZrtynjevFGxgLjkac+5Ls4
         xWIhxMM9mm9LoBQbck4+r1cSzo77LBLybL2KOHJ2jth6acaW0ve7WmoMmMVhOWk5hs7/
         tjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760542127; x=1761146927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lneQjlCdTbb4rDohC4+fj0zRp5lbX3Y7bJ9O1a578NI=;
        b=fqn6pC/A2VjUNZluMBQU693Xh2KmxFJ1LsrpBicQMsTGpe0sP/JPxgleGvBpiLLUxK
         noEEVhbw2taIKiOe+aEQiK3mG6UwS+ViKG8pwxDaxiZtrOdFP3Rq1+oGxq2CSsUAyk24
         14NhA56Rsvz3kxFl4qVWIgbPRGPQ/SoJdR8J69oofLMgMyGyJNsRFGd5ug511sbIshX3
         yX8tRYXttgLMo76rAa3IV41OG3dfJPOiH2Vo1fvrq2hKOvuXyqSlchyhKcvRPqLCA6Yo
         YjnIbatwjtXFso5Ux0Do65Ott1iu8LREA7hv1px4v4KKwnhASC5aHby9Hlst9WULau4v
         Q1ag==
X-Gm-Message-State: AOJu0Yzo70L0nrF7jkl59bovuWSMe3WSFwl/NW8v7b/pe9pk9iM3niLy
	PTPhzaAx/2OXlZOkxBvlQOv3CVZIY6lU1q7Fw4knCtZywFG6w5HXJwNhPklEhhrZiF+aF+pd/ET
	Sf2SEtUbheH5K4e1KUHAsBqD6xvg5PZsnYIkNTck=
X-Gm-Gg: ASbGnctHjKy3fUP9zj/Miudsng/bXEPeWNwonNJNszxkf9T5rBwTEuZw3d5EkezgzgW
	zB0+HA+CDc77e0Z6BHWE2zaqY72Ae27i16+U7KiVpL8kq5Ybr+54GCnK8uW7/xF99SebeEld/nt
	WpMeyqP4Wj25h3sw4ISKPNhcotq7YWKtG1VxFZhWk0RilVIrNNQvgfs/5I08kBTjUprxNm5JMkD
	/phGDgrK1BB13LZGEJPcGOX975joL0uyNm/20CVmL+ZhRI=
X-Google-Smtp-Source: AGHT+IGtdr7WbPm7bDysxvOJAQMSGDff1EXEXNzbuVFWgPZe6Kq1sO6AN4JucIVZZVBr8sjtoXUA09ABzO/9egTCdvc=
X-Received: by 2002:a17:907:3f8a:b0:b3e:5f40:9894 with SMTP id
 a640c23a62f3a-b50acb0e681mr3450772266b.62.1760542127117; Wed, 15 Oct 2025
 08:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760490943.git.belkid98@gmail.com> <d1c20c911637870c3cacfedf763ce508a641710f.1760490943.git.belkid98@gmail.com>
In-Reply-To: <d1c20c911637870c3cacfedf763ce508a641710f.1760490943.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Oct 2025 17:28:34 +0200
X-Gm-Features: AS18NWDiym8PISog93sV6heaDP5sHIiSYKEg860sjIWzMPSwFcKmAye3Te2hgSc
Message-ID: <CAP8UFD3zu6DJRRBcSMOQsPQDQcgzSOsqsrMWJH51=VeBkWs+SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [Outreachy] gpg-interface: use string_list_split
 instead of strbuf_split
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:19=E2=80=AFAM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:
>
> get_default_ssh_signing_key() gets the signing key via the pipe_command a=
nd

s/the pipe_command/pipe_command()/

> stores the output in key_stdout.

It's not very clear from the sentence if the signing key is the output
or not. Maybe something like:

"In get_default_ssh_signing_key(), the default ssh signing key is
retrieved in `key_stdout`, which is then split using
strbuf_split_max() into two tokens."

> The output string is then split using strbuf_split_max into two tokens at=
 a
> new line and the first token is returned.

Here also it might be interesting to know that the first token is
returned as a `char *`, not a strbuf.

> This makes the function lack the
> use of strbuf API as no edits was performed on the split tokens.

s/was performed/are performed/

> Replace strbuf_split_max with string_list_split for simplicity.

Here also, using "()" could help a bit as it would make it clear that
"strbuf_split_max" and "string_list_split" are functions.

> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>

> @@ -884,19 +884,15 @@ static char *get_default_ssh_signing_key(void)
>                            &key_stderr, 0);
>
>         if (!ret) {
> -               keys =3D strbuf_split_max(&key_stdout, '\n', 2);
> -               if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_=
key)) {
> -                       /*
> -                        * We only use `is_literal_ssh_key` here to check=
 validity
> -                        * The prefix will be stripped when the key is us=
ed.
> -                        */

Why is this comment removed? It's not clear to me that it's not valid anymo=
re.

> -                       default_key =3D strbuf_detach(keys[0], NULL);
> +               if (string_list_split(&keys, key_stdout.buf, "\n", 1) > 0=
 &&

In the commit message you should explain, like you did for the
previous commit, why "1" is passed to string_list_split() while "2"
was passed to strbuf_split_max().

Also I think that, instead of "> 0", the tests should be ">=3D2" or "=3D=3D
2". Or, if an output that contains no new line is valid, then that
should be explained in the commit message.

> +                       is_literal_ssh_key(keys.items[0].string, &literal=
_key)) {
> +                               default_key =3D xstrdup(keys.items[0].str=
ing);

Thanks.
