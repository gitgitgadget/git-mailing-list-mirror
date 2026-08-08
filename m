Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA451A6828
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147350; cv=none; b=F9/82cigsQ2mDjjC/twSaTGNM72EaycsuqeO2KS9DN6BktjGVdRro+/7YISD19qCgGAGPufDWWKlwfpQPQiyr8fSP3K1tI3Xu1pe1XqjPygkQ53FzOYbC264TULCJIMTP4zutAMZPAGkLHErntm5kn76wvm1Ze7hiIGpbXt2l/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147350; c=relaxed/simple;
	bh=K8XOJkZSzjvabQ6MRE93mjtDBV18J+j5Gr+c5gcQsuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7fyX8QgK/dYrLPb7h+Zu6U3qXIYe5PFruuFQjxY56QbeS3B8VL+CLhPqPFgd5yGPAlcKpK+b9kstsUrw7lmpQ+n8hCPevnTSMSg5GnpFdhZIyCM3THwgff2fszMlEHBgYnqOAj2QMdniKGUYw/DyMuS82hxLaSHw0BN4AQ4I7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeIJVJlF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeIJVJlF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso331775e9.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147347; x=1786752147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mic+BZ/lHpba0n8+ezmJi2UhTPtOazVDBYwqXvXGDCE=;
        b=jeIJVJlFekk1JfqKNPFco6cvvC5MUmjjpu+7DDbaMzXT3JUyOCxMTi2NvXIKL+mnmc
         vlyQuk52QGGKKjN6LKRRYrv2GKAOeDFI/uTK/I6IO/FhIfjTz6qEkiNf1L83LTt8wJ/S
         Cx1bNtR1X9yJbmDrRFxiEDPtcfR5EAR9oVi94t5rmO3VTKFLMS9JbTgqAQdq7KhHOWP3
         TE9ceqr5Vrjs+jNcA3owWlIXKl2FbfEcw9bNqaesL1+jyPR6E/uOHV0gvb6k6FPLM1sv
         D4BwhsJfMc2lx8Rfe+o0zR6GEBXCLLcXV/34QEV3y9kvXxxwRXX/LuTf9te6jwTsgxiy
         2hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147347; x=1786752147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mic+BZ/lHpba0n8+ezmJi2UhTPtOazVDBYwqXvXGDCE=;
        b=brxHBI+m8jNpg9Wk/iei73Lhsyp51JViJCWQ3ytOA+syIC4VEP1Inj1fLUBjq4anS8
         1AAXH9gprtkNSBq5DWtRvdJz+DUskfx2L9m46QTT0WNJbv7lmL02n4debWj9WNFwEL0b
         3af61k3Ruf6OpHczeUqrdKbbawcHOxKDihdvrus5JRYnZq3RgvEokLaHeMUZV/BBBDc5
         pSHQqXILQSdRj42fG0qmUnphiLKfT/LO8EqzpgM5p8LnzKra97TlGqi2FxfMTqgRq2rs
         IpCRdp1Nej7HrEm1moOdfiJkLxO+guNiRAiCWQA849MoQMsCcNtRP5aeYOC+y0xOwC+Y
         tkFA==
X-Gm-Message-State: AOJu0YxDON2vklbvtLvUVKRUb1aBe2Y9Ym+MxeCpBqeikZPEUs0VYggl
	BGtJxJnrhE6b6r+Up5zJT5eR98dJw9jj1LZtAqf1lbmZF8O6hRV7KAOz
X-Gm-Gg: AR+sD13bGWPbizCd+TBjZX061GOMX9Sld94C+xXUM24pihQwoxpT1QUtJQ6ZmCSmFbK
	XZOU++rr+JQ9kc+hFogtaJdanGD/3LQkBkYjk9PJK4TBWNHdYtfUkRRR96g1ThzYnyFMIK0wO6D
	YG0ELggBT/oTByUlj3UgxfKM955kWXBXnG7wIAShaqk3XARzEuq2O9+ze226TGHVrOWeiQC0qeF
	xrS/lbXuHVozmI1RXjE7Y6Sod6BQAKH4xISblUBpk4Qo+uM+66hZhTL4UmGfxjeuKl/dk/BwFDT
	gbMFQgZUWGX9pccn0tK92iYjkXyc8uvrrb7J1Z7WlhIfptdH/wYy9QikchWXyzwxa67mBOtYY/3
	ulRGvjA/sh0Oeu2zKMqjQB9tiWhr5+RQkQZpqRp+R6oXIDMZtG02qoMDzvbAp5ZeDk9IQGl5eQG
	j51vrHZ957xrSlPSOQ+shn4teZ8NvdqfkZfmb4d6423pwWqxP8HmxOGUsTNjw0Ror8IyqwiobDi
	FgyJo1lDC31RT9Khk/IQQ5j4Z2TE4hLZIXGBlgvngoziRF1QZm79p247kh2WpL1oVgGD5WIhsoG
	bGIVat9WjKGd2bGMZsFiJoXlxaQtVPejEq81ZFifmLRUEvjtzr/B0nUJSVrzmovqqn29NgcVOP1
	K041FYVYflg+LdfdDPCB7W/rpkbYZkclEpeTxp3nLCZI1TcbztjDFW1yj699DodSi1uWz
X-Received: by 2002:a05:600c:4595:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4994e79e377mr254049335e9.8.1786147346592;
        Fri, 07 Aug 2026 17:02:26 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:25 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:17 +0200
Subject: [PATCH GSoC v6 02/10] fetch-object-info: detect malformed server
 responses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-2-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The loop reading the object-info response stops as soon as the reader
returns something other than PACKET_READ_NORMAL, or once it has read as
many lines as we requested. Neither end is checked.

A server that answers with fewer objects leaves the end of the result
arrays empty, and the caller trusts that every requested object was
filled in. A server that answers with more leaves the extra packets
unread. On stateless transports check_stateless_delimiter() notices, but
on the others it passes unnoticed.

Check both limits by extracting the packet_reader_read() from the loop
condition, so the loop no longer consumes the last packet (flush). If
while looping the read is different from a PACKET_READ_NORMAL, die()
meaning there are fewer objects than expected. After iterating, we only
expect a flush, so if the last packet is not a flush, die().

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index ba7e179c44..287f668a3c 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -106,12 +106,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		}
 	}
 
-	for (size_t i = 0;
-	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
-	     i < args->oids->nr;
-	     i++) {
+	for (size_t i = 0; i < args->oids->nr; i++) {
 		struct string_list object_info_values = STRING_LIST_INIT_DUP;
 
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
+			    (uintmax_t)args->oids->nr, (uintmax_t)i);
+
 		string_list_split(&object_info_values, reader->line, " ", -1);
 
 		if (strcmp(object_info_values.items[0].string,
@@ -150,6 +151,11 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 
 		string_list_clear(&object_info_values, 0);
 	}
+
+	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
+		die(_("object-info: expected flush after %" PRIuMAX " objects"),
+		    (uintmax_t)args->oids->nr);
+
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
 
 	return 0;

-- 
2.54.0

