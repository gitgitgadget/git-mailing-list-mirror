Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9133F8BE
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773575859; cv=none; b=dUKLKueekdpEcqKuFc7G9eFO10ehz1hay25lHb/UidiToPjrdEcrvcznQqqaG3t6d5I+W6V4x0a363skx/T3I+B5YJR/e2+ZwJo0AOQ5bkucyUpl84gOqVFkHLWb9PPxw5A5SHbqUUEluGV0WJBzMh9aJskYGcvGMD37wbS2H3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773575859; c=relaxed/simple;
	bh=aPBcAPllVHWKrNoNvpc6dK15Q6fnibZCKkZUnVFNlmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV6/GWJe8f8jTOvTm0vDMlDsjn+6J4d2jG/HV166IEpNb1kIMCEnr0wrdnvxK0DniHS1MQ8QzW9UsNJYT2wKGCBFVH6ULuHyO8bIPr/EHr0LQsImwyln48OdIcyNc31FrPKXcwJGjYW+6tHPCFE1GeO+IxoexfhmS4tj4rQ6bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fYbDt5nDzz7QXB7
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 12:13:18 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fYbDh4yJ5zRnlK;
	Sun, 15 Mar 2026 12:13:08 +0100 (CET)
Message-ID: <87220e93-8159-4a92-9c3f-b3f9fa34ba4e@kdbg.org>
Date: Sun, 15 Mar 2026 12:13:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] l10n: add .gitattributes to simplify location
 filtering
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Alexander Shopov <ash@kambanaria.org>,
 Mikel Forcada <mikel.forcada@gmail.com>,
 Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <jn.avila@free.fr>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Dimitriy Ryazantcev <DJm00n@mail.ru>, Peter Krefting
 <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>,
 Arkadii Yakovets <ark@cho.red>, =?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>, Teng Long <dyroneteng@gmail.com>,
 Yi-Jyun Pan <pan93412@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1773497547.git.worldhello.net@gmail.com>
 <0c00f09918d94995b4f990679d598adcab0d6f2d.1773497547.git.worldhello.net@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <0c00f09918d94995b4f990679d598adcab0d6f2d.1773497547.git.worldhello.net@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.03.26 um 15:38 schrieb Jiang Xin:
> +# Two filter types are used:
> +# 1. gettext-no-file-no-location: Strips both filenames and line numbers
> +#    (e.g., removes "#: main.c:123" entirely)
> +# 2. gettext-no-location: Preserves filenames but removes line numbers, which
> +#    requires gettext 0.20 or higher
> +#    (e.g., "#: main.c:123" becomes "#: main.c")
> +#
> +# See `po/README.md` for instructions on setting up the required filter drivers.
> +
> +# Do not apply these filters to all `*.po` files via a wildcard. For legacy,
> +# unmaintained PO files, that would cause discrepancies between the filtered
> +# blob in the index and the unfiltered file in the working tree.
> +
> +# Languages that strip both filenames and line numbers
> +bg.po	filter=gettext-no-file-no-location
> +de.po	filter=gettext-no-file-no-location
> +#es.po	filter=gettext-no-file-no-location
> +fr.po	filter=gettext-no-file-no-location
> +#ga.po	filter=gettext-no-file-no-location
> +#ru.po	filter=gettext-no-file-no-location
> +sv.po	filter=gettext-no-file-no-location
> +tr.po	filter=gettext-no-file-no-location
> +uk.po	filter=gettext-no-file-no-location
> +vi.po	filter=gettext-no-file-no-location
> +
> +# Languages that preserve filenames but strip line numbers
> +#ca.po	filter=gettext-no-location
> +id.po	filter=gettext-no-location
> +zh_CN.po	filter=gettext-no-location
> +zh_TW.po	filter=gettext-no-location

How settled is the use of these two different filters (and names) in the
community of translators? I am asking because I'm about to align the
translation workflow in the Gitk repository with that in the Git
repository. I need to know which of the two variants of filter names I
should ask translators to use.

-- Hannes

