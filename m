Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85523ABA9
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496553; cv=none; b=EWUHiUvNO6Gi4X0IOPYTMt4sHzf8WwlWST0bg7LDFs7ugjbinYSzaMPOE+nwWIJotxg4ShuiNb02e34jHmZqQUDn0P3OGI1HklbTZiSrRRjTCt+NchWP+Hzx/i066D7ThIEFRV6VMgn5tfGWQCNjGwwZ+NyuAuZVbrWmRKRptyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496553; c=relaxed/simple;
	bh=SRfvOEnrJop8/SCSzrYsHFlq2GqPBEUvdAhoWyDKgJY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n81MXOyGnAypBr9Hl/5PpflB3rc+aTi6DKnVki15fV03L/bfNOitPGAAoqRnKMoYvx1MebA90WjAWoNNUhGFk3a4475PFTXAvF8XUdV9OXH6M8JkQew04UDM5GThjHUxR+wB2YpMqHCRcFqVusVPkS5xkUMt+5I9U7teXSNUdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1MztohH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1MztohH"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771e987b4e6so2005050b3a.2
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496550; x=1757101350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c33jMqaIFPBike2Y+3TwBNbu4aR5VNGK+2iCd9qmFU=;
        b=b1MztohHiHciz0C8fGqr5WEO/j7bQc3CWs9wS3fqYHHFYUkRqrZ9uxIeVVrn1Bx5ku
         rMYbP3pVLdBQhc8GSj9kC9UOFGmvbuPLmNzLTxSvyyLcIdmSwCUyfKChEmuoczeFzGjq
         xVD4A9obNHSy31mk2ZBaM10el1mefaDordTTQ4rBdOjsYaqZbjB6esE7Vjy10WKXKl5y
         rZsQrP9zg2LY3AU/uWa2K/C8vB0Euqtc1tYQ6Iy5A07kJEn6x5xbZnS4FK0WK/EUCg9w
         CZJEhLhibh6ZSNkJKE5ULktZadjC56F1CF8KsL6jwJKr3ZV9qyTQQSpr6i4TxADMovvr
         ZFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496550; x=1757101350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c33jMqaIFPBike2Y+3TwBNbu4aR5VNGK+2iCd9qmFU=;
        b=MwwizmQD6wwE1pS8cYib2kkosxZwdq1Hd0+/aOkLgv0UN9GaaJNJtsTVE2feMYg/7N
         Nat4GUeReZ0WGVHzJw8OvCFSHla3QRPR0fOdRlsAOnvWFZ4p03Hq6u0z7rDvMr1GEIF4
         0Y1rbufmU1zKXGrXf67VUEMDORodEk45Z+sJc3Y/ZmLRgbO5oZsSOqcxhWxO+5QhLG5S
         QIUr6POvTU0w1ygcgXwfdRDEO2D4xCXbl4yKJlHucz55R5vnJa1MGCK5SgPbooQ/J1fW
         V4wL2bRjgjfLQ6QT4ipQu2TC+zkp5Gw7+e+ZhF6eMitOfPS6xMFYFl+o7nLG6k8eLEmj
         CQjA==
X-Gm-Message-State: AOJu0YymX0Gn1HOaOCOUpHT4wIs29/vXwkEanfeRfvvy+m37LGSf+asT
	PVFzwQ3fAHBTK1dzA8LfM5Gq96ip+e2e2b1LL3BVYA4Um9UDcsV1Vxub9N6yOw==
X-Gm-Gg: ASbGncvzS5Ve5aDhdzAxIbmHA/yx9e7h6AL9/9LrjtoVvWtfq3MFZR9dZXmmfYjrhmF
	yaDRTnR9mpd30I8DsnH8h4x4TAMeRkN91kfDhYyofuasXos/H8D2UeKd3Rlh1NjVoU2+KgeSo/W
	8CMcH5A9G73vvvx3wk3HWMyvIVR/iOzUNKu260ATVbVDOJ/pvxB4bWcdp5BSB59whNvNma/o1ep
	VjbnL93VaYyz1Ywe4tbmjAiaHsTPvoSQLfTUyprecRlpqlMcg3MzAWoyCcx7keusoCuE8/pP0+4
	aXDR27m5VA6rAGCQLTfuhrnkPoTFR5QX/5brP/wJsQE3TeDeHbBPqXiYRyIY2UFstGn4icR3Anp
	H+fJt/E3hmgrnqkDxNqaAgKt0oiQ=
X-Google-Smtp-Source: AGHT+IFNSSE5eJoIJeeiFiw2n5cfgv9IDX4RW4YU3JoS2SdOjoHt6WJ0ZdNj2UhCaAdrA1/5j08Cnw==
X-Received: by 2002:a05:6a00:1988:b0:772:2ae4:a6a with SMTP id d2e1a72fcca58-7722ae4234bmr5251588b3a.19.1756496549835;
        Fri, 29 Aug 2025 12:42:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm3150147b3a.92.2025.08.29.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:29 -0700 (PDT)
Message-Id: <922d506ed67635b699be4adb18a0081a6544e0e1.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:10 +0000
Subject: [PATCH 06/15] ivec: create a vector type that is interoperable
 between C and Rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Trying to use Rust's Vec in C, or git's ALLOC_GROW() macros (via
wrapper functions) in Rust is painful because:

  * C doing vector things the Rust way would require wrapper functions,
    and Rust doing vector things the C way would require wrapper
    functions, so ivec was created to ensure a consistent contract
    between the 2 languages for how to manipulate a vector.
  * Currently, Rust defines its own 'Vec' type that is generic, but its
    memory allocator and struct layout weren't designed for
    interoperability with C (or any language for that matter), meaning
    that the C side cannot push to or expand a 'Vec' without defining
    wrapper functions in Rust that C can call. Without special care,
    the two languages might use different allocators (malloc/free on
    the C side, and possibly something else in Rust), which would make
    it difficult for a function in one language to free elements
    allocated by a call from a function in the other language.
  * Similarly, git defines ALLOC_GROW() and related macros in
    git-compat-util.h. While we could add functions allowing Rust to
    invoke something similar to those macros, passing three variables
    (pointer, length, allocated_size) instead of a single variable
    (vector) across the language boundary requires more cognitive
    overhead for readers to keep track of and makes it easier to make
    mistakes. Further, for low-level components that we want to
    eventually convert to pure Rust, such triplets would feel very out
    of place.

To address these issue, introduce a new type, ivec -- short for
interoperable vector. (We refer to it as 'ivec' generally, though on
the Rust side the struct is called IVec to match Rust style.)  This new
type is specifically designed for FFI purposes, so that both languages
handle the vector in the same way, though it could be used on either
side independently. This type is designed such that it can easily be
replaced by a standard Rust 'Vec' once interoperability is no longer a
concern.

One particular item to note is that Git's macros to handle vec
operations infer the amount that a vec needs to grow from the size of
a pointer, but that makes it somewhat specific to the macros used in C.
To avoid defining every ivec function as a macro I opted to also
include an element_size field that allows concrete functions like
push() to know how much to grow the memory. This element_size also
helps in verifying that the ivec is correct when passing from C to
Rust.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile                 |  14 +-
 interop/ivec.c           | 180 ++++++++++++++
 interop/ivec.h           |  60 +++++
 meson.build              |   1 +
 rust/interop/src/ivec.rs | 516 +++++++++++++++++++++++++++++++++++++++
 rust/interop/src/lib.rs  |  10 +
 6 files changed, 778 insertions(+), 3 deletions(-)
 create mode 100644 interop/ivec.c
 create mode 100644 interop/ivec.h
 create mode 100644 rust/interop/src/ivec.rs

diff --git a/Makefile b/Makefile
index 1ec0c1ee66..46e940c96d 100644
--- a/Makefile
+++ b/Makefile
@@ -672,6 +672,7 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
+INTEROP_OBJS =
 XDIFF_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
@@ -918,6 +919,7 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
+INTEROP_LIB = interop/lib.a
 XDIFF_LIB = xdiff/lib.a
 
 EXTLIBS =
@@ -1412,7 +1414,7 @@ UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = common-main.o $(LIB_FILE) $(INTEROP_LIB) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
 
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2747,6 +2749,8 @@ reconfigure config.mak.autogen: config.status
 .PHONY: reconfigure # This is a convenience target.
 endif
 
+INTEROP_OBJS += interop/ivec.o
+
 XDIFF_OBJS += xdiff/xdiffi.o
 XDIFF_OBJS += xdiff/xemit.o
 XDIFF_OBJS += xdiff/xhistogram.o
@@ -2791,6 +2795,7 @@ OBJECTS += $(GIT_OBJS)
 OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
+OBJECTS += $(INTEROP_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
@@ -2945,7 +2950,10 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS) compile_rust
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(XDIFF_LIB): $(XDIFF_OBJS)
+$(INTEROP_LIB): $(INTEROP_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
+$(XDIFF_LIB): $(INTEROP_OBJS) $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
 
@@ -3790,7 +3798,7 @@ clean: profile-clean coverage-clean cocciclean rustclean
 	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE) $(INTEROP_LIB) $(XDIFF_LIB) $(REFTABLE_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
diff --git a/interop/ivec.c b/interop/ivec.c
new file mode 100644
index 0000000000..1c4bf20707
--- /dev/null
+++ b/interop/ivec.c
@@ -0,0 +1,180 @@
+#include "ivec.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+static void ivec_set_capacity(void *self_, usize new_capacity)
+{
+	struct rawivec *self = self_;
+
+	if (new_capacity == 0)
+		FREE_AND_NULL(self->ptr);
+	else
+		self->ptr = xrealloc(self->ptr, new_capacity * self->element_size);
+	self->capacity = new_capacity;
+}
+
+void ivec_init(void *self_, usize element_size)
+{
+	struct rawivec *self = self_;
+
+	self->ptr = NULL;
+	self->length = 0;
+	self->capacity = 0;
+	self->element_size = element_size;
+}
+
+/*
+ * MUST CALL IVEC_INIT() FIRST!!!
+ * This function will free the ivec, set self.capacity and self.length
+ * to the specified capacity, and then calloc self.capacity number of
+ * elements.
+ */
+void ivec_zero(void *self_, usize capacity)
+{
+	struct rawivec *self = self_;
+
+	if (self->ptr)
+		FREE_AND_NULL(self->ptr);
+	self->capacity = self->length = capacity;
+	self->ptr = xcalloc(self->capacity, self->element_size);
+}
+
+void ivec_clear(void *self_)
+{
+	struct rawivec *self = self_;
+
+	self->length = 0;
+}
+
+void ivec_reserve_exact(void *self_, usize additional)
+{
+	struct rawivec *self = self_;
+	usize new_capacity = self->capacity + additional;
+
+	ivec_set_capacity(self, new_capacity);
+}
+
+void ivec_reserve(void *self_, usize additional)
+{
+	struct rawivec *self = self_;
+	usize growby = 128;
+
+	if (self->capacity > growby) {
+		growby = self->capacity;
+	}
+	if (additional > growby) {
+		growby = additional;
+	}
+	ivec_reserve_exact(self, growby);
+}
+
+void ivec_shrink_to_fit(void *self_)
+{
+	struct rawivec *self = self_;
+
+	ivec_set_capacity(self_, self->length);
+}
+
+void ivec_resize(void *self_, usize new_length, void *default_value)
+{
+	struct rawivec *self = self_;
+	isize additional = (isize) (new_length - self->capacity);
+
+	if (additional > 0) {
+		ivec_reserve(self_, additional);
+	}
+
+	for (usize i = self->length; i < new_length; i++) {
+		void *dst = (u8 *)self->ptr + (self->length + i) * self->element_size;
+		memcpy(dst, default_value, self->element_size);
+	}
+	self->length = new_length;
+}
+
+void ivec_push(void *self_, void *value)
+{
+	struct rawivec *self = self_;
+	u8 *dst;
+
+	if (self->length == self->capacity) {
+		ivec_reserve(self_, 1);
+	}
+	dst = (u8 *)self->ptr + self->length * self->element_size;
+	memcpy(dst, value, self->element_size);
+	self->length++;
+}
+
+void ivec_extend_from_slice(void *self_, void const *ptr, usize size)
+{
+	struct rawivec *self = self_;
+	u8 *dst;
+
+	if (size == 0)
+		return;
+
+	if (self->length + size > self->capacity) {
+		ivec_reserve(self_, self->capacity - self->length + size);
+	}
+	dst = (u8 *)self->ptr + self->length * self->element_size;
+	memcpy(dst, ptr, size * self->element_size);
+	self->length += size;
+}
+
+bool ivec_equal(void *self_, void *other)
+{
+	struct rawivec *lhs = self_;
+	struct rawivec *rhs = other;
+
+	if (lhs->element_size != rhs->element_size) {
+		return false;
+	}
+
+	if (lhs->length != rhs->length) {
+		return false;
+	}
+
+	for (usize i = 0; i < lhs->length; i++) {
+		void *left = (u8 *)lhs->ptr + i * lhs->element_size;
+		void *right = (u8 *)rhs->ptr + i * rhs->element_size;
+		if (memcmp(left, right, lhs->element_size) != 0) {
+			return false;
+		}
+	}
+
+	return true;
+}
+
+
+void ivec_free(void *self_)
+{
+	struct rawivec *self = self_;
+
+	FREE_AND_NULL(self->ptr);
+	self->length = 0;
+	self->capacity = 0;
+	/* don't modify self->element_size */
+}
+
+void ivec_move(void *source, void *destination)
+{
+	struct rawivec *src = source;
+	struct rawivec *dst = destination;
+
+	if (src->element_size != dst->element_size)
+		BUG("mismatched element_size");
+
+	ivec_free(destination);
+	dst->ptr = src->ptr;
+	dst->length = src->length;
+	dst->capacity = src->capacity;
+
+	src->ptr = NULL;
+	src->length = 0;
+	src->capacity = 0;
+}
+
+#ifdef __cplusplus
+}
+#endif
diff --git a/interop/ivec.h b/interop/ivec.h
new file mode 100644
index 0000000000..ed3afff944
--- /dev/null
+++ b/interop/ivec.h
@@ -0,0 +1,60 @@
+#ifndef IVEC_H
+#define IVEC_H
+
+#include <git-compat-util.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct rawivec {
+	void *ptr;
+	usize length;
+	usize capacity;
+	usize element_size;
+};
+
+#define DEFINE_IVEC_TYPE(type, suffix) \
+struct ivec_##suffix { \
+	type *ptr; \
+	size_t length; \
+	size_t capacity; \
+	size_t element_size; \
+}
+
+#define IVEC_INIT(variable) ivec_init(&(variable), sizeof(*(variable).ptr))
+
+DEFINE_IVEC_TYPE(u8, u8);
+DEFINE_IVEC_TYPE(u16, u16);
+DEFINE_IVEC_TYPE(u32, u32);
+DEFINE_IVEC_TYPE(u64, u64);
+
+DEFINE_IVEC_TYPE(i8, i8);
+DEFINE_IVEC_TYPE(i16, i16);
+DEFINE_IVEC_TYPE(i32, i32);
+DEFINE_IVEC_TYPE(i64, i64);
+
+DEFINE_IVEC_TYPE(f32, f32);
+DEFINE_IVEC_TYPE(f64, f64);
+
+DEFINE_IVEC_TYPE(usize, usize);
+DEFINE_IVEC_TYPE(isize, isize);
+
+void ivec_init(void *self_, usize element_size);
+void ivec_zero(void *self_, usize capacity);
+void ivec_clear(void *self_);
+void ivec_reserve_exact(void *self_, usize additional);
+void ivec_reserve(void *self_, usize additional);
+void ivec_shrink_to_fit(void *self_);
+void ivec_resize(void *self_, usize new_length, void *default_value);
+void ivec_push(void *self_, void *value);
+void ivec_extend_from_slice(void *self_, void const *ptr, usize size);
+bool ivec_equal(void *self_, void *other);
+void ivec_free(void *self_);
+void ivec_move(void *source, void *destination);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif //IVEC_H
diff --git a/meson.build b/meson.build
index 5aa9901bfc..fc7c133f79 100644
--- a/meson.build
+++ b/meson.build
@@ -395,6 +395,7 @@ libgit_sources = [
   'hex-ll.c',
   'hook.c',
   'ident.c',
+  'interop/ivec.c',
   'json-writer.c',
   'kwset.c',
   'levenshtein.c',
diff --git a/rust/interop/src/ivec.rs b/rust/interop/src/ivec.rs
new file mode 100644
index 0000000000..ba9393a82b
--- /dev/null
+++ b/rust/interop/src/ivec.rs
@@ -0,0 +1,516 @@
+use crate::*;
+use core::mem::{align_of, size_of};
+use std::fmt::{Debug, Formatter};
+use std::ops::{Index, IndexMut};
+
+#[repr(C)]
+pub struct IVec<T> {
+    ptr: *mut T,
+    length: usize,
+    capacity: usize,
+    element_size: usize,
+}
+
+impl<T> Default for IVec<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T> Drop for IVec<T> {
+    fn drop(&mut self) {
+        self._set_capacity(0);
+    }
+}
+
+impl<T: Clone> Clone for IVec<T> {
+    fn clone(&self) -> Self {
+        let mut copy = Self::new();
+        copy.reserve_exact(self.len());
+        for i in 0..self.len() {
+            copy.push(self[i].clone());
+        }
+
+        copy
+    }
+}
+
+impl<T: PartialEq> PartialEq for IVec<T> {
+    fn eq(&self, other: &Self) -> bool {
+        if self.len() != other.len() {
+            return false;
+        }
+
+        let lhs = self.as_slice();
+        let rhs = &other.as_slice()[..lhs.len()];
+        for i in 0..lhs.len() {
+            if lhs[i] != rhs[i] {
+                return false;
+            }
+        }
+
+        true
+    }
+}
+
+impl<T: PartialEq> Eq for IVec<T> {}
+
+/*
+ * constructors
+ */
+impl<T> IVec<T> {
+    pub fn new() -> Self {
+        Self {
+            ptr: std::ptr::null_mut(),
+            length: 0,
+            capacity: 0,
+            element_size: size_of::<T>(),
+        }
+    }
+
+    /// uses calloc to create the IVec, it's unsafe because
+    /// zeroed memory may not be a valid default value
+    pub unsafe fn zero(capacity: usize) -> Self {
+        Self {
+            ptr: calloc(capacity, size_of::<T>()) as *mut T,
+            length: capacity,
+            capacity,
+            element_size: size_of::<T>(),
+        }
+    }
+
+    pub fn with_capacity(capacity: usize) -> Self {
+        let mut vec = Self::new();
+        vec._set_capacity(capacity);
+        vec
+    }
+
+    pub fn with_capacity_and_default(capacity: usize, default_value: T) -> Self
+    where
+        T: Copy,
+    {
+        let mut vec = Self::new();
+        vec._set_capacity(capacity);
+        vec._buffer_mut().fill(default_value);
+        vec
+    }
+
+    pub unsafe fn from_raw_mut<'a>(raw: *mut Self) -> &'a mut Self {
+        let vec = raw.as_mut().expect("null pointer");
+        #[cfg(debug_assertions)]
+        vec.test_invariants();
+        vec
+    }
+
+    pub unsafe fn from_raw<'a>(raw: *const Self) -> &'a Self {
+        let vec = &*raw.as_ref().expect("null pointer");
+        #[cfg(debug_assertions)]
+        vec.test_invariants();
+        vec
+    }
+}
+
+/*
+ * private methods
+ */
+impl<T> IVec<T> {
+    pub fn test_invariants(&self) {
+        if !self.ptr.is_null() && (self.ptr as usize) % align_of::<T>() != 0 {
+            panic!(
+                "misaligned pointer: expected {:x}, got {:x}",
+                align_of::<T>(),
+                self.ptr as usize
+            );
+        }
+        if self.ptr.is_null() && (self.length > 0 || self.capacity > 0) {
+            panic!("ptr is null, but length or capacity is > 0");
+        }
+        if !self.ptr.is_null() && self.capacity == 0 {
+            panic!("ptr ISN'T null, but capacity == 0");
+        }
+        if self.element_size != size_of::<T>() {
+            panic!(
+                "incorrect element size, should be: {}, but was: {}",
+                size_of::<T>(),
+                self.element_size
+            );
+        }
+        if self.length > self.capacity {
+            panic!("length: {} > capacity: {}", self.length, self.capacity);
+        }
+        if self.capacity > usize::MAX / size_of::<T>() {
+            panic!(
+                "Capacity {} is too large, potential overflow detected",
+                self.capacity
+            );
+        }
+    }
+
+    fn _set_capacity(&mut self, new_capacity: usize) {
+        unsafe {
+            if new_capacity == self.capacity {
+                return;
+            }
+            if new_capacity < self.length {
+                self.truncate(new_capacity);
+            }
+            if new_capacity == 0 {
+                free(self.ptr as *mut c_void);
+                self.ptr = std::ptr::null_mut();
+                self.length = 0;
+                self.capacity = 0;
+                // DO NOT MODIFY element_size!!!
+            } else {
+                let t = realloc(self.ptr as *mut c_void, new_capacity * size_of::<T>());
+                if t.is_null() {
+                    panic!("out of memory");
+                }
+                self.ptr = t as *mut T;
+            }
+            self.capacity = new_capacity;
+        }
+    }
+
+    fn _resize(&mut self, new_length: usize, default_value: T, exact: bool)
+    where
+        T: Copy,
+    {
+        if exact {
+            self._set_capacity(new_length);
+        } else if new_length > self.capacity {
+            self.reserve(new_length - self.capacity);
+        } else {
+            /* capacity does not need to be changed */
+        }
+
+        /* IVec grows */
+        if new_length > self.length {
+            let range = self.length..new_length;
+            self._buffer_mut()[range].fill(default_value);
+            self.length = new_length;
+        }
+
+        /* IVec shrinks */
+        if new_length < self.length {
+            self.truncate(new_length);
+        }
+    }
+
+    fn _buffer_mut(&mut self) -> &mut [T] {
+        if self.ptr.is_null() {
+            &mut []
+        } else {
+            unsafe { std::slice::from_raw_parts_mut(self.ptr, self.capacity) }
+        }
+    }
+
+    fn _buffer(&self) -> &[T] {
+        if self.ptr.is_null() {
+            &[]
+        } else {
+            unsafe { std::slice::from_raw_parts(self.ptr, self.capacity) }
+        }
+    }
+}
+
+/*
+ * methods
+ */
+impl<T> IVec<T> {
+    pub fn len(&self) -> usize {
+        self.length
+    }
+
+    pub unsafe fn set_len(&mut self, new_length: usize) {
+        self.length = new_length;
+    }
+
+    pub fn capacity(&self) -> usize {
+        self.capacity
+    }
+
+    pub fn reserve_exact(&mut self, additional: usize) {
+        self._set_capacity(self.capacity + additional);
+    }
+
+    pub fn reserve(&mut self, additional: usize) {
+        let growby = std::cmp::max(128, self.capacity);
+        self.reserve_exact(std::cmp::max(additional, growby));
+    }
+
+    pub fn shrink_to_fit(&mut self) {
+        self._set_capacity(self.length);
+    }
+
+    pub fn resize(&mut self, new_length: usize, default_value: T)
+    where
+        T: Copy,
+    {
+        self._resize(new_length, default_value, false);
+    }
+
+    pub fn resize_exact(&mut self, new_length: usize, default_value: T)
+    where
+        T: Copy,
+    {
+        self._resize(new_length, default_value, true);
+    }
+
+    pub fn truncate(&mut self, new_length: usize) {
+        if new_length >= self.length {
+            return;
+        }
+
+        if std::mem::needs_drop::<T>() {
+            let range = new_length..self.length;
+            for v in &mut self.as_mut_slice()[range] {
+                unsafe {
+                    std::ptr::drop_in_place(v);
+                }
+            }
+        }
+
+        self.length = new_length;
+    }
+
+    pub fn insert(&mut self, index: usize, value: T) {
+        if self.length == self.capacity {
+            self.reserve(1);
+        }
+
+        unsafe {
+            let src = &self._buffer()[index] as *const T;
+            let dst = src.add(1) as *mut T;
+            let len = self.length - index;
+            std::ptr::copy(src, dst, len);
+            std::ptr::write(self.ptr.add(index), value);
+        }
+    }
+
+    pub fn push(&mut self, value: T) {
+        if self.length == self.capacity {
+            self.reserve(1);
+        }
+
+        let i = self.length;
+        unsafe {
+            std::ptr::write(self.ptr.add(i), value);
+        }
+        self.length += 1;
+    }
+
+    pub fn extend_from_slice(&mut self, slice: &[T])
+    where
+        T: Clone,
+    {
+        for v in slice {
+            self.push(v.clone());
+        }
+    }
+
+    pub fn clear(&mut self) {
+        self.length = 0;
+    }
+
+    pub fn as_ptr(&self) -> *const T {
+        self.ptr
+    }
+
+    pub fn as_mut_ptr(&self) -> *mut T {
+        self.ptr
+    }
+
+    pub fn as_slice(&self) -> &[T] {
+        &self._buffer()[0..self.length]
+    }
+
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        let range = 0..self.length;
+        &mut self._buffer_mut()[range]
+    }
+}
+
+impl<T> Extend<T> for IVec<T> {
+    fn extend<IT: IntoIterator<Item = T>>(&mut self, iter: IT) {
+        for v in iter {
+            self.push(v);
+        }
+    }
+}
+
+impl<T> Index<usize> for IVec<T> {
+    type Output = T;
+
+    fn index(&self, index: usize) -> &Self::Output {
+        &self.as_slice()[index]
+    }
+}
+
+impl<T> IndexMut<usize> for IVec<T> {
+    fn index_mut(&mut self, index: usize) -> &mut Self::Output {
+        &mut self.as_mut_slice()[index]
+    }
+}
+
+impl<T: Debug> Debug for IVec<T> {
+    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
+        writeln!(
+            f,
+            "ptr: {}, capacity: {}, len: {}, element_size: {}, content: {:?}",
+            self.ptr as usize,
+            self.capacity,
+            self.length,
+            self.element_size,
+            self.as_slice()
+        )
+    }
+}
+
+impl std::fmt::Write for IVec<u8> {
+    fn write_str(&mut self, s: &str) -> std::fmt::Result {
+        Ok(self.extend_from_slice(s.as_bytes()))
+    }
+}
+
+impl std::io::Write for IVec<u8> {
+    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
+        self.extend_from_slice(buf);
+        Ok(buf.len())
+    }
+
+    fn flush(&mut self) -> std::io::Result<()> {
+        Ok(())
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use crate::ivec::IVec;
+    use std::cell::RefCell;
+    use std::mem::size_of;
+    use std::ops::{Deref, DerefMut};
+    use std::panic;
+    use std::rc::Rc;
+
+    struct DropTest {
+        value: Rc<RefCell<u64>>,
+    }
+
+    impl DropTest {
+        fn new(value: Rc<RefCell<u64>>) -> Self {
+            Self { value }
+        }
+    }
+
+    impl Drop for DropTest {
+        fn drop(&mut self) {
+            *self.value.borrow_mut() -= 1;
+        }
+    }
+
+    #[test]
+    fn test_drop_elements() {
+        let counter = Rc::new(RefCell::new(0u64));
+        let size = 5;
+
+        /* drop whole IVec */
+        let mut vec = IVec::new();
+        for _ in 0..size {
+            let tmp = DropTest::new(counter.clone());
+            *tmp.value.borrow_mut() += 1;
+            vec.push(tmp);
+        }
+        let cur = *counter.borrow();
+        assert_eq!(size, cur);
+        drop(vec);
+
+        let cur = *counter.borrow();
+        assert_eq!(0u64, cur);
+
+        /* drop some elements */
+        let mut vec = IVec::new();
+        for i in 0..size {
+            let tmp = DropTest::new(counter.clone());
+            *tmp.value.borrow_mut() += 1;
+            vec.push(tmp);
+        }
+        let cur = *counter.borrow().deref();
+        assert_eq!(size, cur);
+
+        let expected = 2u64;
+        vec.truncate(expected as usize);
+
+        let cur = *counter.borrow();
+        assert_eq!(expected, cur);
+        drop(vec);
+    }
+
+    #[test]
+    fn test_panic_on_out_of_bounds() {
+        type TestType = i16;
+        let result = panic::catch_unwind(|| {
+            let mut v = IVec::<TestType>::with_capacity(1_000_000);
+            v[0] = 55;
+        });
+
+        match result {
+            Ok(_) => assert!(false, "index was out of bounds, but no panic was triggered"),
+            Err(_) => assert!(true),
+        }
+    }
+
+    #[test]
+    fn test_push_clear_resize_then_shrink_to_fit() {
+        let mut vec = IVec::<u64>::new();
+        let mut monotonic = 1;
+
+        vec.reserve_exact(1);
+        assert_eq!(1, vec.capacity);
+
+        // test push
+        for _ in 0..10 {
+            vec.push(monotonic);
+            assert_eq!(monotonic as usize, vec.length);
+            assert_eq!(monotonic, vec[(monotonic - 1) as usize]);
+            assert!(vec.capacity >= vec.length);
+            monotonic += 1;
+        }
+
+        // test clear
+        let expected = vec.capacity;
+        vec.clear();
+        assert_eq!(0, vec.length);
+        assert_eq!(expected, vec.capacity);
+
+        // test resize
+        let expected = vec.capacity + 10;
+        let default_value = 19;
+        vec.resize(expected, default_value);
+        assert_eq!(expected, vec.length);
+        assert!(vec.capacity >= expected);
+        for i in 0..vec.length {
+            assert_eq!(default_value, vec[i]);
+        }
+
+        vec.reserve(10);
+        assert!(vec.capacity > vec.length);
+        let length_before = vec.length;
+        vec.shrink_to_fit();
+        assert_eq!(length_before, vec.length);
+        assert_eq!(vec.length, vec.capacity);
+    }
+
+    #[test]
+    fn test_struct_size() {
+        let vec = IVec::<i16>::new();
+
+        assert_eq!(2, vec.element_size);
+        assert_eq!(size_of::<usize>() * 4, size_of::<IVec<i16>>());
+
+        drop(vec);
+
+        let vec = IVec::<u128>::new();
+        assert_eq!(16, vec.element_size);
+        assert_eq!(size_of::<usize>() * 4, size_of::<IVec<u128>>());
+    }
+}
diff --git a/rust/interop/src/lib.rs b/rust/interop/src/lib.rs
index e69de29bb2..4850f66e5b 100644
--- a/rust/interop/src/lib.rs
+++ b/rust/interop/src/lib.rs
@@ -0,0 +1,10 @@
+pub mod ivec;
+
+use std::ffi::c_void;
+
+extern "C" {
+    pub fn malloc(size: usize) -> *mut c_void;
+    pub fn calloc(nmemb: usize, size: usize) -> *mut c_void;
+    pub fn realloc(ptr: *mut c_void, size: usize) -> *mut c_void;
+    pub fn free(ptr: *mut c_void);
+}
-- 
gitgitgadget

