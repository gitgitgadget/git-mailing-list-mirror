Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE842111AD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178501; cv=none; b=tQEkl7FTconRjRafjwZg5Z9l/e30iNG197PZvjpX1qdwpY0Npncm6ZSEAThTJxfYZWVYv1HGqxmiG9OmRumX5ZzfTXwlsDEjJ6FU3pYoCwJ1oCUnWJh5oYyL5PE7ntwtWb2Ik6s1UZ3NbfL+HadLGKS5yLd+cUOZyvVDIvjluec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178501; c=relaxed/simple;
	bh=yncHc+iSTueMhNZ0klAMF4cvLOXLHz1LtF0GTqBQico=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=ZXylloAGyjbY9gvb2EfbzfeMIKsA9LPqwgxKeJ+YEw7NNLS8FSetinKLilsNbaXyD+/4gSxvB9712b1DjeJ57QeVRPc7rXPGsbkS7lgwG7d0LYQY5vZoCDy8cSobJSZAJlK/S4xez95xOBDtiIurCS+71rhO8bjrzpTDrIlkNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mxw2aGj1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxw2aGj1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so7592435e9.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729178498; x=1729783298; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAkyf6AT8hzwJAdhVn3oOJDpsRWBdNXYYz5tY+gk00U=;
        b=Mxw2aGj1orm0JCFFvR+rs8LfJPputxk5Eo73VXfhq8+cYizd6qE07WKnj4rUUHr6Yt
         ZXQuuFW+Gj1PK11WfMV23p63mJOIwpcs27LwePoDqsPojPBNI92fD+8tFNKQ72UwZvNl
         BJrjpssA+xToIUajHzgBlHtgLj6xjdMt53iUsTmjI87x6lv5P6Xz/VNsg92c27wELHnI
         IqihrQe8q3VZGs3R5GNLhoJA88eubmnp754Sau36hN/tPUly7pB1gcb5znm5UKx4FUCT
         5QvOfbAY1K08NSLr5caIHUPpNwteBJpXMxFpEYWtoxG1JV3CZPxyAwNBl/FOIff4iZM/
         W/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178498; x=1729783298;
        h=content-transfer-encoding:subject:to:from:content-language:reply-to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gAkyf6AT8hzwJAdhVn3oOJDpsRWBdNXYYz5tY+gk00U=;
        b=aumwFLhxZ9FoV+pEdwxKoorJlJklTo9W+UEGbr1WlOoRs7xUd7ICdz0uCIFQQrAyVR
         1jQdrrH1/RLY5e9l5+XpFB18craYsdCkb7xHd+2+uaN4ZHoSciPkwfuLA9Hn3YquamxR
         KCaxcIy3cuu38vL6GWy6K91qm//1KVfdYEH/fKURJAhVA8OP+tJ2xpOnEFweCo0PKyL5
         bM6U0rzFtLSr3lC2zZ7xobohT7eKUVypJ+Fc0GN3PeyQl80cE+1J+ieWlnQY9ile1C1i
         cFYdilKvIeAG2TEzcvkqM4hNM2hExnAeVc/LODtyAVkkAz8yu5JRfJRxhJXRVQznv02N
         uNuQ==
X-Gm-Message-State: AOJu0YywISmT5VPj/X8FRS48Ebxfk4kCgL0Jm5RIMuN2i0eRSkW8ki8F
	jEfMjmyZ6ShgufLGcUuAOtBkyrLAmcdrGBFlgJDnQ6k0sLqUIHV7ErU98Q==
X-Google-Smtp-Source: AGHT+IHpzoEK/UfISeO84ANRaxy1iWrTEWY4s/T6PTt9Rvem1ttg1NSDdxYg5wfz4Vedx9m1rHr3tw==
X-Received: by 2002:a05:600c:5248:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-4311df56fc6mr218103715e9.24.1729178498029;
        Thu, 17 Oct 2024 08:21:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c516b0sm28574645e9.46.2024.10.17.08.21.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:21:37 -0700 (PDT)
Message-ID: <1b2eae40-0606-4dc9-9272-c145b5b8693a@gmail.com>
Date: Thu, 17 Oct 2024 16:21:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Subject: [OUTREACHY] Mentor Absence
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just to let everyone knew I'm going to be offline from today until the 
29th Oct. If you have any questions and queries in that time I'm sure 
someone else on the mailing list will be happy to help you.

Best Wishes

Phillip
