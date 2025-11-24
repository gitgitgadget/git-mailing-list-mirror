Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762526F467
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989495; cv=none; b=NZNoOOuMmGsEWEHZzy/LzPCu27U5eg274RNBwmWOdwMS5BN+nRmeWvHlsA2wdTxBAIZ2SbZf/7bdtJhm5GMYFxX7nhd+yn395WryHfhUqRNl7S9l3hzVVp+xgpDGslxiIvjyOfPrBPKxJNIB+P/ZVT2JQM/I2NVND3/6wM0ixj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989495; c=relaxed/simple;
	bh=Sy5bsq95vz2/MGm6VKidIE5EgWQdhC0CW8wDtAg3UHI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O+sNW+G1mNi58b2XEovJqXRp/GOrtwyGPXf/Ppz3zgR/5j4lTvNZMTShNAY7HGuI/T3SDF3OnsHBPPzfHRI9n6NbnYTX4Ye54dUzE6F1ZUd3qCKmx0t5BpH/y1KyAGKr9RSW8DAuPykjhqMR/kauke9bJiFtl9q+OoTlZ/plwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7fijznR; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7fijznR"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-657a6028fbbso576428eaf.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 05:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763989492; x=1764594292; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TBkK3JbNXvt34yJ5vJkEjHZgAk0FhKQGdEGlw2wpeHE=;
        b=M7fijznRL97v+Vs+2MirKaaIuFjpf5tmjYpQEZH291kZHvAaP/sSzJX2b7RIYx9gD3
         Ogebqeu9Ydr410HIXbK3inC7QwjxsbCC1HIZzCuCuNMyTUWW8iOARBarQhfqP31O4jvm
         OZId7UTQskb6NDXAsMt5yPa2RasrOrpphOuxbQK1aXnAx14E3v/3mjoNEiwzIUr67Atg
         NbPS5U/pzv9DK29NUGQlJha7WKYJts82+27TRJlAD1DheEuKDrXmiQ1EZjcEwM4eH4Li
         VpY8N09p5hR4kN3RGf7cFe3EeN3J9kHCP0EsuBuqeeah+jLzIiKDwEelt1xBV6lUzX8R
         /UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989492; x=1764594292;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBkK3JbNXvt34yJ5vJkEjHZgAk0FhKQGdEGlw2wpeHE=;
        b=phicZOllymxjCzDRmFMk35wdlOH7OKx3wAI2532T3/KetgQQ2xsL0jl6BPCcTXsHoU
         ijiEAFYyc5T7j8lvlpq00p+ND5n4L+2lWLmVkN/S0BJGRIKtRGfyDOUaHAGL2auFZsQS
         ZWVisdXWGZpNML5DG3a+gpiTdMtxKKQq1kxBkkv9OMVGF5SZOe9gekPFL0SHXBkbcb5O
         rWOCkrl74/3oDoDzNtmZ1wawEOX6OKzl6hILblRt4YWF7cpSYSdX0n+CkMGNBXc2GyMp
         oRmL4m0mUcYE7o4V72e8PP1ToLZH5RPIMq4hCQ/dqPnrZ5UDnAdhQePm2b/w306W3pP5
         TLcw==
X-Gm-Message-State: AOJu0YxB2DCxxGhf48nuHpgTv3c8oKZvTx3ukTa1iHFPmVguV4UAd0fC
	GGfhmrORiXQktbxSOraL6mMu2TpAzwKbPtjXaAhaZObJffMaehhov40NFWhL7tyf7eEm2afPKj7
	Djq0NzhFcDImTfH2XrsVGQTdEKtuzqhJHUoRU
X-Gm-Gg: ASbGncseBRnR6dMSkrV2NtXavTO8fHFHgt6WBxAR4qOhrYzaoflmClYYonAWmowxf2D
	Ww08Xm2MJct7EXeD1xeR8CQeSk0Buck5h4Bp2HkXrs7KzQmNvSksD/yYtkt8MhtK65T0DDfCFoX
	lw24RJVVZrUqsz394U//aDWoz1PvrWiloVQ2Rs1CEtfMtJAofm4ASYQniUwaNmmR4AWvn8ISmXU
	ih1bbzO49L9UfR8YFRzsE0NeQXzREyVnf4BNjqy2alt+rfAXY0R1okq8v7U+C3mk1toWqo=
X-Google-Smtp-Source: AGHT+IHeDVIcH5ojljF00CEEqfQm25e5p0ZihGhWq/uib33RL5BSyMqIYQ7q9Pc2hwDkPqKMdF4wgB/Oi7u6FS3yO+U=
X-Received: by 2002:a05:6820:2006:b0:656:9202:58ca with SMTP id
 006d021491bc7-65790b001damr4320875eaf.3.1763989492380; Mon, 24 Nov 2025
 05:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: windwiny <windwiny.ubt@gmail.com>
Date: Mon, 24 Nov 2025 21:04:25 +0800
X-Gm-Features: AWmQ_blRrS51f0mF7GyhfEQyZf_ezwgwjT9fLmyOmrGkRUm72IjXMPJp5wdDoVM
Message-ID: <CAJ_pojYchJyC4GgPGXnPV+DvVmsHYXycEWVF5GF-1pUEM1mbug@mail.gmail.com>
Subject: [BUG] `git instaweb` and `gitweb`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

 When i run `git instaweb` on a code dir, it generate .git/gitweb/ dir
and some .conf/.perl files,
and lighttpd+fastcgi read/exec those files  to serve git repo access via http.

 When dir name include `@` char ,then instaweb run ok, but gitweb.cgi
will get incorrect dir name.
 In Perl, the array variable @xx is interpolated (its value is
inserted into the string) inside a "" (double-quoted) string, but not
inside a '' (single-quoted) string.

 i write a simple patch can fix when dir include `@` char.

    --- git-instaweb.ori    Tue Sep 30 05:50:42 2025
    +++ git-instaweb        Mon Nov 24 20:53:13 2025
    @@ -716,10 +716,10 @@

     gitweb_conf() {
            cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
     #!/usr/bin/perl
    -our \$projectroot = "$(dirname "$fqgitdir")";
    -our \$git_temp = "$fqgitdir/gitweb/tmp";
    +our \$projectroot = '$(dirname "$fqgitdir")';
    +our \$git_temp = '$fqgitdir/gitweb/tmp';
     our \$projects_list = \$projectroot;

     \$feature{'remote_heads'}{'default'} = [1];
     EOF

Than fixed, those code still has bug:  if dir name include `'` or `"`,
 instaweb run failed.

OTHER,  the instaweb generated an .perl script, gitweb exec it to read
vars define,
this method may cause CVE security vulnerability issues.
Probably should replaced by .ini/.conf/.json
