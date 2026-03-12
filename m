Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D42344025
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282381; cv=pass; b=ACxQglwbg0NNABbC4S7hnoBV0oylH66Tl69B75TmMw764PXyEI29uw08GPnpqqt3ZKLwsjs8QruhawkAYrQsD4JU9ZpHD1rw5r7GxWoMzV2DhcZJQdsfjh2rA+l/vKi/MMpnVNl82ynBeVwLSLBA6VOXa+zNu6YP1+CW6f+WN6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282381; c=relaxed/simple;
	bh=zMZfHEJdZBoKng0vnU9zqRTR4mtj5Z9gG4BucIoVCiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY6bsVl0HuLpR9IW3Z3Ntp30/dn2Ihv+6wBJH8kQIUo8C8iBizj3s6mG9Owd5GVNzjeaNqVJWSFY+ALq61f65NZDf+Jm5c1aNnwzn/5slA4K6XdRguzB31X2rLVGGquvwmLRN1FDGdp0pdmROwnrHN2PqTtHQL62VnXYv8MqYjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/VPYdiK; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/VPYdiK"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128d2e3082eso627801c88.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773282379; cv=none;
        d=google.com; s=arc-20240605;
        b=eBPCyAQNnG5MYfWkwwaKt3+LgIQDM3I/py3Owfc3sovsa4AuVx7HQhTnbr+j9Vo+S5
         2loX5PVyARyeXiPLjEhLB4w3tyxx0zv8vPfiEU7ulDY7YCQJoV7KLjwHnjcdlBsC3zBA
         dyd/9snK57uV+O+kuya5Fw7LKjXrSnyxA441LrAHaJl5ZWvK4JG1G2jywmDHpCAuusFL
         nf6FZ+o+y0Wl6IJmcNqqI+RQLcfYwlJ8QMBY7sVhqYLoN0p6zaoQjFhqTAMvn3BCGK6V
         99bwMg9gcrau+H4SCfiDq1Q5EfxjH/fv1BplPcuj/d2Wv60gujJ+aahFcTwT1bPT73cC
         b8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nq5Of9OSRpb1adal945Y1btXyzXFvCbBOschZXQYr3E=;
        fh=UGORQAzzEPdp19A0H6q6OMbaBNvApTKUMmFhax4CZwo=;
        b=e07uFQRPbkGHEblxRF3fp8jw1sgKLEJ11suXrUdGvN+lK+3DhZL0q3jRCP8YZvUzpD
         ZGld1dDp0koyaFc9KWWEbSFouLkRSt5cFMkvEqn/BV83E0QiJY0496p2V6HO/XUy4x/a
         PdsYFC0NhFMzIxYY5bAIh8y25HquNnnrQoEzq072ZCvjHhFqKP4I8eO6xc3xjiq1CI1X
         PUVnTQImyLVVPS0obLHvvIt9ABz5+thC5iMepkGpSMgTIbeBPHeEy8dVjtG4Gvs5P6z9
         EwKW+Ox09DPn189p0PeNWjYL7mLcxQyEbivrNXSxb0jjbHSN/iOMuYQmbKda2Pte3Al5
         phUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773282379; x=1773887179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq5Of9OSRpb1adal945Y1btXyzXFvCbBOschZXQYr3E=;
        b=P/VPYdiKygZE/kJtxHAZGPg48RlJH1/vMj7KkA4WcQ6+iJNgIcwwyzJtuTbKqlI0/H
         nUFqifphPPLK1Das19VB6YKfxPL7FjW79sXV9P1k4VwADbhUppCUklxHgfyWUNC3jAez
         xdPrBSFCc21CsqgiIiT4jg4dmSnIgVPqiEoKi0+Dn2buw0EWo9lIqoCjjlPeAbZC/w2G
         lfXZfPsvhwBQexacU3O+GyEzuOBcQyD5LVawSv5cssN+d5wZxy9VczSxz4Z0isin7xg5
         r56ohdRMo0ftf3bVHCMRnSGf6E9ckeBafU6JrziCr1ujC/wi5q8wcWL4ZTIkQsd0aSCN
         kSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773282379; x=1773887179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nq5Of9OSRpb1adal945Y1btXyzXFvCbBOschZXQYr3E=;
        b=l3nQ1Y+yjgLkBoKM3dGkCC0mjrkyo9MI89ocHg8TzBxCSYctR6Eke2Xvzz/23gJQMe
         XlLVuBpZEmAEccyyImlnB15ZvgXdW/pWEb13ljDujeT1Y0rLN5ROH+ig4qSfsOuJcbNq
         04D4KIlbDxZVoTBc+hlBWPvOa9gRxhKReuwgHEepneYOIZrhvfkfeumlvVIrN92vwEP/
         J1jJK4GEcUTXJAzh/w+sdg+zjavawXUgWmtsSjFydvX1nKc5fyuimIrT6j3cGWJ3hpgl
         sAtv1D1R6c0yMbomHMGylHZKVw6zyKdC9Oez86HCHC9irMkFquH769e7NJJhZzXCgdTw
         vANQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt+Pv1Pq9RzmF9j6KrrO2kvOB+lw73Z1CBc06/XDlESME1Cb6kwbN3xtwn5Od2kzMKCB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGZ5zAvis/nK/JKUFyt8+uodDltuys4ypuO+DyrsSZco1XrOA
	JmBRmtoOXWnjF+PVXQchH6BAtkCXo7z1BGx0IOTIZoqyUs0+J07VLAZf9qU7asNP4fJYPz22awd
	W05DL+cQH7x0jYdF2iJl+GBIPIP2MF9k=
X-Gm-Gg: ATEYQzzykPWX6Df74PB4epEvlNlDMHOFpYK1yLL1IAOzDrruLZC9yocXUvxi7X3Cjtl
	aN7B4y3Faww5CjSLRvxMKTqARMLNlMC6UGLK6qyUVVnoGySxDKGw+gpUOVOYPyAZUyK8QoPGIgw
	XrxL36hOfpCLUtInpUSAlCULFbgSjZihUkqXNN1kkUjVl5nmPh+3CmmOOK3r06qmAJYz5che93U
	8/E3WEfy4k79Lki/ZzPGnEH4tKVvpBuZArlmIktWshlyGb6z3xa46bbSqJd005ipkqozrTe4N6N
	5BM48oBetHQr7t9XjxPv3TA2or6MXSdPnLXQAT7KDcIwlPVbhGWYxc/al/wW9U71Jlo2O/pkDNa
	XLt1RGFw=
X-Received: by 2002:a05:7022:1282:b0:119:e56b:c74a with SMTP id
 a92af1059eb24-128e77b6bcamr2073050c88.15.1773282379024; Wed, 11 Mar 2026
 19:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1772551123.git.worldhello.net@gmail.com> <d6785db1dfedeccca1cddc17d8c95b99eb266500.1772551123.git.worldhello.net@gmail.com>
In-Reply-To: <d6785db1dfedeccca1cddc17d8c95b99eb266500.1772551123.git.worldhello.net@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 12 Mar 2026 10:26:06 +0800
X-Gm-Features: AaiRm52hpl19lFfSxSYmLoitgyMl9WTGvwuKyZXsjDI43MkJlHLtbPI_gqce4FI
Message-ID: <CANYiYbGhZVCmYPN6kBeP2UpZMjzMFEetNCaefCf1LAWQPezhow@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] docs(l10n): add AI agent instructions for
 translating PO files
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:34=E2=80=AFPM Jiang Xin <worldhello.net@gmail.com=
> wrote:
> +#### GETTEXT JSON format
> +
> +The **GETTEXT JSON** format is an internal format defined by `git-po-hel=
per`
> +for convenient batch processing of translation and related tasks by AI m=
odels.
> +`git-po-helper msg-select`, `git-po-helper msg-cat`, and `git-po-helper =
compare`
> +read and write this format.
> +
> +**Top-level structure**:
> +
> +```json
> +{
> +  "header_comment": "string",
> +  "header_meta": "string",
> +  "entries": [ /* array of entry objects */ ]
> +}
> +```
> +
> +| Field            | Description                                        =
                           |
> +|------------------|----------------------------------------------------=
---------------------------|
> +| `header_comment` | Lines above the first `msgid ""` (comments, glossar=
y). Directly concatenated. |
> +| `header_meta`    | Decoded `msgstr` of the header entry (Project-Id-Ve=
rsion, Plural-Forms, etc.).|
> +| `entries`        | List of PO entries. Order matches source.          =
                           |
> +
> +**Entry object** (each element of `entries`):
> +
> +| Field           | Type     | Description                              =
             |
> +|-----------------|----------|------------------------------------------=
-------------|
> +| `msgid`         | string   | Singular message ID. PO escapes encoded. =
             |
> +| `msgstr`        | string   | Singular message string. Empty for plural=
 entries.    |
> +| `msgid_plural`  | string   | Plural form of msgid. Omit for non-plural=
.            |
> +| `msgstr_plural` | []string | Array of msgstr[0], msgstr[1], =E2=80=A6 =
Omit for non-plural. |
> +| `comments`      | []string | Comment lines (`#`, `#.`, `#:`, `#,`, etc=
.).          |
> +| `fuzzy`         | bool     | True if entry has fuzzy flag.            =
             |
> +| `obsolete`      | bool     | True for `#~` obsolete entries. Omit if f=
alse.        |

The coexistence of msgstr (string) and msgstr_plural (string array)
introduces redundancy and increases the risk of model generation
errors. To resolve this, unify all translations into a single msgstr
array in v3:

- Single element: Represents the singular form (equivalent to PO
msgstr or msgstr[0]).
- Multiple elements: Represent plural forms in sequential order
(msgstr[0], msgstr[1], =E2=80=A6).

> +
> +**Example (single-line entry)**:
> +
> +```json
> +{
> +  "header_comment": "# Glossary:\\n# term1\\tTranslation 1\\n#\\n",
> +  "header_meta": "Project-Id-Version: git\\nContent-Type: text/plain; ch=
arset=3DUTF-8\\n",
> +  "entries": [
> +    {
> +      "msgid": "Hello",
> +      "msgstr": "=E4=BD=A0=E5=A5=BD",
    "msgstr": ["=E4=BD=A0=E5=A5=BD"],

> +**Example (plural entry)**:
> +
> +```json
> +{
> +  "msgid": "One file",
> +  "msgstr": "",
> +  "msgid_plural": "%d files",
> +  "msgstr_plural": ["=E4=B8=80=E4=B8=AA=E6=96=87=E4=BB=B6", "%d =E4=B8=
=AA=E6=96=87=E4=BB=B6"],
    "msgstr": ["=E4=B8=80=E4=B8=AA=E6=96=87=E4=BB=B6", "%d =E4=B8=AA=E6=96=
=87=E4=BB=B6"],

> +6. **Repeat steps 1=E2=80=935** until `po/l10n-pending.po` is empty (or =
does not exist).
> +   Do not stop early.
> +
> +7. **Final verification**:

Some LLMs sometimes fail to follow instructions, skipping directly
from Step 6 to Step 7. This issue can be resolved by renaming the Step
7 title to "7. **Only after loop exits**".
