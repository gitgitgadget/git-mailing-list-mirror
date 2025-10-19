Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511137DA66
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760899816; cv=none; b=AwYpv3DexP6OQsgcT8PWUUE5uB7BVaP/wSzf7xGSTlQtIIXsDmKPPOPA8hOlsaa+O8tnwt1sjPa8EGtuaPuBSD43OM5RG3CIf3UbxCZHH7+YBGxhZejOsH2Vve+e7Zy2N10KL+luzHopuhbKoineo33pI3paIjw6PdEYc81SG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760899816; c=relaxed/simple;
	bh=DoZ5Gu2Xf5mzvRS6fTi1ShDI8swyLDgOeFmLw523x9A=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=o5aIILIv3m36dYEY3O8F3SDCLsyo1gjVZIlkAZ9UilzKuLTRT/x5aezVOpiSaUMvLSlXUBQi99S9GLigZ8/HOo+27o60ZONu+Ut445ZbwpragpEMMXXQDZgM5JAkCZ1hbmhywCOdgDO8j1mIUreHcTwaJmrFxhC2ebep2hTuQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b=gk8CmSNO; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b="gk8CmSNO"
Authentication-Results: mail.aegee.org/59JIkBhs758968; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1760899572; i=dkim+MSA-tls@aegee.org;
	bh=DoZ5Gu2Xf5mzvRS6fTi1ShDI8swyLDgOeFmLw523x9A=;
	h=Subject:From:To:Date;
	b=gk8CmSNOnTFZAADXSsZxculrSWMKxznOnw3tPIq5AFeFXIY4tyaAUq8lfFG0gdcVP
	 hrrNArU2a/5IXYubCcOgypjWt6kVMFZNCpS7MynXDozWdAWRk0u0U6z8YaVg3VYLAx
	 5/ypSArUjQbdUvZ2+KbmhqmYuIhX+32SgRRyp3sHv//X2KHitbho3WnbfeANfCyGts
	 r/XQrkpHtHacgLIWsVUZedbEUPKl8lVvyRAaSRmDna1N/RnmiO2vd6FxUUPwk/4L/q
	 CpeTqnFQwD8ojd7545MBvNMp76Ilf0srb8uD+wfiIrX7BanIpNZKtmSf6A6dpYnvnm
	 OfXeLyhxNsVV8drKS924JUTXRyi+nc64bv4En6/Ubzunk+KjV1G3paXkZbcvP+ANpj
	 EyRGAnFjnV5G0JKjDwVxo/wxGSKbWEs+fM/Sw1FZfQNnUcMKhaEIshtv6qyISFk4AF
	 hMCf9qn6sPoC9DfaFZkRHcDgkyltRJvoV7Hf/YbvYzbqmu27uGkAbCDsraWejLYlmB
	 ePYL32fcTxSPTLRtg5r+yiOz7ZJKISYcx3mU58gEnEcrfk64ag7bgY6QoQDETsES/h
	 MYdSB8rplXxnwBRmSXsTNuBWoaIO+dCg6u4ADvyaZjC1U/id0pQ8QGWDVdDjILIGO9
	 e1bvQNPRCIVGfCbJ1pDRjd8k=
Authentication-Results: mail.aegee.org/59JIkBhs758968; dkim=none
Received: from [192.168.0.242] (95-43-114-153.ip.btc-net.bg [95.43.114.153])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 59JIkBhs758968
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 18:46:11 GMT
Message-ID: <a6ce209d120ca6acf0f5dd04521cb96ac1337a54.camel@aegee.org>
Subject: No config option for `git diff --stat` to always show the full file
 path and name (without .../ abbreviations)
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: git <git@vger.kernel.org>
Date: Sun, 19 Oct 2025 21:46:10 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.59.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

After `git diff --stat` determines the available width, it uses correctly a=
ll available space for the file paths and names:

```
$ git show --stat --oneline=20
0fb93104ba (HEAD -> java223/main) SourceGenerator: avoid delayed actions af=
ter the bundle is deactivated
 .../main/java/org/openhab/automation/java223/internal/Java223ScriptEngineF=
actory.java    |  1 +
 .../java/org/openhab/automation/java223/internal/codegeneration/SourceGene=
rator.java     | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)
```
https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---statwidthnam=
e-widthcount describes that after --stat can be entered up to three numbers=
, two of which can be set by a config option.  The same options apply also =
for show --stat : https://git-scm.com/docs/git-show#Documentation/git-show.=
txt---statwidthname-widthcount .

I set in /etc/gitconfig:
[diff]
        statGraphWidth =3D 200
        statNameWidth =3D 200

which is effectively the same as calling:
```
$ git show --stat-graph-width=3D200 --stat-graph-width=3D200 --oneline
0fb93104ba (HEAD -> java223/main) SourceGenerator: avoid delayed actions af=
ter the bundle is deactivated
 .../main/java/org/openhab/automation/java223/internal/Java223ScriptEngineF=
actory.java    |  1 +
 .../java/org/openhab/automation/java223/internal/codegeneration/SourceGene=
rator.java     | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)
```
There is no difference.  diff.statGraphWidth / diff.statNameWidth / --stat-=
graph-width=3D / --stat-graph-width=3D200 set some number of columns within=
 the available space.  But I want to change the size of the available space=
 to defaut to 200 (or to infinity).

The reason is that I can then copy the file path (e.g. with the mouse) from=
 the git --stat output and open it immediately with less or emacs.

* Please either alter the option `diff.statGraphWidth` to enlarge the avail=
able space (broader than the terminal width), or add an option to `git conf=
ig` to set the available space for `--stat`.  This option should eventually=
 allow always to print the full path and filenames.

Greetings
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD
---
git 2.51.0
