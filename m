Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5623F37C
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740809273; cv=none; b=UFmjHzNO/zB4YF1MS9R8garux4tQP5ZBepmg8cHMMpO9M4PnqZv65a/gg4igo8wxFAS0DxaTmru0bPZElSJ5CyOS3jYj29HucI9G1ciW3QNhRY6b9VnTCaU+010KK0d0cN102MRwdvtlfcl2MA5NpbVX/imxLaeRlA9c3Y3AQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740809273; c=relaxed/simple;
	bh=lWXrJsuT3iwnm90q6x6160BHBKgeAD7Fipw9N4DcStE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=X1mvE8oGbyjupmr1zI/zmN/7UaU+1EmrvDLWuv4PmJOKhFF4NE9x20xQf/ORhlPQPgrhLhkRMLH23Dsz/9uC9hGAwWXtzHBTF1FC+yR7+C4ZxQNpiVlTdTS8eJnSnA/Zz4HG463iFqn3wySnkISMYUBUD+cY0HJV4uAmd5YO30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9069B0S; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9069B0S"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6f77b9e0a34so22395057b3.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 22:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740809271; x=1741414071; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lWXrJsuT3iwnm90q6x6160BHBKgeAD7Fipw9N4DcStE=;
        b=C9069B0S2TTpNAuffjK3bnb0GjRhQP7of8IjYo3mW6NFXKmXHXnzQZGCsUZaBIvYtc
         Bs2n1F1szPDXAfLRvv3Tv9/3sJpf0xB2KId1DdhwkR8xALw3JNIkupot28xfkt/99qFg
         OihOZ7TpaFaEV6E4L2Vh/cssPMUu/GcIsWqWJzhz5zfIiHqQMKII0QgJOBzINjRXw4//
         NEEgnL/yE1l4XP8NCGxlMESkSg2BMNnXwe84pNt+hjYgz6ldv0dIE6lk2dwa9/ni9YVu
         uVawtQIIKd2ORPDKr7tvvYnwWdmFyooFpyQxCA9jC8wVnV+W4CdmdrdDrcmDrQPk1pNp
         3ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740809271; x=1741414071;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWXrJsuT3iwnm90q6x6160BHBKgeAD7Fipw9N4DcStE=;
        b=I8rDuuqf/gIBC52OqRtbE2WPqmpy4XcI/5hIHvR5tFaYEHagYB7OvlS60x7JxSrHLV
         GGUVzdXHJsQ6WCimr0/b96vFcGCZRrBJqyRs36PSupAAV5GpQSfSi+ktMP6eCFKimido
         8WwPMOeQ8PYjVuRVpx7U3Da/ua6MZWwnZszwEZIKjOUEaLnGPSZVP3PuuMeURCeAn3Ue
         2STKz/XCYdYphglXOYCfAe9xhg2j8zValnoLZuifj7Cj79fS5mMLKp58coDysgoUg4pR
         AaUm6choWJvZIclNE74DIJCFSGH0tMdhT/iJHBsgK479XdnsLEiziHkeV46oR5LcHZ1t
         788w==
X-Gm-Message-State: AOJu0YxGdth3/5EuxqZMyo8r/KGBQADAjFveiVjgJHmM6Dya8q05PmFV
	tphe2abIoilwU1Fu0M2wHyWj/FgFlRnV6kByrSO/ERv2Q4pi22tu8qavy+n3e1VsWFxYNWOamcd
	HYZwf2xeZ0p+KwQdiU+Cd85g4PXqXdSj8FTIBjg==
X-Gm-Gg: ASbGncvF0pBE7gMUVdsPIyj9qPqitujB+pxJh+bn7brJ8pcP18Ng6IYUH3CmPB1YrjM
	/cLuEogZ1dLsb0pAM9T8/5fDfAzp9JyOlR7ApaWfvDXiAD2Cyf8tZ4IeArzgsulLIUl83cH8att
	ZGkHt2TbM41Fn6nKjPUOM55Ys5Fs4=
X-Google-Smtp-Source: AGHT+IEm4xEST/+ktZWugxr6Bn9p+pU4tOQsUtQvAAtk8I5ua4NGGCZMAwPuytcYLSjnFWNthjbTQdEmuS6ZNDp2mi8=
X-Received: by 2002:a05:690c:4d47:b0:6f9:82fa:6d96 with SMTP id
 00721157ae682-6fd4a0be34cmr87347337b3.11.1740809270795; Fri, 28 Feb 2025
 22:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: H Z <shiyuyuranzh@gmail.com>
Date: Sat, 1 Mar 2025 14:07:40 +0800
X-Gm-Features: AQ5f1Jo2z9Q225sIO-OL4WSJN0k4IIYZv5vlyFB8SKt7PguYaAyMqp7TXW2HC1k
Message-ID: <CAAJd+fZSUiiUm05D_eO3HS7p=WoxAWSZo51dUNjyGjUNJBvyGg@mail.gmail.com>
Subject: Subject: Memory Leak vulnerability in reftable/readwrite_test.c
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I have found a potential memory leak bug in
reftable/readwrite_test.c and would like to report it to the
maintainers. Can you please help me to check it? Thank you for your
effort and patience!

Below is the execution sequence of the program that may produce the bug.

First, in file src/wrapper.c, function xstrdup allocates memory at
line 40 and returns at line 43.
Second, in the file reftable/reader.c, the function init_reader calls
the function xstrdup on line 202 to allocate memory for r->name, which
is the formal parameter of the function init_reader.
Third, in file reftable/readwrite_test.c, function
test_corrupt_table_empty calls function init_reader on line 935 with
&rd passed as the first argument, causing rd->name to be allocated
memory. rd->name is not freed, which would cause the memory leak
vulnerability.

Thank you very much for reading and I look forward to hearing from you!
