Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6D27FB18
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705306; cv=none; b=SJi/OKmyGhUfV6o3cwVnNFaWrRbD43HijN8EPcPwbDuTfoF2EY+q9ePwBxXGPjQnJPE6H2rQxUBNBjeq+i9RK2TJmiHWYaFCA+0tr9/ZjY6ZdTATmqa0eg3SzFw9J7GixP8ZF3vE3NaTNg8HvGvlaU3K6qi9gfx5NwRIfbwJg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705306; c=relaxed/simple;
	bh=QN/Xpp1EFBCTaS4f0CxThNeUJVmfbwfPKuCqdAUws08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJPviIz5nAB9abYzNsAiMMF0pPJjjyWafv0QbUDykb/HrTW6g6Z3iTod2nZwDDpSQlH07Fb8UMtFS83wTVfRqvrlT4UiuDI1N+ZWtyBnHXIADWpLbHRJVD0jezgbemxE/giYDwNk+lwrtw73mWnpskSrJ0Yegzc2TzebY9GKSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+h/rww6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+h/rww6"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7da9so44137127b3.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773705303; x=1774310103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCu6HdjhBtkBW4BMbOPdtZDkDU1/72gPK8EhhlPW1yc=;
        b=d+h/rww65QtNWqI8a5TFQd+5ziSauNqmUfXvtdQIzJQ5/KpnjVtBpfG9bc7CT1HhGB
         AjLxc58xOUnviX6dJei5IItEScEHSixArFXNeYesMwZ/+mOIPWOXOIl46JP3WlvvPxSS
         ZDbqU/VIIUWV+GTsxBT68xuYRHRfog+aKhfZ2QXcX2P7WxNFGZfGM7WhgCTvQOAyTzS7
         1of2tQ7PoaVat8CZ2GYgKSZMRzL6zcTTPMJVpDUgIvliaWM6GTq39UWdY6Hbe4h3/uGn
         Uv1WrQRQbubI+5ucj14YQJvuU2Y9c4qDnRoOiUPgT7nt62P4kCBxQIXUIHL/TnvqVJgM
         turg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773705303; x=1774310103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCu6HdjhBtkBW4BMbOPdtZDkDU1/72gPK8EhhlPW1yc=;
        b=f5r8+Cp0zc4jyZiNJd+bs/+NYlfI8UO7HTdnkr7kdliOS4cCH8/JMdJkUAkLn3Ix4j
         tciCSYqhMuyYrgoDymDN18DxQW67wDcUtayHmsExBaAYybLtUcFJwE7A2X9XpLPNgYET
         o28y2rJ9Ni1PYPgqWcfZuGNOs/f6LSQtrmPbi0kCE6IGJ4QXwrNVMXWlL+xme4vMD+Qa
         yzL3w13R9dQEpkrJ8Jqzt3Dl3nNUun0JNVasNF6SMHCc3m0GBp3uC71LS/VoTJ7/RyVN
         HbjNvwL3KAd1fqQ/Fd+Gn2F8tJ+ETx1npgdInnrK1Lu68RW6DHUq4wu/inG4U7W1oGgX
         EIaw==
X-Forwarded-Encrypted: i=1; AJvYcCV4TGeBDZTqDxKaY0/9YMh8Iiv33qfdaXuIBa2D8XYYszbd2W6BdTiYa7/byV13LdXVXC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWU6RyYH1wDDL7e5qq32Ng3mxq2HSZZ6wiNJGSFN5bNGwd9vPF
	g/59ZHV8hWiulwRmbokNG4syqePwC6af1qp7qPYgu+gHVCtgfcz4HDUv
X-Gm-Gg: ATEYQzzfpLyN0qJ8/PKILH8EcLaUT744ZdzK0kgKmNfk6Y698wMlrVd2wUQXWZWx/XC
	TyRuFVjd5A1W7sRArBYkrZKThn25G6s8l8ex6N3FtwMXcaFA53rlW8OP9zgqVvYI0CvuCl3817r
	QDipOiAbtHNFiOGrNEtgmNWFY6ZDKiXD4H5Yq4nLY3alDanc3fZFo4jCTB82b0LyaTgdhxvgPfI
	2fmASM/xYS9pPvC7vmlSLUpweLK6HEvR3TEz37JdWnqSiewvzoaehjDKBgGUCeqtpNwcUj9+nHk
	dAdh2mP4H6A0MtP9TIcyv7K/+uiYHv1hiGHad7jnQeA8RabDGrn0CSQnb13uJ6GiRS2jIXKRavQ
	BMxiSTOvVGcAcrUgZQH9eohS5mk1XNvvBiIyc61v0G8eDnvNwFh6BA23QoxW1OvmQ1ATurFUWWi
	akgzNy+quKSxKNWhawUSzKEhNYDJIxxarqpovxxz+zjCs+iL3bQkQmq8VW8+esdX0+X82peEHY2
	/3P05RVIuQVMXVcups4XEYdaYpNuCXq1tz1ExBaaKwah1sdC0VUcBqrR2Nd1ixdfgvU0raF2au/
	XQPGlT6fYB0=
X-Received: by 2002:a05:690c:e368:b0:79a:5e86:adb9 with SMTP id 00721157ae682-79a5e86bb00mr26266957b3.57.1773705303114;
        Mon, 16 Mar 2026 16:55:03 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a1fb76793sm56812897b3.38.2026.03.16.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:55:02 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v4 0/5] docs(l10n): AI agent instructions and workflow improvements
Date: Tue, 17 Mar 2026 07:54:44 +0800
Message-ID: <cover.1773704908.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

## range-diff v3...v4

1:  0c00f09918 ! 1:  cb99047e24 l10n: add .gitattributes to simplify location filtering
    @@ Commit message
         l10n: add .gitattributes to simplify location filtering
     
         To simplify the location filtering process for l10n contributors when
    -    committing po/XX.po files, add the filter attributes for selected PO
    +    committing po/XX.po files, add filter attributes for selected PO
         files to the repository. This ensures all contributors automatically
         get the same filter configuration without manual setup in
         .git/info/attributes.
     
    -    The filter attribute is only applied to specific PO files that have
    -    been properly prepared. Files without the filter attribute fall into
    -    two categories:
    +    The default filter (gettext-no-location) is applied to all .po files
    +    except:
     
    -    - Legacy files that lack maintenance and still contain location
    -      comments that have not been cleaned up
    -    - Files that are already location-less but whose formatting (e.g., line
    -      wrapping style) differs from the output of msgcat processing
    +    - Legacy, unmaintained PO files that still contain location comments.
    +      Leaving the filter off avoids index vs working-tree discrepancies for
    +      these files. The CI pipeline will report an error when future updates
    +      touch these legacy files.
    +    - Some PO files use a different filter that strips only line numbers
    +      from location comments while keeping filenames.
     
    -    To avoid discrepancies between the filtered blob in the index and the
    -    unfiltered working tree for these files, the filter attribute is not
    -    applied to them.
    -
    -    Contributors still need to manually define the filter drivers using
    +    Contributors still need to manually define the filter drivers via
         git-config as documented in po/README.md.
     
    -    Additionally, po/README.md has been reorganized: the content of handling
    -    location-less PO file content has been moved from the "Updating a XX.po
    -    file" section to a separate "Preparing a XX.po file for commit" section.
    -    This prevents AI agents from introducing unrelated operations when
    -    updating PO files.
    +    Four PO files that use location filtering (po/ca.po, po/es.po, po/ga.po,
    +    po/ru.po) were batch-modified so their on-disk format matches the filter
    +    output (e.g. line wrapping), avoiding index vs working-tree mismatch.
    +
    +    Additionally, po/README.md has been reorganized: the material on
    +    preparing location-less PO files for commit has been moved from
    +    "Updating a XX.po file" to a separate "Preparing a XX.po file for
    +    commit" section. This prevents AI agents from introducing unrelated
    +    operations when updating PO files.
     
         Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
     
    @@ po/.gitattributes (new)
     +# space.
     +#
     +# Two filter types are used:
    -+# 1. gettext-no-file-no-location: Strips both filenames and line numbers
    ++# 1. gettext-no-location: Strips both filenames and line numbers
     +#    (e.g., removes "#: main.c:123" entirely)
    -+# 2. gettext-no-location: Preserves filenames but removes line numbers, which
    ++# 2. gettext-no-line-number: Preserves filenames but removes line numbers, which
     +#    requires gettext 0.20 or higher
     +#    (e.g., "#: main.c:123" becomes "#: main.c")
     +#
     +# See `po/README.md` for instructions on setting up the required filter drivers.
     +
    -+# Do not apply these filters to all `*.po` files via a wildcard. For legacy,
    -+# unmaintained PO files, that would cause discrepancies between the filtered
    -+# blob in the index and the unfiltered file in the working tree.
    ++# Default: Strip the whole location comments for all .po files
    ++*.po	filter=gettext-no-location
     +
    -+# Languages that strip both filenames and line numbers
    -+bg.po	filter=gettext-no-file-no-location
    -+de.po	filter=gettext-no-file-no-location
    -+#es.po	filter=gettext-no-file-no-location
    -+fr.po	filter=gettext-no-file-no-location
    -+#ga.po	filter=gettext-no-file-no-location
    -+#ru.po	filter=gettext-no-file-no-location
    -+sv.po	filter=gettext-no-file-no-location
    -+tr.po	filter=gettext-no-file-no-location
    -+uk.po	filter=gettext-no-file-no-location
    -+vi.po	filter=gettext-no-file-no-location
    ++# Legacy, unmaintained PO files: filter disabled to avoid index vs
    ++# working-tree mismatch (these files still have location comments).
    ++el.po	-filter
    ++is.po	-filter
    ++it.po	-filter
    ++ko.po	-filter
    ++pl.po	-filter
    ++pt_PT.po	-filter
     +
    -+# Languages that preserve filenames but strip line numbers
    -+#ca.po	filter=gettext-no-location
    -+id.po	filter=gettext-no-location
    -+zh_CN.po	filter=gettext-no-location
    -+zh_TW.po	filter=gettext-no-location
    ++# These files use gettext-no-line-number (keep filenames, strip line
    ++# numbers). The choice is per l10n team preference. Requires gettext 0.20+.
    ++# The only benefit is locating source files from location comments when
    ++# the .po file is not updated from the POT via make po-update.
    ++ca.po	filter=gettext-no-line-number
    ++id.po	filter=gettext-no-line-number
    ++zh_CN.po	filter=gettext-no-line-number
    ++zh_TW.po	filter=gettext-no-line-number
     
      ## po/README.md ##
     @@ po/README.md: It will:
    @@ po/README.md: git-po-helper check-commits <rev-list-opts>
     +The filter configuration is defined in the "po/.gitattributes" file.
     +
     +Then define the driver for the filter. Most languages use the
    -+"gettext-no-file-no-location" clean filter, which strips out both filenames and
    -+line numbers from location comments. To set this up, run the following command:
    ++"gettext-no-location" clean filter, which strips out both filenames and line
    ++numbers from location comments. To set this up, run the following command:
     +
     +```shell
    -+git config --global filter.gettext-no-file-no-location.clean \
    ++git config --global filter.gettext-no-location.clean \
     +           "msgcat --no-location -"
     +```
     +
    -+Some languages use the "gettext-no-location" clean filter, which preserves
    -+filenames but not line numbers. For these, install gettext version 0.20 or
    -+higher and set up the driver as follows:
    ++Some PO files use the "gettext-no-line-number" clean filter, which keeps
    ++filenames but strips line numbers. This filter requires gettext 0.20 or
    ++later. The only benefit is being able to locate source files from location
    ++comments when the .po file is not updated from the POT via `make po-update`.
     +
     +```shell
    -+git config --global filter.gettext-no-location.clean \
    ++git config --global filter.gettext-no-line-number.clean \
     +           "msgcat --add-location=file -"
     +```
     +
2:  573c24e798 = 2:  e1258eac7d docs(l10n): add AGENTS.md with optimized update-pot instructions
3:  bc00ca2d30 = 3:  88f9e2e2cd docs(l10n): add AI agent instructions for updating po/XX.po files
4:  6c61a8ca25 = 4:  5034063c2b docs(l10n): add AI agent instructions for translating PO files
5:  208c1230d1 = 5:  9388b8e9f4 docs(l10n): add AI agent instructions to review translations

## Introduction

This series introduces AI agent instructions for Git localization (l10n)
workflows to help localization contributors quickly complete drafts and
use AI to check translation quality. The changes focus on:

1. Separating agent-specific documentation into po/AGENTS.md for
   targeted optimization of AI-assisted workflows
2. Providing step-by-step instructions for update-pot, update-po,
   translation, and review tasks
3. Simplifying location filtering for PO file commits via .gitattributes

AI-assisted translation is optional; many successful l10n teams work
well without it. When used, AI output serves as reference only—human
contributors must review and approve before submission.

## Performance summary

Benchmarks use the Qwen model via git-po-helper. The improvements reduce
API costs and make agent workflows more efficient while maintaining human
oversight of translation quality.

| Task        | Before              | After                    | Improvement                           |
|-------------|---------------------|--------------------------|---------------------------------------|
| update-pot  | 17 turns, 34s       | 3 turns, 8s (range 3–3)  | -82% turns, -76% time                 |
| update-po   | 22 turns, 38s       | 4 turns, 9s (3–9, 7–14s) | -82% turns, -76% time                 |
| translate   | 86 turns, ~21m      | 56 turns, ~19m           | -35% turns (git-po-helper JSON batch) |
| review      | N/A                 | 22 turns (63 entries)    |                                       |

## Testing

All changes have been evaluated with the qwen model via git-po-helper
agent-test and agent-run. The po/AGENTS.md instructions are designed
to work with coding tools that support file references (e.g.,
"Translate po/zh_CN.po by referring to @po/AGENTS.md").

## Changes

Jiang Xin (5):
  l10n: add .gitattributes to simplify location filtering
  docs(l10n): add AGENTS.md with optimized update-pot instructions
  docs(l10n): add AI agent instructions for updating po/XX.po files
  docs(l10n): add AI agent instructions for translating PO files
  docs(l10n): add AI agent instructions to review translations

 po/.gitattributes |  35 ++
 po/AGENTS.md      | 872 ++++++++++++++++++++++++++++++++++++++++++++++
 po/README.md      |  71 ++--
 po/ca.po          |  48 +--
 po/es.po          |  34 +-
 po/ga.po          |  64 ++--
 po/ru.po          |  28 +-
 7 files changed, 1033 insertions(+), 119 deletions(-)
 create mode 100644 po/.gitattributes
 create mode 100644 po/AGENTS.md

-- 
2.53.0.rc2.20.g532543fa46

