Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4018AF4
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720207548; cv=none; b=MqUtwobhJeO+PHxYyNNysAhnpSCHKbq2KG9nopyvXS4nbOIO2qqbGP7gpYwfPG+juCFuEgC5Y2jb8CfgGUruY6Yx9XhkkhYzMkNZcRKp2GIZanYFFndLgrXBOTrZ0DZ1I1m5vNjj/EvG80Rop0gS8OC2+UkGanI5ipig8cAB2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720207548; c=relaxed/simple;
	bh=HoiNsuNesMohpG1K0vGhd7QVp90gPAhxntPm90mUzWQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uU+5lhZRurWFV7MXhE7ZgEZBjxvGVyOr+qVzgSKdOKKK5KsZcXKiursFs7BuUGEuHq2etc9UnpQquxhq/VMU/81v+IgmfMmDlK9hk6f6jGl+ALbbkOBq8U/MGy/hX29mVWkVn8K3CfZsfXqhDEtFkHQ5vJRWbz1oj5RinzWlEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=X048j5Ph; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="X048j5Ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720207543; x=1720812343; i=l.s.r@web.de;
	bh=gHlJlKPnqVemdDSJe8kpNdh1ov0jtJH2JKxTq0JpxWs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X048j5Ph44UfYVIAwq5Cflhpn0en4nf185ohyFegXTSdTMV6pgslaCEMIobX5MmR
	 Xy0Vw+QU2TJ75PCx51jKWDDLpXu+62nRgLvGCzVzH9CSwqtgIhpZi3PM9i5IYrx6X
	 ER4psj7NSyPIx/ibggeS2unk1MIpCsNSuNx/kfZBj3vClnSEN3LKWhW26lValxWwU
	 86ja1vXN1gRGhrdNPmgHPgOygFZA/QrajYwAhHWF6es8gioz3eM/T31U63icPSXoU
	 2pCMCSuN74F14qV6bioQtmPncw0jhJM6hZCNaiW7SvtkfgKOL+PRPtRImRIp8cLbY
	 AArD+/O9e+NAQ+LO4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsOP-1s0PpM2rn1-00gg2w for
 <git@vger.kernel.org>; Fri, 05 Jul 2024 21:25:43 +0200
Message-ID: <4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de>
Date: Fri, 5 Jul 2024 21:25:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] clang-format: include kh_foreach* macros in ForEachMacros
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IL68YKghhn6NAvHZ6Qyf1jdkm9eZlF/db4AMMwF6O/SvTBmUnYL
 pu/Lo3zt3pJzR/N91OCvbCBu0m99GxiyqfxfF/za5oQWGIaWotPczYVoS3HkHLszDBbCn/J
 8eJO4rnAozDIUhwpUFHeS8TURr8New5bAVXhcfiWVCzItKrBo99p+c5wyLOfmPY6RlOYEVk
 A/2ygFRO7LpHtVxE0TLsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rWzKKcI9V3o=;JMM9Ykd2WFJ1VjnTbtBPn4o7cr/
 Wze1vgeHGY/daM3JBqMMJev68Jb6Q9Bn/PK5Iyl3z8em11HV2TpA1dNEuRCT8kYYbmQQfZF9B
 1mrrzMxV+g952OOqlA64dXjl5SitE+ToMaq4s9rEIXTOpEfHPtEzgMBMduxkOkuDXREvuW92C
 Q9/32uEWJOXijKzp2giFTmV+HqT9zXKM2/OIvYb82wpA2zRHudba1TRFlREzyWOnqWDClnGyy
 qviHN2KHOLANvPSAfTBLMa5Wtg7P8WM8Q+QMyvTwJvo+5Ljuz38xerVFMTcyUtgbX0JH2xsRa
 H2mZsNZPapCLOKIn8OtQXlKRMciiP78jlpS8ciX2HfAMnteNlTj1wkhF6PbdtfDt1IQ4gN5P5
 Fnx6HeaKPNDmwxTMBBzB2d/6rDw3BpVnrOLh0RJrtqjD4bbDmmjIXfDdlAxCsoShli2X2sffN
 wAg+QtnqyiYzNHo0QfasPyhxkY40CQTRw5H0dR2y862vWA5Hjr6hVbXgo+Pqot90hI0D8Tl7+
 /Ptgllglo61MTFCOKUBytXIhm5aDE2vWVH1r/DRAF0JhgVtWosERGnwD4OcUd1Pei/afJKEE+
 uIok6EmuDR/tIYoP8nNQXX9o2FIalOkXxovajK9DyFeAc5gaS4CYUSiGDpQ35rNAPXKb59jQz
 +10gOE0Sk6W+aYoGj0CkhMdcaZwlE848sLGH7L4V6EKJmis08x52a1rHhngYBi08vL3dzPUoy
 FU5Kx9SqtEHpu5EAbDZCAJlwe2TvKQ023Njgze0zydyY+gFigkqiiWBD6xd2rIkf06Dtm5W7V
 tuweXUaTGE5L6oY3HV3st9NvOwz01eFZuVtjVFL+G/Tqg=

The command for generating the list of ForEachMacros searches for
macros whose name contains the string "for_each".  Include those whose
name contains "foreach" as well.  That brings in kh_foreach and
kh_foreach_value from khash.h.

Regenerating the list also brings in hashmap-based macros added by
87571c3f71 (hashmap: use *_entry APIs for iteration, 2019-10-06),
f0e63c4113 (hashmap: use *_entry APIs to wrap container_of, 2019-10-06),
4fa1d501f7 (strmap: add functions facilitating use as a string->int map,
2020-11-05), b70c82e6ed (strmap: add more utility functions,
2020-11-05), and 1201eb628a (strmap: add a strset sub-type, 2020-11-06).

for_each_abbrev is no longer found because its definition was removed by
d850b7a545 (cocci: apply the "cache.h" part of "the_repository.pending",
2023-03-28).  Note that it had been a false positive, though, as it had
been a function wrapper, not a for-like macro.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 .clang-format | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/.clang-format b/.clang-format
index 3ed4fac753..6408251577 100644
=2D-- a/.clang-format
+++ b/.clang-format
@@ -149,20 +149,25 @@ Cpp11BracedListStyle: false

 # A list of macros that should be interpreted as foreach loops instead of=
 as
 # function calls. Taken from:
-#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
-#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'=
," \
-#   | sort | uniq
+#   git grep -h '^#define [^[:space:]]*for_\?each[^[:space:]]*(' |
+#   sed "s/^#define /  - '/; s/(.*$/'/" | sort | uniq
 ForEachMacros:
-  - 'for_each_abbrev'
   - 'for_each_builtin'
   - 'for_each_string_list_item'
   - 'for_each_ut'
   - 'for_each_wanted_builtin'
+  - 'hashmap_for_each_entry'
+  - 'hashmap_for_each_entry_from'
+  - 'kh_foreach'
+  - 'kh_foreach_value'
   - 'list_for_each'
   - 'list_for_each_dir'
   - 'list_for_each_prev'
   - 'list_for_each_prev_safe'
   - 'list_for_each_safe'
+  - 'strintmap_for_each_entry'
+  - 'strmap_for_each_entry'
+  - 'strset_for_each_entry'

 # The maximum number of consecutive empty lines to keep.
 MaxEmptyLinesToKeep: 1
=2D-
2.45.2
