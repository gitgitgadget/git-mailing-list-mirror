Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8D137923
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773631326; cv=pass; b=BfxLho2sdLX6sRtA6l2hLEuAQi6rGwafE13OSs44YMveI3wnKtvb5tWb1XMg+PuhuQPuMoZvG3KajXMtiLrWH6jsM/K1/8YYmh6R+49gDA2FJJXR1Uljt1wLocHleFXYVw7TLBcBTwhwmNRMOeq4tCc/7LgEGIarBIMHjMCR8R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773631326; c=relaxed/simple;
	bh=ZZ2wArNBtwU27uqmTfGhvK+LxlJqiZdUFGzDiqc4yME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+IYxXlNooCIS69Yu7jAXGJucl+XLe0CYlMPIRK/QYa6xuXSEStcwwmh+2JZckAgoF4IWoZ1vgrEOvQBkFLbiBxULOFQwLabsVin+2QBG7hmpk9abzLTo6jlAJ726pG0LU/N516yBTkjRem8bXzlnFlp4FlDWFVCjMcOoX7phuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEQn0j58; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEQn0j58"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5842831eec.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 20:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773631324; cv=none;
        d=google.com; s=arc-20240605;
        b=kAlaqZwxfXnHNdfi9Q+VwfOZ9ymSe5+/3dHnj3u06zwTmxPAoaug7ScmKGld09rREw
         aqhKU6onc70fjlwSOyddZfGt3zTtUY9ohfNXR3blbrJzD7GImU+bh81p4EB7LcvvJpRV
         Tfau7B9wIoQrkWEvUg3liBeDW0mh7EZLhKG/kEJRv6O+yBYTPd02+3sLteUsAht+Xhkc
         o1Reevp+bcu3KLMbUwQA+qJt+4gs5u3Fnd42uwb6+7tQWDpm/3AnJxSrIdufjFgQhsvO
         dzZoFczkvFvXzrB6LWNhYBCSAbdbhgZtboH+Z9OUb0fn0PKmhTpqHE3TiwHrsRly+ldb
         VCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=92ewljaVTDajoAHTFk/WNxdYDW64j8L+Fv0TAlBy08o=;
        fh=Njtmt6EW/Mc4MhUuMWhgqa/UDBpg7WG5TE0RxCY4FyE=;
        b=ZK97FBpQKdnUXXPhwg5CLdNlBZHdUSzpMbE5NkDU1XrlmcthTqp6itR1OXuBLetLb7
         VWoeW4EiboKHPMb2TN5n60yl3ONzYd8ZsO0XDOH0i0sGibiTLgDI4/gC/aPwxtmdbI8J
         lVAI/15eA506y7QEpabgBb2jyGMpFwto9xKSnU/tnQN9Xal0dgw0G1BJpMz49KyT9Urp
         JR8w/Aom7r0LD4DeR9UN/Bhq9PXClty+2FvblK6rTFGi/DP9aM9qDGLyN23u7k+FlzGi
         FMjziPnx2x0cJ26pSDKgZgRAfLY2/lVYuOjh6EgVSX0HAX0QcgQBd2JAr9/8ZUY7Fba+
         NWdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773631324; x=1774236124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92ewljaVTDajoAHTFk/WNxdYDW64j8L+Fv0TAlBy08o=;
        b=MEQn0j58dhcQYOFp8tCmT7T85tRxLykfZ6GtnTchiKiUVQk3BglzcUGTBVhofRswEq
         R0EkwXN8n309prXZRKrBcp0c4mHI0LJ0YXQRmtYuleBpNoNNjPYTOvMv2Qerni2UwA5l
         qFceUW2HTuvzpGaU8/+3L3g0wrZMXB/DHCGRTh+WfJL8x5x3odMEoac9HRGqadsj44WS
         icy5R0p2/FU1amCCEseaRewcCo/yoU5Do/Qo3lJIAH1fdid/EqzjuLiiODoMCeMyllxL
         BYJoo4RorTEiBnjdYVOfKgDnSF6//kRBy62Z3fwiWyHoBf8y9saK3u23xHUQJFtAqA+n
         IQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773631324; x=1774236124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92ewljaVTDajoAHTFk/WNxdYDW64j8L+Fv0TAlBy08o=;
        b=lL9zAQe+efkKWQe7+Etfy3LgSwMwCqQjXpNWhkbiA9OFvBsug2+IxCDgsPykum4eYV
         8c122BP3j0SL7LXW2F3tYOqtno0zR6mqrikBqskcNxkhaFk6n+WoeOfr/gDAALpE/uOf
         oWMobehXj9k1FoLNkxgHRtPBljDzI20Q0BrhHK2KshRLUIWwB/ZR4KqTCTarWnIDnwwI
         PDA+dZ/w3XXvAMoYIdG3nk66RXJBJ4GLbrn9Zsc86EzUUqopJk0jVGqIJgSVP9k9iYX7
         IznHr5aVqEu8Tv/+r/Y/l60NMQdmxclGl65mfYR6NtzYyUVBH+INIMwj/nxq/lzRlCDN
         AFvw==
X-Forwarded-Encrypted: i=1; AJvYcCW36WK/qKaLMwyHXF7rDJtef14If1TuvVLnLgYBvlkm2VCWyoZvu7OtzD51PjVCn1QP2Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSEFH4PI4srzMJTgy0IcFZBlzYto4GiEX+lineZsljd+Reuaw
	JK+Qv2E3F9LOTdOdtfILiqCPW7Lc4SnCZwhZYIBcuOAwMAJsHTCe4TvwrMeAnE6VYCJADXUlB8W
	KwcygLWgjHu24jYpMd+DcQzUplvOwFKE=
X-Gm-Gg: ATEYQzyiREgX1DgNfbkFIT11ScOQy4W8CYu18F+UYK17WEX72l9bsfXCDNQ3axWTBjG
	Cc+c6HFp0j+8zeYyJEfroxsLVmu5SEwCt05AVvTTd9cqGTfYZKex3jLF3Aob8fR5JZTWu2naG7T
	R5pNiFIWwswh1i8jCslRFjApIZ/pf5vEA66uH7E9peIpaa7c+sp1NtZmB+cXQ65xlGU0nKxqMQ9
	4LIRy4doBS1FFFm0h+RFk/HTZDeVN335lyyuDqw/TY24yPo8YmopzLEzXKIdeGRFfB71NeF8gzX
	92yHIJUKoOTTxgNE+v4yRVZf7BiRa7mj4xqvxi7uqomK1v+afDX1h+ovzyjaUE9WKlfc7rUHpw9
	1ZH+NI8g5eie/RwWydA==
X-Received: by 2002:a05:7022:6709:b0:11b:ade6:45a7 with SMTP id
 a92af1059eb24-128f3d011acmr5255095c88.1.1773631324233; Sun, 15 Mar 2026
 20:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1773497547.git.worldhello.net@gmail.com> <0c00f09918d94995b4f990679d598adcab0d6f2d.1773497547.git.worldhello.net@gmail.com>
 <87220e93-8159-4a92-9c3f-b3f9fa34ba4e@kdbg.org>
In-Reply-To: <87220e93-8159-4a92-9c3f-b3f9fa34ba4e@kdbg.org>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 16 Mar 2026 11:21:52 +0800
X-Gm-Features: AaiRm50F1PGwa5yGfoeMhnPMTwIgH9aA_oLnkSLFeebrwHkddACOlZjZdH8K9oM
Message-ID: <CANYiYbEiDi3-MputSiHi0RZJa+BUe_6viT9HTVz+aJiSwCiw7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] l10n: add .gitattributes to simplify location filtering
To: Johannes Sixt <j6t@kdbg.org>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 7:13=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 14.03.26 um 15:38 schrieb Jiang Xin:
> > +# Two filter types are used:
> > +# 1. gettext-no-file-no-location: Strips both filenames and line numbe=
rs
> > +#    (e.g., removes "#: main.c:123" entirely)
> > +# 2. gettext-no-location: Preserves filenames but removes line numbers=
, which
> > +#    requires gettext 0.20 or higher
> > +#    (e.g., "#: main.c:123" becomes "#: main.c")
> > +#
> > +# See `po/README.md` for instructions on setting up the required filte=
r drivers.
> > +
> > +# Do not apply these filters to all `*.po` files via a wildcard. For l=
egacy,
> > +# unmaintained PO files, that would cause discrepancies between the fi=
ltered
> > +# blob in the index and the unfiltered file in the working tree.
> > +
> > +# Languages that strip both filenames and line numbers
> > +bg.po        filter=3Dgettext-no-file-no-location
> > +de.po        filter=3Dgettext-no-file-no-location
> > +#es.po       filter=3Dgettext-no-file-no-location
> > +fr.po        filter=3Dgettext-no-file-no-location
> > +#ga.po       filter=3Dgettext-no-file-no-location
> > +#ru.po       filter=3Dgettext-no-file-no-location
> > +sv.po        filter=3Dgettext-no-file-no-location
> > +tr.po        filter=3Dgettext-no-file-no-location
> > +uk.po        filter=3Dgettext-no-file-no-location
> > +vi.po        filter=3Dgettext-no-file-no-location
> > +
> > +# Languages that preserve filenames but strip line numbers
> > +#ca.po       filter=3Dgettext-no-location
> > +id.po        filter=3Dgettext-no-location
> > +zh_CN.po     filter=3Dgettext-no-location
> > +zh_TW.po     filter=3Dgettext-no-location
>
> How settled is the use of these two different filters (and names) in the
> community of translators? I am asking because I'm about to align the
> translation workflow in the Gitk repository with that in the Git
> repository. I need to know which of the two variants of filter names I
> should ask translators to use.

This is a very good question, and it reminds me to revisit the names
of these two filters.

When storing PO files in the repository, filtering location comments
is necessary, because it reduces the storage growth caused by frequent
changes in location comments, and also reduces the =E2=80=9Cdiff churn=E2=
=80=9D in
commits caused by location changes.

Either removing the entire location lines (filenames + line numbers)
or removing only the line numbers can solve the two problems above.
Both also improve blob compression equally well, so there is no
difference in terms of repository storage savings. Therefore,
maintainers may choose either approach according to their own
preference. As long as they do not switch back and forth between the
two frequently, there is no impact. Recording the maintainer=E2=80=99s choi=
ce
in the repository through .gitattributes can avoid l10n teams
repeatedly changing their choices.

For the gitk project, there is only one source file, so removing line
numbers while keeping the filename brings no benefit; removing the
entire location is the best choice. However, for the Git project, some
l10n teams keep filenames in PO files while removing line numbers, and
this can still be somewhat helpful for locating the correspondence
between PO entries and the source code when the PO files have not been
regenerated from the POT file.

This also reminds me to rethink the naming of the following filters.
Judging from the msgcat --no-location option, =E2=80=9Clocation=E2=80=9D re=
fers to
filename + line number, so defining the filters like this may be more
appropriate:

```shell
git config --global filter.gettext-no-location.clean \
           "msgcat --no-location -"

git config --global filter.gettext-no-line-number.clean \
           "msgcat --add-location=3Dfile -"
```

Please let me know your thoughts, and I will make the corresponding
changes in reroll v4.

-- Jiang Xin
