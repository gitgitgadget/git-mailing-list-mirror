Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDD396B66
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266106; cv=pass; b=MYjahRkUeLe6VMXySOgryai6qFA/JZxY0cez4W95OC5wW7JcUHYuW6gZxifuKc8eFXiNE5/P4vwed9iolHfmAI5ocFvJ5kMENVCu4ASivNCa6/8rA3zVBtZ/PA1LlfgY9XXNEeyvOFKc/00rWscOmTlowAoiDyK9sVEHU6+UCAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266106; c=relaxed/simple;
	bh=+nDzZm6X391cmErtw+4rPrM+Dloluy4WsfbDNMzEUkQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DqQhDTFsYtRaAQN1F1GKicG1jfkXlChZLLVORMxpA2X32FQJtZ50/HgxEMNgt32pxsC0E4f7lqhgT/Xo8m0Ep1CuVxK8X8EvXcrXlkt88s4zDXNuQ0QHutL65ZgjFnla9j+rU8KYDj0Mz0cTsTFFdNUi1ZDG2a/FvkhdeW0CHfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQYZfMhm; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQYZfMhm"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0bcd8f194so65166eec.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774266105; cv=none;
        d=google.com; s=arc-20240605;
        b=gykxMMqWXW0y/ecZdB1/IVSdCH+WvTPJ6W9PNg43kwcCbSq0+m007m6UGiPYvz0gu3
         uNo139wp+QZX62YfRLUexO6mlS3PHW3p/xleNZJVYTT0EWdh2miYL6ANOyQVPzkeIZHq
         +l+Il9WmbqPoMX88CQkIerxGWYlWWMQ14zsHx3xLCFmaHlxG5PTMbSKmtonpwAecYXF8
         HluKQOta1N0v/CPXedaGzqrXlV9cUJsxEFTUKrRFZsAORWSeeUiEMi5rR473vAmht3Wj
         O9TB9zpxNKQDpNrDXxB+j3e+4slrWxdLXFSyIJa99tifl/HGc8wIrYkL+OcbQ9dUySzb
         uAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+nDzZm6X391cmErtw+4rPrM+Dloluy4WsfbDNMzEUkQ=;
        fh=CKK1g+OyJKHo4xWiNGdPiqd78GGQOVg4veCMwpKU7oM=;
        b=Y4jShPVKbB8GwYaFfmT9R1soM14+zAx4a8djoqbc4oUq4WUBgU+7Se23P2pjTA1w/A
         lY7ZQNBs0hw3h+GUCicDT1Hpk+rWEpaDRg0XdwpCmwOg6IrSoa34B/QfT8x7/2yle/Be
         9eSbXv08EKq1OjK3O33k7bJHaAASnJA3PE1k7S8EWg9F1KVjgAJtktAgBUedU3R6gkuF
         ZkUHDHwm26mZtxXQzzgxZD7FvMab5OcyLbUvSmUlG2nrxtPaGDN44l2YpThOsNFJAD6J
         +FQoi26BiUgYRlZ871h7ThBZOVwJzleF/+Nud07zSADACSqLT7KsrIgI/dsuGX1Lt5/0
         Q+yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266105; x=1774870905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+nDzZm6X391cmErtw+4rPrM+Dloluy4WsfbDNMzEUkQ=;
        b=bQYZfMhmoHiJXJMLOoouC4q01pVwrn8t2P6GoJ4cwBTteT6fssyR+6ECQ9x8oPRJVK
         dDPCfqOmfLTtdz3YsYX/GabODIZ5WmEzJL00+tPtMhhAOPhuBOvrAvtBP4O3uK8ZuFaC
         EdZzhiJhjyi40tXLb0CpWuuiUtmYfYrnhGplLdbGD1dx2o6aoZdpgxFX5PA+L3dfPOpx
         VRWhZ7cQfJtzeIE+WzC4o3CV1HTKg2e7oZWX3uUel/YQO6Ltu9audkycE+4k8pGBkdg+
         Rq5tUMjLeTLnObunTHXMKIFJGUP7IcxBv3sboo9CpDComL+RY3jevvDKD/8C/WwIWpo+
         O0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266105; x=1774870905;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nDzZm6X391cmErtw+4rPrM+Dloluy4WsfbDNMzEUkQ=;
        b=AteRkcGPGtL8Ap+z9SekF9fnv24UHPdlSzBa1BVvkGROP+eeX/eZZwilmvfjgiW5X5
         HodBehyXc4s9xqpWFfxWe/H5cEL4k9s69vLc2aDZHQXDinluYv0OHruieAdij4Qvkeoq
         W2uBxZZloOKG7dnVh4cy/bLDQYK+dIAOpZU88LYir+E5FYSWGbiq2iIj3GSPpZbcdOab
         fC8tLVJZ/Aitz4vdUtkpSCGwMP0pXId7AnWZksbWmhsU/88P6d2065AmXRK2g6yqH9sd
         HFtlPI5g31LX+YqVv0QzD6z8N4BIunsdZGViVRQ5scF+qfd3ZbHrBbX8bQRInOURRBCv
         hvQA==
X-Forwarded-Encrypted: i=1; AJvYcCVu6+77WL4AR+rlLK3M3YfzzTL6LfaZX34OmgLH6mYaSuDP1VcKX80fiBM7ap+nSwa+poU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8WKgOJgmifCx615JhICPZfv+BdOaHW3JBXubbUs3IFa80YgC
	IPOdnaQghDt4Ve+SrSqYWYVZs4N2dCcHuk0ZYi1oa98NRXuXuKk55P+VLIQrCHkxcgyZWSkF9kq
	h9XR2oLA+yeVEghySq1yLoeOj4LF/DPk=
X-Gm-Gg: ATEYQzzApaxnDAxIOFZ0hTedFIDvYao5v/AlfmkC0SeY2qhjr5zoT/2dpypRZJPLHal
	CnYvOcSXySNTN1Dou4+ZesqbDBG22qEMgadmCaztaMJSoOFjspHfFS7nUSnwNsb0TfaivbFhybQ
	b7d7lSymQVDjDlxhE7eZJWt0sD3e+w8tzvlwpSHdWZwpqn1bEmlUkAMKCBgFuZyj+ITn8Wh+IV5
	a9Xge2yIGsgrI2X5LphRxPiutp90puIZc1f8Cr5V3uR63cqy7p/S76Cgt5FWIIrFvdBUk8lNcSM
	uC44tcdlYqOP705eXFa+AwU/5TFyQ7CilkGopuJyvji/Kro4/2MyWlEoQb08oz9+noKUJcaQUvt
	rgXdYlyvF
X-Received: by 2002:a05:7300:e7a2:b0:2c1:23d:c728 with SMTP id
 5a478bee46e88-2c1097ab161mr5040374eec.31.1774266104450; Mon, 23 Mar 2026
 04:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Mon, 23 Mar 2026 17:11:31 +0530
X-Gm-Features: AQROBzDeh-8PdOA52jcq6KM6OegEauRE9FqX_fVQ5QEjoAmlUBmncLLYMXhbvnc
Message-ID: <CAG7UgEQ1iasN+hRT33QtSWmm3KSejyJZVu97CyGR6zURTQA3jA@mail.gmail.com>
Subject: Re: [GSOC][RFC] Draft Proposal: Complete and extend the
 remote-object-info command for git cat-file
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	christian.couder@gmail.com, git@vger.kernel.org, jltobler@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi! I would be thankful for any suggestions or feedback on my
proposal. Thank you!
