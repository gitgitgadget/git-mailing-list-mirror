Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7102EEDE
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901012; cv=none; b=GBOaSX6zYTZWkYgoae0flw5QAb2IGWdSuXcqmR0uvaquJPC7+sheot6LkSu7V4KuOT5Fw8VB1yOV/sspZxKNPry+eEZcIzgg4T67UWpzN46Ra+xB0ReOGuDwwLiePVtatuV/tysZ/DlmyxKDYUa4kJlt9r3SSRzBRP+q5Wm7iVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901012; c=relaxed/simple;
	bh=aXHpdtNaOFVWlyocXJLCi5UW23c9Pv8ZQpjhm0NLVh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NiaV0ZEwOXxzdl1bJD+8AUwxlZFlBrS0Uqj9yUrtJMR77dV1ZCFtjqF9OLtz+GXB2cXqXUWqYlCzNmDAY6btjdFgR6myDLnRvWkAQNwpnJG042c22fKq/fdcOBKYc2V0DyUmj2jA3+M0HpkBSKJ+fNKpFzFiac3W9S5I/nKaYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+OVNcad; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+OVNcad"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234c5b57557so29144355ad.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751901010; x=1752505810; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENvHM5SQZTnnIQLdV2eZ3uqKB/Jz8KtqWYUuOkCGLsE=;
        b=i+OVNcadEMws4VCUeLr5KFNNcaEz776HxGM7ZkRlxYAHgPWDvyooD+G6PwFHte+VrA
         BDaJT5pjXo3uJqFiob078cyHf2hIpjIG6w+nQmINO5Kv+kifg8/ba8Id7NTAHQzh3d0k
         m0WK8SVU6YCgPQs395qQF5KmLMYC5KbKqxkOduNhLAo83GVBenIzhCeU8/nwusOKjosL
         Nxc2QcuZf4/bczubAB+9oEwQAKal5Bn4BlhgMdzDGDdV/Ol4md50SDFGY1cd6oSGEeCt
         ao5m5WX949QFdqJFYd6Bx2l/tg66leBaMR5KGVq3dcXaMT4r3F5+rYyzAEvzfaWXYijP
         2lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901010; x=1752505810;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ENvHM5SQZTnnIQLdV2eZ3uqKB/Jz8KtqWYUuOkCGLsE=;
        b=giwwVUek2zn/ayBP4Pe54pza3wMRUl3iYmqBZfxgua6AAdO2veQnI9KdHKNTdVINKA
         jZnegQuChEJzUuzWfu37eRdWAUC5fWa1HwpzS8lX2ILY/x6ZwhzXzH8zEIC6UNR1sVsI
         TRKrMJkLMtslwKmqQZxaZEFiNxPZLt4Nof8Tzr6t+r6wfdt9Rl5zT35kis+nB0Vg041j
         UMLdDwzy/9d2ITd9+xVivMKKPFo18TBddTNwxw0SLGpKlCjmxGWbHJcq244CZUYu1v1P
         d2MrGq3LRnILX1hpLJBhIJ1VfrHhKlyRjVXDFGM75+ZhZ+ZKIl7EnU1Udxr6wk5EmkuL
         qORw==
X-Forwarded-Encrypted: i=1; AJvYcCVgrHXJPLtiVBvFSRBE5FIoml+/k2TX5GtoV2AJsk8M5rnJW4VxX9rgmpRtthSpPe8EaLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIJXaHQpyiFoh2qfdGAZWMpVSrWfnXzlsp5kO35dQxMh663sw
	/nXPcf9UvE01mKANDSOWPEttloV4xbsykHWVwNOzQq2PVOSIshTasZD9
X-Gm-Gg: ASbGncsGfdcDr+zLbOP+FmBKmssh0ouiXwRGDsUmKa24U3whGVicndmofEjRkw/IZp3
	TiVr26hM3xhgik2UGnFihv1FxJJa5rg+XeqisVkbizAjTxMJpNy+PI2kCQRGCdpL4pQ97wn9Aee
	mPQyPMfrnND9mDgizx7N76mE4RJWILqSsvjBZ/HY7A/ttDeqE/K6Lm8JbBJ1c7U5Yntake6Wm3c
	ONJRMeDUd+y9gjWFOKeVYZrRlyqqhWDkU7hmPzYG28vqRzoMy1PIA4XlWSHB0vkzwGjOGLtdmhm
	luUmx9sPr54j7/MwmM9GOCGJYkaFu5IObY42G098lzvUDLbhlU6SktoUvG4Xg4CcADtPiUV57EU
	i80e4trm0Nj+TW3FJyYJnZqSaM1c=
X-Google-Smtp-Source: AGHT+IGZlKgmRK/a2/+Oag6+Z4CiOcJyQy2AgzrB213IHTxBuCzNmPxzlcjo9Cnboc6xz4Q5tUGang==
X-Received: by 2002:a17:902:f60f:b0:235:6f7:b918 with SMTP id d9443c01a7336-23c85e74308mr195865565ad.28.1751901009937;
        Mon, 07 Jul 2025 08:10:09 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8457f308sm93272865ad.149.2025.07.07.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:10:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 0/8] enhance "string_list" code and test
In-Reply-To: <aGdllONkAbTJt-Ud@pks.im> (Patrick Steinhardt's message of "Fri,
	4 Jul 2025 07:24:36 +0200")
References: <aCoDB9P5XV1lHMil@ArchLinux> <aGDAZ6a0-PyXXGmK@ArchLinux>
	<aGdllONkAbTJt-Ud@pks.im>
Date: Mon, 07 Jul 2025 08:10:08 -0700
Message-ID: <xmqqms9g5967.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Jun 29, 2025 at 12:26:15PM +0800, shejialuo wrote:
>> Changes since v2:
>> 
>> 1. [PATCH v3 1/8]: improve the commit message to explain that we would
>>    handle a warning in the later commits.
>> 2. [PATCH v3 2/8] and [PATCH v2 3/8]: improve the commit message to add
>>    the history background.
>> 3. [PATCH v3 4/8]: improve the commit message to show why the current
>>    bianry search algorithm introduces the sign warning and how to change
>>    it to fix the sign warning.
>> 4. [PATCH v3 5/8] - [PATCH v3 8/8]: remove list into test helper instead
>>    of test itself for reducing the shared state.
>> 5. [PATCH v3 8/8]: improve the commit message to say why we can't delete
>>    "test-tool string_list" totally.
>
> Thanks, this version looks good to me!
>
> Patrick

Thanks. Will queue.
