Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A6374F5
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842950; cv=none; b=X4tudn8dmlrbA1gTwLlFtBtHz02FqMEJcE56l7OAu6ysCCHIJxcg17De0Ew5GK8KrLZFLQ+88rA1KIqBoYh5edi3EAgNLuljZqtHB2bBW+JqtuS1GInDWQp13mSxSLyCxFLMfeNg/MFq9UCjnzG87pGjDM7+uNBHryRKYVBlp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842950; c=relaxed/simple;
	bh=v0bApPGYbw+NFOFCDWm4cQGKQcPc1sX0kUteFAizM6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4EXGooDFB1k9n34YDModcm0pKR+sUo9ZTsFvi7gs1Ecy+01IeKMeSzoR1WCfkv+fjYc6OJdZAMN5Squ6rQtaRhkNttkLw+nd73o+SD6HhSJvXto+b1wRlVEfsIV8RKRvNNet049+UnIuwNwgnbRvhX6xeXeMjmbJo9G6xpoubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUWIIGvD; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUWIIGvD"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5997492d71cso596482eaf.2
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 05:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705842948; x=1706447748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CozsLbOmwkgZRdoKGjxxiV76kRVAqRlsUpx1KPOtBJg=;
        b=aUWIIGvDOpAnTnAPsBClCt2i6O9vA9strvKlYCty6tcQxOLE0GbkiRE7uBDk7KXjZW
         fnJXIWMEEyT+77rJaHOPf3RMmUR1AMiYT6DsrvDDYONVOa4Rqm9/PkXCikY3HKrETayA
         rHneoSwcXUiKvYqehGqjuy1aPCPxo8g3qVQewIxiCMwPu16c39TyK66KoF1LcpIwh6lx
         oj/QklUYYelZclPH9va6AJEzUYZEtw2huG/qXiADFNMlHyxdGudhY31GfCXmcuxXKQok
         CsAG0svFbLAV/lHz5HOGOx5Xy7vlsxY/Ugem7TTXKbx+OICCnUuTE2ieVEA9XRHxIxGD
         g3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705842948; x=1706447748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CozsLbOmwkgZRdoKGjxxiV76kRVAqRlsUpx1KPOtBJg=;
        b=kfPg+00+XMm6JnkkKeT9KaeW3PPaUanxVfshR3isCj0dq6IMQZEhmUei9VQIHEXOcG
         ddiA9WHsIJwQp652KiuFUsnaBQ3Bxp8AfyFctVRTTIEfJmeCeHS0IX/A61TZIMEztWBv
         QBMieh/n7/g7joSJb3mSwfd54JVLjqczrQUBNKRWRpNHGVOWG9aRGjGGPTdNCsaT3G9/
         qIfer9zEQxNg/1kngNqclTlebo9rB3TI46QploK5VZtnZt5rolhTvM/10nYHY8t9LEIS
         z6SpW1KAA9BRG0L0Z5kDKemvjOo8UYpwk0XtRyYXiwSGMXd0mGwKF/MdYBNw7hH576pO
         jhuA==
X-Gm-Message-State: AOJu0Yw2rj7Y79koLWNYIy7R8cpovPZT345LAvrXOSIjts0OvQfv8X1p
	TFB1MHMtYuQ8SWEtb8UwLBju1mx0qkmvgML0s+i2hkmyrmMyzhmgpM2PrNyp
X-Google-Smtp-Source: AGHT+IGurcpwvprokjVosSHnd2fujk+uQPCXHRlwkozemnnxClz7ZI+xD68HHy3q6+vXwTKkj1jYAA==
X-Received: by 2002:a05:6358:923:b0:176:4f39:406e with SMTP id r35-20020a056358092300b001764f39406emr379827rwi.54.1705842947673;
        Sun, 21 Jan 2024 05:15:47 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm6619005pgc.29.2024.01.21.05.15.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 05:15:47 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 6/6] transport-helper: call do_take_over() in process_connect
Date: Sun, 21 Jan 2024 21:15:38 +0800
Message-Id: <ed765da3433b372e75b7f44b925550fbf119d315.1705841443.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The existing pattern among all callers of process_connect() seems to be

        if (process_connect(...)) {
                do_take_over();
                ... dispatch to the underlying method ...
        }
        ... otherwise implement the fallback ...

where the return value from process_connect() is the return value of the
call it makes to process_connect_service().

Move the call of do_take_over() inside process_connect(), so that
calling the process_connect() function is more concise and will not
miss do_take_over().

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 91381be622..566f7473df 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -646,6 +646,7 @@ static int process_connect(struct transport *transport,
 	struct helper_data *data = transport->data;
 	const char *name;
 	const char *exec;
+	int ret;
 
 	name = for_push ? "git-receive-pack" : "git-upload-pack";
 	if (for_push)
@@ -653,7 +654,10 @@ static int process_connect(struct transport *transport,
 	else
 		exec = data->transport_options.uploadpack;
 
-	return process_connect_service(transport, name, exec);
+	ret = process_connect_service(transport, name, exec);
+	if (ret)
+		do_take_over(transport);
+	return ret;
 }
 
 static int connect_helper(struct transport *transport, const char *name,
@@ -685,10 +689,8 @@ static int fetch_refs(struct transport *transport,
 
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->fetch_refs(transport, nr_heads, to_fetch);
-	}
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
@@ -1145,10 +1147,8 @@ static int push_refs(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 
-	if (process_connect(transport, 1)) {
-		do_take_over(transport);
+	if (process_connect(transport, 1))
 		return transport->vtable->push_refs(transport, remote_refs, flags);
-	}
 
 	if (!remote_refs) {
 		fprintf(stderr,
@@ -1189,11 +1189,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 {
 	get_helper(transport);
 
-	if (process_connect(transport, for_push)) {
-		do_take_over(transport);
+	if (process_connect(transport, for_push))
 		return transport->vtable->get_refs_list(transport, for_push,
 							transport_options);
-	}
 
 	return get_refs_list_using_list(transport, for_push);
 }
@@ -1277,10 +1275,8 @@ static int get_bundle_uri(struct transport *transport)
 {
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->get_bundle_uri(transport);
-	}
 
 	return -1;
 }
-- 
2.43.0

