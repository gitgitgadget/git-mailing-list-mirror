Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44A250C06
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303201; cv=none; b=Nk9aWFUKd69fI44TOPFzhjp5VrJQPyLCPAkvCSYhc70LnIxUsfXRRVkI76RxQD6UaNM2Ft6dxD6kilQ5eShI7JnC/H0DIr3q8gRtEBvrVbDZGTZCz0UHJ0GQysXIel96JCZeLjIlZvk41Gi9gHnzw6r9gnzp9TdZPYLfZKAnUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303201; c=relaxed/simple;
	bh=W364uJo5KFUjyYfctf/ymQX1axjrFLXNrD6FTTIWA1E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RcaRZb0EthXHteV9FgJ9wTza7a+VZcYzIvo138QUAEuYQJSXQ9LEpU/fGs1AkyNqpWzcN2ZVhUtE1U2FIYuc/jAqKzfWOR+HGM5wxz1I38JiugAxYuqFU/KP91Yp7poNWr9NdQumjO/+wGnLEndyR1XkByCkMyYZrQyX5KT8eaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com; spf=pass smtp.mailfrom=odoo.com; dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b=jE8VePKj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b="jE8VePKj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so7862035e9.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google; t=1773303194; x=1773907994; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIesOUHUd+lWXLW6JXv8C0zvnZFNZTn5XgHVE+PdO9I=;
        b=jE8VePKjnV4kkvXNwGYRcDI23ttGlU9hnjMx2WFJBV+aDYJpvwK+pkIdNaji+dW2Z2
         f/Grm77ur4V372YeIBoUQg0xlANCTFxgJ7vHMbG/5WFymSDISAgq+9gvHX7Ru6bc32Yj
         phicXl/wTaUpi1sTvm4nWoVmr6/hJ36dfZFbdj8IOhwngy7Wjm1h1IyLW+RUlt20b+7g
         m8BX7DHOijykODcNWAQ3nKfOBT/ScvrwlBg0jxw0knoywUpbItch5xaJ0rV4jyxX4SGZ
         EM2PP8cMOMxgwyRcrPDSxhNYy/Mtvx8vdONOpVWXZI3SZ63iZzYqPpQmeHKC+svhTMfj
         jM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303194; x=1773907994;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIesOUHUd+lWXLW6JXv8C0zvnZFNZTn5XgHVE+PdO9I=;
        b=gHLXjZB4R/5XtGDYxwxXx4RATgEzFQ4qt4yCNyCVYLkoLFs27yfejQcTr1vtxHU6We
         R7MCtRucj3VonUWm3DDoJrd//Cj0R7mkxwNj3J8SfQkVdKDQeHqp+pu0Ms60LVFnSf1Q
         YbO5m2EpskcBi5AMv2h6Za5Uy4oyF+6to+l6mz/ZDRDL4A2BqgOQjZKyt4YJ+9lztsiu
         gRX5xCyLC8QSWubcBHdYJ6WzQk9wm5PZNQlVnSkDHOc9xyIAXIwhQ+cPAUQPd1Ilgwqi
         pZAiaNBB325f5M8aFbH77rUBkuZKN9YizxWbjxbgbm2syM8I5FJrdynTuANyhL9Bkv2g
         qs0A==
X-Gm-Message-State: AOJu0Yzfc17Cc3mszecaW8ChG9Ask9teeA4oVy+hQiQPADA3RismZ5N4
	bKxp04BkLzcR+pao+E2+83LgZKHfvD8KKJS/Xf6PhPc0kZatCXx2PnJJtR45v7FdXLAkX8NGTxg
	XC+OB
X-Gm-Gg: ATEYQzwy2W01xsKdSCTWsPzTw45WvotlJHCaRd4PVqFcccu6BuIHGk9fBzjxhTS8zke
	omfLoFQEtUXfKtp7JTekwIomv4Xx6B2Z1Nw534gEettY7SWwCkRalkc215OKvZ3ISSgtzpgUKeJ
	i1jDFplLYidhYp7y2RxmBbu3yGTHWARQZb0nDm6sXTJUNDNT5FCkmO5S+9B58hg4DGXhb+nJ3Fq
	9p3dp0aukRs/FyvbR5VSnku/WwMFGYJEK7rt750JDGkm5DDtqFuflLvFHnf5WFIWckIffRcqu+2
	XjXChl3Rs9z9wZrUnm0oN3aILBlo9M6Y+SqrWb34AAv4S8oaLlPquVEQ+ML1J5tMWnQoavOthdk
	deqWA8iaBw5g8auzU+bwI9QWeTSepd1+MIINTU/GeHBI0uFjdUSTnyocBbER7PTwGMr37V+O6sq
	nnbEKfU+dS6vCJTqbft8bghIU+yQTxjq7J2Ivz3i/yoMC8eeotOKmP9lmq
X-Received: by 2002:a05:600c:a010:b0:485:2c61:9457 with SMTP id 5b1f17b1804b1-4854b0e0565mr93147145e9.10.1773303194111;
        Thu, 12 Mar 2026 01:13:14 -0700 (PDT)
Received: from [10.30.68.14] (ip-94-140-170-249.reverse.destiny.be. [94.140.170.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm215943505e9.8.2026.03.12.01.13.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 01:13:13 -0700 (PDT)
Message-ID: <5152ce98-b0ce-42f2-bd34-1cc324042f88@odoo.com>
Date: Thu, 12 Mar 2026 09:13:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Xavier Morel <xmo@odoo.com>
Subject: git submodule using worktrees?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a number of fairly large projects I work with, for that reason I 
have a bare clone for each and fork off worktrees as needed in order to 
avoid unnecessary duplication and pulls between them. That works just fine.

However when I tried to use submodules to provide a unified view of some 
of those projects I found out that there's seemingly no way to have 
submodules created as worktrees (off of a shared repository), at least 
not built-in. It seems like the submodules do set up some sort of bare 
repository / worktree situation but do not support passing in an 
existing repository to worktree off of.

`--reference` with `--dissociate` does avoid unnecessary fetches on the 
initial clone, but they do duplicate objects (and without `--dissociate` 
has all the issues of a non-static shared alternate), and do require 
duplicate fetches afterwards to update the submodules, even if the 
central local repository already has everything.

Q1: is there any way to massage the submodules into working off of a 
central shared repository? Poking around and messing with `.git/modules` 
didn't really work out but I may have just not poked the right bit, 
having to set up the submodules by hand (or via a bespoke script) is no 
issue.

Q2: is there any chance submodules will gain more first-class support 
for worktree-ing off of a local repository in the future
