Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AF2BAF7
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054969; cv=none; b=htP1fJ7uMXQuma/oK3343D5liFizrl3ENXSpuEUvuc+lLVbILWLnbw7y7XmW7/HzRo0Rvpb77FRhZuIpRzR2wiXWFT27jNKnTexoJ3CPQb2tdsy5f9zQl4WcPA+ilFdlhoU8QEE4F0kGH2+8OuZQo7feUrInrRzvMTmfAMiy840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054969; c=relaxed/simple;
	bh=AvkxHUY9rP9WT19jHFeCOmbg0dy4D3SREr7Mu6GA5qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqBpVEa2GA3VfRp6xYM58cDEM0bWfB3JBDmWg0TT29l+F3lrnzSaZtDzOqVxwL01LrMtS9Jwii5rIpubwxoKe96JAqaln8nJCAzzzmj1+4M6U6t4H/Iz+AOzyXt6gYrOW0r0ggD7rLe8qLI0Qm+RRDRu/4asQpslbcbbiUIj8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQuAST4n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQuAST4n"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso29618395e9.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747054966; x=1747659766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t1KLTlOynAEzdOVFCRHQY4UCHklVLO5IV+1TTcu49fE=;
        b=WQuAST4nhFlfRMgmCDvBwJOVmxEhhKZB1KJW9pX2XVLrWP9EPnEx1edACPvFgUpnlh
         q0cQNnrImPf8YVBDCGf54eBYO8a4JU6gP+tgvxhJMQT8yMfOMnNzAglNPy/ssQ6MH6no
         4XmVLhlSq8c5X34Mya9w71NCzA6DtkcXDnB47MHbONQrFMdnPAjASMBA+vhQ89uRMQM4
         T4D8RIGfz1SFORXzlkoIWhp4es2sYW1xCFqy+AqA2QqxW91twMmTKGrpEvHGxmKeFaqU
         r2ynVj0eYVpArIcSlYlMkUn5wQeIW/wPBIvBHkgmrP7y/kF9yP7RCaj+myl5zI8JETZZ
         Pi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747054966; x=1747659766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1KLTlOynAEzdOVFCRHQY4UCHklVLO5IV+1TTcu49fE=;
        b=BfUtcWxlsD9zBhmPby1umWxgKRjuPFUr1tKaeYv2kiKBOLNkQjcCe+Du78DjAbpSEq
         kwZx2r0aBhk3fNyGIwiW9iUb70z0uKJYHnNQLAx7yRFTJXBZguZYcBNxyHnc99KsQCrq
         HhC3MeI0q2zmCwconoJa4/64+DgS37xv4RkD7sAc/3ID8CC6cep6mlrJZVHT3QFrLhFu
         uFEPrh3HBVYUB6XGqTLDoITRWOGrLZRRkKuGS6KIdsVvOldeRH3TEsnqpsz3agh0uuQS
         eDQTmhbaEDlxVbon5fvFCKplZDm6s3UOEts+Xqd2iLdLNZI7pxlALR+4yvNELo3bQISJ
         Tbpg==
X-Gm-Message-State: AOJu0Yy34wayFqQuPSIrU+Kfs4FaQUX1QXDn0DKliM+rvMlMTot+G6YW
	Gz8gf8vueMkzmyqYxpHq/Zq0CG81alDc4a8GSDvviZIiRPmxuWSC
X-Gm-Gg: ASbGncvNIKowZsWC9+qM7uHEJFWxJxO6Tg1BOVPWrziTvzNnU9gyowxUA0w/YYIRUxU
	V+tB4jOMHHE9Vf0gm3RnV8VksJXnwur1ckRfxk8ixJOcD3Q43LHXFF3JXcNmybVzg90LO+kcBJ3
	Hjv+Vg+P+yxUG8Bz0SvzDaJ8EoKEUHw1rL+M7PaGk8RY+eFybqGwvidBes3s9T6hBKMjtybObfl
	ix3g65iR6aqZZm4OBV0Fieg/jU7ITus+FBtIYb4ko6I4nHr09P2TVv+GodJ7XN28ZBBDJZibVWX
	IKInGMRK6OH7U5bh+tZSiZlP0nT/JCFPVek49+HyACv+m1brhDwwikUOy2i1pmnMlmkAhRZ67kj
	ng49GsooNfp/llfbC83pxtdhPjwA=
X-Google-Smtp-Source: AGHT+IHULxr36VYrLrbbVmaYEhGBKZ+ESNVGBN6s4lx3ijWHHbPd6ix6IykNm0pZuNv0/70e5zfiiA==
X-Received: by 2002:a05:600c:a089:b0:43c:e9d0:9ee5 with SMTP id 5b1f17b1804b1-442d6d6ad82mr113431385e9.18.1747054965057;
        Mon, 12 May 2025 06:02:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd328f0fsm172767815e9.7.2025.05.12.06.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:02:44 -0700 (PDT)
Message-ID: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
Date: Mon, 12 May 2025 14:02:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 04/11] contrib: remove "thunderbird-patch-inline"
To: Collin Funk <collin.funk1@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>,
 Todd Zullinger <tmz@pobox.com>
References: <87jz6mo4n9.fsf@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87jz6mo4n9.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Collin

On 12/05/2025 05:05, Collin Funk wrote:
> Hi,
> 
> You said:
> 
>> The "thunderbird-patch-inline" directory in "contrib/" contains a script
>> to send patch files via Thunderbird. This script depends on the
>> ExternalEditor extension [1], which seems to be effectively unmaintained
>> with the last update being in 2008. While the extension has eventually
>> been maintained in [2], that fork hasn't received any updates since
>> 2020, either.
>>
>> In addition, the script itself hasn't really seen a lot of maintenance
>> outside of a couple of global cleanups. It is quite unlikely that this
>> setup still works, and if it did it's even less likely that somebody
>> uses this script.
> 
> FWIW, in case it helps any Thunderbird users, there is External Editor
> Revived which seems to work pretty well when I used Thunderbird [1].

Thanks for pointing that out. I noticed that extensional the other day
but had not got around to posting it.

> I think this script would be irrelevant with that extension though.

Users who want to post patches using thunderbird would still benefit
from the script. It needs tweaking to account for a different
separator between the headers and message body though. The patch below
does that.

Best Wishes

Phillip

---- >8 ----
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] contrib: update thunderbird-patch-inline

This script uses an extension to run an external editor from
thunderbird that is no-longer maintained. Replace it with a different
extension that is maintained[1]. The new extension uses a different
separator between the mail headers and message body so update the
script to accommodate that.

Signed-Off-By: Phillip Wood <phillip.wood@dunelm.org.uk>

[1] https://github.com/Frederick888/external-editor-revived
---

diff --git a/contrib/thunderbird-patch-inline/README b/contrib/thunderbird-patch-inline/README
index 000147bbe4a..aa00b379a60 100644
--- a/contrib/thunderbird-patch-inline/README
+++ b/contrib/thunderbird-patch-inline/README
@@ -1,6 +1,6 @@
-appp.sh is a script that is supposed to be used together with ExternalEditor
-for Mozilla Thunderbird. It will let you include patches inline in e-mails
-in an easy way.
+appp.sh is a script that is supposed to be used together with
+ExternalEditorRevived for Mozilla Thunderbird. It will let you include
+patches inline in e-mails in an easy way.
  
  Usage:
  - Generate the patch with git format-patch.
@@ -14,7 +14,7 @@ will be moved to the section between the --- and the diffstat.
  
  All S-O-B:s and Cc:s in the patch will be added to the CC list.
  
-To set it up, just install External Editor and tell it to use appp.sh as the
-editor.
+To set it up, just install External Editor Revived and tell it to use
+appp.sh as the editor.
  
  Zenity is a required dependency.
diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index fdcc9483520..72c37aace4e 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -1,10 +1,12 @@
  #!/bin/sh
  # Copyright 2008 Lukas Sandström <luksan@gmail.com>
  #
-# AppendPatch - A script to be used together with ExternalEditor
+# AppendPatch - A script to be used together with ExternalEditorRevived
  # for Mozilla Thunderbird to properly include patches inline in e-mails.
  
-# ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
+# ExternalEditorRevived extension can be installed using the Add-ons
+# manager in thunderbird, the source is available at
+# https://github.com/Frederick888/external-editor-revived
  
  CONFFILE=~/.appprc
  
@@ -25,8 +27,12 @@ fi
  
  cd - > /dev/null
  
+# The headers are separated from the message body by a blanks
+# line. However the message uses CR LF line ending so on platforms
+# where the native line ending is LF we see a line with a single CR.
+SEP="$(printf '^\r\\{0,1\\}$')"
  SUBJECT=$(sed -n -e '/^Subject: /p' "${PATCH}")
-HEADERS=$(sed -e '/^'"${SEP}"'$/,$d' $1)
+HEADERS=$(sed -e "/${SEP}/"',$d' $1)
  BODY=$(sed -e "1,/${SEP}/d" $1)
  CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
  DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
@@ -37,7 +43,7 @@ CCS=$(printf '%s\n%s\n' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp
  echo "$SUBJECT" > $1
  echo "Cc: $CCS" >> $1
  echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
-echo "$SEP" >> $1
+echo >> $1
  
  echo "$CMT_MSG" >> $1
  echo "---" >> $1
