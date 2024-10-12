Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396815099D
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732088; cv=none; b=D6KxS8v8nVrhU2lY4JkiXsJeZNquNVnIMx/dnRFjuaDa80hU3yhru9Kvr5S96Bw8Vs60x/QWmkAuZ0MthxgKY/hI/zDTCQxyFZ2dGnXTD42tq7zLWcEdpJU2UipikaW9mUDbnOoKBBtPpWMJe0VHf4t6X4hqDf+pwpremUx70eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732088; c=relaxed/simple;
	bh=Iz4VfQQ+9Na14mZvgUGiGZRrZRJxzVt93sNJE8Rk8oU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b2lQtCHFYB9vNjsYbAovvZlyZ4R07J6qKDoV1LG6aZeMChQo6C+f45DWgGqJQszSWn8EfTb5SdH8z7RBTfDseih1RiDLotMTAsknwFsnbyHsAN7EDzHpRHz5uKawWkHIKX2uo1g+y1yInHnByFVkc0Avr1rPLyA9ITiJ56PSiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKoo5f02; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKoo5f02"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a46edda7d1so391295137.0
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728732085; x=1729336885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y6I2/CFLmhBnOcPHqIXPdOJkO1+X4kYHp7BgK78uoNY=;
        b=bKoo5f02Gphe6dRIr/oCqFVKXsYo6pZeIbpM56yE6APKaeyJoliqL3OvlKERMa2N5m
         gdUdMZnVf5ZwX3v3BC+Y5EjWV87pjtQR3RyOx80Qn2FvJt3MO/mUTBl+Mo4TMMxe9R6o
         BmsutB9Fm6pHM0Guy9s2PLxP14OKJN+ZqfKX+2E3Dd2tR1ILYw45TgVVloeX6lN0tEaP
         XhcgcyA8LSu7YoCVgcti+53HT2xKypYNhKLZmFlAxyZqZIRXnapHLYR5gjY2mJMvOiQI
         UHLF8Wh+ViaHid1XjaxS0EJBE/FzZ2f4Nvp7p4VbIeBTjKbrIy3/SdVOIqfQydOy+bmi
         xxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728732085; x=1729336885;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6I2/CFLmhBnOcPHqIXPdOJkO1+X4kYHp7BgK78uoNY=;
        b=AIxhJc3S3Ct4j00N8rfBAi4zy03LjtjQBZGJBjvK7/WmbyJSNi3pDkYOW1d7ej1kDi
         JX11tkqlME7B+QZp8x9L77QGqH0riGKmbMiRAQYSSncvnxYRVA4g/wvREhk8xguDVuO3
         G1puQVvd+/LNORtJNCbAyxZod0VIVPZr2YZn7Zm5E52dC+b32AKKbhVggZuzuSefv5a7
         jMpevUKb8rAvETgVTBC83IjphrhyXK3wyeFItLpwNOpevVqHC7KoiG4v7ZVelKDUOGnl
         lFXH1DkldCnjm6MWfIPbZgI6GNQl6lQ6FmT4PWhVYlKlBzX89dSQoSurBJ6Uzbg4akI8
         JN5g==
X-Gm-Message-State: AOJu0YwBUZYo3xI/IrzcNWFE9tgmrah1O1C/dp2VhIes8SnPIlc+blMx
	iLmbSPA/PFbgcRDYZN1rQ5/EYJcphuYdKfE7dcWpRgQ+TOOT4XZFlj4Kq+ajk31TkIZOZBeDiYg
	jIsmUFWPr38bjPLWKND6o0vKfjqikADBDxLyZuQ==
X-Google-Smtp-Source: AGHT+IFb6Ynlc3lx/rcx+GOGhdUvp2U5R/OSbQALEadRL8E/zzlwUbl0g1zSNHdJw+joUvKvhuXrXIGABFg8M/+PFtM=
X-Received: by 2002:a05:6102:26c1:b0:4a3:e644:54dd with SMTP id
 ada2fe7eead31-4a465994c45mr3669816137.12.1728732085505; Sat, 12 Oct 2024
 04:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 12 Oct 2024 11:21:13 +0000
Message-ID: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
Subject: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
To: git@vger.kernel.org
Cc: gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, phillip.wood123@gmail.com, 
	Christian Couder <christian.couder@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I was looking at some #leftoverbits which I can work on and I came
across this conversation.
https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/

I followed the conversation and came accross
three instances where I think atoi can be
converted to strtol or strtol_i or parse_timestamp().
These are the three files which I think the atoi can be
replaced with.

merge-ll.c

something like this can be replace with
if (check->items[1].value) {
  marker_size = atoi(check->items[1].value);
  if (marker_size <= 0)
    marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
}

if (check->items[1].value) {
    char *endptr;
    long temp_marker_size = strtol(check->items[1].value, &endptr, 10);

    // Check for conversion errors
    if (endptr == check->items[1].value || *endptr != '\0' ||
temp_marker_size <= 0) {
        marker_size = DEFAULT_CONFLICT_MARKER_SIZE; // Set to default on error
    } else {
        marker_size = (int)temp_marker_size;
    }
}

alternative is to use strtol_i here which I think is more neater.
if (check->items[1].value) {
    if (strtol_i(check->items[1].value, 10, &marker_size) != 0 ||
marker_size <= 0) {
        marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
    }
}


daemon.c
if (skip_prefix(arg, "--timeout=", &v)) {
  timeout = atoi(v);
  continue;
}
if (skip_prefix(arg, "--init-timeout=", &v)) {
  init_timeout = atoi(v);
  continue;
}
if (skip_prefix(arg, "--max-connections=", &v)) {
  max_connections = atoi(v);
  if (max_connections < 0)
    max_connections = 0;         /* unlimited */
  continue;
}


if (skip_prefix(arg, "--timeout=", &v)) {
    timeout = parse_age(v);
    continue;
}

if (skip_prefix(arg, "--init-timeout=", &v)) {
    init_timeout = parse_age(v);
    continue;
}

if (skip_prefix(arg, "--max-connections=", &v)) {
    // Use strtol_i to convert the string to an integer
    if (strtol_i(v, 10, &max_connections) != 0 || max_connections < 0) {
        max_connections = 0; // Set to default on error
    }
    continue;
}

imap-send.c

if (!strcmp("UIDVALIDITY", arg)) {
  if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
    fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
    return RESP_BAD;
  }
} else if (!strcmp("UIDNEXT", arg)) {
  if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
    fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
    return RESP_BAD;
  }
} else if (!strcmp("CAPABILITY", arg)) {
  parse_capability(imap, s);
} else if (!strcmp("ALERT", arg)) {
  /* RFC2060 says that these messages MUST be displayed
   * to the user
   */
  for (; isspace((unsigned char)*p); p++);
  fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
  if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
      !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
    fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
    return RESP_BAD;
  }
}

proposed one using strtol_i and I think instead of using strtol_i here, we can
have another custom function that indicate what cause the UIDVALIDITY
to be malformed
either overflow, letter etc

if (!strcmp("UIDVALIDITY", arg)) {
    if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) != 0) {
        fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
        return RESP_BAD;
    }


} else if (!strcmp("UIDNEXT", arg)) {
    if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) != 0) {
        fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
        return RESP_BAD;
    }

} else if (!strcmp("CAPABILITY", arg)) {
    parse_capability(imap, s);
} else if (!strcmp("ALERT", arg)) {
    // RFC2060 says that these messages MUST be displayed to the user
    for (; isspace((unsigned char)*p); p++);
    fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
    if (!(arg = next_arg(&s)) ||
        (strtol_i(arg, 10, &ctx->uidvalidity) != 0) ||
        !(arg = next_arg(&s)) ||
        (strtol_i(arg, 10, (int *)cb->ctx) != 0)) {

        fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
        return RESP_BAD;
    }
}

- Another instance inside imap-send.c
} else {
    tag = atoi(arg);
    for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
        if (cmdp->tag == tag)
            goto gottag;
    fprintf(stderr, "IMAP error: unexpected tag %s\n", arg);
    return RESP_BAD;
}

- Possible solution.

} else {
    int tag_result; // Variable to hold the result of strtol_i
    if (strtol_i(arg, 10, &tag_result) != 0) {
        fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
        return RESP_BAD;
    }

    // Now use the valid tag_result
    for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
        if (cmdp->tag == tag_result)
            goto gottag;

    fprintf(stderr, "IMAP error: unexpected tag %s\n", arg);
    return RESP_BAD;
}

Thank you.
Usman Akinyemi.
