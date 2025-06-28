Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E29148838
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751095590; cv=none; b=NI8wrsi8bNu9D6hckOnZrBxhweZry+O6XoDnXdaMaw1Vhaw9qgD1JAzT4NyqHTEq7eaGgM1ueRRDPl6wwf/SneZ0TsWY6WiWnwKv8vgAzOCi8H+edz9AsveJQ1CZF7oJPqbWVW0firppEM4ipZmKiyhflnRsyxQBgbzydUZz3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751095590; c=relaxed/simple;
	bh=wmAW+VlqLHUKO8FvPpBglUBufVUovWI+9qW/6g5CL9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4NDbWxixLUuJTh4y8WeX4c8dZ1f98BpQvrbKO6I69HIyprxfdQpmr9tTMYSScqWx3GNs0//NdNTJEci0/sIyu7lZY70iMvGKIawVTZqLPc5KlKoOPtmOc5lX0YAHRnFg/Xm0JTQw7sbT1kM9cANcP7KZIQJ7u+QYDQfZ591kN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY1evKaq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY1evKaq"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313b6625cf1so2024368a91.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751095588; x=1751700388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHCiQpL/ELdjZBTXzRILhezowBgRYP+g+oIoqkqoLeI=;
        b=WY1evKaqWAI62QwPOhNUgN7oYhL5V5CFZRAkfcicHyBZHhpRsuOiYg9g7F2g0iZGgf
         7CWRl5rZEMrK/aj5yukMcsQbVQQInTQ123YcOrfkLWMrePhLXWAUESLF/PKr2P8a/EDX
         oeloVPWq2fQZtCMcTo7aBRsT+RgBQO1yzFoXO10OEEDUjJHP4WLmq6zrhu2il6dfrh22
         kSad3NHk9dZx34OyDqjZfvMA2g4YXAdOEyiQ4ehHe5/8c8ZISt7hzKBQyJ5mMzRvtmqn
         kA/xHLeqGO35rbt8aDN+H91Ghuh6XzDfzrXFod1i24EYpEA0XOgoYSkVva8FQXUwSe00
         NziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751095588; x=1751700388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHCiQpL/ELdjZBTXzRILhezowBgRYP+g+oIoqkqoLeI=;
        b=AfB+r9lCkUZbwKRMITooZFCps9vxgZHyexCFXSr8eYuxqF1jI7GC+TpY7HFdS2B8WI
         41hHb/nxSm/0aUSB6p0eB4qvWob0XTtN+cf24HbP300nmjkflOa0hY/CAKpBSO1NUSEf
         teHq2eFISKfxW8yhg7uziY83Yn9uBg8A8QoAm9OAIgPqrriHATrSpuoIsDKq6MpuFE9c
         HNCSuM5ZwtX2ZZEbEVvlFTT+g5BmjIoLgD+sZC9p4F5paQa/oxddjYPeI4yE0DFmwqLK
         F3WdyBOQ6rRqdY2TDhMvyqqXmA6zmTo62KPrnxVXemOmOid/I00U4DtRaxQ+L76Hm144
         MZIw==
X-Gm-Message-State: AOJu0YyBGVp829wKKTD3I367Iqb7CKiu347nFFU0OdIB6TAiaF6JRzl7
	eXTjN25Vls5DabdfBhS6yaBPmYETQowkKTYVbDB9b91Y7jlhSMnHHOiz3M/SYw==
X-Gm-Gg: ASbGncvsJz7TeU1jMpjT21ThMW+o2x3nKw2pM40aqN9WSvumbIsILvKKRsNP8/IiUXZ
	IZ23ZXyQn10b26Zf7uQOY6yohPR9RO8McJQYuIUJV6l4yXlMAkQxEbze/Qum9YI+lEj88kM0QF/
	TPB6oCinqqd/45ApC/hxzUicdBWUzWz8wulUPj66DMHrQ++GRiJ8LWLjNPjJBFqPaaZGceuQ3uE
	98BGp30v/sxXt2auD20bLxFE8Alua49roMkz4NedLhqBIsmhOPhPP8AirVetF1cek3bbjjcJsL0
	U9e5nbdyd7W5Z1QeOFEa6gFF/w/c5aDWUkKomweP+Pzxg9CyyEZxIGfqUA==
X-Google-Smtp-Source: AGHT+IEuaM6UQECaXtTSZSE8MofY+xjFZyMy4jwg2k5B6nuhSPDJtMQZPMydWGEXri43oxSeivXOxQ==
X-Received: by 2002:a17:90b:224c:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-318c90f03bemr8890176a91.1.1751095587917;
        Sat, 28 Jun 2025 00:26:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f54379ecsm8287132a91.33.2025.06.28.00.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 00:26:26 -0700 (PDT)
Date: Sat, 28 Jun 2025 15:26:37 +0800
From: shejialuo <shejialuo@gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH 1/2] repository: move
 'repository_format_precious_objects' to repo scope
Message-ID: <aF-ZLbf8rBHrHOXb@ArchLinux>
References: <cover.1749343601.git.ayu.chandekar@gmail.com>
 <6ffb071295272a1d5311f52d8d2015d0aec7e71f.1749343601.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ffb071295272a1d5311f52d8d2015d0aec7e71f.1749343601.git.ayu.chandekar@gmail.com>

On Sun, Jun 08, 2025 at 06:36:34AM +0530, Ayush Chandekar wrote:
> The 'extensions.preciousObjects' settings when set true, prevents

Should "settings" be "setting"?

> operations that might drop objects from the object storage.
> This setting is populated in the global variable
> 'repository_format_precious_objects'.
> Move this global variable to repo scope by adding it to 'struct
> repository' and also refactor all the occurences accordingly.
> 
> This change is part of an ongoing effort to eliminate global variables,
> improve modularity and help libify the codebase.
> 
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>

Maybe you should add the following things before "Signed-off-by":

    Mentored-by: ...
    Mentored-by: ...

Thanks,
Jialuo
