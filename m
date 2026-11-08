Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794142267;
	b=oR36WU4FEesD/b+3ss4LpE/JDdBzE8xOHMCrcYE/H1WXnCRJuGlf76L9Gk+CNEhK1QVP
	 WyI58LzeoRXCOzRPA7P4emuyE6r9RwSp9t5YTahEuunIQLn9SBoIkNL49GZh8GUTq2yjI
	 G3nU1r50rUGAFOe4wd4JS96JvkVPFMrFOZDGOSt/AsSlLQxOrDxof5CkgZEBBH0IbS1/t
	 8srgsCuhu5DcBus0UzJUu2kv1b80Rc6NPS3jjKRBAdHRTygYn3K/kpq2wkuHfCIpLzvTX
	 pcl3lq63OBU6S/J0o/fp9DsUKMnsIFuE86izWAxvjx4NXFiwBriI8Otg/UqSw1IXFdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=WtHn/UPt/e2Xtpz7aJpOJVsHMdKwzadPzCSkHSqWjdg=;
	b=I8+i5khLYyRVxZOPu+GIb2Ti7DyGN1woPSbVK6X7LTXFm9G4fhBqTzi0NpYZ/244plO9
	 gprgz5+4k3SNJAWFNoCDQQO91M5nUHUIJANQ71oEdrhxRGPMNYboHCE9QcTlbMTFO36Sl
	 Kbmb8Zv3uo0cd1VWLgvRoj1JoVKXs2y/n04Yr5DiFpufOJzzGewFs9P9s0PgyjcUsT6h5
	 yjUo058s0j+osVb7Ko4YJzD063OqjEbazbpb6cShB/VPbiQ8MYQU51EtNuuCzeymzczea
	 geWz7e8hZcDsQm3H1kWSku2VisRpWmW+CSW3qXsigcV9czEvDwYZPw08Hf2CnHmfJaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GaW8IdQf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD554606A320
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 12:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD554606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GaW8IdQf
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f1f8f59a1so985085a.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 04:51:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794142266; cv=none;
        d=google.com; s=arc-20260327;
        b=KI0yhWqXfcuKp82ezz4Sed4Idg4ko5CVB4tYveSsqjzWAXJ8LTjCUg/+XbT/5t+8Bu
         QE8dRzyB0mk3nQvS5CvaO7P4GHBGpTcPjCzo4gr+Em7tMJCNZLmfWBkr8IzeVWrtW2MH
         XzptpUR8g9sm3WAixX85VvNw57fuC6cE3bgd0WmzJPffmI5om6AbmicQsK7YhrFtkOzr
         r7OG6tB7e66rgMbEFd2//0ODVYzMw659edO0cZaTRRcv1dU3iRH26NsNBujrs7+1hUmi
         3hRrqIT8K890C/YPwIf74oBX23UB08XUSqPMs0Clt2IO6cWrzXTQAiCXKuM4O/Eg7L4K
         iN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WtHn/UPt/e2Xtpz7aJpOJVsHMdKwzadPzCSkHSqWjdg=;
        fh=EfP1jSEWdwI+7K9IOG2KVmV7Le9iX+/fZH5Qy9Mn7f4=;
        b=b0KaOeG+o7F5qjOCXA1Kyhk6qCZR9lNVOqe4QdfrcwWUnJtnjjfnibqgifasp8PdSf
         teUo7AojhgbExi84Gr1sPUr0aZR+R1Tc9SpMVhW891lERQOw7jroVXCN3Clz4pogh/dH
         YqC8WzZGaoLORg+OvS5TFZ5fr8YZtMxMHj8iwmYzExwMwinlKD1VF4mi7Y3GwPhtTbSA
         i9mXHKiH3uOd6YmT2ysazTXM5kFFXFB9C0LNImcBpZ/hTkT3l3BZyUsrAjQEM2AXobJQ
         /vI+j3Za4/s7Buiz8Y+1khBF/MJtm06IzwvcscO6eN/JONbo40AatWCzLAExpa/FPn5L
         w8qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142266; x=1794747066; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WtHn/UPt/e2Xtpz7aJpOJVsHMdKwzadPzCSkHSqWjdg=;
        b=GaW8IdQfjgT00orlnWn+foc3rQM7mc+p8pG+c5Qcht5cTIxvcTFGkdClp1jIizT3tF
         BfwAi3WAdLdzoPPoxVlcO8MGe0bW0G0RLq9g8slerALpf0WQNkjPPHHStGWpExKg0Z3O
         cBhcXdW0tWcJzlmJtXCgnEgGu6nF35jbrNfHIqqTXGRI2Y4sEdAzoTF7kO4YoCW4pQm8
         62zDpgCoxSgMyATc7XuQAmpHSZIOJMrgpVLol5O1Yg+CwxyRg4+wkIqZjVeO1nbf5xhD
         zeSZLGRC3qpELhQoIrV7ZszANtUXgqYQIn0ffDKnrnz1Lg+AnUtF8zsDjG013L6r5hG1
         wkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142266; x=1794747066;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WtHn/UPt/e2Xtpz7aJpOJVsHMdKwzadPzCSkHSqWjdg=;
        b=vkSxzX0sVya3xCOoysPzDww86273e1aU4BEsWRn3EOUkPZQnBDGgMGkElN8cYCoF2U
         00GmYVbIV+36v/bEKwyaZ9Zv6sqdfBfh2s4eHWcGjiGx3AcedhdfNTDv5SUlgFL630Mh
         T+Cu4us3gmE4owl3flGBzr9Ep0n/yc6EtH80pdzRsoPsDCmX5uFvGqRmP8p2guOdJ80/
         2LgLDpCSc7PDAXOER00aG4qxKMHxpeRwADZZXPtiVg0cCLkQV/y9PBUgctChK0MP+ZgT
         MMCjbh/HBvaxOQTtUcPIdj0kYJ4J4WTvK2IiHGj5Go3rQZr9FBprWYoS3mIb7mRt7QPu
         fNlA==
X-Gm-Message-State: APuU4Z83Dx1WtLU12qWQymQ7s2A1+hDB1V9ncfUThJjK/GDC9ZkdSd8f
	TajqOKIY1r2Zc46qu/BYecQnVHna0l+pQyH00TPXYak8gJJspmztGz5bX/1E7ZCHk8IJI89xdjD
	HopdTjNiFVL8FAWg4o1sejAhORcMLk0/8HLVInvRGpw==
X-Gm-Gg: AYBFou1YDmZOOPsaTrt87oSzhb03++vSYVldCSqwLkyKAxvN2X7nkrumTChuuWjJI8F
	Cd2Q8gjzPDFLF0YvTtno6GEt3ZxZlWv/+WqDwQQ+PSCimWFj5OPyymHtzzfYvKdoy/hzoPsLiy4
	66C2Npd63SmFKsza238W8/+SODoxJopjzZh4ygKeEb6hv+UPKgHP0AFoUg5ErxzoVxWqchm5wKT
	9xUNgQlHVkUbLOkEoStdjoDmBiRgp9j0pOxxr3Vk/Et9Omva2YeRjjS58dlbpMsIUoEKT124opk
	GPE/GZBVSX1B9oIeTlpwRTaY2J9VB+RNIYAHBZQ5E8nT5gWqtwGoQGNF2xHuJyRIdsmD0keJBMY
	oQUM9FR0j9SPQh6zrB4v7TxJJ8dhTT7GEJtI=
X-Received: by 2002:a05:620a:72c8:10b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-94784104ac3mr161132785a.1.1794142265751; Sun, 08 Nov 2026
 04:51:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Sun, 8 Nov 2026 21:50:55 +0900
X-Gm-Features: AclHuK_zK1_RnJ4XnvkJjn22kr9mT9LmkgJQkMkn4OWUIauGLXBhTCo2z1AuqdM
Message-ID: <CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com>
Subject: reftable: wrong HEAD reflog when its target is updated in the same transaction
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

With the reftable backend, if one transaction updates a branch and points
HEAD at it, the new HEAD reflog entry records the branch's old value. If
the branch is created in the same transaction, no HEAD reflog entry is
written at all. The files backend records the new value in both cases.

To reproduce on current master (fb255012ac):

  git init -q --ref-format=reftable repo && cd repo
  git commit -q --allow-empty -m one
  git commit -q --allow-empty -m two
  git branch y HEAD~
  printf '%s\n' start "update refs/heads/y $(git rev-parse HEAD)" \
          'option no-deref' 'symref-update HEAD refs/heads/y' commit |
  git update-ref -m test --stdin >/dev/null
  git log -1 --format='%h %s' HEAD
  git reflog -1 --format='%h %gs' HEAD

HEAD is at "two", but the "test" reflog entry points at "one". With
--ref-format=files it points at "two".

Using "create refs/heads/z <oid>" instead of updating y leaves HEAD's
reflog without a new entry.

I think the cause is write_transaction_table() in
refs/reftable-backend.c. For a symref update it gets the new oid for the
log record with refs_resolve_ref_unsafe() on new_target, which reads the
refs as they were before the transaction. So it sees the old value of y,
or no y at all, in which case the update is treated as a dangling symref
and the reflog entry is skipped.

I ran into this while looking at updating a new branch and HEAD in one
transaction for "git switch -c". Would taking the new oid from the
target's update in the same transaction, when there is one, be the right
fix? I can try to write a patch.

Thanks,
Tsukasa
