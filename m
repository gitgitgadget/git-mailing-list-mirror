Received: from mail.hq6.me (hq6.me [104.236.142.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5379DC
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.236.142.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474814; cv=none; b=VbFnQf3qtWiR30IVHU/6CnB8GeREZr5jEah320AdwXqIknfpwrVCnjBcapYxNtx0BeF7VHzV1ZSSGZDYQsSTDkRBKcXwNZqD+PpwZWNnS/M7skWiMWtFUrGDXdLaB+yDJ+b3+fEeHk/6MiyL6JNycquKoLtu/Fy+04JnhoVKZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474814; c=relaxed/simple;
	bh=H4iGg9wqGEYJZtM+2kru3BrD0Mi+Ay9+7BAqphc0ELk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cZ872mjZ8bLIDF/ILi270pJJusrQoaZjgZDXONJfZPouQVHYRCog7mXQLVQCUGo6S7q45lwQ0HvcsAnTygkbG6Ds/QoNge9OT7kIKNoaGPSR+hxqHExUbeVw847Zst1t6pkhcrF+XLagRVwy5o7WRamuASj7o4xXSlVTnFG9UDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me; spf=pass smtp.mailfrom=hq6.me; dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b=enl8+6wH; arc=none smtp.client-ip=104.236.142.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hq6.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b="enl8+6wH"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id D6570120063
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 00:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hq6.me; s=mail;
	t=1733474811; bh=H4iGg9wqGEYJZtM+2kru3BrD0Mi+Ay9+7BAqphc0ELk=;
	h=From:Date:Subject:To:From;
	b=enl8+6wHht7gwk1QOrdr7XEkA/72ZyAEGWkkAoIFzOsjZoZvg2uxcpHbiKV1KEWFr
	 WjsyjMgVwK6PdPveMUNKIXvMltRQwV1Mfwfg8jMRKFTErtlWAHWah12bEjE6ZlVek1
	 al+aGsGVmKCOfZ6M9eIcFD0LpFoYfFLLJloczyF9mUUhDmftWK52k3meNy2/g62QTw
	 EYcXi0R0R0iLi9JkiTcCNhr+KFFjhNyRBzuUbki5LojZ2VRKIGEW7j+OsY78nCwetY
	 fuLJNw7e5+TQt7Nwp6z5T8n67JfgW5bC7DtL3YZq7xBjCrc/PpIY7uQfpQau1JSS/c
	 NhjcFKM9H7YEQ==
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725bc2ac9acso84226b3a.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 00:46:51 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7VeGYDzGgiXH33Xea2GIlYJt3BD59vmw6csXVZWmMI2t6WkUz
	S5Hs/Zc/Osw8hOR4BBEbS7Geh1tUmnftJa/GdoZG4AtFYUuWcIPrjXceOtVUwGaGAUQfIfPCM97
	Vgz4/EUYJsq+PJamS9MTeAa83+1o=
X-Google-Smtp-Source: AGHT+IHHmtgmkfkNPW3A7IantYx334xH29yxf8sjYnmAXEJfP+lUcyqpLbVWvwrIvf9jjjNeV50DnRzPEkZHO5PfYPU=
X-Received: by 2002:a17:903:230e:b0:20b:9b07:777a with SMTP id
 d9443c01a7336-21614da2ad5mr11895105ad.10.1733474811428; Fri, 06 Dec 2024
 00:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Henry Qin <root@hq6.me>
Date: Fri, 6 Dec 2024 00:46:25 -0800
X-Gmail-Original-Message-ID: <CAO8bsPBZzSWG9YL9q3hsStygy=DMYkAAJ6PVyP4id4RCcjzM6g@mail.gmail.com>
Message-ID: <CAO8bsPBZzSWG9YL9q3hsStygy=DMYkAAJ6PVyP4id4RCcjzM6g@mail.gmail.com>
Subject: Potential bug: git rev-list missing objects
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

On git 2.47.0, I noticed that git rev-list --objects missed two blobs
that were in the current HEAD and also in the output of git
pack-objects --revs for the same revision.

More details are in my SO question, but could this be a bug in git rev-list?

https://stackoverflow.com/questions/79257277/what-are-the-mysterious-extra-objects-produced-by-git-pack-objects-revs-comp

Thanks,
~Henry
