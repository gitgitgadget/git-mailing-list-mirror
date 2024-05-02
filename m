Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504315E21E
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668720; cv=none; b=ig2Lh2ymo/slSMaTi5lq8nVBQJbXLE2zhCfsK54VoWj2EwKwJj88FA2RTzUGP8fJZtgWjV6uLR8K34cxBlztICUCu6eHfuNarERIHeml8gsAIvmUfPkwea7T5HtE5RX4FDBIkjHgC2FiRb6wVdMZPS97lwvRAZ7lSyzcLwBw2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668720; c=relaxed/simple;
	bh=KkAh4PqXTFZ415d00jpCliatzifuZ+fExxZHAVeq6DM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WyWSjHLL0sk9qrHmfP+YmUNZJCYL73vpAhxnEQnXlSTrQGE5PwysqF8nm7e5c7T3zqWbeNwNfffziZ6v0w1SEcCX9wTbI3CC15P3q/q2pQ2bOhwxai2AmuV+Fz8v7XVuNi9CfxA65JGGJ+u8904rM9ODSXUoaGa6S5UajJJVRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BT4w4w9x; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT4w4w9x"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de596c078c2so8224784276.0
        for <git@vger.kernel.org>; Thu, 02 May 2024 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714668718; x=1715273518; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tkKcYolzu3ha2v+zUgj1KZ4B8ztSxYBD9SvXnmmFYrw=;
        b=BT4w4w9x+go7AYS6WeKtLLBKb8RhcBlyy3KYLJBWEqAhJtL0BKxDJ6ktlCMD5IhJmB
         XEEmg3v0B1CRnJMAlvgLs5xjWIck0Nv253RlhW2MDPHi3ZYvqgLU6jaRlsBJI9l7Fjbn
         zXtH1paFRufN7WHWy1/RKDHDgU1T7Sw0aO8T8EGm/hlnLNU/u7UqptAsI4mUuz3/1DXB
         ZJ4/YtHa694/mX9Eo7sUc9tX3KB2Hl3OjSd1R5Wh6l41huVzUjVyNeA+1qLtHvSI8Y5S
         Da/g94YPsLsbKbypk6vDE8ZiFSS8Obn3gHmMPQot2/OdocyUEvioTR3/oUEe3obXflmH
         Go2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714668718; x=1715273518;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkKcYolzu3ha2v+zUgj1KZ4B8ztSxYBD9SvXnmmFYrw=;
        b=lNgm6pGiBWhPz8LTcSShLR/6sz6UUeGJvk125JHvATS0Yop0eQ5ivQHrfPB1Qd5pfv
         ouDgPN5DJWWALj40DzjX83ZvNK0cQWLRyeIsYDTX8qp7es13ockuKK/2OOnulgQ3GQ/z
         oJdC6PtmouUxXeQ7KEO2XuVG+gM6JbDTxgl29FF9zGaBQTrHxdysvrT2Arh3j8HgkSez
         HW0Gr78ZxqnsSpSLJsQVCEOFQfgbyfBplCntpZPxN3ZXU0CKJR2vyEY4ZPQ60DqjlRHR
         Pb6NSeVumaB8xRAmq76VQVmEZSNvn7NCeMY8dkvZII9imvYV/NjomMLCOQ6mhGQ9X+27
         U5uQ==
X-Gm-Message-State: AOJu0YwXBhRZ4hsa/DxVX7HBM2kNgUQLUCOKtVA8qq9DwrT658yYb/wp
	sfa2018WO3Vlc8dVellRM+5531eixf1wtiAEDBHLpePfrbb3x3DP49htF8GbQVLeO21wZOiwk2f
	7dyAFlARl+coTut6Gov8sDrmyzGblO17QSgM=
X-Google-Smtp-Source: AGHT+IH29PHHdLHknmT8Ai5CSg/6oFkbCAzFAakNTFDbBd5Rmuj04m3AuxClTU04ZpEP7tgV4eBBab3m0ydARj9SwAo=
X-Received: by 2002:a25:8145:0:b0:dc7:43aa:5c0b with SMTP id
 j5-20020a258145000000b00dc743aa5c0bmr457546ybm.21.1714668718203; Thu, 02 May
 2024 09:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Johan Walles <johan.walles@gmail.com>
Date: Thu, 2 May 2024 18:51:47 +0200
Message-ID: <CAKtyTbevS7W-X4qoO=uPnHmXCEtKhqycD8DZZY-oK-z0p4CEAQ@mail.gmail.com>
Subject: Chunk header @@@ counts wrong?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Are these counts produced by git 2.44.0 correct, and in that case how?

The header says "@@@ -6,6 -6,60 +6,60 @@@", meaning "six rows in v1,
sixty in v2 and sixty in the merge result".

I think v2 contains 57 lines, but git says 60. What am I missing?

I'm counting:
* 6 space-space (context) lines
* 51 plus-space (new to v1 but already in v2) lines
* 3 plus-plus (new to both v1 and v2) lines

Doesn't this mean that v2 contains 57 (51 plus-space + 6 context) lines?

Why does git say that v2 contains 60 lines?

Originally reported here: https://github.com/walles/riff/issues/63

  Regards /Johan

"
diff --cc ansible/roles/zfsbootmenu/tasks/main.yaml
index 73fa864,08648fa..0000000
--- a/ansible/roles/zfsbootmenu/tasks/main.yaml
+++ b/ansible/roles/zfsbootmenu/tasks/main.yaml
@@@ -6,6 -6,60 +6,60 @@@
        - zfsbootmenu
      state: present

++<<<<<<< HEAD
++=======
+ - name: Create ESP mdadm config
+   template:
+     src: mdadm.conf.j2
+     dest: /etc/mdadm.conf
+     owner: root
+     group: root
+     mode: 0644
+   when: esp_mdadm_array is defined
+
+ - name: Install dropbear
+   xbps:
+     pkg:
+       - dropbear
+       - mkinitcpio-dropbear
+     state: present
+
+ - name: Create dropbear directory
+   file:
+     path: /etc/dropbear
+     owner: root
+     group: root
+     mode: 0755
+     state: directory
+
+ - name: Create dropbear keys
+   command:
+     cmd: /usr/bin/dropbearkey -t {{ item }} -f
/etc/dropbear/dropbear_{{ item }}_host_key
+     creates: /etc/dropbear/dropbear_{{ item }}_host_key
+   loop:
+     - rsa
+     - ecdsa
+     - ed25519
+
+ - name: Create dropbear authorised keys
+   template:
+     src: authorized_keys.j2
+     dest: /etc/dropbear/root_key
+     owner: root
+     group: root
+     mode: 0644
+     lstrip_blocks: true
+
+ - name: Create dropbear config
+   template:
+     src: dropbear.conf.j2
+     dest: /etc/dropbear/dropbear.conf
+     owner: root
+     group: root
+     mode: 0644
+     lstrip_blocks: true
+
++>>>>>>> 8eec118 (fixup! ansible/roles/zfsbootmenu: add role)
  - name: Create zfsbootmenu config
    template:
      src: config.yaml.j2
* Unmerged path ansible/host_vars/foo.yaml
"
