Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995416418
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgAl86w8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336788cb261so5463088f8f.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705093629; x=1705698429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWwqDICoOOysd6GX9YX8an6i8gvUrRPZ4JPnZPhpfd0=;
        b=QgAl86w86AoKG1Fs+HGQ5qQXaz8PZPS2X39tjE4T3C8HTaNaf+BJENoSklbAowxXfl
         DIK4rYZyjZlK/IZKUIuZFCL8rGXvr6FEpjMJOaxHNSmSuYKiagu0QxKUvU+CNUXnBuWd
         CKb5kCnF5ec+1an6B4hGWAVvReIjZ7Uq3EjqLw07On3UUnBFj+iwX8OPmeyKbOaPxIrQ
         8HQOrX8fuXLQTNwqT1qOIEwlvGxym8WoAf6VmVSasagnd8XIlcXLkElFO7v7+0Yxw5cv
         DAQMEuPlaq9rBTjgbTQLcQ/XKW9HsWsMP9ISDcsLB3DRuX6JpNrcn4AjoBJaqXbr785G
         X6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705093629; x=1705698429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWwqDICoOOysd6GX9YX8an6i8gvUrRPZ4JPnZPhpfd0=;
        b=FxaNM1SYEUIdU0sM3hepFpGGB4k904WJZACjqP4Xxa5t+cEZc7RYraUID/JjL3RTsx
         Hb1de+o4Ox3qifLIBdKpoCriilSF18KnmPfdIzqb7iQud/UsKJO4jHunUs8TuKxlbyFe
         rfpqrRbL0swj9WyhfHBv6mRlhVdYYCT0/JNPyPAp8fNdX0muMKSD89ThGt/UUwXwsfHs
         PbMKlOuF7RxGp+Q6lZ/88bAVVcENntbSjXOsaiGZBklG4Z9ohiIfUrPKEC5NkIv0QbzH
         JUjZw0A5ffL2Byw3PL8Py1iXCHIh99oakeBzakUQENBHHksC0DecRypCDfnUUiPq1m3d
         hIIA==
X-Gm-Message-State: AOJu0YzMYYu0FOdSndIOXta7EUlFzHkBmWwqhPxfYED9tkYf6genPF2u
	TEy3o2c6n9Gnm81w2OdVel8=
X-Google-Smtp-Source: AGHT+IHZWl+ds3Qc1YLNouJxYolOpkgcBMuwFPQjnqkRnDgAQCfr0TEz90XeYpb4k+LJAIfkf5bKHw==
X-Received: by 2002:a05:6000:14d:b0:336:74c5:e597 with SMTP id r13-20020a056000014d00b0033674c5e597mr1040812wrx.97.1705093628942;
        Fri, 12 Jan 2024 13:07:08 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-4d85-f76e-9351-ffeb.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:4d85:f76e:9351:ffeb])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003366a9cb0d1sm4788809wrx.92.2024.01.12.13.07.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 13:07:08 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
Date: Fri, 12 Jan 2024 22:06:50 +0100
Message-Id: <20240112210650.5455-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqr0im9ub9.fsf@gitster.g>
References: <xmqqr0im9ub9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > tells us. Indeed there HEAD and CHERRY_PICK_HEAD may not share a
> > common ancestor. As I say I've not used "git log --merge" so maybe I'm
> > missing the reason why it would be useful when cherry-picking or
> > rebasing.
> 
> Good question.  It is the whole point of cherry-pick that
> CHERRY_PICK_HEAD and the current HEAD may not have any meaningful
> ancestry relationship, so yes, it is questionable to use the same
> logic for "log --merge" between HEAD...CHERRY_PICK_HEAD, while using
> HEAD...MERGE_HEAD does make perfect sense.

I tried to say it in [1]: a merge also does not need a common ancestor! Try it:

   git init test
   cd test
   echo something > README.md
   git add --all
   git commit -m "initial commit"
   git remote add origin_git git://git.kernel.org/pub/scm/git/git.git
   git fetch origin_git master     # obviously no common ancestor
   git merge --allow-unrelated-histories origin_git/master
   # merge conflict
   git log --merge    # Still loggs all the conflicting commits

So indeed the command that Phillip wrote is not equivalent and the existing
logic already can deal with unrelated histories. Or am I misunderstanding?

Michael

[1] https://lore.kernel.org/git/20240112150346.73735-1-mi.al.lohmann@gmail.com/
