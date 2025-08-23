Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631C21A43D
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921371; cv=none; b=bYsIRszssQK8mQztrM+jOLx1IlcX83yxlzTtWFQR27z+v4M6hox3XcxQsF5HVDy8lrhOwX3rEfVX8/km8oD+W6aBNCwsDx9xm/aJzg6Z0lUPL9RzfA45ArIy9k0vVJp1OYICfBO6SZdNeOgjd9pGIrVRpIq3I1Q+0v36E0uMWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921371; c=relaxed/simple;
	bh=n41m8/71k71h3NspPwVmHxcveyoYoIa4ZzGeUqJFHAs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xl5TkkAuP+lYHHKjOKIhcWmRTvq1Z5e3DHf3PsjXoBO66eh+Dsjd0+XMbjCbZ+anoIh4JiG7zu7Nk/D56eeEqHxgwUg6YwYKd6e4LhgOOQmYIuSIK9PCEB/ign3mMaGYDZhY6JxKc7Nt/35FJvRpv6g0UYUw18leVV/Lo1ZJHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5SDjSZU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5SDjSZU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so14998835e9.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921367; x=1756526167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY5bMpAFd1OkfjgyprVJzayDBwkBSrt0V3kKqYqOEXQ=;
        b=P5SDjSZUnvfSu7vG5nZUFn7BvnDnyzz2edeaMv9oHnsr/rKUC0gEwk/6UtYSAz3wdW
         cX1USBYWn7oylDN6PseX2tw5WKtKyslFIsZbPZTHOZwdBHH/lsuvxLzPBq6Mua7MXZH6
         uQi4au+2yrrHGjXpC7sHFoGI57Sc2i8awgxsXFdR311vneuVNTFq5nWobKEzbrZpcgba
         h3E+YhS7IK63xscZGZoJoLJV/0SgUTb1lB9FtzXWYxViyAmTW3MAeFJs1i5C522H8OMR
         BuzqBKjBTHyT8HtLkvxoWUNwZIi8Wl+V2nc+kIlx0IQqty2/+ymyKMmmYPpTKY3EY0Qu
         NE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921367; x=1756526167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY5bMpAFd1OkfjgyprVJzayDBwkBSrt0V3kKqYqOEXQ=;
        b=dmv70eP2x6ldIBbdrWry/nJVUEnJ7Xt+kR8342ViFrZfZwe/gQJXodn1vbG5P8YqAI
         HenrL2Sww+E1RnXUAXCOWCK/J7uDyn+8iIHvw/QrW+6pVO44hJDvi+YueHK9vNzH5yh0
         P6Uk/rCeJHp3bR26VDuGETwIP09uwyoH6i2NTI5uSg0BP/YvHD8D6DDOGxDnVqLWj2cz
         juGmiNluSUtFUw9cSyM5iHx8Ccq/FANqEp4e3iSwJaULPLdTTy6SeiHzoBGU0HewCOwx
         gInk+eHED1UsjHufAkeENGZX/Isee0mt8E6aRm5UrEReDgbLtyCNbprXQJS8NrnPIJhL
         m9qA==
X-Gm-Message-State: AOJu0YytEW9o+6A+18nQdQa60mq1gFFfkeZsMN/T4QJ4htaTIup2XlV4
	VJ5h94tvrtcpAi0w2QmUgljnti6ObPBmXLvi6/hX/olUxSv0GDqhHVbfg3YALQ==
X-Gm-Gg: ASbGnctAehuzjEH0k7rFpSx7lk22/7/qBDCE3zWioAWjpww3atzmmoUNmXnYT5e87sd
	l8mSFpEA5Bd17OdS6591ai3UBnEMLmxqCzr1qQSyx7FtGPFyypPcw4uZN0+19zs/eOMnN2ygR3b
	8VsdyeOe92DRKr+9b6wvuxUuQ12xLVC81QfrpxsZ6FInn1cAe+kAZclcFwXsS1ZwXZXgtuJ6kzc
	mVaBni6+JvD85klk59lF0cNtqhNTIjh8WBNgu8OVwI25ExenDChiV/bn8N7h+DuOknjcNYn5P6i
	bzikjjkCINhha+s4X4nI6s61bv77U6Iy8x2JTIRs+dlqfgmpq+Xzlk8Yobp0eBd5vnd8riwgBBo
	QN9ZA2X30qnBWXTbrsudwxfSh0Qk=
X-Google-Smtp-Source: AGHT+IEakeRrGI+jjkx0RlW5FGtkZa3j5bwf7AqkjkI8aiVCCHDR6j83fjn4ptUZjzBkLzT89PfRlQ==
X-Received: by 2002:a05:600c:4ca1:b0:45b:4ba0:da4 with SMTP id 5b1f17b1804b1-45b541d5401mr22707725e9.13.1755921366524;
        Fri, 22 Aug 2025 20:56:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211bd7sm1881731f8f.38.2025.08.22.20.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:05 -0700 (PDT)
Message-Id: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:47 +0000
Subject: [PATCH v3 06/15] ivec: create a vector type that is interoperable
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
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
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
 Makefile                 |  16 +-
 interop/ivec.c           | 151 +++++++++++++
 interop/ivec.h           |  52 +++++
 meson.build              |   1 +
 rust/interop/src/ivec.rs | 462 +++++++++++++++++++++++++++++++++++++++
 rust/interop/src/lib.rs  |  10 +
 rust/xdiff/src/lib.rs    |   1 +
 7 files changed, 690 insertions(+), 3 deletions(-)
 create mode 100644 interop/ivec.c
 create mode 100644 interop/ivec.h
 create mode 100644 rust/interop/src/ivec.rs

diff --git a/Makefile b/Makefile
index 1ec0c1ee6603..29a53520fd28 100644
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
@@ -2747,6 +2749,10 @@ reconfigure config.mak.autogen: config.status
 .PHONY: reconfigure # This is a convenience target.
 endif
 
+INTEROP_OBJS += interop/ivec.o
+.PHONY: interop-objs
+interop-objs: $(INTEROP_OBJS)
+
 XDIFF_OBJS += xdiff/xdiffi.o
 XDIFF_OBJS += xdiff/xemit.o
 XDIFF_OBJS += xdiff/xhistogram.o
@@ -2791,6 +2797,7 @@ OBJECTS += $(GIT_OBJS)
 OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
+OBJECTS += $(INTEROP_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
@@ -2945,7 +2952,10 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS) compile_rust
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(XDIFF_LIB): $(XDIFF_OBJS)
+$(INTEROP_LIB): $(INTEROP_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
+$(XDIFF_LIB): $(INTEROP_OBJS) $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
 
@@ -3790,7 +3800,7 @@ clean: profile-clean coverage-clean cocciclean rustclean
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
index 000000000000..9bc2258c04ad
--- /dev/null
+++ b/interop/ivec.c
@@ -0,0 +1,151 @@
+#include "ivec.h"
+
+static void ivec_set_capacity(void* self, usize new_capacity) {
+	struct rawivec *this = self;
+	if (new_capacity == 0)
+		FREE_AND_NULL(this->ptr);
+	else
+		this->ptr = xrealloc(this->ptr, new_capacity * this->element_size);
+	this->capacity = new_capacity;
+}
+
+void ivec_init(void* self, usize element_size) {
+	struct rawivec *this = self;
+	this->ptr = NULL;
+	this->length = 0;
+	this->capacity = 0;
+	this->element_size = element_size;
+}
+
+/*
+ * MUST CALL IVEC_INIT() FIRST!!!
+ * This function will free the ivec, set self.capacity and self.length
+ * to the specified capacity, and then calloc self.capacity number of
+ * elements.
+ */
+void ivec_zero(void* self, usize capacity) {
+	struct rawivec *this = self;
+	if (this->ptr)
+		FREE_AND_NULL(this->ptr);
+	this->capacity = this->length = capacity;
+	this->ptr = xcalloc(this->capacity, this->element_size);
+}
+
+void ivec_clear(void* self) {
+	struct rawivec *this = self;
+	this->length = 0;
+}
+
+void ivec_reserve_exact(void* self, usize additional) {
+	struct rawivec *this = self;
+	usize new_capacity = this->capacity + additional;
+	ivec_set_capacity(self, new_capacity);
+}
+
+void ivec_reserve(void* self, usize additional) {
+	struct rawivec *this = self;
+	usize growby = 128;
+	if (this->capacity > growby) {
+		growby = this->capacity;
+	}
+	if (additional > growby) {
+		growby = additional;
+	}
+	ivec_reserve_exact(self, growby);
+}
+
+void ivec_shrink_to_fit(void* self) {
+	struct rawivec *this = self;
+	ivec_set_capacity(self, this->length);
+}
+
+void ivec_resize(void* self, usize new_length, void* default_value) {
+	struct rawivec *this = self;
+	isize additional = (isize) (new_length - this->capacity);
+	if (additional > 0) {
+		ivec_reserve(self, additional);
+	}
+
+	for (usize i = this->length; i < new_length; i++) {
+		void* dst = (u8*) this->ptr + (this->length + i) * this->element_size;
+		memcpy(dst, default_value, this->element_size);
+	}
+	this->length = new_length;
+}
+
+void ivec_push(void* self, void* value) {
+	struct rawivec *this = self;
+	u8* dst;
+
+	if (this->length == this->capacity) {
+		ivec_reserve(self, 1);
+	}
+	dst = (u8*) this->ptr + this->length * this->element_size;
+	memcpy(dst, value, this->element_size);
+	this->length++;
+}
+
+void ivec_extend_from_slice(void* self, void const* ptr, usize size) {
+	struct rawivec *this = self;
+	u8* dst;
+
+	if (size == 0)
+		return;
+
+	if (this->length + size > this->capacity) {
+		ivec_reserve(self, this->capacity - this->length + size);
+	}
+	dst = (u8*) this->ptr + this->length * this->element_size;
+	memcpy(dst, ptr, size * this->element_size);
+	this->length += size;
+}
+
+bool ivec_equal(void* self, void* other) {
+	struct rawivec *lhs = self;
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
+
+	for (usize i = 0; i < lhs->length; i++) {
+		void* left = (u8 *) lhs->ptr + i * lhs->element_size;
+		void* right = (u8 *) rhs->ptr + i * rhs->element_size;
+		if (memcmp(left, right, lhs->element_size) != 0) {
+			return false;
+		}
+	}
+
+	return true;
+}
+
+
+void ivec_free(void* self) {
+	struct rawivec *this = self;
+	FREE_AND_NULL(this->ptr);
+	this->length = 0;
+	this->capacity = 0;
+	/* don't modify self->element_size */
+}
+
+void ivec_move(void* source, void* destination) {
+	struct rawivec *this = source;
+	struct rawivec *that = destination;
+
+	if (this->element_size != that->element_size)
+		BUG("mismatched element_size");
+
+	ivec_free(destination);
+	that->ptr = this->ptr;
+	that->length = this->length;
+	that->capacity = this->capacity;
+
+	this->ptr = NULL;
+	this->length = 0;
+	this->capacity = 0;
+}
diff --git a/interop/ivec.h b/interop/ivec.h
new file mode 100644
index 000000000000..98be4bbeb54a
--- /dev/null
+++ b/interop/ivec.h
@@ -0,0 +1,52 @@
+#ifndef IVEC_H
+#define IVEC_H
+
+#include "../git-compat-util.h"
+
+struct rawivec {
+	void* ptr;
+	usize length;
+	usize capacity;
+	usize element_size;
+};
+
+#define DEFINE_IVEC_TYPE(type, suffix) \
+struct ivec_##suffix { \
+	type* ptr; \
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
+void ivec_init(void* self, usize element_size);
+void ivec_zero(void* self, usize capacity);
+void ivec_clear(void* self);
+void ivec_reserve_exact(void* self, usize additional);
+void ivec_reserve(void* self, usize additional);
+void ivec_shrink_to_fit(void* self);
+void ivec_resize(void* self, usize new_length, void* default_value);
+void ivec_push(void* self, void* value);
+void ivec_extend_from_slice(void* self, void const* ptr, usize size);
+bool ivec_equal(void* self, void* other);
+void ivec_free(void* self);
+void ivec_move(void* source, void* destination);
+
+#endif //IVEC_H
diff --git a/meson.build b/meson.build
index 5aa9901bfc0f..fc7c133f79d8 100644
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
index 000000000000..4e047572b922
--- /dev/null
+++ b/rust/interop/src/ivec.rs
@@ -0,0 +1,462 @@
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
+        unsafe {
+            self._free();
+        }
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
+    fn _zero(&mut self) {
+        self.ptr = std::ptr::null_mut();
+        self.length = 0;
+        self.capacity = 0;
+        // DO NOT MODIFY element_size!!!
+    }
+
+    unsafe fn _free(&mut self) {
+        free(self.ptr as *mut std::ffi::c_void);
+        self._zero();
+    }
+
+    fn _set_capacity(&mut self, new_capacity: usize) {
+        unsafe {
+            if new_capacity == self.capacity {
+                return;
+            }
+            if new_capacity == 0 {
+                self._free();
+            } else {
+                let t = realloc(
+                    self.ptr as *mut std::ffi::c_void,
+                    new_capacity * size_of::<T>(),
+                );
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
+        if new_length > self.length {
+            let range = self.length..new_length;
+            self._buffer_mut()[range].fill(default_value);
+        }
+
+        self.length = new_length;
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
+    use std::panic;
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
+        // assert_eq!(vec.capacity, vec.slice.len());
+        assert_eq!(expected, vec.length);
+        assert!(vec.capacity >= expected);
+        for i in 0..vec.length {
+            assert_eq!(default_value, vec[i]);
+        }
+
+        vec.reserve(10);
+        // assert_eq!(vec.capacity, vec.slice.len());
+        assert!(vec.capacity > vec.length);
+        let length_before = vec.length;
+        vec.shrink_to_fit();
+        assert_eq!(length_before, vec.length);
+        assert_eq!(vec.length, vec.capacity);
+        // assert_eq!(vec.capacity, vec.slice.len());
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
+
+    #[test]
+    fn test_manual_free() {
+        type TestType = i16;
+        let mut vec = IVec::<TestType>::new();
+
+        unsafe { vec._free() };
+        assert!(vec.ptr.is_null());
+        assert_eq!(0, vec.length);
+        assert_eq!(0, vec.capacity);
+        assert_eq!(size_of::<TestType>(), vec.element_size);
+    }
+}
diff --git a/rust/interop/src/lib.rs b/rust/interop/src/lib.rs
index e69de29bb2d1..4850f66e5bd9 100644
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
diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index e69de29bb2d1..8b137891791f 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -0,0 +1 @@
+
-- 
gitgitgadget

