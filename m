Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4301C6FF5
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719826; cv=none; b=rUAIIkSB+ldtAaobcym+xyjJOS5DT5mZKLENHlFguF7fOhS93jqEy+XcuzE2ryHKb2BWoM+LH1Pejp4IyLPi/RdTBfzyGGjyrz4Usezl0rsCONwDHBQFWFyRBWMxBjulxaXV8zTwO4O0ePbeZPhaLYOFJMlUb5Vfc9qoyTkKhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719826; c=relaxed/simple;
	bh=laDFMtY+zkG5QS1FrPxAvKNHAHoV2VyQ/2OaTy5LFkc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=E20Lob5b4hu7HMI9Ey9GVUbnj7vTahJLaGLnLyfJM4oyvqRZNlkIYpbIepH0eeXsUFAtHUWIxNIG3KdrGGmHOKvejuj7/dp7WX3yXqvoIGZnC1cAeK8raygy8sGnXD6kGR3PzX8U5msv+S3FNuk1Gqb5RakzRHkphLxSkjqJUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwtCt2EJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwtCt2EJ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72b82c8230aso1521818a34.2
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744719823; x=1745324623; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ips/MLfliSth7qGf06uat9T+WFEIv2ya94BHNalMv60=;
        b=dwtCt2EJ0kY94cTvfDX527NCK314l/nT0HDPrq4ZbIgIpcWMT6Z2uaqrWqXm6pdnbx
         KIHoW6rpKDDDu0Rw6i3YQblOBLaIIYs0AfAerDthXA+YlqpNM5Mf7oDVzmMBxcpfP/5/
         Tuegc+brrjZcKI1AU4fAtlX5Vit63dgQ152jZwKimGOEv6UBwd35is2az2hYmY5WnvLw
         9MP2Z4APipv5j6YUCdFH8BBysBWLNm2Z87USmIyUkqEqxXErgIhLxBF7tyyFVuQP1Yk3
         SrLXjkafTyotmqxgvLnGYxb7NYgKH4fzdTpY96XC0Alq22qbw5i70A1p7kP9SIbPFhle
         V/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744719823; x=1745324623;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ips/MLfliSth7qGf06uat9T+WFEIv2ya94BHNalMv60=;
        b=qicNVduPNDEVPvEXHA2Xe7qHv7KCy4IbWZgJJN0ee4nAyntR4f4gmb3NpfykTqZXXr
         KxnUFdCx9HqPwWUjCUggREqrDVKTQCZKfssvQuIBt6l80jLG+99ws8AKE9VHozQn1lxq
         oRPmAA68evE6DuT/chz/lsxGytaDIvFE00tcSFnArBuHfckIFUMZ59I8h55k5oP932EA
         r0AILN+AMCRvPeyuqVS/lEJEMTJjuA22flosG4zFQJa8OzS171GcLw5jCqPQhKezxo+D
         80dY1gJ0avnSiRfuYVSrR8OEuZ7QzfqLoG/kf8yHXLRUhQHePqI3b+7enwlIO5axUvgE
         9e0w==
X-Gm-Message-State: AOJu0YyWZvXmX2L0u4vO4LxxAuc8y7RKN3UHkJbtxjbIRZ2UydRJ3N0Z
	ac9ncvjsuNN/O0PcuEknDJBqXcAk/U52fdBACq9UwC+P/G4RyTbO20Ryho1XwFBfZ0znUYn0KEi
	cwcCumFGLjGEqoIJLcSVvmX5r6NVViwL4APhwqg==
X-Gm-Gg: ASbGncsHS3Rml4YDnLQMd+4eMIVitqa700O5GVrAf9xMp9avyvlHh+HtBJ+SAhAgZfr
	ZDfxUiQ+Y7ZRR8+0YI6YJwJM9/DeQbTXM1vWWk7kmKLg8wDvXBZYPogUNSg0D76JOOu/h23O/SH
	QteYMpkmfEyUNMrB70yx9tBQ==
X-Google-Smtp-Source: AGHT+IHJjtLR3Vcwgy4+qm8+RgwOyKJ6ufkia6UtRcf4KaQoMU5t7pfCBeCBTPBpedvIExFdxpGJxMRWiEAZg0pD0Ds=
X-Received: by 2002:a05:6830:6784:b0:72c:3289:827c with SMTP id
 46e09a7af769-72e864149demr10826959a34.16.1744719823423; Tue, 15 Apr 2025
 05:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mu gsh <yue937@gmail.com>
Date: Tue, 15 Apr 2025 20:23:30 +0800
X-Gm-Features: ATxdqUFBR_1QQJpPj0BxG2RJ1Nyo1YDGZKv7A-iw5AWM9VK19Zld0pUeaCN_uUE
Message-ID: <CAE8aReXOwM8ByyObxrb8NhRMYfK1OB_6B9eOO07mYXMkp_E8EA@mail.gmail.com>
Subject: git merge bug report
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git Maintainers,

I would like to report a bug I encountered in Git during a merge
operation. The method from one branch was merged into the wrong class,
despite there being no reported conflict.

Git Version: git version 2.49.0
Operating System: Arch Linux

Description:
When merging two commits involving changes to the same file, Git does
not report a conflict, but the resulting merged file places a method
in an unexpected class. This seems like a mismerge.


Steps to Reproduce
You can reproduce the issue using the following shell script:
```
#!/bin/bash

set -e

# init in /tmp dir
rm -rf /tmp/git-merge-bug
mkdir -p /tmp/git-merge-bug && cd /tmp/git-merge-bug
git init
cat > models.py <<EOF
class User:
    name = "str"


class Product:
    id = 0
EOF
git add models.py
git commit -m "initial: User and Product class"

# feature1
git checkout -b feature
cat > models.py <<EOF
class User:
    name = "str"

    def user_method(self):
        return


class Product:
    id = 0
EOF
git commit -am "feature: add method to User"

# feature 2
git checkout master
cat > models.py <<EOF
class User:
    name = "str"
    bugger = "fix me"


class NoMethod:
    pass


class Product:
    id = 0
EOF
git commit -am "master: add field to User and new class"

git merge feature
echo
echo "==== merged, user_method into NoMethod class  ===="
cat models.py
```

Actual Result

After the merge, the user_method ends up inside the NoMethod class,
which is incorrect and unexpected.


Please let me know if any additional information is needed. Thank you
for your time and help.


Best regards,

gshmu
