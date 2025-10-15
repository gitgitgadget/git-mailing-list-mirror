Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086D30F55D
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567316; cv=none; b=r44CXmBN4AWm7VBDtGhX6YA9c4gQUI48xO7wza/vzbAMXRqvACfb5OW+o/mpOObgZNc4tGXeRiBZxdJSaySoRV6aOK/AFob5x+RdXq2YycVXbuqX0JgC7U2Pn3i3OxMYXYj9XxFd5UhtMD0T35LT+VmZ/ZgQ90xBZnfpJXdHbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567316; c=relaxed/simple;
	bh=YP3rAfH+1qmOy1vGy7eExVk+xfTkHN0rVk3XenkbIDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kATR3EkCXHclh+OQEpDKRfgLbPlr4EfZG5St7586TLYPeR7hhqdCcfv8I+TS3KXZhYSgjXPsSj27ONIQZ62fld5ADqIGkOAxWAQtH3Qk90hfa/p4Sd8zvj9xCIcG+reUHpZPyLaIwkp+65pS8hjeCy8ur4f7OBLjUwD0FfHkXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QsImbj6I; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QsImbj6I"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-635401a8f5aso111054d50.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567314; x=1761172114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2rii5GN6OHUVKNUEZI+PC3TKr2q4ijA2BuQWKINtOE=;
        b=QsImbj6IBQZJg70CFKWdI9krf09qkSCqu4h1MMfi/W00DIvgML6YQ9CiH3k1fbY2UH
         ++TjRumQCzFz3jBYvItV/j3a+zSkusf9sjy4rUl6Edb65rwgg8QynjxI2MEgbnCvds4W
         oC7SBREqkJR6jhqHAqLUzA/7xrOtNEgtcFJYPv0a2+dxMt78xlxW/K6msf2xPNpOYHPM
         Jjzzga00Me5BanHpMHsQ2MoZ+UwmqNWOpa5N+AJq0P1hie7aC4oGIJMiXkFxfX0NiPHf
         uIdQBXJaU8qAgnxlLlXD04brp0w7WIfA1BLsamzb2sfJLGITC0VPzbm+E9D/IsjSv9UV
         w1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567314; x=1761172114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2rii5GN6OHUVKNUEZI+PC3TKr2q4ijA2BuQWKINtOE=;
        b=o4fd2KjZAaQW0Fk9A8LU+dqm/f54/FitW1ef5IeTiOVcWMynX7cTEnd9gsmm6n8qE7
         fwimutdqNedYWzGtveE/r7C+MbEaN2+x2JIZ/nYTK2tTrFPpoFGa/KKAktlW/9LjODRx
         t/EN3yTPOR9eL4aVB3g9axLuVPbUerMFfMNs/jFOXSX4B91vY0nkNH6nQWByCDRYhxBG
         A9EHwSOTny5TxLbmp2FYpLlfRhVyxG15beyti9hHWSAfPFBCeIy1C8KChPfnIROcGQ4p
         Fb6660ack85QG9GZ2/9DvL/rvz6Xi7gXcwT7Tu+Af3lDZalrkd0fZCYGUrw/IW10zahS
         ki8Q==
X-Gm-Message-State: AOJu0YxvkB7pd4zzaJhjr6u+KfE7VLC/iz4fn0R16yMArSC9AjQ31gAV
	nyg89oAPzlVSAtWq086iPpMiGJG1/TMbe4+mN/cPIH4p/8j+kLUBxDES+yE75nP/ZmS36/vJR02
	MafT37izmhw==
X-Gm-Gg: ASbGnctMe+2s5blxjQR49IcAj0+5p3nzuFoJtENNV5Ro8wfC8UtDYlWGEbG1s59nFIC
	DM2IUKDZdLpfk1trgotwRG1l/t4DQCNoRzKg1kd9TdauSDETS8t/mEKZ8Qhbmw3rgZWsh6cKcR3
	OI2ZwXr/W6HjGXdfS3puWo2NyGS5tBO8bLeMT74bOA+1sDFguPeCtiJEjbWL36T/WoUMl3LARZp
	zX/LPdykb1spW/HMXJnmjnl/PD1QtYtSUg6KgZa0ktbRdOMkm27j4wvYQj5kAgMK5GnPdkseCzN
	YXEI/K4UNDiP4YXsINaOXfwkFcdZAmdZ1H0OIbLOxbRuDycwDFsIRKEGHNuT3jVOxWZsytfj2gH
	DRLWuqTrNwpPn2kdBI0sYk9J4L7+XCK4chU1iGrUluGfE70Y3VyCEWfrW/neDJKGqa7bHh9+SyJ
	ccHKtUf9euLzzlrmQnTMq29o5AtJNimrDpxqUEWy3gQ0RJtwVzrh3963BKSskHcgSzlhMQtBFt9
	9/a0WY=
X-Google-Smtp-Source: AGHT+IHAz5K3FArPLgqYhL2nIMoSWGzSpfLB9zcOZQphbBHH4znFuOZLzXHu0PC4psZ0XzO6oDgZXQ==
X-Received: by 2002:a53:c050:0:10b0:63d:24a3:28da with SMTP id 956f58d0204a3-63d24a32ecemr4772754d50.13.1760567314177;
        Wed, 15 Oct 2025 15:28:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828cdd2645sm2764237b3.12.2025.10.15.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 25/49] builtin/repack.c: pass "packtmp" to
 `repack_promisor_objects()`
Message-ID: <ca030322cf05a2c44463f94e9100e7163d8cdd67.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

In a similar spirit as previous commit(s), pass the "packtmp" variable
to "repack_promisor_objects()" as an explicit parameter of the function,
preparing us to move this function in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0e11c3b2c9..2c67111b33 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -136,7 +136,8 @@ static int write_oid(const struct object_id *oid,
 
 static void repack_promisor_objects(struct repository *repo,
 				    const struct pack_objects_args *args,
-				    struct string_list *names)
+				    struct string_list *names,
+				    const char *packtmp)
 {
 	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1199,7 +1200,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names);
+		repack_promisor_objects(repo, &po_args, &names, packtmp);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
-- 
2.51.0.540.ga7423965ad8

