Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531077;
	b=TqxPc6q9Ak3gva88yBPGVP5MX8V3S+I0ukM8WwYgfZGNlbEG3temmZwcunhE1pOFkQ+v
	 aBLqbyXFf64k+LybxV4r4wiAQ8C35T/lhBhi9eYuTXwc8fIaqo15HvzdelIGjavv/Er9M
	 sZD9S6wF2p31LOeu1eGXOaa7scp7bLRS3AfGnZzL3wJ5FoJ2cJm5s7FRRWxVxDTCZtL6S
	 DY+AlCIyOOpgzqFK6miH/HBAmRGRnK1UUu6TgzHD5sBPJ/53hJ662dj0jcwH9dBdg6zzx
	 +kyWn2U4KBiAcBIC4XyqQTllwpcqarXyU0ewEi5aeC0nDuzc0+flkaen62oGrc89urQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V2XmLQSG2Six5VRgs5VEMu9N2FSRLq2ZoOFKq+2Wv7o=;
	b=vNO4GBjhH+7bQRG8rN2hwuZuBuwfWgBobxMc4rEI122kvjLnPffM9L0UjgOyDeNePBup
	 hUNPAWJvRj5B9xfI+pPqMOaES0QnNjkAaqZ/oL7U7bCNDAult7/Mc6dukQVqoMpRfH6bV
	 0pxBv4ZBnaik6G/CByTwYZR9mQyHZhtrxbq4cYmMTq2RNMkS68n4YbKQx4gwT/e2YavMk
	 6DwLf2lr5PGyDaDCpkhtSFugThgApQpJEcMX/R6v1xYS1Bk9k0/SCgaEx2EeXBZDY/wWq
	 UBL+SC9j6IsOzBqcU9C386Js3ZA7klbllLU83Nxai1Oc4oWjntxGtVxt6cxRE1slx7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WF25NImh;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6227606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6227606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WF25NImh
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so59690355e9.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795531075; x=1796135875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2XmLQSG2Six5VRgs5VEMu9N2FSRLq2ZoOFKq+2Wv7o=;
        b=WF25NImhxO0vN4ts0d6a0++Lg1qtUOI8Vj4rbbYyS7QLP355r+7h5nBk9P0m5TISY+
         M5tLoC7e20ucAzSQxezt9wGnPGC4m/reWfmRhbf9yFXYO3Fj93ejUQ2oPB5y7ccxprkV
         e1/UmaKFzDX/C8vQ7qfIwSb5Zz9XxbZ++EfH4F8mphOeItnPW5xVrxsDsNyfFWKfgIpg
         YTt6JUB1k944DafmwQVywBuni9OPxGFb+mZecvz9zdF6zZHAfChkg3fFMBOcZYmj3Qrz
         Nf2VwknndkQf9W1B3nWL9D1JeWgJfPLsN/Lf7JSeZKjRxfEzsole3+hZ7EfAsS4e4Y2n
         DmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531075; x=1796135875;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2XmLQSG2Six5VRgs5VEMu9N2FSRLq2ZoOFKq+2Wv7o=;
        b=TgKcwAb72ROQyiM/XrmPM4E24NDAXbOHgH1b/O6Vs9hniEdbfdSJXBymUe/7FNPuAJ
         6LYszvDcnNp+BJzuxoZc4IOT0QuaKwdTUj7kwLFaa7K58Wuj+BLaiKBXACouS3xh4VXF
         QZS8FGgTrRvm3sr6rXnmmy7mA9WDo9lPNRbwruwXSBhjKcqSy+vx0ENM5jkY+uDPdEX6
         u+obbRV1BADDNveDxG7+KWsvebQpQQDAOnEVifP/eZYozu9oJViGa0uiGNAModgGyh/4
         TJuQaqFUop8JFb3TsSw7YBnhqy8wrl9HLqicwtjWuAjo8+yU2OAdZw+X/zwm+ryybNaJ
         sAcw==
X-Forwarded-Encrypted: i=1; AL+hErEvBT5i2tytbgHhl5PwreX2tSuTqjKpc0RSNkQXqwtcV3ultsEoYgI+oFBmSf04TyRciPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/p6lCI15h5sIB8kzYoMCPXcC4PAC6AskXFLkUyCcWM4SjJOJF
	p7k9im18jmwo9a+SvUi8FahRicHpmoI2BhrtGZp8VrqLkvUeX9k5Qg1a
X-Gm-Gg: AZFdTZe5lG/7BLSmPI5WzM1xPfG8PGU7QXEtw25WkDC+vZ5MBoNrzVIE3d0EKIyt5gK
	tMgPDeRYeclV7O9153p7Og1eDgNFNdgJ3uDMpg2dhCVXKTJDASIjqEeXt4JJOTLQaW4rgAWk3VF
	yTQBxZfHMijIL+TaVrwrNru1dugx6cq7o7aU9chKLFVYgi+HOJ7VDo3HXmQJkEboppaTUEafOAG
	w2lFT1bK1Fbre8ldkj+KUl74Th6TOpThosFFRWCfioZB6/w3bgLet/2wWpuT9G7oVAIHy4VRyJk
	zIgJBw4lI2FvI+OaAtsR60eqOfkNkG+7LMKFfhtJn1r7leZ9HAtywL4UC106vnU/QLAmCth1RB5
	EydaI7XvEYI44ryGVQV3rICyduINUXWIHOz7hfRf5EoWykh9p19uPhxXV2toSfYQvNZZyiIu7Bf
	dkG7VYdLS2DcpGG4s1CG38Ch5Eae+yj4vgPTRLNSMuNfKiSNt9diU8zuvzHGdj5k8gZA5hOP8vu
	VhOzIMrzAaa1d1Ivdq+wl9+a5rXlC8AEHCuBHhQh73GUSuS/WiUnyuFvXaW2xSPJnBsLk7jITIg
	pJ6kHgDXbIWaft0UGUuFT93V4rRNQrYPl0j3nJSI0q/p8nC59OkceWIS8MyUm3nFI76w3MHkivx
	lvNJEmqM=
X-Received: by 2002:a05:600c:5303:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4bb88807d7cmr288747065e9.9.1795531074846;
        Tue, 24 Nov 2026 06:37:54 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm526895525e9.6.2026.11.24.06.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 06:37:54 -0800 (PST)
Message-ID: <2cf35f82-9477-4ef8-bbbd-42fd06d487ea@gmail.com>
Date: Tue, 24 Nov 2026 14:37:45 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/5] wrapper: avoid byte-count overflow in
 write_in_full()
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Harald Nordgren
 <haraldnordgren@gmail.com>, Simon Richter <Simon.Richter@hogyros.de>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
 <b24520c50dc1ccc079ce6194b9ff9028e38e1b2b.1795472027.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <b24520c50dc1ccc079ce6194b9ff9028e38e1b2b.1795472027.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 23/11/2026 22:13, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Accumulating the output count in `write_in_full()` can overflow because
> it counts via a `ssize_t` variable which can overflow for valid `size_t`
> sizes passed as input.
> 
> Since this function either completes the requested count or fails,
> callers already know how many bytes were written on success. Let's just
> return status instead, so the total transfer size need not fit in
> `ssize_t`.

This makes perfect sense and the changes in this patch all look good. 
Looking at how the callers of write_in_full() use the return value, 
there are a few we might want to tweak.

In config.c write_section() and write_pair() both return the result of 
write_in_full(). All of the callers of those functions are only 
interested in whether the return value was negative, so there is no 
problem with the change in behavior, but we might want to change the 
return value to an int to match the new prototype of write_in_full().

In entry.c:write_entry() and parallel-checkout.c:write_pc_item_to_fd() 
we're still using a ssize_t to store the return value even though it is 
now an int.

In odb/streaming.c:odb_stream_blob_to_fd() we're also storing the return 
value in a ssize_t. Unlike the cases above we can simply avoid storing 
the value at all.

One final note - in refs.c:transaction_hook_feed_stdin(), 
sequencer.c:pipe_from_strbuf() and 
transport.c:pre_push_hook_feed_stdin() we're storing the result in an 
int and then checking if it is negative, so this patch actually fixes 
potential bugs in those callers.

Thanks

Phillip



> Pointed out by Coverity.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Assisted-by: GPT-6.1
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   Makefile                        |  1 +
>   imap-send.c                     |  2 +-
>   notes-merge.c                   | 13 ++--------
>   t/meson.build                   |  1 +
>   t/unit-tests/u-reftable-stack.c |  2 +-
>   t/unit-tests/u-wrapper.c        | 42 +++++++++++++++++++++++++++++++++
>   wrapper.c                       |  6 ++---
>   wrapper.h                       |  7 ++++--
>   8 files changed, 55 insertions(+), 19 deletions(-)
>   create mode 100644 t/unit-tests/u-wrapper.c
> 
> diff --git a/Makefile b/Makefile
> index 4c84eea6e2..0687eb82d3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1564,6 +1564,7 @@ CLAR_TEST_SUITES += u-strvec
>   CLAR_TEST_SUITES += u-trailer
>   CLAR_TEST_SUITES += u-urlmatch-normalization
>   CLAR_TEST_SUITES += u-utf8-width
> +CLAR_TEST_SUITES += u-wrapper
>   CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>   CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
>   CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> diff --git a/imap-send.c b/imap-send.c
> index bf1d2cf74d..dccc2264de 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -392,7 +392,7 @@ static int socket_write(struct imap_socket *sock, const char *buf, int len)
>   		n = SSL_write(sock->ssl, buf, len);
>   	else
>   #endif
> -		n = write_in_full(sock->fd[1], buf, len);
> +		n = write_in_full(sock->fd[1], buf, len) < 0 ? -1 : len;
>   	if (n != len) {
>   		socket_perror("write", sock, n);
>   		close(sock->fd[0]);
> diff --git a/notes-merge.c b/notes-merge.c
> index d361e70a48..991490a187 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -319,17 +319,8 @@ static void write_buf_to_worktree(const struct object_id *obj,
>   
>   	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
>   
> -	while (size > 0) {
> -		ssize_t ret = write_in_full(fd, buf, size);
> -		if (ret < 0) {
> -			/* Ignore epipe */
> -			if (errno == EPIPE)
> -				break;
> -			die_errno("notes-merge");
> -		}
> -		size -= ret;
> -		buf += ret;
> -	}
> +	if (write_in_full(fd, buf, size) < 0 && errno != EPIPE)
> +		die_errno("notes-merge");
>   
>   	close(fd);
>   	free(path);
> diff --git a/t/meson.build b/t/meson.build
> index 1cf1d95f70..8938d4eb47 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -27,6 +27,7 @@ clar_test_suites = [
>     'unit-tests/u-trailer.c',
>     'unit-tests/u-urlmatch-normalization.c',
>     'unit-tests/u-utf8-width.c',
> +  'unit-tests/u-wrapper.c',
>   ]
>   
>   clar_sources = [
> diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
> index b6f1c6cc52..3e19f0466a 100644
> --- a/t/unit-tests/u-reftable-stack.c
> +++ b/t/unit-tests/u-reftable-stack.c
> @@ -86,7 +86,7 @@ void test_reftable_stack__read_file(void)
>   
>   	cl_assert(fd > 0);
>   	n = write_in_full(fd, out, strlen(out));
> -	cl_assert_equal_i(n, strlen(out));
> +	cl_assert_equal_i(n, 0);
>   	err = close(fd);
>   	cl_assert(err >= 0);
>   
> diff --git a/t/unit-tests/u-wrapper.c b/t/unit-tests/u-wrapper.c
> new file mode 100644
> index 0000000000..713ac0df92
> --- /dev/null
> +++ b/t/unit-tests/u-wrapper.c
> @@ -0,0 +1,42 @@
> +#include "unit-test.h"
> +#include "tempfile.h"
> +
> +static struct tempfile *file;
> +static char data[128 * 1024], actual[sizeof(data)];
> +
> +void test_wrapper__initialize(void)
> +{
> +	file = mks_tempfile("wrapper-test-XXXXXX");
> +	cl_assert(file != NULL);
> +	for (size_t i = 0; i < sizeof(data); i++)
> +		data[i] = i % 127;
> +	memset(actual, 0, sizeof(actual));
> +}
> +
> +void test_wrapper__cleanup(void)
> +{
> +	delete_tempfile(&file);
> +}
> +
> +void test_wrapper__write_in_full(void)
> +{
> +	int fd = get_tempfile_fd(file);
> +
> +	cl_assert_equal_i(write_in_full(fd, data, sizeof(data)), 0);
> +	cl_assert(lseek(fd, 0, SEEK_SET) == 0);
> +	cl_assert(read_in_full(fd, actual, sizeof(actual)) ==
> +		  (ssize_t)sizeof(actual));
> +	cl_assert(!memcmp(data, actual, sizeof(data)));
> +}
> +
> +void test_wrapper__write_in_full_empty(void)
> +{
> +	cl_assert_equal_i(write_in_full(-1, NULL, 0), 0);
> +}
> +
> +void test_wrapper__write_in_full_error(void)
> +{
> +	errno = 0;
> +	cl_assert_equal_i(write_in_full(-1, data, 1), -1);
> +	cl_assert_equal_i(errno, EBADF);
> +}
> diff --git a/wrapper.c b/wrapper.c
> index 05a9cd369c..87e1b4bfd2 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -302,10 +302,9 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
>   	return total;
>   }
>   
> -ssize_t write_in_full(int fd, const void *buf, size_t count)
> +int write_in_full(int fd, const void *buf, size_t count)
>   {
>   	const char *p = buf;
> -	ssize_t total = 0;
>   
>   	while (count > 0) {
>   		ssize_t written = xwrite(fd, p, count);
> @@ -317,10 +316,9 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
>   		}
>   		count -= written;
>   		p += written;
> -		total += written;
>   	}
>   
> -	return total;
> +	return 0;
>   }
>   
>   ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
> diff --git a/wrapper.h b/wrapper.h
> index a6287d7f4d..726c5c2f6b 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -45,7 +45,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
>   int git_mkstemp_mode(char *pattern, int mode);
>   
>   ssize_t read_in_full(int fd, void *buf, size_t count);
> -ssize_t write_in_full(int fd, const void *buf, size_t count);
> +
> +/* Return 0 on a complete write, or -1 with errno set on failure. */
> +int write_in_full(int fd, const void *buf, size_t count);
> +
>   ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
>   
>   /*
> @@ -57,7 +60,7 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
>    */
>   ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt);
>   
> -static inline ssize_t write_str_in_full(int fd, const char *str)
> +static inline int write_str_in_full(int fd, const char *str)
>   {
>   	return write_in_full(fd, str, strlen(str));
>   }

