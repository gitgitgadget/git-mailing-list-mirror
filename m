Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE39151991
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496545; cv=none; b=CAUTRRYyNn0RbtxB0y6TUutmbf/7yQvUStRA//ksIA4ICRBB7edq+A3wkOIakhRwgq8ZsHrItEydyDN+yCXMAykffgucv5wN+Gw+qKksZnXh+h7NZgZ8uZ/E2Ck7X1TXyNoCOIGy7/4+Wl1sQlT/obIDUtGYA+Rvrm8vO/miKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496545; c=relaxed/simple;
	bh=mvBDT00jq+LoGrY55xg3mBOFt+w0QdNyoD7r0ccm+m4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=uR71ugxA3RsRS5LbhogVzqufpbfMh8dz+JIBukq4kZ4pTnuU8WVP9pxVrWKoEAJnue+OJ+pJQ6PK1+Rp7pLrf3yVu8zLenWSGEMg6MqYqQznKG8sVUGaVusUek56XdRY0D4DibfvylfTxC1jHHsTIZhCGFOBfl6VH+CwtdqzWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeLZdhWw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeLZdhWw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24622df0d95so19765295ad.2
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496542; x=1757101342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ysKXf1l9cgGEfOANGccmVpqDWgM3hjrLwnlZgwaioa4=;
        b=ZeLZdhWw+FEyiHLPljLMT/MIzWzNwnmS4RK0i+kZtreNyyRlrDTfECSFgfeYEPOSHC
         jwUR/GXUIjzCLBian9myQZVLu5aeMho5DKC0Jm1xoPNknv5GGOyxIuhzW74Wj0mjvXaw
         bExJtkq641SONtLqD9bHkOujs7cwZReG62ZmLeEAc6kpkUHFk0tvvtg8TaTiPd5uHB6b
         m7eLSb5245vf/HiGjCD6LF3bEaGCxYU+EDCTRlHd3kIdSXQWr2gIm6qf0W3bkW1DEO5h
         VkmU2EWpds867KYIpChcY0ad2jyGCWwg5YwajoH1VGnY4QqdnInaXPgH5wjfN/PZckin
         lD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496542; x=1757101342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysKXf1l9cgGEfOANGccmVpqDWgM3hjrLwnlZgwaioa4=;
        b=DKqeWnDTAlzcoseN1Yv/WsVlhvjNw30JuDw9cHygsNBuHCpGAdrk23A1DghMOQ+XZq
         21050ciFOOLa3tZ0wBrXVOM0/gSEW3OuDClRwB7et8m3m+BJzykSY9C5ch8jzYTe/6dh
         Cb0hBmx+QTSKllJDGJZcU6Xd9DS308D3uQComKwaGv/9NCLifBOhcSrRq98het7JTXCR
         dxnOtpeVJU5Y5yyfKXhmi8rEUCAA2Ase4QXcVyY2mr8XmLuELXo8jqyvfYK02ajiqLKv
         yfn5PuEcX6/zvLwzPC7eMOmXIf2WkYx0gIn7b+I/ylv4uEe+V5ivN152JEDQaMLLzKZ4
         lKQw==
X-Gm-Message-State: AOJu0YykGYPgHAdkoQBGFADALCMkzkuho8YL1CDcgLdipXHX0WYEAWuR
	LeDhEH2rYh5SFoZ245ma3RPYzWAsvjYafTiSJZw85LUUj45o6CqI+SA3CBkOVQ==
X-Gm-Gg: ASbGncvpaj/7YfrkDERKO4gPhHd65rbDbxSmg4mDlPNKKBnwlhMSBtHr3CZO1rEJ9IW
	ZQVxPZoZW0r4vdQ6wNnEARHFAXZPd9Th/GjyjM8TNl3JHuu8K1xZFW1/bQyx79NWe2RbwqIHJ6g
	cbk230JnHf/4+v0ImfQVdRXBQAJhsp0exiaGr7m+3q0H2FM8zf98kbwrfemvQ3chN9YRuDmgFCZ
	H0b4mJkD2pupZvRD0oZvahoME4Wh9hFVQgv6z1GEppmI0CoG3m+x1ZfjwDemNrofCcEqwS09JT/
	w+LeHl+RgWQ09cDaZ0UsqdoFyaRdm5kgJNfnq9UDcscfvZ92m+29oY6TxvcYwIAq9mRxI/CeN88
	xecpVTXa4UILS9AtAme9v4amksWktsZtUyLuTMw==
X-Google-Smtp-Source: AGHT+IHwG1nYLdgNLBPErWvL6eTV3PD0HNPfq6Qhma+1P2wPo5tAHiohQRIpHHVomsI6G+5okaCLhA==
X-Received: by 2002:a17:903:388e:b0:23f:e51b:2189 with SMTP id d9443c01a7336-2462ee4579cmr386737655ad.17.1756496541396;
        Fri, 29 Aug 2025 12:42:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006c340sm2964512a12.1.2025.08.29.12.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:20 -0700 (PDT)
Message-Id: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:04 +0000
Subject: [PATCH 00/15] Introduce rust: In xdiff
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>

This is a continuation of
https://lore.kernel.org/git/pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com/,
but I am removing the RFC label.

Changes since the last RFC patch series (range-diff added below):

 * Addressed feedback:
   * Use self instead of this
   * Update ivec to use Git code style
   * Remove environment variable CI_IS_DOCKER from github workflows
   * Remove PHONY target interop-objs
   * Removed left over asserts in Rust and fix near by code
 * Other changes:
   * Avoid name mangling of ivec if c++ compiler used
   * Fixed a typo in patch 11 commit message

High level overview:

 * patch 1: add a policy for using Rust (brian's patch, with a small tweak)
 * patch 2: introduce Rust to the codebase
 * patches 3-5: adapt CI (github workflows) to build Git with Rust
 * patch 6: introduce the ivec type
 * patches 7-14: xdiff code cleanup in preparation for translating to Rust
 * patch 15: translate a C function into Rust and call it from C

Build results for these changes:
https://github.com/git/git/actions/runs/17330190596

Range-Diff against last RFC version:

 1:  6d065f550f =  1:  6d065f550f doc: add a policy for using Rust
 2:  0393995125 =  2:  cc9cf87775 xdiff: introduce rust
 3:  a98d9e4d21 !  3:  6c47401ba0 github workflows: install rust
    @@ .github/workflows/main.yml: jobs:
                image: fedora:latest
              # A RHEL 8 compatible distro.  Supported until 2029-05-31.
     @@ .github/workflows/main.yml: jobs:
    -       jobname: ${{matrix.vector.jobname}}
            CC: ${{matrix.vector.cc}}
            CI_JOB_IMAGE: ${{matrix.vector.image}}
    -+      CI_IS_DOCKER: "true"
            CUSTOM_PATH: /custom
     +      CARGO_HOME: /home/builder/.cargo
          runs-on: ubuntu-latest
 4:  0d2b39c3e0 =  4:  8e350700bc win+Meson: do allow linking with the Rust-built xdiff
 5:  e65488ab99 =  5:  a00cbf7bcb github workflows: upload Cargo.lock
 6:  db5d22b188 !  6:  922d506ed6 ivec: create a vector type that is interoperable between C and Rust
    @@ Makefile: reconfigure config.mak.autogen: config.status
      endif
      
     +INTEROP_OBJS += interop/ivec.o
    -+.PHONY: interop-objs
    -+interop-objs: $(INTEROP_OBJS)
     +
      XDIFF_OBJS += xdiff/xdiffi.o
      XDIFF_OBJS += xdiff/xemit.o
    @@ interop/ivec.c (new)
     @@
     +#include "ivec.h"
     +
    -+static void ivec_set_capacity(void* self, usize new_capacity) {
    -+	struct rawivec *this = self;
    ++#ifdef __cplusplus
    ++extern "C" {
    ++#endif
    ++
    ++static void ivec_set_capacity(void *self_, usize new_capacity)
    ++{
    ++	struct rawivec *self = self_;
    ++
     +	if (new_capacity == 0)
    -+		FREE_AND_NULL(this->ptr);
    ++		FREE_AND_NULL(self->ptr);
     +	else
    -+		this->ptr = xrealloc(this->ptr, new_capacity * this->element_size);
    -+	this->capacity = new_capacity;
    ++		self->ptr = xrealloc(self->ptr, new_capacity * self->element_size);
    ++	self->capacity = new_capacity;
     +}
     +
    -+void ivec_init(void* self, usize element_size) {
    -+	struct rawivec *this = self;
    -+	this->ptr = NULL;
    -+	this->length = 0;
    -+	this->capacity = 0;
    -+	this->element_size = element_size;
    ++void ivec_init(void *self_, usize element_size)
    ++{
    ++	struct rawivec *self = self_;
    ++
    ++	self->ptr = NULL;
    ++	self->length = 0;
    ++	self->capacity = 0;
    ++	self->element_size = element_size;
     +}
     +
     +/*
    @@ interop/ivec.c (new)
     + * to the specified capacity, and then calloc self.capacity number of
     + * elements.
     + */
    -+void ivec_zero(void* self, usize capacity) {
    -+	struct rawivec *this = self;
    -+	if (this->ptr)
    -+		FREE_AND_NULL(this->ptr);
    -+	this->capacity = this->length = capacity;
    -+	this->ptr = xcalloc(this->capacity, this->element_size);
    ++void ivec_zero(void *self_, usize capacity)
    ++{
    ++	struct rawivec *self = self_;
    ++
    ++	if (self->ptr)
    ++		FREE_AND_NULL(self->ptr);
    ++	self->capacity = self->length = capacity;
    ++	self->ptr = xcalloc(self->capacity, self->element_size);
     +}
     +
    -+void ivec_clear(void* self) {
    -+	struct rawivec *this = self;
    -+	this->length = 0;
    ++void ivec_clear(void *self_)
    ++{
    ++	struct rawivec *self = self_;
    ++
    ++	self->length = 0;
     +}
     +
    -+void ivec_reserve_exact(void* self, usize additional) {
    -+	struct rawivec *this = self;
    -+	usize new_capacity = this->capacity + additional;
    ++void ivec_reserve_exact(void *self_, usize additional)
    ++{
    ++	struct rawivec *self = self_;
    ++	usize new_capacity = self->capacity + additional;
    ++
     +	ivec_set_capacity(self, new_capacity);
     +}
     +
    -+void ivec_reserve(void* self, usize additional) {
    -+	struct rawivec *this = self;
    ++void ivec_reserve(void *self_, usize additional)
    ++{
    ++	struct rawivec *self = self_;
     +	usize growby = 128;
    -+	if (this->capacity > growby) {
    -+		growby = this->capacity;
    ++
    ++	if (self->capacity > growby) {
    ++		growby = self->capacity;
     +	}
     +	if (additional > growby) {
     +		growby = additional;
    @@ interop/ivec.c (new)
     +	ivec_reserve_exact(self, growby);
     +}
     +
    -+void ivec_shrink_to_fit(void* self) {
    -+	struct rawivec *this = self;
    -+	ivec_set_capacity(self, this->length);
    ++void ivec_shrink_to_fit(void *self_)
    ++{
    ++	struct rawivec *self = self_;
    ++
    ++	ivec_set_capacity(self_, self->length);
     +}
     +
    -+void ivec_resize(void* self, usize new_length, void* default_value) {
    -+	struct rawivec *this = self;
    -+	isize additional = (isize) (new_length - this->capacity);
    ++void ivec_resize(void *self_, usize new_length, void *default_value)
    ++{
    ++	struct rawivec *self = self_;
    ++	isize additional = (isize) (new_length - self->capacity);
    ++
     +	if (additional > 0) {
    -+		ivec_reserve(self, additional);
    ++		ivec_reserve(self_, additional);
     +	}
     +
    -+	for (usize i = this->length; i < new_length; i++) {
    -+		void* dst = (u8*) this->ptr + (this->length + i) * this->element_size;
    -+		memcpy(dst, default_value, this->element_size);
    ++	for (usize i = self->length; i < new_length; i++) {
    ++		void *dst = (u8 *)self->ptr + (self->length + i) * self->element_size;
    ++		memcpy(dst, default_value, self->element_size);
     +	}
    -+	this->length = new_length;
    ++	self->length = new_length;
     +}
     +
    -+void ivec_push(void* self, void* value) {
    -+	struct rawivec *this = self;
    -+	u8* dst;
    ++void ivec_push(void *self_, void *value)
    ++{
    ++	struct rawivec *self = self_;
    ++	u8 *dst;
     +
    -+	if (this->length == this->capacity) {
    -+		ivec_reserve(self, 1);
    ++	if (self->length == self->capacity) {
    ++		ivec_reserve(self_, 1);
     +	}
    -+	dst = (u8*) this->ptr + this->length * this->element_size;
    -+	memcpy(dst, value, this->element_size);
    -+	this->length++;
    ++	dst = (u8 *)self->ptr + self->length * self->element_size;
    ++	memcpy(dst, value, self->element_size);
    ++	self->length++;
     +}
     +
    -+void ivec_extend_from_slice(void* self, void const* ptr, usize size) {
    -+	struct rawivec *this = self;
    -+	u8* dst;
    ++void ivec_extend_from_slice(void *self_, void const *ptr, usize size)
    ++{
    ++	struct rawivec *self = self_;
    ++	u8 *dst;
     +
     +	if (size == 0)
     +		return;
     +
    -+	if (this->length + size > this->capacity) {
    -+		ivec_reserve(self, this->capacity - this->length + size);
    ++	if (self->length + size > self->capacity) {
    ++		ivec_reserve(self_, self->capacity - self->length + size);
     +	}
    -+	dst = (u8*) this->ptr + this->length * this->element_size;
    -+	memcpy(dst, ptr, size * this->element_size);
    -+	this->length += size;
    ++	dst = (u8 *)self->ptr + self->length * self->element_size;
    ++	memcpy(dst, ptr, size * self->element_size);
    ++	self->length += size;
     +}
     +
    -+bool ivec_equal(void* self, void* other) {
    -+	struct rawivec *lhs = self;
    ++bool ivec_equal(void *self_, void *other)
    ++{
    ++	struct rawivec *lhs = self_;
     +	struct rawivec *rhs = other;
     +
     +	if (lhs->element_size != rhs->element_size) {
    @@ interop/ivec.c (new)
     +		return false;
     +	}
     +
    -+
     +	for (usize i = 0; i < lhs->length; i++) {
    -+		void* left = (u8 *) lhs->ptr + i * lhs->element_size;
    -+		void* right = (u8 *) rhs->ptr + i * rhs->element_size;
    ++		void *left = (u8 *)lhs->ptr + i * lhs->element_size;
    ++		void *right = (u8 *)rhs->ptr + i * rhs->element_size;
     +		if (memcmp(left, right, lhs->element_size) != 0) {
     +			return false;
     +		}
    @@ interop/ivec.c (new)
     +}
     +
     +
    -+void ivec_free(void* self) {
    -+	struct rawivec *this = self;
    -+	FREE_AND_NULL(this->ptr);
    -+	this->length = 0;
    -+	this->capacity = 0;
    ++void ivec_free(void *self_)
    ++{
    ++	struct rawivec *self = self_;
    ++
    ++	FREE_AND_NULL(self->ptr);
    ++	self->length = 0;
    ++	self->capacity = 0;
     +	/* don't modify self->element_size */
     +}
     +
    -+void ivec_move(void* source, void* destination) {
    -+	struct rawivec *this = source;
    -+	struct rawivec *that = destination;
    ++void ivec_move(void *source, void *destination)
    ++{
    ++	struct rawivec *src = source;
    ++	struct rawivec *dst = destination;
     +
    -+	if (this->element_size != that->element_size)
    ++	if (src->element_size != dst->element_size)
     +		BUG("mismatched element_size");
     +
     +	ivec_free(destination);
    -+	that->ptr = this->ptr;
    -+	that->length = this->length;
    -+	that->capacity = this->capacity;
    ++	dst->ptr = src->ptr;
    ++	dst->length = src->length;
    ++	dst->capacity = src->capacity;
    ++
    ++	src->ptr = NULL;
    ++	src->length = 0;
    ++	src->capacity = 0;
    ++}
     +
    -+	this->ptr = NULL;
    -+	this->length = 0;
    -+	this->capacity = 0;
    ++#ifdef __cplusplus
     +}
    ++#endif
     
      ## interop/ivec.h (new) ##
     @@
     +#ifndef IVEC_H
     +#define IVEC_H
     +
    -+#include "../git-compat-util.h"
    ++#include <git-compat-util.h>
    ++
    ++#ifdef __cplusplus
    ++extern "C" {
    ++#endif
     +
     +struct rawivec {
    -+	void* ptr;
    ++	void *ptr;
     +	usize length;
     +	usize capacity;
     +	usize element_size;
    @@ interop/ivec.h (new)
     +
     +#define DEFINE_IVEC_TYPE(type, suffix) \
     +struct ivec_##suffix { \
    -+	type* ptr; \
    ++	type *ptr; \
     +	size_t length; \
     +	size_t capacity; \
     +	size_t element_size; \
    @@ interop/ivec.h (new)
     +DEFINE_IVEC_TYPE(usize, usize);
     +DEFINE_IVEC_TYPE(isize, isize);
     +
    -+void ivec_init(void* self, usize element_size);
    -+void ivec_zero(void* self, usize capacity);
    -+void ivec_clear(void* self);
    -+void ivec_reserve_exact(void* self, usize additional);
    -+void ivec_reserve(void* self, usize additional);
    -+void ivec_shrink_to_fit(void* self);
    -+void ivec_resize(void* self, usize new_length, void* default_value);
    -+void ivec_push(void* self, void* value);
    -+void ivec_extend_from_slice(void* self, void const* ptr, usize size);
    -+bool ivec_equal(void* self, void* other);
    -+void ivec_free(void* self);
    -+void ivec_move(void* source, void* destination);
    ++void ivec_init(void *self_, usize element_size);
    ++void ivec_zero(void *self_, usize capacity);
    ++void ivec_clear(void *self_);
    ++void ivec_reserve_exact(void *self_, usize additional);
    ++void ivec_reserve(void *self_, usize additional);
    ++void ivec_shrink_to_fit(void *self_);
    ++void ivec_resize(void *self_, usize new_length, void *default_value);
    ++void ivec_push(void *self_, void *value);
    ++void ivec_extend_from_slice(void *self_, void const *ptr, usize size);
    ++bool ivec_equal(void *self_, void *other);
    ++void ivec_free(void *self_);
    ++void ivec_move(void *source, void *destination);
    ++
    ++#ifdef __cplusplus
    ++}
    ++#endif
     +
     +#endif //IVEC_H
     
    @@ rust/interop/src/ivec.rs (new)
     +
     +impl<T> Drop for IVec<T> {
     +    fn drop(&mut self) {
    -+        unsafe {
    -+            self._free();
    -+        }
    ++        self._set_capacity(0);
     +    }
     +}
     +
    @@ rust/interop/src/ivec.rs (new)
     +        }
     +    }
     +
    -+    fn _zero(&mut self) {
    -+        self.ptr = std::ptr::null_mut();
    -+        self.length = 0;
    -+        self.capacity = 0;
    -+        // DO NOT MODIFY element_size!!!
    -+    }
    -+
    -+    unsafe fn _free(&mut self) {
    -+        free(self.ptr as *mut std::ffi::c_void);
    -+        self._zero();
    -+    }
    -+
     +    fn _set_capacity(&mut self, new_capacity: usize) {
     +        unsafe {
     +            if new_capacity == self.capacity {
     +                return;
     +            }
    ++            if new_capacity < self.length {
    ++                self.truncate(new_capacity);
    ++            }
     +            if new_capacity == 0 {
    -+                self._free();
    ++                free(self.ptr as *mut c_void);
    ++                self.ptr = std::ptr::null_mut();
    ++                self.length = 0;
    ++                self.capacity = 0;
    ++                // DO NOT MODIFY element_size!!!
     +            } else {
    -+                let t = realloc(
    -+                    self.ptr as *mut std::ffi::c_void,
    -+                    new_capacity * size_of::<T>(),
    -+                );
    ++                let t = realloc(self.ptr as *mut c_void, new_capacity * size_of::<T>());
     +                if t.is_null() {
     +                    panic!("out of memory");
     +                }
    @@ rust/interop/src/ivec.rs (new)
     +            /* capacity does not need to be changed */
     +        }
     +
    ++        /* IVec grows */
     +        if new_length > self.length {
     +            let range = self.length..new_length;
     +            self._buffer_mut()[range].fill(default_value);
    ++            self.length = new_length;
     +        }
     +
    -+        self.length = new_length;
    ++        /* IVec shrinks */
    ++        if new_length < self.length {
    ++            self.truncate(new_length);
    ++        }
     +    }
     +
     +    fn _buffer_mut(&mut self) -> &mut [T] {
    @@ rust/interop/src/ivec.rs (new)
     +        self._resize(new_length, default_value, true);
     +    }
     +
    ++    pub fn truncate(&mut self, new_length: usize) {
    ++        if new_length >= self.length {
    ++            return;
    ++        }
    ++
    ++        if std::mem::needs_drop::<T>() {
    ++            let range = new_length..self.length;
    ++            for v in &mut self.as_mut_slice()[range] {
    ++                unsafe {
    ++                    std::ptr::drop_in_place(v);
    ++                }
    ++            }
    ++        }
    ++
    ++        self.length = new_length;
    ++    }
    ++
     +    pub fn insert(&mut self, index: usize, value: T) {
     +        if self.length == self.capacity {
     +            self.reserve(1);
    @@ rust/interop/src/ivec.rs (new)
     +#[cfg(test)]
     +mod tests {
     +    use crate::ivec::IVec;
    ++    use std::cell::RefCell;
    ++    use std::mem::size_of;
    ++    use std::ops::{Deref, DerefMut};
     +    use std::panic;
    ++    use std::rc::Rc;
    ++
    ++    struct DropTest {
    ++        value: Rc<RefCell<u64>>,
    ++    }
    ++
    ++    impl DropTest {
    ++        fn new(value: Rc<RefCell<u64>>) -> Self {
    ++            Self { value }
    ++        }
    ++    }
    ++
    ++    impl Drop for DropTest {
    ++        fn drop(&mut self) {
    ++            *self.value.borrow_mut() -= 1;
    ++        }
    ++    }
    ++
    ++    #[test]
    ++    fn test_drop_elements() {
    ++        let counter = Rc::new(RefCell::new(0u64));
    ++        let size = 5;
    ++
    ++        /* drop whole IVec */
    ++        let mut vec = IVec::new();
    ++        for _ in 0..size {
    ++            let tmp = DropTest::new(counter.clone());
    ++            *tmp.value.borrow_mut() += 1;
    ++            vec.push(tmp);
    ++        }
    ++        let cur = *counter.borrow();
    ++        assert_eq!(size, cur);
    ++        drop(vec);
    ++
    ++        let cur = *counter.borrow();
    ++        assert_eq!(0u64, cur);
    ++
    ++        /* drop some elements */
    ++        let mut vec = IVec::new();
    ++        for i in 0..size {
    ++            let tmp = DropTest::new(counter.clone());
    ++            *tmp.value.borrow_mut() += 1;
    ++            vec.push(tmp);
    ++        }
    ++        let cur = *counter.borrow().deref();
    ++        assert_eq!(size, cur);
    ++
    ++        let expected = 2u64;
    ++        vec.truncate(expected as usize);
    ++
    ++        let cur = *counter.borrow();
    ++        assert_eq!(expected, cur);
    ++        drop(vec);
    ++    }
     +
     +    #[test]
     +    fn test_panic_on_out_of_bounds() {
    @@ rust/interop/src/ivec.rs (new)
     +        let expected = vec.capacity + 10;
     +        let default_value = 19;
     +        vec.resize(expected, default_value);
    -+        // assert_eq!(vec.capacity, vec.slice.len());
     +        assert_eq!(expected, vec.length);
     +        assert!(vec.capacity >= expected);
     +        for i in 0..vec.length {
    @@ rust/interop/src/ivec.rs (new)
     +        }
     +
     +        vec.reserve(10);
    -+        // assert_eq!(vec.capacity, vec.slice.len());
     +        assert!(vec.capacity > vec.length);
     +        let length_before = vec.length;
     +        vec.shrink_to_fit();
     +        assert_eq!(length_before, vec.length);
     +        assert_eq!(vec.length, vec.capacity);
    -+        // assert_eq!(vec.capacity, vec.slice.len());
     +    }
     +
     +    #[test]
    @@ rust/interop/src/ivec.rs (new)
     +        assert_eq!(16, vec.element_size);
     +        assert_eq!(size_of::<usize>() * 4, size_of::<IVec<u128>>());
     +    }
    -+
    -+    #[test]
    -+    fn test_manual_free() {
    -+        type TestType = i16;
    -+        let mut vec = IVec::<TestType>::new();
    -+
    -+        unsafe { vec._free() };
    -+        assert!(vec.ptr.is_null());
    -+        assert_eq!(0, vec.length);
    -+        assert_eq!(0, vec.capacity);
    -+        assert_eq!(size_of::<TestType>(), vec.element_size);
    -+    }
     +}
     
      ## rust/interop/src/lib.rs ##
    @@ rust/interop/src/lib.rs
     +    pub fn realloc(ptr: *mut c_void, size: usize) -> *mut c_void;
     +    pub fn free(ptr: *mut c_void);
     +}
    -
    - ## rust/xdiff/src/lib.rs ##
    -@@
    -+
 7:  d4bed95463 =  7:  3a6f822e2a xdiff/xprepare: remove superfluous forward declarations
 8:  7c68ce5349 =  8:  c7cd71dae0 xdiff: delete unnecessary fields from xrecord_t and xdfile_t
 9:  e516ccc8c0 =  9:  1096c8f0a4 xdiff: make fields of xrecord_t Rust friendly
10:  21bfb9f088 = 10:  0cd2168512 xdiff: use one definition for freeing xdfile_t
11:  6ce0e252b3 ! 11:  7ea2dccd71 xdiff: replace chastore with an ivec in xdfile_t
    @@ Commit message
         xdiff: replace chastore with an ivec in xdfile_t
     
         xdfile_t currently uses a chastore which functions as a memory pool and
    -    a vector which maps to the alocations created by the chastore. It seems
    +    a vector which maps to the allocations created by the chastore. It seems
         like xrecord_t used to be a linked list until the recs and nrec fields
         were added. I think that xrecord_t.next was meant to be removed, but
         was overlooked. This dual data structure setup make the code somewhat
12:  0cfc6cf26b = 12:  d8f561e173 xdiff: delete nrec field from xdfile_t
13:  cf0387d851 = 13:  15c2854a32 xdiff: delete recs field from xdfile_t
14:  ea699135f9 = 14:  3dacb2c09d xdiff: make xdfile_t more rust friendly
15:  b18544b74f ! 15:  9fdd23acf6 xdiff: implement xdl_trim_ends() in Rust
    @@ rust/xdiff/src/lib.rs
     @@
     +pub mod xprepare;
     +pub mod xtypes;
    - 
    ++
     +use crate::xprepare::trim_ends;
     +use crate::xtypes::xdfile;
     +


Ezekiel Newren (13):
  xdiff: introduce rust
  github workflows: install rust
  github workflows: upload Cargo.lock
  ivec: create a vector type that is interoperable between C and Rust
  xdiff/xprepare: remove superfluous forward declarations
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: make fields of xrecord_t Rust friendly
  xdiff: use one definition for freeing xdfile_t
  xdiff: replace chastore with an ivec in xdfile_t
  xdiff: delete nrec field from xdfile_t
  xdiff: delete recs field from xdfile_t
  xdiff: make xdfile_t more rust friendly
  xdiff: implement xdl_trim_ends() in Rust

Johannes Schindelin (1):
  win+Meson: do allow linking with the Rust-built xdiff

brian m. carlson (1):
  doc: add a policy for using Rust

 .github/workflows/main.yml                    |  88 ++-
 .gitignore                                    |   3 +
 Documentation/Makefile                        |   1 +
 Documentation/technical/platform-support.adoc |   2 +
 Documentation/technical/rust-support.adoc     | 142 +++++
 Makefile                                      |  67 ++-
 build_rust.sh                                 |  57 ++
 ci/install-dependencies.sh                    |  14 +-
 ci/install-rust-toolchain.sh                  |  30 +
 ci/install-rustup.sh                          |  25 +
 ci/lib.sh                                     |   1 +
 ci/make-test-artifacts.sh                     |   9 +
 ci/run-build-and-tests.sh                     |  13 +
 config.mak.uname                              |   4 +
 git-compat-util.h                             |  17 +
 interop/ivec.c                                | 180 ++++++
 interop/ivec.h                                |  60 ++
 meson.build                                   |  54 +-
 rust/Cargo.toml                               |   6 +
 rust/interop/Cargo.toml                       |  14 +
 rust/interop/src/ivec.rs                      | 516 ++++++++++++++++++
 rust/interop/src/lib.rs                       |  10 +
 rust/xdiff/Cargo.toml                         |  15 +
 rust/xdiff/src/lib.rs                         |  15 +
 rust/xdiff/src/xprepare.rs                    |  27 +
 rust/xdiff/src/xtypes.rs                      |  19 +
 xdiff/xdiffi.c                                |  60 +-
 xdiff/xdiffi.h                                |   8 +-
 xdiff/xemit.c                                 |  24 +-
 xdiff/xhistogram.c                            |   2 +-
 xdiff/xmerge.c                                |  72 +--
 xdiff/xpatience.c                             |  16 +-
 xdiff/xprepare.c                              | 271 ++++-----
 xdiff/xtypes.h                                |  27 +-
 xdiff/xutils.c                                |  12 +-
 35 files changed, 1562 insertions(+), 319 deletions(-)
 create mode 100644 Documentation/technical/rust-support.adoc
 create mode 100755 build_rust.sh
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh
 create mode 100644 interop/ivec.c
 create mode 100644 interop/ivec.h
 create mode 100644 rust/Cargo.toml
 create mode 100644 rust/interop/Cargo.toml
 create mode 100644 rust/interop/src/ivec.rs
 create mode 100644 rust/interop/src/lib.rs
 create mode 100644 rust/xdiff/Cargo.toml
 create mode 100644 rust/xdiff/src/lib.rs
 create mode 100644 rust/xdiff/src/xprepare.rs
 create mode 100644 rust/xdiff/src/xtypes.rs


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2043%2Fezekielnewren%2Fintroduce_rust-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2043/ezekielnewren/introduce_rust-v1
Pull-Request: https://github.com/git/git/pull/2043
-- 
gitgitgadget
