Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52511AAA1E
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169535; cv=none; b=ND51ce/6VcY/TbaUCEwqj8wE01G9zrlA3PAKhFlwdc7Qm0HtJqIOpWAcKTyRy7+HSSCXccfR367TL8xxcEEktXLdmugFDMQhsQm+p3OdL7wl59Sa2dI++TTyoZ3uJAwx4aEqwLopGZyq1Wq6fZSU/TmF0khrVgaP77f6KrMQ3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169535; c=relaxed/simple;
	bh=Oyq8dS1L05UVBpBAXqV8hwiP2HBvevHRwEF2jc4v0eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQtDmO68bNGlsQdHuM7qhRuODnXI5qNJMYg5hlobbK5UYExblFuYG3bibOWGpo4HBwVHoo+uWSkmqEh6XqqA3w2G01qTgSmLQOoom8R7jgcziZV7Kpvg1PNaHrxN7wwDKhZrgw7ewgoTrEFZDc+bjo01VtxyF8HB5oZNC5VGQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDWTru+c; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDWTru+c"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2255003f4c6so42189355ad.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743169533; x=1743774333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqpWH3iTs9lVm5Mhdwu9Gru8mkK8nr0OUhVKH7HP7gw=;
        b=XDWTru+cSh1kWVuIFiQcZ2mByeQ2DAzUz4WDtOBPAMPVTW2zmJyIi4ZBC3TPle4v7U
         zlSCVfB75CUv+lacsG7HFDgMOmufYbNgRInzlllwHVwlgOxxWABEubeIljQ4DsMK8gyA
         GJL+e5TXpPhdscU88JlAFu9rWp4RI5DxYdV1Dsx0bOZx9sIJDTbGzWelVT9rxecVe5n4
         StHj/eqJEphjdGyRVzKq33cwZa2Uc7+Lyc+BysIzFpLV8WnPK4ZIQurjeInsEt6YYNuV
         FAM1Lo3zfOjXmbb57MI0qmX8blCBC+QzErrxZNX6On/9jwIH7A1sdqhVSKYjePRi4qUM
         QSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743169533; x=1743774333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqpWH3iTs9lVm5Mhdwu9Gru8mkK8nr0OUhVKH7HP7gw=;
        b=cVJH6o3Ot+dVHIJUBvh2NHCgnlSQEl1qx/B0ZyFx4BMi5+6Q1rxuNUMnZJ2HHGHXNA
         BDoy9UotnGVAVT7HkUMS8cZf7eI0ukgDLtcRPXLMn61obzcruwYJFOFsz9Q1oEKDT6wQ
         h8wB6iZy895acwxuLzPwXuk8C/rLswhE2xBJcjO+EfbxFj165n38icsEm1kHst1u4Dsd
         9oRGV/c9WLMOScEBMey+L/mSwj6JcRTsw25/HpgEkIm1WR7J96xHAhPHgD60CFtCNmtM
         udE8GbayQ1U8n9onHhhTZVJLXbum2/oZCn7659tIucqsklC2tEnB90rAsHO0k2ocAo6/
         xGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUkWoaxEUoZGbodQD8U+wPnDi+PjeEL9Gnq0asD+HTxm53nROBquYRFxT0yL0DyoFa0C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAFPunDD/rPp5cMntCGNZ5/7zwxwBTYi6TI47QHgFL0OESo3L
	3dGJohvRjy2/ndGI4GMF1FEGJke4rhxMi/AAJOTbqdDbFSrvx0g9
X-Gm-Gg: ASbGncvUbd41riv2F21txYzzeLi4RHIVvaw1PdN+LnalAS2AJwwPU68xoj72xoEI/J4
	v4ePrVAbRoKazAghGat6ItaFl/KApDKt0yBJmGhd/+A9ctpWXfwpbUTb+zxrDCNMhs/U/ZLisK1
	D2Z9j/KXA0d9mQPqXCxRVxgRHU9OTUzT7aKxdHhb+GUZVsfY4ycysZcg4zgpdZKTMXHJptOe8pU
	ODJ2FlhWQROPX8udz8u02IZV4YmQi5nEx3AajDUlKy3TADRVBiFrq98Six46gJiVHca0f5iMweI
	BKwmK1CM18TDz9jjppmBDdKVFyGwGs1VNeruNsga
X-Google-Smtp-Source: AGHT+IHumMRzN7niRopHsB/+ikN6tZA4Ia5ww1GmYkidfYncmrH7EHLt2L0yxUsls013oW4QlpzrEg==
X-Received: by 2002:a17:902:f68e:b0:215:89a0:416f with SMTP id d9443c01a7336-22804897de1mr96376745ad.30.1743169532606;
        Fri, 28 Mar 2025 06:45:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1dedb5sm17509455ad.176.2025.03.28.06.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:45:31 -0700 (PDT)
Date: Fri, 28 Mar 2025 21:45:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: Yuting Zheng <05zyt30@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [GSoC] Proposal Discussion: git-refs Project
Message-ID: <Z-aoALIDd-U0bYnI@ArchLinux>
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
 <Z-FJ3EQdFIkQgtkR@pks.im>
 <D8QOYSD6NLCS.OVF4RKHUCX0A@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8QOYSD6NLCS.OVF4RKHUCX0A@gmail.com>

On Thu, Mar 27, 2025 at 10:26:49AM +0800, Yuting Zheng wrote:
> Thanks for your reply!
> 
> I have reviewed the changelog and noted that Git version 2.23
> introduced similar work through the addition of the git-switch and
> git-restore commands, which replace some legacy commands and incorporate
> various functional modifications.
> 
> After examining the updates, I have summarized the proposed work as
> follows and would appreciate confirmation on whether these tasks are to be
> included in the current project:
> 
> 1. Code Modifications for Command Implementation:
> 
> - Implementation of new commands.
> - Necessary modifications to existing commands to support these changes.

I think "modifications to existing commands" may not be accurate. I
think what we need to do is we should try to reuse the original logic as
much as possible which requires:

1. Understand the behavior of the existing commands.
2. Find good design to expose the common interfaces for the new commands
and existing commands.

> 
> 2. Test Modifications:
> 
> - Addition of tests for the new features (including help tests, basic
> functionality tests, and extended feature tests).
> - Updating tests for old commands to execute tests on the new commands
> (for example, changing the command in git-checkout tests to git-restore).

I don't think that we should update tests for old commands. We want to
keep the original command not broken, right? So, we should use the
original test to exercise your changed code to make sure that everything
is OK.

> 
> 3. Documentation Updates:
> 
> - Creating documentation for the new commands.
> Updating and unifying existing documentation (including git.txt,
> git-cli.txt, and git-commit.txt).
> 
> Additionally, I have a few points that require further discussion:
> 
> 1. Command Migration:
> 
> Upon reviewing the commands slated for replacement (e.g., git-update-ref(1),
> git-for-each-ref(1), git-show-ref(1), git-pack-refs(1), and
> git-symbolic-ref), it seems that migrating their functionality into a
> subcommand of git-refs could be sufficient. Could you please confirm if
> this approach meets our project requirements without introducing
> additional functionality?
> 

From my own understanding, we just want to use "git-refs(1)" as an entry
point about all operations for refs. So, we don't need to add new
functionality in this project.

> 2. Function Call Integration:
> 
> Regarding migration, is it acceptable to directly invoke the legacy command
> functions by passing parameters from the new command functions?
> 

So, you want to say that could we use a subprocess to just invoke the
legacy command? I don't think we should use subprocess. If we could use
subprocess, should this project be called as a project?

I somehow think that you may first look at "git-pack-refs(1)" or
something like which is not so complicated to think about a solution.
And when writing the proposal, you may need to talk about how many
commands you want to migrate and how do you plan to migrate.

> 3. Test Retention:
> 
> Lastly, should we retain the original tests for the legacy commands, or
> should they be fully replaced with tests for the new implementations?
> 

This is a good question. From my view, we should not change the original
tests. And this would introduce another question, if we add the new test
for the new command, we'd introduce repetition. I cannot give your
answer here because I don't have experience about this.

> I appreciate your guidance and look forward to your feedback on these points.
> 
> Best regards,
> Zheng Yuting

Thanks,
Jialuo
