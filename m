Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F4184E
	for <git@vger.kernel.org>; Sat, 25 May 2024 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600145; cv=none; b=GFKHTpjDhtkgPOmVDqF8sirLpgVClgg42vXvINh2jc0zYnRrguTDk8ESvCum/qhe++gfKpqZPOX0evWn81D0e+ty5eX4MUwPn+IJn8B/2Uo+ysIRW+Ls5vhFNcegiM2yaeqMhC7OlF0Ce0L50BKK2SbcKH1/OUxHb28PvLuWfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600145; c=relaxed/simple;
	bh=lmqbNgGMmABTQP5nSU3AMvzls+Vfe0MU4r19Mys/S7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfBTbMgge/ZzNv7i3ZUE2TgWAvg4W8rdF50O+nRNHCV8K2u/5DJzca9IeB17ENfszHZAawXeNloFu/u0tZW5hpk/CWvkBmd5pKj+COW9b6EdyVq4cwinNZ+4UoXyBAWYvojHZCXYRdX0KeXFC50Eri2TYJanXBPRTJXQoBrSq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDX0qYxu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDX0qYxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716600141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HA6j17gQrsO2y+zRbGT2fkxHEsbsSXgNNVrSzERTX+0=;
	b=jDX0qYxuRdMU6b5VETzE7FQHSLK7CbHmd27TJUgb7dj4GFeHFTTRPhtraTae23Es35eCeB
	x5ORLjB3xjK3JD81Yft5tSXrNRgIXJwetII+eP4XAKeyk8zDP1PfXgzsYbYfH69YzxIuj8
	D0/8nNeR4F+u2Fz7DaHrLO9NNqLfrbM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-ffHE5S3zMNqiukHkQvPiSQ-1; Fri, 24 May 2024 21:22:20 -0400
X-MC-Unique: ffHE5S3zMNqiukHkQvPiSQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43e0e94fa82so18206141cf.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 18:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600139; x=1717204939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA6j17gQrsO2y+zRbGT2fkxHEsbsSXgNNVrSzERTX+0=;
        b=HoN8rURUXc0Bcflu3NsRVBPyw/it7JIShKSAZH2rZV369XWOA3/SnRAewiAh/VmNId
         fRAWjzbrJEy68+bB3+rgd70R9/Qd3uQinxDj1F4BVqRYyWGt8yhhOa2bQRmkANvIdsTf
         pUjoBpHAUcJgOFmMGn1kJQ5uwqD5kqCKNv0Np8HUB81yd/YykCe3codszgBs5CN2m1jw
         NkrDh7YNiSl/Ax1YhgvrzqODslMYwBc0x0TgPM6qPC0daeVXnpTHc7CICnSd3eNiVtjc
         pzTGKjSoaMGcarFsVEAq7GZWUIIx5XTUHcXEnEmDGO45dWbhvRnmEZwlpzyedU1oXGAe
         vNPA==
X-Gm-Message-State: AOJu0YyczUlxx0v4qxSITsgty/Y/JbbakG1D1NALNgFv0WrySRYe0k9b
	MMT8jC2RC1WeAa6ZA7hvTZOsli2z2Ywk5pogs3FsqNTCd42uquRlCDrL4i0YfLVKCSfoQvB8ehX
	jTS8q/EPFS9iY9AfGDDWyqD5rWxIR+xe0keRg3s+YrQ2TMSzWU8prKSQ21rf2ELNy8NrIOfiPqN
	bW52SKiyPS8CBezF8EZHPj3rPi7xU5MaOAow==
X-Received: by 2002:a05:622a:111:b0:43a:ed56:4c86 with SMTP id d75a77b69052e-43fb0f252eemr44660321cf.56.1716600138748;
        Fri, 24 May 2024 18:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFurCTtcWYn9JNdC//5Fp9xiSLJlIFYBHID2vi7cYF8KlSGW2u5gwkhPOpMjKEM6059147Jow==
X-Received: by 2002:a05:622a:111:b0:43a:ed56:4c86 with SMTP id d75a77b69052e-43fb0f252eemr44660161cf.56.1716600138287;
        Fri, 24 May 2024 18:22:18 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b6a79sm13347841cf.13.2024.05.24.18.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 18:22:17 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v5 2/3] Documentation: alias: add notes on shell expansion
Date: Sat, 25 May 2024 11:20:51 +1000
Message-ID: <20240525012207.1415196-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525012207.1415196-1-iwienand@redhat.com>
References: <20240524073411.1355958-1-iwienand@redhat.com>
 <20240525012207.1415196-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing inline shell for shell-expansion aliases (i.e. prefixed
with "!"), there are some caveats around argument parsing to be aware
of.  This series of notes attempts to explain what is happening more
clearly.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 Documentation/config/alias.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 40851ef429..f32b86cde3 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -27,3 +27,31 @@ it will be treated as a shell command.  For example, defining
   repository, which may not necessarily be the current directory.
 * `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
   from the original current directory. See linkgit:git-rev-parse[1].
+* If the shell alias is the full path to a binary, it will be executed
+  directly with any arguments as positional arguments.
+* If the alias contains any white-space or reserved characters, it
+  will be considered an inline script and run as an argument to `sh
+  -c`.
+* When running as a script, if arguments are provided to the alias
+  call, Git makes them available to the process by appending "$@" to
+  the alias shell command.  This is not appended if arguments are not
+  provided.
+** For "simple" commands, such as calling a single binary
+  (e.g. `alias.myapp = !myapp --myflag1`) this will result in any
+  arguments becoming additional regular positional arguments to the
+  called binary, appended after any arguments specified in the aliased
+  command.
+** Care should be taken if your alias script has multiple commands
+   (e.g. in a pipeline), references argument variables, or is
+   otherwise not expecting the presence of the appended `"$@"`.  For
+   example: `alias.echo = "!echo $1"` when run as `git echo arg` will
+   actually execute `sh -c "echo $1 $@" "echo $1" "arg"` resulting in
+   output `arg arg`.  When writing such aliases, you should ensure
+   that the appended "$@" when arguments are present does not cause
+   syntax errors or unintended side-effects.
+** A convenient way to deal with this is to write your script
+   operations in an inline function that is then called with any
+   arguments from the command-line.  For example `alias.cmd = "!c() {
+   cmd $1 | cmd $2 ; }; c" will allow you to work with separate
+   arguments.
+** Setting `GIT_TRACE=1` can help debug the command being run.
-- 
2.45.1

