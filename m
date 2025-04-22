Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82711EB1A1
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306357; cv=none; b=S86lX3etSYWuvFGJeR/ZGTrLIVAVo3Ql4IYwBarwD/dVRAn+XKfA9AUHmRwMJf1vWv6yosD8bVlLgUSq6KIpp+xs3yBhA1XlxtzDhxvubPmdCgO1jzDi1nDFHCs84isBEjNg/kBJInwr4FSEII8b2orlRwZynHHROKpOQeAeTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306357; c=relaxed/simple;
	bh=ie/X7C8HhFAcZEHYTvt2ihLdFjkTn8bPACZnDq4DqC4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XTeaN+RXs4mRRpi5BBzi7lt1pB4/y1TSvF6cnXgwplGcPdrnqy2VVL+Tc9MpXeRAFtRR4LoZxkDQNJ5CjpXsfg4nLInxYOZdEJ4IXLE5eVLlwUryxpfHaOV7YND2l80sdLLOgnI/dYb2X1W05FkN6zbvdcscAkJxa6xFtMyuzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtL9Aux6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtL9Aux6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so38145965e9.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745306354; x=1745911154; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBjynJJWtegI8EunYzI1yjE1cBqzWwJ+dC788nkXEKI=;
        b=MtL9Aux6csIUy6ISCI4gUURkpMNYzmcCtqPFAKRBxle5XQUW7n80xxeojt1IbPKFvb
         8we0s2FKn+O1AKojzaRXrYZYKNbLC5ehz3JhLTAT/D3eH6SPPJLyPlNZ8yIYqWtKaR2L
         ZUT4dQlgLS3Gqt3R8IiDoIYVWqLFtfkb2BkDG/d73TTKSp8IeXccnVQb6OouLgZNvA2m
         3h6DR73xYTuIbgwS1FWjLaNRlxJDmS2EaHVqyFPwLU3G8vZmlMXpMK32/B3/u6VYPOEM
         TZ1mQd+bmKIXJrM+/Jw1SlOFI/5bfOW0wB05Wb+ZSmQ42PxrPCOCLInKgiWnPhqTWEE9
         tnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745306354; x=1745911154;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBjynJJWtegI8EunYzI1yjE1cBqzWwJ+dC788nkXEKI=;
        b=AocDSlUn0a7ly8uvg9L981++TOov2X1zhRzMfPwD/PlMD1WSI3rHKhKPf1SMXtQrUH
         YP2Cp8KUotaqAvF8gbH8L20HcZe+bbU1yTpyC/a85CkPZiu+/Lu5dC045E+ma7h8gRHS
         JO6A4/FGVfcsKIbEm+IRu4UzZlOuOhb974JcRH3W7SRd6a1ImBRUOQo1pUlfQoh8o+dq
         E9XJDBDLaYLeSH5xJ3PqZTio+VFzqc/PXV7Rm2i7zLI3/INv+OdelXGofyKWO23rJxwM
         wEYhJXs70DZ55Z3vsJUr4BN8mEJCnfpQHJ6jYhN/Ek0NbR/JyuS2PF0hrNS4tQiUnwG3
         +s+A==
X-Gm-Message-State: AOJu0YyEmM5XR1Vhy/2g1oAYI4voeDpZr7EYd7yPI2HPCFa3/achGQPw
	2+lviNKnBAedwO7UDW3gbZuI1gZK8MHRssdud5nt5GnntrKZpyY3sTbq8w==
X-Gm-Gg: ASbGnctIoa1MCdSKtEgWeTIuZ0TgDkUR0gTBhoYt7tS3qXkUdAkdfkMy1zuqBnlQFgv
	OE4WkxePcjVkndFAEpN/8iq9qE6HjD6dLww963fPZXypCnB73cgVqjn7Ib4rhqZL93SVl32TRvk
	f76ojirI6rnuCkur9Iarfgv4zXwb7rPWcgAS6eglnYWS9CiciAwmscFszXzYa3s0mxIy5KBT9Ji
	xGXnSU7oVyn8YH/CZpojWRwnuTKapdHOyvPb1mIIHC2Oy71EuZzt4HsJ0CvBsPoJUpV1w0GVdSB
	ZH1UaL0oAOcz7nkoHVWmiDT+HrP/lsfZW2xNEZLNfQ==
X-Google-Smtp-Source: AGHT+IG8iLVeUOdWo5qg2Z977ATqZq1J6wpmd8eSzUxowruWrnjvtqR/qDLK7foWoU0CVAc3vu+j9g==
X-Received: by 2002:a05:600c:1990:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-4406ac3d219mr134024215e9.31.1745306353379;
        Tue, 22 Apr 2025 00:19:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5ccd38sm160166665e9.28.2025.04.22.00.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 00:19:12 -0700 (PDT)
Message-Id: <3165055f209c50372dcf6829f04e05378e100d02.1745306351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.git.1745306351.gitgitgadget@gmail.com>
References: <pull.1949.git.git.1745306351.gitgitgadget@gmail.com>
From: "Julian Swagemakers via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Apr 2025 07:19:09 +0000
Subject: [PATCH 1/2] send-email: implement SMTP bearer authentication
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    Julian Swagemakers <julian@swagemakers.org>,
    sandals@crustytoothpaste.net,
    Shengyu Qu <wiagn233@outlook.com>,
    Aditya Garg <gargaditya08@live.com>,
    Julian Swagemakers <julian@swagemakers.org>

From: Julian Swagemakers <julian@swagemakers.org>

Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
This is necessary since they are currently not supported by the Perls
Authen::SASL module.

The bearer token needs to be passed in as the password. This can be done
with git-credential-oauth[0] after minor modifications[1]. Which will
allow using git send-email with Gmail and oauth2 authentication:

    [credential]
        helper = cache --timeout 7200    # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.gmail.com
        smtpUser = example@gmail.com
        smtpServerPort = 587
        smtpauth = OAUTHBEARER

As well as Office 365 accounts:

    [credential]
        helper = cache --timeout 7200   # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.office365.com
        smtpUser = example@example.com
        smtpServerPort = 587
        smtpauth = XOAUTH2

[0] https://github.com/hickford/git-credential-oauth
[1] https://github.com/hickford/git-credential-oauth/issues/48

Tested-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc |  5 ++-
 git-send-email.perl               | 64 ++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42dd..1bf75c060d3 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -213,7 +213,10 @@ SMTP server and if it is supported by the utilized SASL library, the mechanism
 is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
 is specified, all mechanisms supported by the SASL library can be used. The
 special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+independently of `--smtp-user`. Specifying `OAUTHBEARER` or `XOAUTH2` will
+bypass SASL negotiation and force bearer authentication. In this case the
+bearer token must be provided with `--smtp-pass` or using a credential helper
+and `--smtp-encryption=tls` must be set.
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
diff --git a/git-send-email.perl b/git-send-email.perl
index 1f613fa979d..aa6aad596f2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1398,6 +1398,63 @@ sub smtp_host_string {
 	}
 }
 
+sub generate_oauthbearer_string {
+	# This will generate the oauthbearer string used for authentication.
+	#
+	# "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	#
+	# The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	# * gs2-cb-flag `n` -> client does not support CB
+	# * gs2-authzid `a=" {User} "`
+	#
+	# The second part are key value pairs containing host, port and auth as
+	# described in RFC7628.
+	#
+	# https://datatracker.ietf.org/doc/html/rfc5801
+	# https://datatracker.ietf.org/doc/html/rfc7628
+	my $username = shift;
+	my $token = shift;
+	return "n,a=$username,\001port=$smtp_server_port\001auth=Bearer $token\001\001";
+}
+
+sub generate_xoauth2_string {
+	# "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	# https://developers.google.com/gmail/imap/xoauth2-protocol#initial_client_response
+	my $username = shift;
+	my $token = shift;
+	return "user=$username\001auth=Bearer $token\001\001";
+}
+
+sub smtp_bearer_auth {
+	my $username = shift;
+	my $token = shift;
+	my $auth_string;
+	if ($smtp_encryption ne "tls") {
+		# As described in RFC7628 TLS is required and will be enforced
+		# at this point.
+		#
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3
+		die __("For $smtp_auth TLS is required.")
+	}
+	if ($smtp_auth eq "OAUTHBEARER") {
+		$auth_string = generate_oauthbearer_string($username, $token);
+	} elsif ($smtp_auth eq "XOAUTH2") {
+		$auth_string = generate_xoauth2_string($username, $token);
+	}
+	my $encoded_auth_string = MIME::Base64::encode($auth_string, "");
+	$smtp->command("AUTH $smtp_auth $encoded_auth_string\r\n");
+	use Net::Cmd qw(CMD_OK);
+	if ($smtp->response() == CMD_OK){
+		return 1;
+	} else {
+		# Send dummy request on authentication failure according to rfc7628.
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3.2.3
+		$smtp->command(MIME::Base64::encode("\001"));
+		$smtp->response();
+		return 0;
+	}
+}
+
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
@@ -1436,7 +1493,12 @@ sub smtp_auth_maybe {
 
 		# catch all SMTP auth error in a unified eval block
 		eval {
-			if ($smtp_auth) {
+			if (defined $smtp_auth && ($smtp_auth eq "OAUTHBEARER" || $smtp_auth eq "XOAUTH2")) {
+				# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
+				# manually authenticate for these types. The password field should
+				# contain the auth token at this point.
+				$result = smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
+			} elsif ($smtp_auth) {
 				my $sasl = Authen::SASL->new(
 					mechanism => $smtp_auth,
 					callback => {
-- 
gitgitgadget

