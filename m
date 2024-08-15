Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DB76026
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749124; cv=none; b=gAMgdgMfAKefDgWD+vfT340NZwe0KYikjfoL5j0mUPD30RjUtMo9pIgN47nhkPVJz5RuHx4fjE/r9YwUSxFkfbd2l5ZT8AJMkqeZ3sKRiJWUY1qhfyDfl9RuJq6k6UJ/aZ9fVz+Ia/reZGQhYaM2sq4bjVrVyYf8Bq3ua0V6fTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749124; c=relaxed/simple;
	bh=9aYO4g+3PFrRiizR0V5lJUW27eX87LNIqnMbztpY1og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RViEjNn2oOrnUHdT1qWjJYdE+2uf0Lfz4SGocXdWOGESB5ayl+T/in/yLdhIJLo6TMPPNTTjz5EGl1Nety65fjav94FUiCP0gwm5YAbrsmW1gFaz08K5cH4h92h51t3boe26s9F5z+lGeZd6Vgu1iJ2gb1a47ymD/vBHyiQzQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wkc2iRM8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkc2iRM8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8374e6a6fbso167538366b.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723749121; x=1724353921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GiCoqg8FiuMGo2HzjNLzyGswj1AE4DMH+uTSvDPLumI=;
        b=Wkc2iRM8TfqgHlZYDZZnkQMXSkp9EWvzN575/BvHpHaLIhOzRVMkaPwF+5cz5x+Akx
         7MeFGxuJPCJ9fBRdW82EmtyHhIV7V/Djvpeiv4+DLjErrCltjcHlHzWOYP3PgIXTUXGO
         fyH+CQW3cGluEv7kLuqrh8JPy59OB+ZrPouUBt9DBRDQVLYu6pmXhZdMbNTKEAVQyIfM
         s8+1I7OXAx45kiWmnh/K8hhNY7dNzc232w7yAaCEXfHHWB3lckkQrCZwdlMDGssHSVHc
         PNFVIEvSwLeKzsnUm71msmJJPAKrsAzwFPc0GIA+1sNOo25/8nB5RDhc4Savjml3Jk4C
         ddDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749121; x=1724353921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiCoqg8FiuMGo2HzjNLzyGswj1AE4DMH+uTSvDPLumI=;
        b=TTuCaGgK7TE2fjlb4vo1wdMvQXfQ1/5ILuMMuxL6MD01T12sznLb37wJfkezzzl4hn
         NKKhNitXjMNdJvO58EsaZ3q+E7JHN8gOGOkdub3Y5O1EOmIxmY9uvhQktQXiitDLajbK
         Aq/T5gkgepmrv57RiVbNuzaFT33TX5yVshON8mkh+aIonxh48uC/Pd/Lo4JUCj3wUP7N
         3fHb8Rtxewz7yxbQCkHA7xtXVKhyg9Iow2MdOPDZLpFtyk33KztCaauuA5OjPsFWNnLG
         Azfc4umJPP0PizlOdp5uMCnlHB+o8bmdWPu+JMVTm8zKVDF4Volul78E7HAR8JfqDEF5
         twXA==
X-Gm-Message-State: AOJu0YwsMWcvKYGNRIvyOymTcXnvdmlk6T9CI3sC51kXywXxN9IK4z4c
	A+GL2GXTfd4y14yErk+J20r61SoEoXnAvY92VdSu72cbSCfcdBl9lFSE/uId9NqwDAajwZ6hEmN
	3fvBfbdQwTmqZc/XK6soL5aRFZkI=
X-Google-Smtp-Source: AGHT+IGaNFti9+efCD/qHvwTrP5KJZMDmbp8d4+cCsEAs2GPwy8bWCEYX09fd6ji+TyqoSD4hoJ5k2L+hzOTNkQo9EI=
X-Received: by 2002:a17:906:f595:b0:a77:dd1c:6273 with SMTP id
 a640c23a62f3a-a83928a9930mr37133966b.12.1723749120907; Thu, 15 Aug 2024
 12:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-10-chandrapratap3519@gmail.com> <Zr3NNBTXNXSCrTpJ@tanuki>
In-Reply-To: <Zr3NNBTXNXSCrTpJ@tanuki>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 16 Aug 2024 00:41:34 +0530
Message-ID: <CA+J6zkRHZ3NF8QV_oFBVEO8gCy-Pvf6zerdiY7aKCqkofRPktA@mail.gmail.com>
Subject: Re: [PATCH 09/10] t-reftable-block: add tests for obj blocks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 15:11, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Aug 14, 2024 at 05:33:17PM +0530, Chandra Pratap wrote:
> > In the current testing setup, block operations are left unexercised
> > for obj blocks. Add a test that exercises these operations for obj
> > blocks.
>
> Same remarks here as for the preceding commit.
>
> > @@ -186,9 +186,88 @@ static void t_log_block_read_write(void)
> >               reftable_record_release(&recs[i]);
> >  }
> >
> > +static void t_obj_block_read_write(void)
> > +{
> > +     const int header_off = 21;
> > +     struct reftable_record recs[30];
> > +     const size_t N = ARRAY_SIZE(recs);
> > +     const size_t block_size = 1024;
> > +     struct reftable_block block = { 0 };
> > +     struct block_writer bw = {
> > +             .last_key = STRBUF_INIT,
> > +     };
> > +     struct reftable_record rec = {
> > +             .type = BLOCK_TYPE_OBJ,
> > +     };
> > +     size_t i = 0;
> > +     int n;
> > +     struct block_reader br = { 0 };
> > +     struct block_iter it = BLOCK_ITER_INIT;
> > +     struct strbuf want = STRBUF_INIT;
> > +
> > +     REFTABLE_CALLOC_ARRAY(block.data, block_size);
> > +     block.len = block_size;
> > +     block.source = malloc_block_source();
> > +     block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
> > +                       header_off, hash_size(GIT_SHA1_FORMAT_ID));
> > +
> > +     for (i = 0; i < N; i++) {
> > +             uint8_t *bytes = reftable_malloc(sizeof(uint8_t[5]));
> > +             memcpy(bytes, (uint8_t[]){i, i+1, i+2, i+3, i+5}, sizeof(uint8_t[5]));
>
> From the top of my head I'm not sure whether we use inline-array
> declarations like this anywhere. I'd rather just make it a separate
> variable, which also allows us to get rid of the magic 5 via
> `ARRAY_SIZE()`.

We _do_ use inline array declarations like this, here's an example from
t/unit-tests/t-prio-queue.c:
TEST(TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
          ((int []){ 1, 2, 3, 4, 5, 6 })), "prio-queue works when LIFO
stack is reversed");

I did implement bytes[] as a local variable array when I first worked
on this patch but that turned out to be tricky due to variable scoping
and pointer semantics, so I ultimately settled on this approach.
