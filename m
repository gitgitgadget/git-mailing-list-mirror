Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F634BA35
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879919; cv=none; b=jg+98RqXP58HOLxomYzceUNDTq6hUOPeUqi6RhVBDlrngnxosX1n/iUDJEr15Wg2GK94jKmWRqdC3p6TUImMrfdTBsuHKeaKWZtbuwRgZ18r6lgV+BIGgYsYB9LqQcKuUM/QAwrU+8DtZ/rhNv0DnzacZ5ZbPgnYDz5eO7ZhwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879919; c=relaxed/simple;
	bh=jVbuue0OnakeG3B01s2V+rMpz6+v1jJtLB3rS00S+nA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SncmG7YfpOTi4sn+RqvPD4o1d84wjRGyUc8lw940MG/BA+eTGoEf0592fHcKq9aICwwNZ5mDGK2puYpg0ktu5Bfd77/TESSx5vvb+p5/nDYyQBruS8VFZN7CRO5TkPco9ti3a9V897D9etmEC7CvZ7Zk1Rw6ftpJuiT7PdxPRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRBoLoFz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRBoLoFz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85ed0a1b35dso552023185a.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759879916; x=1760484716; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jVbuue0OnakeG3B01s2V+rMpz6+v1jJtLB3rS00S+nA=;
        b=FRBoLoFz6SWJQTizO7w05QMdtEvTV0IoaMkavIMIqjs5sYXcSrorDucEzpIbcE8Wby
         mPn1/ulAo5TN4q4F4vw/TfKVdciNgPxXlxPGURViBpwr/K2OPj3pE8CmlrA9HX+e7v+1
         jZtKLSOklV6FvaeNv/LliERIDF/Om5LpSmtJoeaSpaVMVHNKqibiHoNosBApwaX/kJfw
         zC6H2bkYYjVHnzeWfDHUYHa4p7rtP11n429klSYYMO2ttmD73l1rdQ3pUSb3hd+hHK9U
         9lFWa6Fe6DlUtD8ScrijhQLUzX5xCulvzhrsOMh1KwMF6JhuWnya6dt7KpAJ2tdtTngO
         d1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759879916; x=1760484716;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVbuue0OnakeG3B01s2V+rMpz6+v1jJtLB3rS00S+nA=;
        b=C77Oeu9JlGb3OBmqfWHFQKkK6aniytkYQGqGDLMZukzWVtDMPuvyXFXFNQoFbXfzXP
         g3emuiC0TCRb6/LtnKY9UcUMB5TLkBR51UNPZEElO4M5s6JdmeJ+FiL4lQZEXf960K4B
         Bnv8I0qYgpafzhM4xBAQKieLSrmEV/IkOlLShNjgNFJfkRmV2OtPMOFkkmyig8AJXEug
         bIuI4tG2ZJEdq/9YMaQwAhWPUbwALnbS/C2JyB7X4P7N9zwGSX7qtXkFQPNK4TezsQEP
         0XUzrcQPvV62GuXhTrrfUQiO7eS9ZMOYSPyFdRfREAYllR/T8/DUbtmAkS37mMEGFL7Q
         vzVg==
X-Gm-Message-State: AOJu0YzEj8R9UeOGl9cC22n76+XNinyzc8XB9FL14KYE9dg5yJl3GGuU
	+Xff6xxNiqYVa3t38EiDZhtp110rHm1B66ciy3IysYIwwY/Ch1I+ZfOASmOP5OfoPVAM4OEELPW
	HCko/Nyp8kCZyhjHdu19pAdCMzt3kydMBz4fjtBQWuk56
X-Gm-Gg: ASbGncuDX016IqupsSLx3H6RYMBs+msAFmkDN+akuHJ5KjgY6NNyk/QDSZBiOwTqAVj
	KktV+aTv1Gxux11sYyeJeWzhJQiWIpiJaydzFXukWN5G8tEdwlZhtYY07BO/9bq9HJ3PxmzQfUe
	oQkyfPCVtQaRnR5JecLqNl7k49LhZdVlVhxhRTL7Ky8GfYtqfehypTAoH1/wUDAIjokyRHBeooH
	7nasSNCxW0EctOJSy1tSeEsPfe/6Z5PZOmmON+QjlwjL26kH59oaxgsu/ubL73BTV4Y
X-Google-Smtp-Source: AGHT+IHcnxiloSkDWyUMLWwWXyCn2FLaoWhTRUBzMz8zNiunraxPzSjw8NJe8Wb8Oxy2aJwZPooakK+0NCxGcahKtEE=
X-Received: by 2002:ad4:5bce:0:b0:720:8825:f1b7 with SMTP id
 6a1803df08f44-87b2103b2d0mr16773616d6.9.1759879916151; Tue, 07 Oct 2025
 16:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 8 Oct 2025 00:31:45 +0100
X-Gm-Features: AS18NWC8RkU-yIqh6PmliatgxnTgSwZn8z-efMHM1ZrpIP8jhYOUWywG-UW_9jc
Message-ID: <CAFpMFfCzm2pKtFMxQh_Jaytt0BPTd=oqhPXBGwW4ZQ-4N8+iOw@mail.gmail.com>
Subject: Outreachy Inroduction Rosematy Ajayi
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git Community, My name is Rosemary Ajayi, and I'm an Outreachy
Applicant for the December internship round.
I'm interested in the project "Refactor in order to reduce Git's
global state," mentored by Christian Couder and Usman Akinyemi.
I have experience with Javascript and I'm currently learning C and
exploring Git Internals.
I'm looking forward to contributing to a microproject and learning
more about the GIt internals. Thank you for maintaining such an
important project, and I'm excited to join this community.
Best regards
Rosemary Ajayi
