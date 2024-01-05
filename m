Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6D185B
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrUr6QC6"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbd1fab03cso760526b6e.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 17:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704417302; x=1705022102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxPZkxO9Q4M1tWOI2EUqaD+p4etQPgUi8if3TbuLqjw=;
        b=MrUr6QC6ODn1E5iCm7pR2n9lA4zXjBQycAMS+TfG/bFNNZkwnirGyBJ1W/aRV5Z10b
         /xPt7+sdmGlnxtIM14NbdyIT2FUtYQilIabAX68+iFjt5EwJ3aFBdOeJb6r9p+bi4DNM
         QeAKL7OYHtucW+6Qo4CtkUDSmUYwQex9UOJl/KTuQ1TCe3MxEQ6a+vHpk94NqZEwsmd5
         sMnb+nlVaFi/8QNn5JWt7z9HiAUEwupCBVom6GwMv6JmCWHcaYQaXOcuW0+gHw1PMV+6
         T1D9Hq8NJ/i8m6dOLig/x8MAWpGUaY0pnc/d4vx4zCDTI4147+ZY3+imPf/TefC+MgU9
         UCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704417302; x=1705022102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxPZkxO9Q4M1tWOI2EUqaD+p4etQPgUi8if3TbuLqjw=;
        b=adGqzx6CT1DVhk3qFYLpSo1JQhXGRQEJ2GscKuKAhethP0p7FCOBSoaGuE3RkyLJVg
         uwX/LVf/kSnKA0+ozydnh+f8JQcIRgiHJh0+vy4WwT9qg/cz9nOLOzn2wIw5NrhAiaC/
         9VfRTw1JUrrtrgumIUgEdmKuGzjt61EiW+Eq5sbT+Co2igX2pcNsf4fkzYJGXIaEVWlF
         zoAAzlc0Zo0VUbH37MsOxZK2gDze3zguYo/n2kGr2MPcoKVlysdy/oEPUHc4NoeuP01T
         8AAz4IcwG3xDwivtaoLL2hjPvaC5rP5Y62havtH2FH1gofMpOpPecpQ5hzVWit9ZkZAs
         gAQQ==
X-Gm-Message-State: AOJu0Yyu911xVIBu4490PIWRmw0OJ/aDKlwXpdaHcQVr8HsTqF05x95i
	EjwNfGvzECJ4HBchLYL1hWB42yTZvHc=
X-Google-Smtp-Source: AGHT+IHDvEof48F7X5NoDjn/cQeYu2Yh0QO1b618TMopDSRPEs1/fJo2MSxaulXA5PCVXdGc239IQQ==
X-Received: by 2002:a05:6358:6f9e:b0:175:61c4:3004 with SMTP id s30-20020a0563586f9e00b0017561c43004mr1653495rwn.46.1704417302032;
        Thu, 04 Jan 2024 17:15:02 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:c2a2:6c8a:c793:9aa0])
        by smtp.gmail.com with ESMTPSA id h24-20020aa786d8000000b006d9af7f09easm276194pfo.29.2024.01.04.17.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:15:01 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3] rebase: clarify --reschedule-failed-exec default
Date: Thu,  4 Jan 2024 17:14:24 -0800
Message-Id: <20240105011424.1443732-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZZcE/Kw24YKlqSOT@nand.local>
References: <20240104080631.3666413-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, I did not actually include the change in v2.
Still learning how to use git send-email.

On Thu, Jan 04, 2024 at 11:20:28AM -0800, Taylor Blau wrote:
> [...]
>
> > +Recording this option for the whole rebase is a convenience feature. Otherwise
> > +an explicit `--no-reschedule-failed-exec` at the start would be overridden by
> > +the presence of a `rebase.rescheduleFailedExec=true` configuration when `git
> > +rebase --continue` is invoked. Currently, you can not, pass
> > +`--[no-]reschedule-failed-exec` to `git rebase --continue`.
> 
> The last sentence was a bit confusing to me. I assume you meant
> 
>     Currently, you cannot pass `--[no-]reschedule-failed-exec` [...]
> 
> without the comma between "pass" and "`--[no]reschedule-failed-exect`",
> and replacing "can not" with "cannot".

Applied.
Thank you for reviewing!
