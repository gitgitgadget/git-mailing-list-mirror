Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAD42EECA
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472518; cv=none; b=m36uFKwAybBfP11YDI2uzQgCyQWUEmTxt3g499vWJ+gD/osDrn7IB2AjiNgmrqL7tZ0cvuiO4fypgz1xESEcn0dKiqgoUuYgkVsWXpl9sTu6NVsStumuLuCE+sNmCETr/9uUmHyJlE0QUyt77iD5CCu6F/jIR4xGIEarhJj02d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472518; c=relaxed/simple;
	bh=BfFEd/4D7gda50h9Hqpld/kWm/uzE4vRQruGlzXokww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkpfC41N0aSM+gZ/BsHM7A+Tr9yVphrgO5x3uW48CGltQ87EHYKAB1pi4N+t9kjHVr/fp0N94GOU+uQGmb77AS7q5vZo4hBdy3Ok8ZlDQCIldVKpCYdsorpH0e8/SEkrsUPW9+KqyPt5D7c0wOMofTfX9dMmfMzvU3S+voM/TfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhxJ/4vb; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhxJ/4vb"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d55b97f358so4160479a34.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 09:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772472515; x=1773077315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM2NG8UZg4SMkLoCV0MZg9FATBCL45UJAMTfxHlQZ2M=;
        b=GhxJ/4vb5gBhdDQFOOUYyHY5qNNrQn133nQUkIMT3D10JH0F5L0+g+XBntEIjF/VeG
         ORYVFJbN5H4JnorF7Ki6TUCZfY2siNccmHHJHU5WVRuz0HBDOL3JtlSBv85u8kYMhl8L
         j+vYNusvNY8tqRqPiQ4xfR+UfMIQ8d0szunEMT0jwYgJoSh4hhZBFeuaWr/ztqc/i8gS
         AEZIs8ZmXt9dznVPG11Hy1xPYTFpH+a6uDup85Oo4F5+wqOA1EFIYh/L8zUGXmiOtAfC
         1a7JMu1kYhHpLB44ckjT2AJLPh1asKb0RQdOM8An3W/UyqN/FnpHWyF/LBT7hmLnIsVA
         MrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472515; x=1773077315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM2NG8UZg4SMkLoCV0MZg9FATBCL45UJAMTfxHlQZ2M=;
        b=pu0IOqNlqw7uuceIrK8ZlVAa/7rhtt9+qBu5XBAxUAfYSb8tkMuCfbs8NYOJHjNjt3
         EBEOg0ODm5WdWvFK9BcffLfQoMfJ4jrWc6Nt6zokaCexQWXF8aIzWlJmCCZBjU978Sju
         6HPDsseJVu+Q9YaKEF5RpmxucFNXJsbcYMsNq6cptS8ZgBWbuw5YXCdS6Fomc2Gd72LX
         +JqRjda8VQgMvE7n6v9bEvRf/os5wRC66KL947rY2FC/WiyV9P3w8Je+oidQCUw10W5h
         3dvtEfHiG26RvWRAq4ByRJ7qNAVpaqLlL59RIjZ8/ZEmplK2f7RaGUtYuJu4kOf8UwQU
         8eHA==
X-Gm-Message-State: AOJu0YwrEu38UePNCXZ5csksDCvroe8oRfCqyEaDUJxluFtup6lD+2um
	cyt4xKHZ+NDOOGDDvYxgiOTEN2ylD8AGnR82XnenU9m7A+dnK+iG/Yi+
X-Gm-Gg: ATEYQzxWVNOyxF2JnNvIxtNJ7b98Idqvqyyt7ZV8JctGHHk6fRDAu82ucsBGEE6TJNY
	T/7+duABnPcNUfLgWHwor9u+lPBThqsJJXR11rfyN+2NvsyAJ3xAYYME7ND2EmHWHzFHEm1wxji
	wS0NJ8S3D+1XE2BcmZFUDDKIHfmX1VBORhTv514gbcM78vGAdYfV0YMzKXl1ZI9eQf+oWTaJJ9z
	JbGLLCPnGYSv9OicXnqxpHmnfddDL43s6vXhsO6TNzaQV2cU/orP9zq31RltfbQmih06jtDwZLa
	4AEiQ/4aFC5v8TCX1RD4vKEa6ocCGu7ksq4xEBDzdE0JZOQXibspi5m3Dv6o5FJ14USeyXy8FNb
	ONsGXnpOOoUN6EHJNv74wgGISYoY33nDMUr6U0/8ubJl1c0OdElTH9/9U+4cuPXQSSZTVycnAHm
	OU69e2JMN5tKt6bGLJ
X-Received: by 2002:a05:6870:15c8:b0:409:79d2:43a6 with SMTP id 586e51a60fabf-41626ff8323mr7202408fac.36.1772472515106;
        Mon, 02 Mar 2026 09:28:35 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d277316sm12344899fac.17.2026.03.02.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:28:34 -0800 (PST)
Date: Mon, 2 Mar 2026 11:28:32 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com, 
	eslam.reda.div@gmail.com
Subject: Re: [PATCH v2 2/5] builtin/repo: collect largest inflated objects
Message-ID: <aaXFcz8AQrwRtr5C@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
 <20260223174120.2356504-3-jltobler@gmail.com>
 <xmqqv7fj1dzg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7fj1dzg.fsf@gitster.g>

On 26/02/26 11:50AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > @@ -485,6 +514,23 @@ static void structure_keyvalue_print(struct repo_structure *stats,
> >  	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
> >  	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
> >  
> > +	printf("objects.commits.max_size%c%" PRIuMAX "%c", key_delim,
> > +	       (uintmax_t)stats->objects.largest.commit_size.value, value_delim);
> > +	printf("objects.commits.max_size_oid%c%s%c", key_delim,
> > +	       oid_to_hex(&stats->objects.largest.commit_size.oid), value_delim);
> > +	printf("objects.trees.max_size%c%" PRIuMAX "%c", key_delim,
> > +	       (uintmax_t)stats->objects.largest.tree_size.value, value_delim);
> > +	printf("objects.trees.max_size_oid%c%s%c", key_delim,
> > +	       oid_to_hex(&stats->objects.largest.tree_size.oid), value_delim);
> > +	printf("objects.blobs.max_size%c%" PRIuMAX "%c", key_delim,
> > +	       (uintmax_t)stats->objects.largest.blob_size.value, value_delim);
> > +	printf("objects.blobs.max_size_oid%c%s%c", key_delim,
> > +	       oid_to_hex(&stats->objects.largest.blob_size.oid), value_delim);
> > +	printf("objects.tags.max_size%c%" PRIuMAX "%c", key_delim,
> > +	       (uintmax_t)stats->objects.largest.tag_size.value, value_delim);
> > +	printf("objects.tags.max_size_oid%c%s%c", key_delim,
> > +	       oid_to_hex(&stats->objects.largest.tag_size.oid), value_delim);
> 
> The repetition tires reviewers' eyes.  I am reasonably sure if there
> were an intentional copy-and-paste error, I wouldn't be able to spot
> it.  But I tried to be careful and read it over three times ;-).

Ya, I was thinking about adding another patch that reduces the
duplication for the output here. I'll go ahead and do that in the next
version.

> > @@ -553,6 +599,15 @@ struct count_objects_data {
> >  	struct progress *progress;
> >  };
> >  
> > +static void check_largest(struct object_data *data, struct object_id *oid,
> > +			  size_t value)
> > +{
> > +	if (value > data->value) {
> > +		oidcpy(&data->oid, oid);
> > +		data->value = value;
> > +	}
> > +}
> 
> How important is it for this application to end up with a valid
> value in data->oid?
> 
> If data->value is initialized to a valid value, instead of an
> impossible sentinel value that is strictly smaller than any valid
> values, this can leave data->value to a valid value from an existing
> object without recording its object name.  Imagine a repository with
> a single empty blob, and data->value initialized to zero (it cannot
> be initialized to a sentinel -1, as use of size_t here makes it
> impossible to have any reasonable sentinel values).

So in cases where we do not record an OID for an object, the table
output format knows not to show any annotations and the machine parsable
formats display null OIDs. In the example you provided though, this
technically wouldn't be correct though as it possible we could have an
empty blob.

One way we could deal which this is have a sentinel value of -1 for the
size value as you mentioned. Another option could be to check if the OID
is a null value and if so record the value regardless. I'll work on this
in the next version.

Thanks,
-Justin
