Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CF21C16D
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360050; cv=none; b=A7f6soh/xubNdFQcsHy4R+bPwaRQd4gorIhu0aLMHDl1jdvFTyEW/kXfADBxxfzDRrbofbo42mUq4MfFkPZVJWeSmkrg8EmujTQXJm2ENrOZjnx3Nz1htdmXcfHAA5zCgItqrlBrsW4BrWocMPgIP1OqIYVjoshQeSM13jRgqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360050; c=relaxed/simple;
	bh=eBF+gDjFwgJjnWtxmMi45NQ1K5TVb9D0TEtWXYqVJPg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bbAjzH70e+CYaJVmJr8WdVVIKie0gSXecv+BBnGUJEu/cRtjEr4hp7i+ganuVssxZ3JwmB2w5cEER5oRAX0CWqAFhnJPlrT/NQucQzgchAfgY3ubtaRVo+TRbCR6uv/oQ4CsdiuHRPCo9M0vGrCS3TjuE2fO7rmw6cvMuhyQrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJcAwi8t; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJcAwi8t"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbb12bea54so379148166b.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741360047; x=1741964847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ/Ey2m+cdHeStn1PjrkbGly9GZ2dI8UZ+HE60tdc04=;
        b=lJcAwi8t5TWlQZ/8lnhRh1El3BeAGBf4/oopfBBkt8nlWkqmGVD5X9nBs6xWtwXAyL
         2dZZIXM5MKZHo3fS8iK+84733A03eeHvN+c0B6uwfgVbn9h4y61pA5SwptiL04TyF9MI
         V+V5kuaVAsTcdPKqcw9IZ3Y6oqkyCSZgjGtBge0tTO7seEFCpOgeS3qy4mm2GTGKXbKi
         G8T8H+ct13wBi0x2R9zhD/qDo+t+Zvze04uSkVGPezox3vTUXB6jQoNYX9c03zvl5LqH
         JEDLfojNFg50GenqpHV8BdKv8kOaX3CsX6sQRUPX+SG4WaykTjd9VK640NcBk4ivw+Ah
         j5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360047; x=1741964847;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ/Ey2m+cdHeStn1PjrkbGly9GZ2dI8UZ+HE60tdc04=;
        b=B10vPvguxLoF7Zo/9nR6AkvA+Kw20fgUTWH6h4UFyL+tUnxDxo5Hz7DS/B+ZeyhBvF
         dUn4+Hwgjn7z1uVRYB0ixFZ6hGasxeca/oG5mThCF36n+v8UkydpyIc/yCxKvqJR2wlU
         o4g1es9nIgNT5DsNx/OdX9cVOuWtzP7/DYNuXv8qR7md9RZdEqVmCuUEijZ/9ziHkqql
         BEjTPn8rjGVfSajbNg6pscF6+JJu0LwryCdAMLEKNtj1A0jHgw7ytuhgRK4VHe8in/DB
         qVta41+gqRlYEg5TZ0MqSKJbWmT5Fa/DLNAlF2Z1eciMCY6fL3ltuXjqnmmC6jyMgOVU
         ycCA==
X-Forwarded-Encrypted: i=1; AJvYcCUhvF3jPRjwIQcMCmKJvow9eDAWBlPfeLT/XjM16cUxueEtafB8rPlxd1Tjw4i2Jc9ISCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF53CcXzbqE3zK49Hxq19KfAycdKZNSEL37r8YKvkXVVMsiI00
	InjRHnxP9EdJt25VglSQMIBf42r2ra0vIboQVs02/vuO81Q47pHj
X-Gm-Gg: ASbGncv8rAD+l2QqzTDk70G0ImRxi7sa4p77Gb8SKJqdytYME9dvyrfOOvNkhBhWr7o
	LfuRH80ODVZXXJkFPTRIjDO5gCgq8nBBWQGV+L8tLR4Ge63xx9nv6vzlsSjLcCx42X4f7KMS4Ef
	QN8srVwMPvG2AARUFTVCOv8TLaV3SRNwI7L4VtQ9OJtVa7slg4g/7PsUT/Y0l5Y0+ye/VlecPmu
	/5fucrzhnAQhsrsp+FOg+GWpomx39iGLASw5KWJQPMBMpreQb9Iqyx0MA/IdbfC2DMKvQHbbePe
	TnAe/32Zh0rHseG12khy68ciCK42KyFOf9tAkqfI+FWmYspjnlLGWv6EwVASZKEztdIIKhx3Uab
	4cwRXEzS6BF4SZgGeDM0Z5FI=
X-Google-Smtp-Source: AGHT+IE1JXtqBkFQ9uK/zzk6nGtFZ3I4JMQRtobg9Fi92IqEQe14wtILJa0BGyn+R2X+Y7v2IPzPDw==
X-Received: by 2002:a17:907:1b21:b0:ac1:e2e0:f8d6 with SMTP id a640c23a62f3a-ac2525f936amr377759466b.17.1741360046429;
        Fri, 07 Mar 2025 07:07:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399c9a79sm284486266b.162.2025.03.07.07.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:07:26 -0800 (PST)
Message-ID: <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
Date: Fri, 7 Mar 2025 15:07:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
Content-Language: en-US
In-Reply-To: <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/03/2025 10:32, Phillip Wood wrote:
> On 05/03/2025 15:53, Junio C Hamano wrote:
>> We correctly omit builtin/pack-objects.o from BUILTIN_OBJS, but
>> forgot to add "git pack-redundant" on the EXCLUDED_PROGRAMS list,
>> which made "make check-docs" target notice that the command has been
>> removed but still is documented.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   * The command is still listed in the resulting "git help git"
>>     output, as cmd-list.perl does not yet know which commands on the
>>     list are to be ignored under WITH_BREAKING_CHANGES.
> 
> Good catch. It seems the meson build was also forgotten in 68f51871df8 
> (builtin/pack-redundant: remove subcommand with breaking changes, 
> 2025-01-22) as we still compile builtin/pack-redundant.c and build the 
> documentation. We should probably wrap the function declaration for 
> cmd_pack_redundant() in builtin.h with "#ifndef WITH_BREAKING_CHANGES" 
> as well though I don't think that is urgent.

I just had a look at fixing the meson build but it seems to be tricky as
the manpage sources are stored in a meson dictionary and meson
dictionaries are immutable so I don't know how one is supposed to
conditionally add items.

I also noticed that while we store the correct value for
WITH_BREAKING_CHANGES in GIT-BUILD-OPTIONS it is not defined when
building the C sources and so we still build the pack-redundant builtin.

The diff below stops us from building pack-redundant with
-Dbreaking_changes=true but still builds the documentation. I don't intend
spending any more time one this

Best Wishes

Phillip

diff --git a/builtin.h b/builtin.h
index 89928ccf92f..8483975c191 100644
--- a/builtin.h
+++ b/builtin.h
@@ -197,7 +197,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix, struct repository *r
  int cmd_name_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
  int cmd_notes(int argc, const char **argv, const char *prefix, struct repository *repo);
  int cmd_pack_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
+#ifndef WITH_BREAKING_CHANGES
  int cmd_pack_redundant(int argc, const char **argv, const char *prefix, struct repository *repo);
+#endif
  int cmd_patch_id(int argc, const char **argv, const char *prefix, struct repository *repo);
  int cmd_prune(int argc, const char **argv, const char *prefix, struct repository *repo);
  int cmd_prune_packed(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/meson.build b/meson.build
index e86085b0a47..5c039fe525a 100644
--- a/meson.build
+++ b/meson.build
@@ -581,7 +581,6 @@ builtin_sources = [
    'builtin/name-rev.c',
    'builtin/notes.c',
    'builtin/pack-objects.c',
-  'builtin/pack-redundant.c',
    'builtin/pack-refs.c',
    'builtin/patch-id.c',
    'builtin/prune-packed.c',
@@ -632,6 +631,10 @@ builtin_sources = [
    'builtin/write-tree.c',
  ]
  
+if not get_option('breaking_changes')
+  builtin_sources += 'builtin/pack-redundant.c'
+endif
+
  builtin_sources += custom_target(
    output: 'config-list.h',
    command: [
@@ -674,6 +677,7 @@ build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_opt
  
  if get_option('breaking_changes')
    build_options_config.set('WITH_BREAKING_CHANGES', 'YesPlease')
+  add_project_arguments('-DWITH_BREAKING_CHANGES=YesPlease', language : 'c')
  else
    build_options_config.set('WITH_BREAKING_CHANGES', '')
  endif

