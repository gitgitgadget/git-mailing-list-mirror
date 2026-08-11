Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20463126D7
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443140; cv=pass; b=DyP7kI5RaM5y3zKSAbD37hpy+8yg9oSB25IvkdtlfrUYFn+O8BAE3W1gHrSjqlwKeP/MELyk3VTUxGhE5tmUzzAwec3WhaN1SW8+72JXnybfS1FVlfW41k70jX2YDITI7YPQOsdA+Hoa3G390JyFrO56bINHi2PtEi8/DqcnhLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443140; c=relaxed/simple;
	bh=lv6deANId7tCndLpFR8OWNHRmX556henaWVE5Q/vp5A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF1dlY69OVD2EFnxr5kJFjAM0j3uVmj3nboAUlaR0d+X0GBkIUaMwyHW+EaQpfCvXgHqIundKgWE2lXPSM/oVlVQQnLm7Ztu2Brnu4CMHSsVaMYeYw4sNf+qFxTBF1P5iGPyy6yqsuCuuO/O4o0s45/Yfm9bO92etYio9zIJ6ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVwg5W4T; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVwg5W4T"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf95ade656so1025864e0c.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 03:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786443126; cv=none;
        d=google.com; s=arc-20260327;
        b=LKpjlSH8HtgxB13dR3El92afM6K4l4BQpVBlE+1NgudjO6kxnB53bBoNdXWZgcelm5
         Blh8UI1HuUKVatkJlUGDdJA37Ykkrq2xiTOCcDZC8E81hwpxQen098is6OBBYPy1pWGv
         KEWLc40+csshlzWGElsFu7SCt/Elu2sStwZCOgRDIAPLsPcW2VraLiKWeFS/6OWtFyYQ
         t4FyOwjjj4ltdXd5UM3NCJPXz3aGjorwUpeq0U14snLat2JPLmsT5eqepcC+AYLWUYFS
         uvg4YUsud8giwQMco/VsSo3WfVrNEWDFtPfpAt+Q4TZqxM+bTx4C+lm+ZBiy1qXUK/xO
         RPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FLgyJy93oPX+cH2hD7DWMQ5MUXSGurwOg8fhN/tA3RI=;
        fh=wUXQR+H0LmEZy5W52BKJU2uvRA9Uj6/uvgWBLhfighs=;
        b=am3XBgPFclQtjLVGt5xPg+OpFFWGmlyehbT+v7yVbQZSo2Z1y1bVuItsmUp8pbQLmG
         LVRQZ9WghRxf4Z0onu3wIrGA1NF8A2Qcq6yw0XzDAgh0kzQIMbWu4rMzgyzphW1V/w3A
         v99KOAz/kdNR6mM6h1mCy+EsceodgtSxF/CJ140OOf8M5KUQrRK0nShpu+87eRgTVLtV
         RreiVUUNYYthTLz8QNjs0Df8oVnOIzXI+zdVkdvddFhoaqG1+NBcCnJbmnB5bjLTEU+6
         JUnEmDCroXOfxxN71wYEyCzsP8Ud5U/NIloszGdxKb6NgVhgnwEaz7rVcz5FCrKYs1i8
         Ca1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786443126; x=1787047926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLgyJy93oPX+cH2hD7DWMQ5MUXSGurwOg8fhN/tA3RI=;
        b=fVwg5W4TAQNGXSemQqx6JF1NSS4+/kL5O0rB0etjmb6sVDgY/7VYUaYjvGIcRv3/Jf
         eba7TaraCHTiB0ToeRvGrLOB+FsplheQfWECzHJMzUItze2oTES424rfNRp/Uj5LJQ9B
         vVU7nSssaI7vSnw/CfyVYtXwid0URsa46AGldycULbeNsPEUIhJb87Ry8eD4eTBak8aF
         luG4VjkeLfbaNyuHSWBhgEu9/aH98PPxmlpA6U5aZrLX048/bGMFke9gBPdof9GGhhfk
         HwthLrHGoNWHoueU75/451CnRlaLjm2m4xuD6xvTiw1M2sPiJu6Vu+b0qjZLtNSugV6n
         TMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443126; x=1787047926;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLgyJy93oPX+cH2hD7DWMQ5MUXSGurwOg8fhN/tA3RI=;
        b=l3zy7rCXBs126EejtPV4fP6LuFSwt4etr3dT2mnEZsMfTGKaM18K8R9pEbNJEKZfcT
         eynCqrVHhPjJmq5ZT2vz3cEudQjGBLZFcn/xqaS7VcKxKCnSUAyhuCZoC+2K7R0zyOdg
         1PO2yXBhP4wYBYCAovDQcWIm0sxBGxKigOh5WLphhseBApPpcYXmEGug40sbuRHakaRK
         hgvpxBVTFuZrX4b6FLW5qGFYF1ln9eXsPbGV8TPMGj+XN0eg6pgkyhV+HXtYIWMYdRy+
         dWhy0r/zodAm2jSBZ6H8w9Fc8bs9jyoYaayI6XCEYD5t+5mAAd7D49hGOdxUcXe96bkW
         116A==
X-Forwarded-Encrypted: i=1; AHgh+Rp4rxpI52/yDFiJxzkvSPAQqoIz86KdvWSlvafwx+QvEOpLORLuGRe52pJ9AjrfCONQzNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HqSpKkliWqWoRjewo+CK9p4L8nsYQ4u1PC7NQo2e53MEOWnn
	qnStElzzvvY6WxZ2CyiWa5Loj/8/rmkqKn6q/WdsT+AkluprRsoIE00G/SJyZ7onMM3IY7XFwZy
	AkioUVYntcvFdQTCrQL1eR3OgDHsC7Nd+T/d3
X-Gm-Gg: AR+sD1131QBNpXPbD5LtajZWm4wKnH9/K9U45mOfWzuEVAc/pXERafUuh2M1XGafiWQ
	PK0jXZa6OBg42lnMo5W6JGHuk6rmS/l4Ymx806ogvqTfqgorbXUlhDnJC7J/utmybvScZDZ0L9k
	vVMvcJf+XgV+vp0WJtYydPhHM/Q2CoidvuVT7g/YWnawXn2lLtTJe4bUru1wl5seFNxZCCu0JZn
	zwTl3E8NOYCeXfEMn0hchzCz5s3hZB79I6fis1Jm0vYeBdy0+joHMS3il9FAINAFiBGJpF5NuYU
	1Xho8RaXhpG5RtdigYRDvcW22Tlkkz2LqQizQx2CEXesfgqB5fkAUmNPrdIZW8DNDzfdWIZXMek
	qnHJul+4jkC++NTJCtIBe6TN+UPQvx44OpOFG4GFZdLUSbQ==
X-Received: by 2002:a05:6122:d1e:b0:5a1:fbbd:6bd0 with SMTP id
 71dfb90a1353d-5c4503b7528mr246390e0c.5.1786443126166; Tue, 11 Aug 2026
 03:12:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 06:12:05 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 06:12:05 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-5-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im> <20260805-pks-odb-stream-unification-v2-5-b8c369564641@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 06:12:05 -0400
X-Gm-Features: AUfX_mzukH5cjtcCm1dFP9tRtCyIiLqOT8DgDeN1N8XwobQTUGuNh8EbPH466wY
Message-ID: <CAOLa=ZTi8tL896_F2ONQck0z+H8NYhzcbTorb80NOdiqvnpjNg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] odb/streaming: consolidate read and write streams
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000f273720658c2b313"

--000000000000f273720658c2b313
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `struct odb_read_stream` and `struct odb_write_stream` both provide
> the same functionality: they allow a caller to read object data from an
> arbitrary source. Historically, the only difference was that the read
> stream was used to read data out of the object database, whereas the
> write stream was used to write data into the object database, but the
> interfaces were mostly the same.
>
> Over the preceding commits we have refactored the write stream to have
> almost exactly the same interface as the read stream. With these
> refactorings we can now easily merge those two streams into a single
> interface that's used for both use cases.
>
> While most of the changes are mechanical, there are two sites that need
> special mention:
>
>   - "builtin/unpack-objects.c" creates a write stream from compressed
>     object data.
>
>   - "odb/streaming.c" creates a write stream from a file descriptor.
>
> Adapting these sites to yield the new stream type requires a couple more
> changes. Most importantly, instead of embedding the pointer to the data
> in `struct odb_write_stream`, we now allocate a structure that wraps the
> new `struct odb_stream` base. Other than that though, the changes are
> rather straight forward.
>

So instead of `odb_write_stream.data` which was pointing to the data, we
simply wrap the stream with the data's structure, this allows us to get
the parent struct if we have the `odb_stream`. Alright!

> Some of the structures and functions are now somewhat misnamed. These
> will be fixed in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/unpack-objects.c      | 31 ++++++++++++++++---------------
>  object-file.c                 | 25 ++++++++++++-------------
>  odb.c                         |  2 +-
>  odb.h                         |  4 ++--
>  odb/source-files.c            |  2 +-
>  odb/source-inmemory.c         |  4 ++--
>  odb/source-loose.c            |  6 +++---
>  odb/source-packed.c           |  2 +-
>  odb/source.h                  |  4 ++--
>  odb/streaming.c               | 35 ++++++++++++++++-------------------
>  odb/streaming.h               | 31 +++----------------------------
>  odb/transaction.c             |  2 +-
>  odb/transaction.h             |  4 ++--
>  t/unit-tests/u-odb-inmemory.c |  6 +++---
>  14 files changed, 65 insertions(+), 93 deletions(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 7439ec53be..05a2d48011 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -359,20 +359,21 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
>  }
>
>  struct input_zstream_data {
> +	struct odb_stream base;
>  	git_zstream *zstream;
>  	int status;
>  };
>
> -static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
> -				  unsigned char *buf, size_t buf_len)
> +static ssize_t feed_input_zstream(struct odb_stream *in_stream,
> +				  char *buf, size_t buf_len)
>  {
> -	struct input_zstream_data *data = in_stream->data;
> +	struct input_zstream_data *data = container_of(in_stream, struct input_zstream_data, base);
>  	git_zstream *zstream = data->zstream;
>
>  	if (data->status != Z_OK)
>  		return 0;
>
> -	zstream->next_out = buf;
> +	zstream->next_out = (unsigned char *) buf;

But we do loose information here since we now use 'char *' for both
read/write. But we gain flexibility.

[snip]

The rest looks good.

--000000000000f273720658c2b313
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2f83343236f64c95_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wNjlYTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGZGREFDYTFBa080dmo1cXNDclBEemdJSUQ0dlRxKwpCWXpCVWo1SUFJ
TzNMbWw3RDJCUUYvYVg1Z1o3eWlyRTZnc1A1dmJSOEpUcjVyUFdHa0QvK29sWjdsSXRCS3o0CnpY
aUtFVlM4UGpvcDluYzlhTVYvUFoxL0x0OHVOL1oySnM5UmdYRHI5U1ZFdW9wSGtxSjdPcXVZWlBD
WUxOVmcKcjRyTG5idGFQeEdzbFhQZkNsN3dBays5SDI2c29zalkya2NVRDlEN25IL3doNEt6d29l
N0F3K1RJZW52cWlHUwpUYlNCWWVDNG1sSzlZaXVqbENxVjNsTW1XeVZyVnFlS3dzdWhhOG9XZFRi
U05Qd3VOM3BWZmcrRDUxbEExL04rCnhpUjUvdUVxek52b1V0NUE5Q1lsZWJUOXQvTFM1QVMvUUUw
ZU9sUithNTc4NFQ0LzZEaXkxR3dkU1FFaU12NzMKbllkMHNiVUVVMk84SkVhekVYbDhWaURLaFJT
OWxvV2xwcGt4ME1KYXV3Nmd3UUxvSHRtSjI0clJUOUF0bHUxOQpEd0RYVHQvY3F4MndtV2VYSDZK
MWVyejY1QjBsVDEydHRLQkx2VCtNYStLREs4eVVSZllwL0dzLzR0SS9HOVp5CldYcHo5cjRxRDdp
OGpFWHJHVVpXSngxRUs5MThFcHMrS3BaZlFqdz0KPUZRYzcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f273720658c2b313--
