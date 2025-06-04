Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970728D8C8
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030106; cv=none; b=L2fnFP1TmqAwMC9VVUo/LI+70lb5G3At+pRH6dFz8CvV2tUb1T382Ixlb+OxmZwzYdXpqLDl8xaR1QBpACpgguivipwjwYvocK9AmKf13Ye1LuzEd2/+QURMlCLUnvetwlMXGG85uOBEbbleSgtxTaeXMqADHorQeVVOSu0og0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030106; c=relaxed/simple;
	bh=bFaALwSU0tNkKRHoN1/9i16h8Frz7r4PUCmab6m4psc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hmf75y+95zL3mGc13K+8IDdC0AmQ2Wu5vaz6twyShjXmsyKf8Svz6FfLS7Z4E95ER+40j4KpyOQMxdXjeM8MohAmzYIFjG85Bsnzp/KphgznECJbkzY5n45Y3fGytfHtesQCwwOXRqgAwBDeHPsOtiwTCxSs+tUGEdQWGek+T84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2wxNzBN; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2wxNzBN"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4c9cea30173so2086775137.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749030103; x=1749634903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2COHasYfW0boTG0fZ4pZGktf6toPcNklfjBTEozwXVo=;
        b=i2wxNzBN65qlyUulPWPJN+7u2PVusubPDO79OgUhLyaRXkZxy4liQaP//6s43W5ivP
         akVqItktHKiiIgWSMpJJ2mny2vEIEcCeIsfoT67hmdjvJP1PRMYXzeY4r5k2CivIdprW
         iV7Q8r4JAKFB3svp4NXtaftaRRJfP8Ieiwpw2fcdZrj7Seo3OseuzpU7916mKnmPs/Oj
         FwRPawWL2ItrIvUhi+tAjrR/UBKoWH30I5Qn+VElYwUkOWf6g8UHR+5VO4EJm/c1UXy4
         ITpF6//0LQear27VO0LVM0/KYjEWoSqr7O+tPPz8NLl/RQTpsIEwNtaCrVtYBLmzTrUi
         vnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030103; x=1749634903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2COHasYfW0boTG0fZ4pZGktf6toPcNklfjBTEozwXVo=;
        b=BFPoKinbvJt82sPbqx5os94XHzuJh0tgyHwSOSYJIEZIFUiFqIU7saUtTqKcW6w/Ia
         R+LJKiDXxhPrpKDhk0I3U55iA95e7GtFMMCIcH4IZaX/3uB5A6japv81Yf0aE94qOpNn
         EVrIRALpQVM8xSCNsaaV1sRY3KZ6r71ceMOrr6t9Xn1Lh40+jjDQki3DKxZe1hpCM30q
         hBDfeIarCm6zSVr4DPedrbz6/N2eZJ3tQM/zb2pS3pmtkM8o5BbFXI8163vT/7l50sX0
         lIrcaMFzxmpR34McOVZ8QVYUg4MeLaSXqSbyu2RY4iR3L/haEqyPdeQ2qBmAoKOK97UV
         wKWg==
X-Gm-Message-State: AOJu0YwMOTIxq24f/VslUIDwEGIBCfxtsFWZNPwjlzMr1oydnr2rP3bX
	Z9P7vFzPgNwna0OEBbdlHamBPqmIOhdEGqDMay8wBUZXVrwIkX8hxqDUDyeKtA==
X-Gm-Gg: ASbGncuBS3CT53OzoCuE0GMDv1KwEEFjsGBEGpOgOfN2ZVEUST9IDgFGifzWpqXev/v
	Gp7gXuD8DCIIt2udwbvhrYFu2kn9xDpn3dClbW3hW8l73jhETD6CXCGd0HpDU0yJjhICXPzmP5N
	pEX9S4YyWGVK3i+rTJAV/jgZPasWIoqkgqdw5eEBmLuYG7yLY5AxLzaWFClCYvQQyFedcfusjou
	amfVdi0uNmOuC1aI2vK+lZm7ddK5WQjjh8hP1BEWaqXysJxhZfht41Br5oHP8wE17RzZ9u6BO+q
	s6hD4DgdFKhQMhDfxay7sZKGLas1SSrV89aYOKcdyb1Hc/jiOvQ77QTM312IvQCzHDb81IdMnw=
	=
X-Google-Smtp-Source: AGHT+IEK5VCx0wmwESHnpVhvABJSfakdR1+zNNPe85/Ht//2rVJtwIX0mxic/5iVt/FxPO6XaxE2zA==
X-Received: by 2002:a05:6102:3e0c:b0:4e5:a67d:92a6 with SMTP id ada2fe7eead31-4e746e19a94mr910567137.14.1749030103065;
        Wed, 04 Jun 2025 02:41:43 -0700 (PDT)
Received: from dwmfdoom ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64e9f8d5asm9905473137.28.2025.06.04.02.41.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:41:42 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC PATCH 1/1] userdiff: add javascript diff driver
Date: Wed,  4 Jun 2025 06:35:46 -0300
Message-ID: <20250604094100.80598-2-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
In-Reply-To: <20250604094100.80598-1-derick.william.moraes@gmail.com>
References: <20250604094100.80598-1-derick.william.moraes@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a userdiff pattern for javascript, and 13 test cases for instances
of function declarations in javascript.

Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
---
 .../javascript-anonymous-function-assigned    |  4 +++
 t/t4018/javascript-arrow-function-assigned    |  4 +++
 t/t4018/javascript-arrow-function-assigned-2  |  1 +
 t/t4018/javascript-async-function             |  4 +++
 t/t4018/javascript-async-function-assigned    |  4 +++
 t/t4018/javascript-class-function             |  6 ++++
 t/t4018/javascript-function                   |  4 +++
 t/t4018/javascript-function-assigned          |  4 +++
 t/t4018/javascript-generator-function         |  5 ++++
 t/t4018/javascript-generator-function-2       |  5 ++++
 .../javascript-generator-function-assigned    |  5 ++++
 .../javascript-generator-function-assigned-2  |  5 ++++
 t/t4018/javascript-method-function            |  6 ++++
 userdiff.c                                    | 28 +++++++++++++++++++
 14 files changed, 85 insertions(+)
 create mode 100644 t/t4018/javascript-anonymous-function-assigned
 create mode 100644 t/t4018/javascript-arrow-function-assigned
 create mode 100644 t/t4018/javascript-arrow-function-assigned-2
 create mode 100644 t/t4018/javascript-async-function
 create mode 100644 t/t4018/javascript-async-function-assigned
 create mode 100644 t/t4018/javascript-class-function
 create mode 100644 t/t4018/javascript-function
 create mode 100644 t/t4018/javascript-function-assigned
 create mode 100644 t/t4018/javascript-generator-function
 create mode 100644 t/t4018/javascript-generator-function-2
 create mode 100644 t/t4018/javascript-generator-function-assigned
 create mode 100644 t/t4018/javascript-generator-function-assigned-2
 create mode 100644 t/t4018/javascript-method-function

diff --git a/t/t4018/javascript-anonymous-function-assigned b/t/t4018/javascript-anonymous-function-assigned
new file mode 100644
index 0000000000..d3c1728dd8
--- /dev/null
+++ b/t/t4018/javascript-anonymous-function-assigned
@@ -0,0 +1,4 @@
+const RIGHT = function (a, b) {	
+
+    return a + b;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-arrow-function-assigned b/t/t4018/javascript-arrow-function-assigned
new file mode 100644
index 0000000000..5f0b056f61
--- /dev/null
+++ b/t/t4018/javascript-arrow-function-assigned
@@ -0,0 +1,4 @@
+const RIGHT = (a, b) => {
+	
+    return a + b;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-arrow-function-assigned-2 b/t/t4018/javascript-arrow-function-assigned-2
new file mode 100644
index 0000000000..9e923f4261
--- /dev/null
+++ b/t/t4018/javascript-arrow-function-assigned-2
@@ -0,0 +1 @@
+const RIGHT = a => a+1;
\ No newline at end of file
diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
new file mode 100644
index 0000000000..7f99b8c89a
--- /dev/null
+++ b/t/t4018/javascript-async-function
@@ -0,0 +1,4 @@
+async function RIGHT (a, b) {
+	
+    return a + b;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-async-function-assigned b/t/t4018/javascript-async-function-assigned
new file mode 100644
index 0000000000..9a01d9701f
--- /dev/null
+++ b/t/t4018/javascript-async-function-assigned
@@ -0,0 +1,4 @@
+const RIGHT = async function (a, b) {
+	
+    return a + b;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-class-function b/t/t4018/javascript-class-function
new file mode 100644
index 0000000000..9f216d7174
--- /dev/null
+++ b/t/t4018/javascript-class-function
@@ -0,0 +1,6 @@
+class Test {
+  RIGHT() {
+    let a = 1;
+    let b = Value;
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
new file mode 100644
index 0000000000..d11ad34aff
--- /dev/null
+++ b/t/t4018/javascript-function
@@ -0,0 +1,4 @@
+function RIGHT (a, b) {
+	
+    return a + b;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-function-assigned b/t/t4018/javascript-function-assigned
new file mode 100644
index 0000000000..38eaecafc6
--- /dev/null
+++ b/t/t4018/javascript-function-assigned
@@ -0,0 +1,4 @@
+const RIGHT = function test (a, b) {
+	
+    return a + b;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
new file mode 100644
index 0000000000..af7cbb50a3
--- /dev/null
+++ b/t/t4018/javascript-generator-function
@@ -0,0 +1,5 @@
+function* RIGHT() {
+  
+  yield 1;
+  yield 2;
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
new file mode 100644
index 0000000000..d40b395f5c
--- /dev/null
+++ b/t/t4018/javascript-generator-function-2
@@ -0,0 +1,5 @@
+function *RIGHT() {
+  
+  yield 1;
+  yield 2;
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-generator-function-assigned b/t/t4018/javascript-generator-function-assigned
new file mode 100644
index 0000000000..b45d069949
--- /dev/null
+++ b/t/t4018/javascript-generator-function-assigned
@@ -0,0 +1,5 @@
+const RIGHT = function* (){
+  
+  yield 1;
+  yield 2;
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-generator-function-assigned-2 b/t/t4018/javascript-generator-function-assigned-2
new file mode 100644
index 0000000000..2c4bc271ab
--- /dev/null
+++ b/t/t4018/javascript-generator-function-assigned-2
@@ -0,0 +1,5 @@
+const RIGHT = function *(){
+  
+  yield 1;
+  yield 2;
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-method-function b/t/t4018/javascript-method-function
new file mode 100644
index 0000000000..37e380cc6f
--- /dev/null
+++ b/t/t4018/javascript-method-function
@@ -0,0 +1,6 @@
+const Test = {
+  RIGHT() {
+    let a = 1;
+    let b = Value;
+  }
+}
\ No newline at end of file
diff --git a/userdiff.c b/userdiff.c
index 05776ccd10..94134e5b09 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -237,6 +237,34 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("javascript",
+     /* conventional named functions */
+     "^[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\(.*$|"
+     /* assigned functions */
+     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
+     "[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)?[ \t]*\\(.*$|"
+     /* arrow functions */
+     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
+     "[ \t]*(\\([^\\)]*\\)|[$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=>[ \t]*\\{?.*$|"
+     /* functions declared inside classes and objects */
+     "^[ \t]*(static[ \t]+)?(async[ \t]+)?(get[ \t]+|set[ \t]+)?\\*?[ \t]*"
+     "([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\([^)]*\\)[ \t]*\\{.*$",
+     /* identifiers */
+	 "[$_A-Za-z][$_A-Za-z0-9]*|"
+     /* hexadecimal and big hexadecimal */
+     "0[xX](?:[0-9a-fA-F](?:_?[0-9a-fA-F])*)n?|"
+     /* octa and big octa */
+     "0[oO](?:[0-7](?:_?[0-7])*)n?|"
+     /* binary and big binary */
+     "0[bB](?:[01](?:_?[01])*)n?|"
+     /* decimal, floting point and exponent notation (eE) */
+     "(?:0|[1-9](?:_?[0-9])*)(?:\\.(?:[0-9](?:_?[0-9])*))?(?:[eE][+-]?(?:[0-9](?:_?[0-9])*))?|"
+     /* big decimal */
+     "(?:0|[1-9](?:_?[0-9])*)n|"
+	 /* punctuation */
+	 "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=|>=|==|!=|={3}|!==|\\+|-|\\*|/|%|\\*{2}|"
+	 "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=|\\+=|-=|\\*=|%=|\\*{2}=|"
+	 "<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"),
 PATTERNS("kotlin",
 	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
 	 /* -- */
-- 
2.50.0.rc0.62.g658f0ae201.dirty

