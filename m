Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0244F57A
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326741; cv=none; b=HWLuyf9hF5CvTYC5GzTyUdv2qm6aMMQSY9UHPPjMcaZkf1ZQon8UT9QaHPj0DlRTziPFCA/4VpRFmZHw8gajfipOpt37SlPhCRoekRJ2//tv5OXK0FwumLCYHEABX8b5vpj+evsmwvAO4fHDwIbbdmQVC/JT4Td+d+7Kk5mMwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326741; c=relaxed/simple;
	bh=yOY/Ynfl7OtEh/dQ1a2zHYKflUrEEWsZwIRw3bIcZPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuc+UWvrw8XoOUjdZzuQ9K94TJBlYIwanxrlRA4CdrbeM7QVaIg0i90a7T3ExJ7uQluaOyXuqIVBZK5rGwJ69350q6awFDWhgG2fwiHBOLq3VQJXqQxYUeXjs1kSc9BDKzECfxlaSL8E2JdlUaky6Rqa3o7AmDmtXiXB2DTLM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmNZDOvw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmNZDOvw"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so676178f8f.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792326738; x=1792931538; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E8zwn/9SAl0KsrUI0mq6ftAPHEOyE4rQLCzl3DdXUaI=;
        b=QmNZDOvwHNFkRIWKVuXEXt9DDgYU6IwDjTdOAT/4f988KMiZ5X1hYbt7fY1oICCMV1
         ghGv+rzGYEfjUz4HIA9wDxuaYFcdenZYn2VmGAXRH6Ce7knBCCb+o5iHthS3f3JFtD01
         v5iKR1+o6MWLgQEDECKQ99QDTpojyNzVDdJvbMHQIbbqwgo9I1WpcXU2cPbHZtrxciIM
         aqK2v4hFb+NVkBVt8Z6meSAbafycvMGH1PKPAc/ttEMxf9YYcWh3eRcfjFXcHsNJz9sG
         xY8JVZ6CcuJteps2tAh54PP4JsM1J6QLHP1AO2qrsvZmOmxLGQn9tLd+1tJMnsQEYyKo
         bK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792326738; x=1792931538;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8zwn/9SAl0KsrUI0mq6ftAPHEOyE4rQLCzl3DdXUaI=;
        b=xcBP9fk7ZiX3JZ4p2K7lhPy4Ye1E0r3WFiuOUQPbuL2pPTuCvN8T4QdsVanbCqA9NX
         Otv4PnXsrZFH31MLSAPz6dziB7LgrkPcbHl6jeOR7FYv2kME4UpucDRfxjm/Ux58y7ch
         7L7nIwjvnJTl7UStKgPLSCsneJgf7ISI0wLrpxBhGjfIMTFfDdK0cp2FnjKIh6IueA5p
         0EMxpGDSVBhfDK3q2NyVy1HLHrD4ijNrNVHjE5E0U+ngbVnUqaQg0L5b+usCPtEzuNmh
         Q6N0IZrFkyUI5W1vcEbQdKXOUynGbFb3cQlplBSOaYNgpR7NVE1rEqLr2go2IUp/FyxO
         BWQA==
X-Gm-Message-State: AFq9FYIAAlchNQ5UjN8WSMR0TEtkvaTeTI5Lrt/+nW/algNAiOC6mUQ/
	gmO5O43jv9ZyGo2qfhFWJC7/0jP7VQxZa1Xw7g0SbloxFylIQyKBfrpNCF+VnEg8
X-Gm-Gg: AYBFou0SNxWZU77S0su4TI+41AsdU/fhakLxZlJVQEw255tFCqcSldZ8GxPQU9BRHxN
	5KgbsIsYH6M6XI9tU2EPUu/0HHxpkIhkV8x2nyFyo03YXprPPg16Lbtwiwt4PWTsY672rEKuNoH
	0Ly1IFI6V5JFcPQJkGlnVtPGBd5SV9/Qb2uouqbQyCdooCZ0PoyK8SJv0x1KITOFlZGWvxOihLk
	AFd6OP7/0oK+A9qVpAB+XjTydAb5MoXbBGMFQySFvGWn56RlMPadDFdf2JxqS9CfZGT1OBekeqR
	wObbA1hNgDiQPxAJYpNEmByhwz9iynWyBtaMy3zdDjLAY079swRItRtLA6+OfPW9vXOJGtkj4nA
	9p+CxiQVL4/Uzx2znD/vkQtH1kgIGJWhu6JpPWg8YsYZlHx44E5CDlb9rhnjDOkkDE3D9ezHovH
	9dMSSl5SOZowwvbPZMD6OM8bojfqNrCavyBVBQA0wl+ZCtSqNA4we8zmrdwRqbjZqPsB0nj2K1E
	+y7UtI+oFxX5A==
X-Received: by 2002:a05:6000:2dc8:b0:48c:4d32:ccf8 with SMTP id ffacd0b85a97d-48e07bbe524mr9189533f8f.16.1792326738276;
        Sun, 18 Oct 2026 05:32:18 -0700 (PDT)
Received: from piment-oiseau.localnet ([2a01:e0a:1169:f360:6ebe:9fef:71c6:8f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4978sm15416688f8f.21.2026.10.18.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:32:16 -0700 (PDT)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Julia Evans <gitgitgadget@gmail.com>,
 Julia Evans <julia@jvns.ca>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Date: Sun, 18 Oct 2026 14:32:15 +0200
Message-ID: <meK9MCd0TPmi4tPMhh-XUA@gmail.com>
In-Reply-To: <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
References:
 <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <xmqq4ifhdon2.fsf@gitster.g>
 <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 22 September 2026 22:54:17 CEST Julia Evans wrote:
> > Oh, I love a change that is so sharply focused on a single issue and
> > describes what the problem being solved is.
> :
> :)
> :
> >>      * I tested it by running this script
> >>      
> >>        (https://gist.github.com/jvns/039c8ed0add092f2179f0dba52ebb896) 
which
> >>        builds the previous and current views of all the man pages. I 
looked
> >>        at the output to make sure there were no differences. You can see 
the
> >>        output in that gist.
> >>      
> >>      * I believe that asciidoctor will automatically make sure that there
> >>      
> >>        are no broken links.
> >>      
> >>      * I also spot checked some of the HTML output to make sure it looked
> >>      
> >>        reasonable.
> >> 
> >> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-
options.adoc
> >> index 035f780e58..47dea1de8e 100644
> >> --- a/Documentation/fetch-options.adoc
> >> +++ b/Documentation/fetch-options.adoc
> >> @@ -199,7 +199,7 @@ endif::git-pull[]
> >> 
> >>  	providing the tag refspec.
> >>  
> >>  ifndef::git-pull[]
> >>  +
> >> 
> >> -See the PRUNING section below for more details.
> >> +See the <<PRUNING,PRUNING>> section below for more details.
> > 
> > OK, we already see an example of the <<double,double>> reference
> > notation.  This needs to be in this form, intead of <<pruning>>,
> > because it refers to the named section of a different file, namely
> > git-fetch.adoc (I am just trying to make sure I understood your
> > explanation correctly).
> 
> The reason I explained this in a bit of a confusing way is that I'm not
> 100% sure in which exact cases we need to use <<double,double>
> instead of <<single>.
> 
> I double checked just now that if in `git-push.adoc`, I change:
> 
> 	of a remote (see the section <<REMOTES,REMOTES>> below),
> 
> to:
> 
> 	of a remote (see the section <<REMOTES>> below),
> 
> Then there's a problem where in the HTML version it displays as
> "[REMOTES]" instead of just "REMOTES".
> 
> But in the <<PRUNING,PRUNING>> example, just using <<PRUNING>>
> seems to work. I started working on this way back in December 2025
> so I assume that something in this patch was affected by this issue
> and that's how I came across this problem but I'm not sure exactly
> what it was.

I have a strong argument for using <<PRUNING,PRUNING>>, it is that the manual 
pages are now translated and that the translated term can require changes in 
the target languages and not be compatible with simply inserting the title, 
where English is very malleable.




