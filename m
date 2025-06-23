Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37722E406
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669571; cv=none; b=ATFOF2N6N3DsAve/RRWhS9YHgQcEQlQYRfoZ0xd+7xuNBBIAAzEXQzD9mHmcR9eH7aUwKC03cEmRGMruPVPvO//JO3iUelia+Vcee21Trl5sqp9qI4FuKnXS+qtMt35pVcMslrTzvE4PLz2N7n6o213N+7jVSX7TBqeJSdjjVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669571; c=relaxed/simple;
	bh=KEiTGsIn/PT+47VyIHToJHPFBZqGjB61pAri6009l2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNWgxntwnrJJaIg8OHRWpzfI+cLU1xSBJglKorwLtLp/bPdxpLsZ+KPElm7GYXCVlsg4H3r0lFfsHRgt4n1X5F/dgZd9QsWywIQqACHkbp2T5ktviElX5xUZ0Q5X+1ty6MHGKsRrQQJbJ0+/cu6P2MAMblQ2n/hrgBR0hHBWS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb9HVrHx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb9HVrHx"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7481600130eso4813446b3a.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669569; x=1751274369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn8mT64X2uipr2m+TcmGros/FowgeLg7S0YUb3BUxBQ=;
        b=kb9HVrHxDKL/e5RXGkgjJHsCGW94hxsDKaLdSIzVKs2j82HcrLV/cuCSR/FWHnBLxB
         KqXZazr4N2fUkJIYkwmTv4eaYX2X7fnb19dbFtvsyxC8zMeXNkKYjoRhHtyHrm36nvEI
         adoR5fGruysZwJ6QpAhlDZnqY9mVqfjTgnWjHdX78Qj1H5qqKsW9eI7qZ2PbDDVVhJRY
         jMEJgFa+4m8p4RKw5fYxZn9uMIjXfkSmIcvw31OQUUoWj0Eapk5Ll5x+dWg9D+By6WYW
         CLhPaouTfobHwuodPmwg1E768Tr3APVDWLSAX9KwzeiYQaFJnMQD6uxwpJWDO5Y0hqyO
         GKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669569; x=1751274369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn8mT64X2uipr2m+TcmGros/FowgeLg7S0YUb3BUxBQ=;
        b=hOni8NBKaTtpElYsvCTproiNSckOlNF1VzpISwhhkFSlg1X3Zr2AB4phxUBA7gPCgZ
         JMm7Gyqpx3GYdDkbmh+cDAkE41MCTdmvmXwH9wLRBWF/ZqTCSAz+rsgJdMGkULjThld1
         NFxX5S8LN5fGA8b2CBC9SOKPGsH16ubDlT1bY5j7WRtZwXrxA/XkAajye/F1bWhDJ4V6
         +9GVbvBnAyOTfoNXNcW0ghlt6sfmN2vYYJgefA/I+z5mt7CPlswEa89zaOwX1b1uRvRc
         rPXt9AG4i1ou8wNU+fM4FmLW2QOfPIPkqWpmms4N/ilBkdHB7XdR3+edOBHOd6r/l3c/
         59cg==
X-Forwarded-Encrypted: i=1; AJvYcCUw12lox0QEoOGfGEu7vr43nChezQ+1xYv9Gbq5UKIqxiDLMcOK/rzjR3tTJQ7warOTFgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIOfYUuME8FUasoRf5WZUJSH4l70/fstPMPADMgXXXHHFcJ0l
	YBb29dEoq7U/VNrvopVt+SBkUXVqGJHDwN0mykeXwGQckApP+ywdGJt2
X-Gm-Gg: ASbGncv6eWwb5p3MdvQxB5eeQGciKHaxvcgpQca+gkO5uvM1G95FHQwO9YDY8JdSWSu
	xD3a5bTysDWh1ecbxcwq71pdrNR8ttOvc78CEbAtrrbVtGt0338l0BBtJXoOf/bPjBbF+Q6iN+I
	BVXICYG+sOqdFg17BViTnNKChqTqSZQqRqWndAOujufAi0anZWaj1+99xjSmxLZN6wpfuMyUSTX
	juegTWHhRhOvIGbCV03QdWSrvJra5BVOFyWewqQMiZCSTqpsMMc9RT0bSpLqyEsS5dUxaUx0pUB
	uzLRcBxqL6vtaQoDpCkP0B7PaPNG1C47VwmTEYPt3x6ojFVgsdhjgu+WTtyBTvLEVXcg/2up/Me
	Wy3YMyyoa9N5PBwBJLGMB+g==
X-Google-Smtp-Source: AGHT+IFu358GY2CrYb6ip/gb0ezcspUJrq9k7I3WNJ1LynKLc8TIHMnFTXeuMbOZWYLykNsjiGT0zQ==
X-Received: by 2002:a05:6a00:3c90:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-7490da07100mr16739991b3a.21.1750669569065;
        Mon, 23 Jun 2025 02:06:09 -0700 (PDT)
Received: from dwmfdoom.tail99f6b6.ts.net ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7779179b3a.83.2025.06.23.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:06:08 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: j6t@kdbg.org
Cc: derick.william.moraes@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2 3/4] t4018: add tests for recognizing javascript function syntax
Date: Mon, 23 Jun 2025 03:35:48 -0300
Message-ID: <20250623090538.154858-4-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
In-Reply-To: <20250623090538.154858-1-derick.william.moraes@gmail.com>
References: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
 <20250623090538.154858-1-derick.william.moraes@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for javascript function declarations as in ECMAScript ES5.1<

Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
---
 .../javascript-anonymous-assigned-function    |  4 ++
 t/t4018/javascript-arrow-assigned-function    |  4 ++
 t/t4018/javascript-arrow-assigned-function-2  |  5 +++
 t/t4018/javascript-arrow-assigned-function-3  |  1 +
 t/t4018/javascript-assigned-function          |  4 ++
 t/t4018/javascript-async-assigned-function    |  4 ++
 t/t4018/javascript-async-function             |  4 +-
 t/t4018/javascript-class-get-function         |  5 +++
 t/t4018/javascript-class-set-function         |  5 +++
 t/t4018/javascript-class-static-function      |  5 +++
 t/t4018/javascript-class-unprefixed-function  |  6 +++
 t/t4018/javascript-function                   |  4 +-
 .../javascript-generator-assigned-function    |  5 +++
 .../javascript-generator-assigned-function-2  |  5 +++
 t/t4018/javascript-generator-function         |  4 +-
 t/t4018/javascript-generator-function-2       |  4 +-
 t/t4018/javascript-method-unprefixed-function |  6 +++
 t/t4018/javascript-skip-function-calls        |  7 ++++
 t/t4018/javascript-skip-reserved-words        | 38 +++++++++++++++++++
 19 files changed, 112 insertions(+), 8 deletions(-)
 create mode 100644 t/t4018/javascript-anonymous-assigned-function
 create mode 100644 t/t4018/javascript-arrow-assigned-function
 create mode 100644 t/t4018/javascript-arrow-assigned-function-2
 create mode 100644 t/t4018/javascript-arrow-assigned-function-3
 create mode 100644 t/t4018/javascript-assigned-function
 create mode 100644 t/t4018/javascript-async-assigned-function
 create mode 100644 t/t4018/javascript-class-get-function
 create mode 100644 t/t4018/javascript-class-set-function
 create mode 100644 t/t4018/javascript-class-static-function
 create mode 100644 t/t4018/javascript-class-unprefixed-function
 create mode 100644 t/t4018/javascript-generator-assigned-function
 create mode 100644 t/t4018/javascript-generator-assigned-function-2
 create mode 100644 t/t4018/javascript-method-unprefixed-function
 create mode 100644 t/t4018/javascript-skip-function-calls
 create mode 100644 t/t4018/javascript-skip-reserved-words

diff --git a/t/t4018/javascript-anonymous-assigned-function b/t/t4018/javascript-anonymous-assigned-function
new file mode 100644
index 0000000000..c9127e231d
--- /dev/null
+++ b/t/t4018/javascript-anonymous-assigned-function
@@ -0,0 +1,4 @@
+const RIGHT = function (a, b) {	
+
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-arrow-assigned-function b/t/t4018/javascript-arrow-assigned-function
new file mode 100644
index 0000000000..3182197aee
--- /dev/null
+++ b/t/t4018/javascript-arrow-assigned-function
@@ -0,0 +1,4 @@
+const RIGHT = (a, b) => {
+	
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-arrow-assigned-function-2 b/t/t4018/javascript-arrow-assigned-function-2
new file mode 100644
index 0000000000..b5732967c0
--- /dev/null
+++ b/t/t4018/javascript-arrow-assigned-function-2
@@ -0,0 +1,5 @@
+const RIGHT = a => {
+	
+    return a + 1; //ChangeMe
+};
+
diff --git a/t/t4018/javascript-arrow-assigned-function-3 b/t/t4018/javascript-arrow-assigned-function-3
new file mode 100644
index 0000000000..98ee879dd2
--- /dev/null
+++ b/t/t4018/javascript-arrow-assigned-function-3
@@ -0,0 +1 @@
+const RIGHT = a => a+1; //ChangeMe
diff --git a/t/t4018/javascript-assigned-function b/t/t4018/javascript-assigned-function
new file mode 100644
index 0000000000..170d54db4f
--- /dev/null
+++ b/t/t4018/javascript-assigned-function
@@ -0,0 +1,4 @@
+const RIGHT = function test (a, b) {
+	
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-async-assigned-function b/t/t4018/javascript-async-assigned-function
new file mode 100644
index 0000000000..1c1923b336
--- /dev/null
+++ b/t/t4018/javascript-async-assigned-function
@@ -0,0 +1,4 @@
+const RIGHT = async function (a, b) {
+	
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
index 7f99b8c89a..740e5304aa 100644
--- a/t/t4018/javascript-async-function
+++ b/t/t4018/javascript-async-function
@@ -1,4 +1,4 @@
 async function RIGHT (a, b) {
 	
-    return a + b;
-};
\ No newline at end of file
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-class-get-function b/t/t4018/javascript-class-get-function
new file mode 100644
index 0000000000..e27fa81478
--- /dev/null
+++ b/t/t4018/javascript-class-get-function
@@ -0,0 +1,5 @@
+class ChangeMe {
+  get RIGHT() {
+    return 1;
+  }
+}
diff --git a/t/t4018/javascript-class-set-function b/t/t4018/javascript-class-set-function
new file mode 100644
index 0000000000..ba747db7c7
--- /dev/null
+++ b/t/t4018/javascript-class-set-function
@@ -0,0 +1,5 @@
+class ChangeMe {
+  set RIGHT() {
+    return 1;
+  }
+}
diff --git a/t/t4018/javascript-class-static-function b/t/t4018/javascript-class-static-function
new file mode 100644
index 0000000000..b3c8f1ff2a
--- /dev/null
+++ b/t/t4018/javascript-class-static-function
@@ -0,0 +1,5 @@
+class ChangeMe {
+  static RIGHT(a, b) {
+    return a + b;
+  }
+}
diff --git a/t/t4018/javascript-class-unprefixed-function b/t/t4018/javascript-class-unprefixed-function
new file mode 100644
index 0000000000..675c787995
--- /dev/null
+++ b/t/t4018/javascript-class-unprefixed-function
@@ -0,0 +1,6 @@
+class Test {
+  RIGHT() {
+    let a = 1;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
index d11ad34aff..bd7945ca2b 100644
--- a/t/t4018/javascript-function
+++ b/t/t4018/javascript-function
@@ -1,4 +1,4 @@
 function RIGHT (a, b) {
 	
-    return a + b;
-};
\ No newline at end of file
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-generator-assigned-function b/t/t4018/javascript-generator-assigned-function
new file mode 100644
index 0000000000..c5ff9d89b5
--- /dev/null
+++ b/t/t4018/javascript-generator-assigned-function
@@ -0,0 +1,5 @@
+const RIGHT = function* (){
+  
+  yield 1;
+  yield 2; //ChangeMe
+}
diff --git a/t/t4018/javascript-generator-assigned-function-2 b/t/t4018/javascript-generator-assigned-function-2
new file mode 100644
index 0000000000..8ce7567987
--- /dev/null
+++ b/t/t4018/javascript-generator-assigned-function-2
@@ -0,0 +1,5 @@
+const RIGHT = function *(){
+  
+  yield 1;
+  yield 2; //ChangeMe
+}
diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
index af7cbb50a3..9a24ae7d08 100644
--- a/t/t4018/javascript-generator-function
+++ b/t/t4018/javascript-generator-function
@@ -1,5 +1,5 @@
 function* RIGHT() {
   
   yield 1;
-  yield 2;
-}
\ No newline at end of file
+  yield 2; //ChangeMe
+}
diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
index d40b395f5c..bac71e362c 100644
--- a/t/t4018/javascript-generator-function-2
+++ b/t/t4018/javascript-generator-function-2
@@ -1,5 +1,5 @@
 function *RIGHT() {
   
   yield 1;
-  yield 2;
-}
\ No newline at end of file
+  yield 2; //ChangeMe
+}
diff --git a/t/t4018/javascript-method-unprefixed-function b/t/t4018/javascript-method-unprefixed-function
new file mode 100644
index 0000000000..eb6300dda3
--- /dev/null
+++ b/t/t4018/javascript-method-unprefixed-function
@@ -0,0 +1,6 @@
+const Test = {
+  RIGHT() {
+    let a = 1;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-skip-function-calls b/t/t4018/javascript-skip-function-calls
new file mode 100644
index 0000000000..cc9699a9f5
--- /dev/null
+++ b/t/t4018/javascript-skip-function-calls
@@ -0,0 +1,7 @@
+class Test {
+  static RIGHT() {
+    call_to_skip();
+    call_to_skip2();
+    let a = ChangeMe;
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-skip-reserved-words b/t/t4018/javascript-skip-reserved-words
new file mode 100644
index 0000000000..d12fe587a8
--- /dev/null
+++ b/t/t4018/javascript-skip-reserved-words
@@ -0,0 +1,38 @@
+function RIGHT(a, b) {
+  import("./async1")
+
+  if (a > 1) {
+    // ...
+  }
+  do {
+    // ...
+  } 
+  while (i < 5){
+    //
+  };
+  for (const element of array1) {
+    console.log(element)
+  }
+  with(o) {
+    console.log(x)
+  }
+  switch (expr) {
+    case 'a':
+      // ...
+      break;
+    case 'b':
+      // ...
+      break;
+    default:
+      // ...
+  }
+  try {
+    // ...
+    return (a + c)
+  } 
+  catch (error) {
+    // ...
+  }
+
+  return a + b; // ChangeMe
+}
-- 
2.50.0.rc0.62.g658f0ae201.dirty

