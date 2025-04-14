Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76726ACC
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633906; cv=none; b=M819BMhSJW51rYFJV8BT55/16E6MVbfrfD4y2GWM5H8DUzv3ZTkQ7uwsmZ+6tSvD1MB7osOAPmFLMqZ0xF5Ir/8/NI573OTNAPgripMrQpy2nh2B6ujqJpoA0iGlVhCpLv8u8EkGGyjs9TIJie47W8cLZf8RLgi4zBUDoeAuEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633906; c=relaxed/simple;
	bh=JQHAWsBF1SO1wzyRBXxFg1oO+Mq9AEXh39XcLyCgqKc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=njAtqKyLk8z9MCSbKc43dy9bmemfrec5Pwjwbkj3T1I3J2bG8Xmltzz7aP35QssZU9UMdaeKGQw4wrdH2yYtEde1lsS0T2+drHfTZ3scs/Y04Lb58+/SQzEd9TGqQ3fHjrpKV1ymqxs7TcsZ6KZu8nn/qa5zcqPsWd1yrvLi7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKMhtACz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKMhtACz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224191d92e4so39324015ad.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744633903; x=1745238703; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVkgNGr4bpFz3NEMp48XL4XPAF5uBVTeQ05BqTj9QKo=;
        b=QKMhtACza5GrKieN+gw6+GvQ2i6rgM1FMD+7to8H1xWM/J2+YSCmTsv0Vj3brAz3Id
         EuNi8dr76zu7nIeVchy6oB7jKXwOcMs8j8fkpjyEUcB357FBEMLk2ppBdj5sq8NqV73N
         XPDQScC+82KCi4eM0DMBpuRqj44Y0+eB5KOyq0hC8NIPd8mVfJpkbQMdiy3lK2DjrUZE
         mVV7VkKwLnqODrS+SSkmZqR/ToK55on+FclNhBB5JhcMfW3rC0Z6pR8CfgwZK4D5z58q
         ma0puz9YLwlGVDq/TPKITYk8Dmuc5SOPolAGknPtrdDoCsNnUN8guEN+u6TzY9B2zqhN
         mGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744633903; x=1745238703;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVkgNGr4bpFz3NEMp48XL4XPAF5uBVTeQ05BqTj9QKo=;
        b=XCQ5+bM+B4+0QR9Dz8O82XOi4Ysbxk83kjXWzSJ1UGuqWgu2eWi9iJL4fAMh2Yl/cI
         u3x3N6omqk4RtxPpsXpPemQxCNNmur1mLB+4NACiWKX/kCXtwhJls7QBuo0wzX4a2d7J
         H0fojYP5q0eQsrb/jucIWx7i/W098NhCKme5l3xiScYh5LZ7RFHl2Jdcl8z72QlxXk47
         8X2HDIs2ZzHbackkSjkPxpwnwABv3ijIQYgRVTJSucocV1C15zEn6eqTRLutM7vQMwyC
         GNb4zTAxTguqn5XZYngACxovC4Nn01Qd1M4lVSExewH8g3SBaAdCuGKSUEBejWh/7NMA
         cg9w==
X-Gm-Message-State: AOJu0YwCNnPj3vM0zOhJEwoITtL2V1W3t6kqlkUjDKm5U9nLJlkOD1Ty
	1DY1uGclqqvOaBK9GKoB1mu0zkXbwRHc9cReNYrWmKqF/dgGSvV7UR61zw==
X-Gm-Gg: ASbGncvCFx1j5y3OYx249u1/+9dvrbAlRo1PM4pv+9mMmuIVv8HbRa3uETwJAQ5KIVH
	pppbcuzwVk9nIxTcNJSYs8qXRD2rEfxoP+GkNglWSrPjSsq2Uv6z2qLQTM6Of6PjoHRbJqaKrdn
	2M6fu1kQSwu1AIkj+bMddi/ZOdTquw7oOV5A7VBwYr6EbAmNM8qKgjPTJqLK1izIK3H4IVY7EgI
	deDFnymuyP39VqFHWqLS0O/9ong4pRlpaGmEjGW01wK797XrR+43C1cycIUzkPADr/YPGZcLW8t
	xmCpaCiCeGJ6YLX1dicWdU+mX1p+KeAl8nWhk5dLFVJoplOhQVE=
X-Google-Smtp-Source: AGHT+IElKFYB/dTM/+eX22Lpp9/1XkQvANU1oyZn1cdcCQBqjOCIZsyU9aEhqwnXnGJ0JkVwGJW62g==
X-Received: by 2002:a17:902:d48d:b0:21f:6546:9af0 with SMTP id d9443c01a7336-22bea502685mr139210685ad.44.1744633903030;
        Mon, 14 Apr 2025 05:31:43 -0700 (PDT)
Received: from [192.168.0.7] ([106.51.24.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b73asm97000855ad.86.2025.04.14.05.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 05:31:42 -0700 (PDT)
Message-ID: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
Date: Mon, 14 Apr 2025 18:01:14 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?Q?Jakub_Nar=C4=99bski?=
 <jnareb@gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Collaborative community interview for Git's 20th anniversary
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

As part of the Git's 20th year anniversary, we from the Git Rev News 
team are thinking of doing a community interview where we would share a 
list of questions that we've prepared and we would like to welcome 
answers from anyone in the community for them. We could gather the 
answers for them upto a particular time (like 25/April or so) and begin 
curating the answers into a special interview for this month's edition. 
The questions are below. Feel free to respond with your answers to this 
mail thread. Let me know if I've missed to include any particularly 
compelling question.

   - What's your favorite Git trick or workflow that you wish more people
     knew about?

   - What was your worst Git disaster, and how did you recover from it?

   - If you could go back in time and change one design decision in Git,
     what would it be?

   - Which Git feature or improvement over the past 20 years do you think
     had the biggest impact on your workflow?

   - What Git problem that existed 10 years ago has been most
     successfully solved?

   - Which Git commands or workflows do you think are still misunderstood
     or underutilized today?

   - What's one Git based project, tool, or extension you think deserves
     more recognition from the community?

   - What Git feature or capability surprised you most when you first
     discovered it?

   - What's your boldest prediction about how version control might look
     in another 20 years?


Looking forward to see interesting answers. :-)

--
Sivaraam for the Git Rev News team.

