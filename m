Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4281E834E
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760161277; cv=none; b=bZHZAl/ivrixhxlO51Ze/xZQwNOhtjcbubm3Y6Soo7qF5cZpwPVHl5VuW4wBk/i4zmuN7vEzl8/3/k/wgrIvhUB6Am+dLJDRBmU6NvrWm0wnUksF/iV9siwcAFK8Fi0i/4zjQ70ITpAc5UPNHv7VM4Hzdnc2ah97YlrIfflImKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760161277; c=relaxed/simple;
	bh=3kXToZp3EdTIlI6ek3xO7GRVPh8pWA77WiZx+PrPShc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XDMlepulqW8VxX4V4RwHPP75MWzOAAHDx8xkBUrvVbSJiIP7jAvJSDxKto11NPZjNSE2DX6YDBR3KxU7ZnBbLa4jS5aeHl7miolucZ8TqUKGu/mrkIQazJ62bmvjb3d5/h56mngU4PcXRrrCZWQy8pqUYce4JqrsKrcaV4pORBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf/WrKVb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf/WrKVb"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso3254784e87.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760161274; x=1760766074; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3kXToZp3EdTIlI6ek3xO7GRVPh8pWA77WiZx+PrPShc=;
        b=jf/WrKVbHdNiEaoOmuP9bTzH4E+0x+EANwKRdwp/hfrwx7u7yMxdT3MS8LXjUN2foB
         4p2fZbcTMmx5V3dNzoq/GCkw6bQvtno5FPo39hWAKoqaLQN7VP+VR1euXYOpXpT4aJcJ
         xZxybn3hQPxoq4OdFKWahyRJSoNoQ/z8K7FM+0baVj94rv2/MyOva1lEANqCEFHUSsGe
         e/q3C2bFQszZha43CYiXlS0sVAqNZf7LviWEMdbaDU2Y4u+bWAtYK7MBaIPvzPWc7rTj
         ITHGJQu3tMi9H81oHz+hFLTmQsnoOiPqYPlKi+sT2VBtJSkDRDa84VXF0b5kSbh6SUxS
         idpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760161274; x=1760766074;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kXToZp3EdTIlI6ek3xO7GRVPh8pWA77WiZx+PrPShc=;
        b=JlFk+l8+/v8qHsKVGEY376K/TA+rD933ELN3VE/q0QQaX5nbWGVsqwpuOW4CJVG/KC
         oUbJ7iJ2imdWKxMp4Dlr6KdmrazR9exP/2b8RX4W+ZW63XwBKIbclRhOVXlw2RgrnQmn
         0AeE0DxO9/O4cheFe6hJsxpWUxLi4I1XTs8htlJEskbU1NmbtYkvlqfMoH18jTUzmVcn
         3HTIxNXQsPVNI9KOleWMh4ESEnteWT2mfx1WQXj0ia8wRad5cCBYeHWihM42Nsc6fljy
         hGEjKBboQuVkSxNjSP/zvqk+ktQvxbq8nKq2FtGjBFVBRt7FxUJCitzIYgDbEnjOO+nW
         /DNQ==
X-Gm-Message-State: AOJu0YwhjJ1Brw90cwupD7Xsneq9Zt6QyzdiN7iBD98t+f9bCB2NdNkb
	PIiceu7gzW0lHu/rRqnDCCmBmF4N0uFhpFS3Kq+a6ra8E4pc5SqBmgj0Kbb2OwO6EqkAJ7hh5sq
	wagwxNgt49yTECe/cio/AXPu6iQ0b3zZFj2chepGR5w==
X-Gm-Gg: ASbGnctQxlcZ1n5+625pa6TGMPCAYBObDR5MQTUyJDEU8u2DqmHV6I4g0dO5/OJ7mmh
	J7RRtegoukZESAwBGG4JyuhY1rD86eygYXQgz9eDp7bWT8nsonNx1ZQ5DHT4mzcofdWva1/tZFc
	p4dtNyKFWfzJd7ivC1gdvB0l7KgdrMFmKreKy9j7JJ7TbMrucag1/kgzt16Kxh9PE6AitiZWzEL
	uR1Eo23sciHY61XGs8e0Nrs/nmZMHBL9dY+hhH+bj/5MstlMwbdRU7ghVb2Bc9rXIh5ZpRL0sjB
	GcClrA==
X-Google-Smtp-Source: AGHT+IFUPF5ynkkL41kgZLpurmnAIM9HmMqTLIwKFvjc6tvxX53QxSBJkb+er1hj3bz3ljNfXlpdONJv1gOnelbCVV8=
X-Received: by 2002:a05:6512:3b9a:b0:57f:6da2:6a1a with SMTP id
 2adb3069b0e04-5906db01c1emr3891332e87.48.1760161273860; Fri, 10 Oct 2025
 22:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: areychana <areychana@gmail.com>
Date: Sat, 11 Oct 2025 11:11:00 +0530
X-Gm-Features: AS18NWBpXjDo68OckoLZOrSev7H0dP54VWfzi8BN3_AP0HKcsVaxUacZjliW0wA
Message-ID: <CAJrT3AvkiXFBsfoGypHiXAOY6pDqxbYc5jap2Vn_ONCUh85a+g@mail.gmail.com>
Subject: [Outreachy] Introduction from Applicant (Archana Kumari)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git community and Outreachy Mentors,

My name is Archana Kumari and I am reaching out as an applicant for
the current Outreachy internship round. I have successfully subscribed
to the mailing list and am excited to begin contributing.
I've been using Git for 5 years and am eager to contribute to the core
project. My primary coding experience is in C and Python. I am also
familiar with Shell, and I am comfortable setting up the Git source
code and building/testing it locally.
I am particularly interested in the microproject idea related to
'Refactor in order to reduce Git's global state'.
I look forward to interacting with the community, receiving feedback,
and submitting my first patch.
Thank you for the opportunity!
Best regards,

Archana Kumari
areychana@gmail.com
IST/India
