Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C802DE719
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777137; cv=none; b=eOlasNtgZ8yPo4LnUNi9N1PWdFxr79ax8HWBNkUclA3tKnTARdWdNJCniTX44H/RuLmTovgqwAj1RZDcVd2WD7v78xuRsIUYjJtMaAtlCARcL1/8ewl/pbn1AR65h0ESHLP/HZQljofIQnbE34Es7UM956sBo1Q8nswAdbixx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777137; c=relaxed/simple;
	bh=55DJASOpaSeo5tHatmGd/+jQ4xh4WwrvINnecJgKjKg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R6Iq+FQNjVFf3mBxZuE2wb8K4HFMp+2l2X22s+5aDPpO432SQ/T75r2cYQdL6GwveSsw21V57OoLg4XBEWRx7L/6Ad6B9XykD5w9jeaB8uGTyTva9sf9682dPnt51DL855sNvzmj8RU1UgnVr7yWr9iDYOY4hd0xGTkhsIQUsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXjoiFih; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXjoiFih"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28a5b8b12a1so52898445ad.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777135; x=1760381935; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGdIcmZns6U85XDYnW+k/aIiGwf4itNWqcFr9Jns37k=;
        b=VXjoiFihID7M87nvZoS/yP94juSFa7S2lQPNBX2AUsDIZCRArep/fvw+15PBNntAxd
         dplAZr24CoHPhSauNWLPAcISXK9OWQPsj/5dHCvLl0yBDTmLxFiVIzxwOS8VPX25Vr8J
         VADW2c76zRTOULSR/muX4O54cH5EAuQDZzJawl7SYy5YZU9/OK3C/6QJEnkHiGJj9mm/
         Kk8fktvY7SAThfl7bpHwbbCrhc62FUpnSFWAOPKPtlz+iAl2MOha0nFGWAOuF6ZvhFzE
         MdEdoVIlprQZsVy5Cq57WcOakQhKCIsmPP2z2oDdCJbJe386nsyJjLlWTNHwdOTFtJBX
         bIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777135; x=1760381935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGdIcmZns6U85XDYnW+k/aIiGwf4itNWqcFr9Jns37k=;
        b=eE/5afd3t2fV4G/6l5vbPjp3lkuL4aVrDrHjM4mwDxGbl39d3f7kDZon6zWVYJrrk8
         7RcRE5R7e11MsDT6GUnMtYKc7Ud+J5nRiwJPLpRjrDaFEV4GB9qEHoNG/CO+4zJVSy0j
         bMEzQamGLsIVzcp3K73cXNtTKbSaj5hPjzODK4VhBCHo/qwQS4QK7jUWH3kBS5kfvhBq
         XbYrlPZF0RDqbe5/LR0MrmItt9KJTYgYeNPhdRppPjeyEl4O0kf3E4zndGf/QIWBiax0
         yI53VF6jfa2oEhTykUU2HcnkP95nj2LiZ8vg9Gy/GnyK25hDLLoIfMsf+oZ15svoxoSm
         fbqw==
X-Gm-Message-State: AOJu0YxAK401wUSORzPFhqKSk7GDr2RyaDt5cfcly6vS6/vzRRthW7fG
	8gyMxxYfLee5Cupg+S1hGfOM9B6lci4C9UsSVOsH1WqRFPSbAs7HpWdxQlPYPy64
X-Gm-Gg: ASbGncvD5psUzYHSM+7M9EMWSH5VFKPuNvp54ZytV4/sbOgS8yOP5ZYhUTDGlPgWvsI
	LbPGkJwfrAcJgY/Ox7ZeXfoKdY1Pg243qOa7C79MxPhJ4SqDNWqIqrsuJL4oefTtvSoS0pIPzqU
	feB7O/XuttAXEKeueo9s6I/sU0goyb564q9bu3eamwf84IPEP8AGZwRSQAMCFCt+uFVvz/YT3pf
	Z64nijmHFE2y8UGe+xxJAvY38zASJUHIln0w3eVphMq+u38kIZ7rPGCepAR85Xb7Zh4/bA8gk0P
	8pb/sXIZGcygZRA/N8VSltY+0RlKQNDL5e2EbZ4Rx0bBHFBTZkI2ChfPMMg1OCAMqXOxcnhlTI0
	TTVxRE+9PmcpOkA6RVosalIrZZh4mXBhqs9+w34+x+6mbHINdWw==
X-Google-Smtp-Source: AGHT+IEseeNhjmBs7ALY86c31uZgrJTW6VTaFeVVU56aS+hxxvjf5KZ3y1VzqxCxgxcVxvs7uPTfew==
X-Received: by 2002:a17:902:ebc5:b0:275:c1e7:c7e with SMTP id d9443c01a7336-28e9a5133d1mr136034005ad.4.1759777135130;
        Mon, 06 Oct 2025 11:58:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d564csm139569955ad.98.2025.10.06.11.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:58:54 -0700 (PDT)
Message-Id: <4811ce1c8621babcdfe12510fc581a28863bfb95.1759777131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 18:58:47 +0000
Subject: [PATCH v5 1/5] doc: git-push: clarify intro
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback, 5 users are unsure what "ref" and/or "objects" means
in this context. 3 users said they don't know what "complete the refs"
means.

Many users also commented that receive hooks do not seem like the most
important thing to know about `git push`, and that this information
should not be the second sentence in the man page.

Use more familiar language to make it more accessible to users who do
not know what a "ref" is and move the "hooks" comment to the end.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d6..25d972f248 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -19,12 +19,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Updates remote refs using local refs, while sending objects
-necessary to complete the given refs.
-
-You can make interesting things happen to a repository
-every time you push into it, by setting up 'hooks' there.  See
-documentation for linkgit:git-receive-pack[1].
+Updates one or more branches, tags, or other references in a remote
+repository from your local repository, and sends all necessary data
+that isn't already on the remote.
 
 When the command line does not specify where to push with the
 `<repository>` argument, `branch.*.remote` configuration for the
@@ -44,6 +41,10 @@ corresponding upstream branch, but as a safety measure, the push is
 aborted if the upstream branch does not have the same name as the
 local one.
 
+You can make interesting things happen to a repository
+every time you push into it, by setting up 'hooks' there.  See
+documentation for linkgit:git-receive-pack[1].
+
 
 OPTIONS[[OPTIONS]]
 ------------------
-- 
gitgitgadget

