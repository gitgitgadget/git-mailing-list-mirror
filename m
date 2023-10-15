Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6E15D4
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="Pog3p7hg"
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84413C9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:42:57 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c4c594c0eeso2285732a34.0
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697341376; x=1697946176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OzSw35lGOSSnhYxtGRzIocaNUTl+7XwBXC0NaLRCBs=;
        b=Pog3p7hgaquKdduCmm3lcItDgms9a3uFerCpz3z7Jamw/Tsu7mhoidzoZGMYaLPHh2
         6qCnKjJSZQAWLpYD5mKLg9NBTGZb+CffTrXeGR2dZXJonzU+bJmCQyP9PfX6i+hz6gF6
         xu9TlHY8r9FAKLwBtqZhy2lfZ4A62+uEaQ5i9o6acQByl0l8emGVOhFiVa6zVcBHkvev
         wCEfYT0KiwVLm+2mE4jaFSuGcEuvjYIRycSNFRJVFxiAuBEZ1687Affcyfs4eVtcXVg+
         /2+COA5HuSbsnx6OgnsPIFIjERQ4uZkm4e/JoNVz0S4LiRK83aI5+wFdDQWvzgnEw9Jm
         UFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697341376; x=1697946176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OzSw35lGOSSnhYxtGRzIocaNUTl+7XwBXC0NaLRCBs=;
        b=ahmh327TVNxoHi6RJHB8qvIIQQsQ8fHgW8EGCmmB5CTiy5UDQl+YRhseQoZKvOn+P5
         wcdjkhP5+BIqqCX6wLXDfdfIqQUib3nvVKQXE37hocLikz68DbaM9vYACrGd5zomYV4/
         OFgbRXhrZcZH4LStiK0EmpdeURB30GD2fSRIv1biOLxo28r+UXVoweRIRcCrNIldasPi
         w6h+jjCGUbiebKW+cwJ6QJctXCObsDiOGpVPcQteiWS18JHX4NhfQ0S+Rhgr+eoE8XDd
         hFWJK5S2jAEfi3R0wUtpcfRU5e1017GT4U3smKE2cWi3Jm4OnsH7bdu6TCkpr3kUYCOt
         /qkA==
X-Gm-Message-State: AOJu0YwUwuPKuPcixsgm8ZJ+ZxRWWmeUiCZCb7Fcg68Ix9Rq3xm05iGO
	yR97pe9KzczqOZYB0YXGFpApcKOFn3+rslPLiTo=
X-Google-Smtp-Source: AGHT+IFSHYPueOGVIxzjKBhJ+P/oAi5aYipe2nEyo4kRO37fwAPJr0dK8ekLhuUYvVla2iL5bTRR6A==
X-Received: by 2002:a05:6870:d905:b0:1e9:f4e4:2882 with SMTP id gq5-20020a056870d90500b001e9f4e42882mr5898354oab.38.1697341376537;
        Sat, 14 Oct 2023 20:42:56 -0700 (PDT)
Received: from localhost.localdomain (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id bq10-20020a056a02044a00b0059ce3d1def5sm510777pgb.45.2023.10.14.20.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 20:42:56 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/3] bugreport: include +i in outfile suffix as needed
Date: Sat, 14 Oct 2023 20:42:34 -0700
Message-ID: <20231015034238.100675-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.298.gd89efca819.dirty
In-Reply-To: <20231014040101.8333-1-jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update git bugreport to allow creation of multiple bugreports with
default settings during a given minute interval.

Address several edge cases where users might run git bugreport multiple
times within a minute and expect multiple reports to be created.

Handle these cases by checking to see if a file with the default
timestamped filename already exists, and if so, appending a '+1' value
to the filename suffix. Keep doing so until a unique filename is reached
or '+9' is reached. At this point, if uniqueness is still not found,
the previous error that a file with the given name already exists.

If the --diagnose flag is supplied, apply the same '+i' incremented
filename suffix to the diagnostics zip file.

Reorder the code block that creates the diagnostics zip file so it isn't
created in the event the bugreport itself isn't created due to an error.

Jacob Stopak (3):
  bugreport: include +i in outfile suffix as needed
  bugreport: match diagnostics filename with report
  bugreport: don't create --diagnose zip w/o report

 builtin/bugreport.c | 54 ++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 18 deletions(-)


base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
-- 
2.42.0.298.gd89efca819.dirty

