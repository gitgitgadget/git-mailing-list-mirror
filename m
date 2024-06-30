Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36F3987D
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719774694; cv=none; b=QrUxfPS4kn0omyAiB0r/Cjy2mY9PWpLhOSYj6pAX+svAB+8bsFsDyI3NaCIj4ZQ2szH8/+XPyJsfAe3c3FNzXe/pn7p8xtPlbxWJzRe92WL/gRJfQPSOowTxEhQFSvveMolmgQmDLNPHlFROhfytlTfdYkBaocuW0TCBK+1mBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719774694; c=relaxed/simple;
	bh=C9Gm6rey/0j9e8CLhBZ3cN5JQJ8AwWGgfPj9P6ZXtoY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhghgHAmuHYfxDNEHXtHi4/i4n31W9aUOEcVW2yLL2KRh3NQRAGlSUVPZU1KnXC9P6HTMXX2xUY8CQBgjZZse7pwB+d9Zo80M5T9IeiLnVeUXGQntIQ9D+cr6c0n6Q0/UF0h2qmDTc95dZMDMjIbcK7iaAIW7GLM3I4+zKT/2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6V61MBt; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6V61MBt"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70211abf4cbso367059a34.3
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719774692; x=1720379492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnnHBPSSfdJq3EXpMBLnCdi0vpXQQxSYDhYJp1TgXLY=;
        b=Y6V61MBthmUv0MIaJCbfAXrNVyzqmVjYuaR2nz2shROi4oJ51D0jqwpVqdj1kznJW9
         kLEs3QMTlZpWqoFl6g9S7Z5uKbtKyWMb1+Tgg0moXXWyhO1LOl0oL1GXyL0feXtR1bkD
         5dGjQN/Ajbi7nA1ZtVBC3atd0rsyGGUFHMyhGsjjGrDvdLGuHJfyG7QSPxkDTW9wxPsA
         X6KDovbYD8UdLTPPI30r2IXak5IJiQrKHw7ZvqPW140SF9v5uqO8EiB3QDYFeBt6Omq6
         UEZnX+7H/521lDCEVoPpQ1b94d9/0Ot+6mp2ky7XA9BrdfvA4H+Ack9zG9foHEaWkugo
         h+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719774692; x=1720379492;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnnHBPSSfdJq3EXpMBLnCdi0vpXQQxSYDhYJp1TgXLY=;
        b=Ea/2dTxI5WzR+6gYpFV8r5wcPBG+B55Ejj+IR+p0OG8LcL57U7LtGiEkFdXdhQ1Bzr
         pOtwVT0w73D0s7oTgPAXyleP1aZ/6Q6UQFpsQN5V3pRBDDn8fsvlAfeBZ4hFhnpTenPn
         a/rcEka25pnX8JSWhEtMHOIXpB5PnWF5m6AYAIRlB6sYWqziJtdjEw/6ZhI8mW4i4Xoy
         sLhzW+KlCkK/nUvCXTHuWZBCuWTw8wqyQyz4pOKrPjOKxmkUcOK9YXagm6v8ddh57h47
         xFdgLE++FXgjHkfG8/5w9e7lPx2ltX1h+3dOXxyESGK/zLKmlAovsFGqXPLlYehzr+Y0
         Juxg==
X-Forwarded-Encrypted: i=1; AJvYcCXLk+1Mq7btFhw6wN0R37hiYbC8EKdgZd56/L9UZ0QtR1WFrUplNviwsfrtaHdhTwa2+KD6/ubZdvhNrD7TS15J6hUz
X-Gm-Message-State: AOJu0Yx4E6fN/1TzjfzgR+0/F6UYSmk/4hjHQs6yzww+cBWMaCUNH7T2
	bUPAgEhsXx4Hc0TJVyTksBleICaHQhbI766S/D5CbpWXAmHIaSq6RCPt9EpJnwf5aERNzhr1rs2
	Xhhgd/1cw2TrpvmnaRMzbAHNsL6dwsh0+
X-Google-Smtp-Source: AGHT+IGVBYf+tL8QmlAh1XEEJretk6ulm7nZvjSLjBBWw61j+sK6iIVHW055Dtx5hqAZIGUvaIAxcL2UuQaVo4uBb8s=
X-Received: by 2002:a05:6871:3a12:b0:258:42bd:d916 with SMTP id
 586e51a60fabf-25db3432f01mr3554810fac.14.1719774691622; Sun, 30 Jun 2024
 12:11:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 30 Jun 2024 15:11:30 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628063625.4092-12-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com> <20240628063625.4092-12-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Jun 2024 15:11:30 -0400
Message-ID: <CAOLa=ZSC9BFHBuqwnHj6VZDAL5Xuh0tkxAnXjEUkvh8ZpoZPQw@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] t-reftable-record: add tests for reftable_log_record_compare_key()
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000096a30b061c203f33"

--00000000000096a30b061c203f33
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable_log_record_compare_key() is a function defined by
> reftable/record.{c, h} and is used to compare the keys of two
> log records when sorting multiple log records using 'qsort'.
> In the current testing setup, this function is left unexercised.
> Add a testing function for the same.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-record.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index f45f2fdef2..cac8f632f9 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -208,6 +208,37 @@ static void test_reftable_log_record_comparison(void)
>  	check(!reftable_record_cmp(&in[0], &in[1]));
>  }
>
> +static void test_reftable_log_record_compare_key(void)
> +{
> +	struct reftable_log_record logs[14] = { 0 };
> +	size_t N = ARRAY_SIZE(logs), i;
> +
> +	for (i = 0; i < N; i++) {
> +		if (i < N / 2) {
> +			logs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
> +			logs[i].update_index = i;
> +		} else {
> +			logs[i].refname = xstrdup("refs/heads/master");
> +			logs[i].update_index = i;
> +		}
> +	}
> +

So we split the array into two sets, the first containing "00" ... "06"
and the next seven containing "refs/heads/master". It would be nice if
there was a comment here explaining why.

> +	QSORT(logs, N, reftable_log_record_compare_key);
> +
> +	for (i = 1; i < N / 2; i++)
> +		check_int(strcmp(logs[i - 1].refname, logs[i].refname), <, 0);
> +	for (i = N / 2 + 1; i < N; i++)
> +		check_int(logs[i - 1].update_index, >, logs[i].update_index);
> +
> +	for (i = 0; i < N - 1; i++) {
> +		check_int(reftable_log_record_compare_key(&logs[i], &logs[i]), ==, 0);
> +		check_int(reftable_log_record_compare_key(&logs[i + 1], &logs[i]), >, 0);
> +	}
> +

The same comments as the previous patch apply here too.

So the splitting of the array into two was mostly to show that for log
records, the update index is what determines the comparison factor when
the refname is the same I assume.

I can think of the following scenarios:
1. diff refnames, diff update index
2. diff refnames, same update index
3. same refnames, diff update index
4. same refnames, same update index

Seems like we test 1, 3 & 4. We should also test scenario 2.

Speaking of which, I also noticed that for scenario 4, we test this by
passing the same record '&logs[i]'. While this is useful, we should also
be testing passing different logs with the same value.

The difference is subtle here, but from a unit test point of view, we
want to ensure that the function works the same for records which have
same values and records which have the same address. This ensures to
test for function which would contain code like

    int reftable_log_record_compare_key(const void *a, const void *b)
    {
    	const struct reftable_log_record *la = a;
    	const struct reftable_log_record *lb = b;

        if (la == lb)
           return 0;
        ...

but forgot to check for value similarity.

> +	for (i = 0; i < N; i++)
> +		reftable_log_record_release(&logs[i]);
> +}
> +
>  static void test_reftable_log_record_roundtrip(void)
>  {
>  	struct reftable_log_record in[] = {
> @@ -513,6 +544,7 @@ int cmd_main(int argc, const char *argv[])
>  	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
>  	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
>  	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
> +	TEST(test_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
>  	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>  	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>  	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> --
> 2.45.2.404.g9eaef5822c

--00000000000096a30b061c203f33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 548b8740a2ed3e1d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hQnJlQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVBRREFDa1NjRHRLMW05TnpXSldpbklieHA0RjQzeQpxZDNHMVkrQmxn
NXZOVlRKZGE0MXE2OUU1WXBPRVh5dnQwZjE2UTBHbTVjK3B0eDZ3NVpoRmJXVEtCT3VSOWgrCmY3
LzJuZW5WbS9ueVZrWGhtdnlQbzVsOVFTYUpGYVJDR0VHQTRnUWdBbVhuMjltWnBwUmJ3Y1hrRlBT
Q283bXkKVWxSa1JtQWNOUEpLS1RhZTloeU5xRmNyTnVlenpaeTdyT1E0d250TElxWm9mQXdOU2Jr
ZGRzSkxIQisrQXhVVQpJUnJwcklVMzlZUmhkMnQxeGFIaHRtbjFqVDBuOFlCWU1JcFhSZ2Z0K2NS
bG9hdXNDZy9IWFJXcFBEUVNEdTY2ClRDUG0xR0ZQWDU0TXRBMm9EU0ZXZkY5Rjd2YnBpY0ZMNUM3
VzRwcE9PNDgwQ2hWZHAyMFo0bHZSQmRJVkFNVFMKTEI5cGxOTWNibFVrVE02Q3oxZUZKRzgxUFlL
Qis0VWQ4YTRWcVhKYTloZUgwc01GMEJ5RHJaMWZrV1NPZ3RCYgoyY0NlUkZJalJBSTdBNlBoVmpF
OUxpUUk2eHZnaTlzOVQydW5iT2tsQkh5YVB1MnI5UmZIQXJkeVRJYjlVdUNyCi95SDJrSWQwK3Bv
Y2EzUDNiTzVhT3BWOHpVY3ZsUGZJNTRyd044ND0KPWtwS00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000096a30b061c203f33--
