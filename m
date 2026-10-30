Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393790;
	b=O0yrX9uZdtuPUvRa3yOtfDgt3xevW4pXirMVEWv4WBetExxrZXjN2iNQ5s6mi0a3UPE4
	 jgCWSyXyUKbkbQGm3SJrQYgT7I6pytH1rrQM0d2x8MB9qhaKPqhWwpTQETVxgBrwR4gtO
	 EBsCAccMXPI99qEzny/CMCePoBM045s5LQFKLG3G2/2a47fEFF82bQOGm0BKJ1TB+2Taw
	 SQI6hZ3XfoJa8rlvPC7HO/VzD4tLxUe0C5Lo/orDzDG9dTGxwnta8fzWh7HWZ6DR+oFXK
	 RySXtCg8YapWcJbTsm5ljHGDOjaYdJfC+fzqKpADvW2Qk6Xm84igzkP+IkbLLTYY6cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=4U2sAke5UAov0kFIkq0GEtlb3aqnN8vWiEBQHkiwFgM=;
	b=W//DakelrrzAhPijubKNUJ+aLa+ZNh+119xaTjiUcTaB3I6ifPtLs5OQ5WFTLcuSqzbM
	 2W2KY2+obQmGbbUWvOzeLj/ZlMN7WDjLuTgJpwU5RTeOIF87ErOb5R055gi/pIQWgR3iK
	 MfsJ0MK5D6HHH0ekudVcA8uNcyz9TfOuSWwoZXOXaT0KAdG2WZPpAs+Wn/2AZAUj7ltqm
	 vyOhok8xFCcYJTRSIE3YIvD75dBU3kXDOmj/DMeLTT7X8rZwvmB9EDYhwSqlbtzRjBsIJ
	 6ILfvqAOfkCw4ox8+8L88zvIf6UrNnsL4X9Ae2OcfSlrTJveUvkXD41w0PBTW1PxBNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdHlc7Zl;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A2606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 766A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdHlc7Zl
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8446af403b5so760208a34.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793393789; x=1793998589; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4U2sAke5UAov0kFIkq0GEtlb3aqnN8vWiEBQHkiwFgM=;
        b=wdHlc7ZlBo1gRZjtDxNKrwL+vuy6lxkvmm2PLFJp4R2qwU7foHNbe+p3ZRk8sesbKO
         DvQQrUn0IgJRNV6MWobf/98BRo/W7MsnOpxmc7dbsmhGpCdf00mS7QfCdkh3rB92lLXW
         B7DGzKJc5FO5dIIMc9yqidvR1xXrVBSVHn4HkAmd+CVgYFetm8JYH+nkp766tphFJSH+
         xL/nmsS5uV63f0vH2NBmx1rbM5IPRD90M9+tfdX6SnzS1bn4BaTM9orYaZuzBkCHJ/D5
         TCj46yWAbokrf9RSrhAVeysrc2IzEH6m4aJ5CCt58x7C+Yg551Va28utwc5VhuYzsPXz
         Uf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793393789; x=1793998589;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4U2sAke5UAov0kFIkq0GEtlb3aqnN8vWiEBQHkiwFgM=;
        b=Lye7Jv9/w3yaU3v+BqcbkBgeAqEpjF3pJn+AONRen/he3wmKyIeo+3tnLDae+iAY82
         H8H210up0ycSuSxARVA31jHxvMToova/A6JK2J0Sgr2u6wcsTaeIPXQt+Yhlm1c7fZJp
         BpISuHNQTPHOL6FqSZzAiKJYJezasROpQPcix3VM3zTOkxOe2XaQFAMeRJiXDugq3Wzp
         ydB9H6EC38nU7avA6tgOf1+2FI33AndqGpXncUW2GC0T0pUcXi4YLecwQln/y+5QRLaH
         cb+bmueWkYsZxBGkeBUqJUXcy8QnbYWRftk2EgRM/XKDDSFhd2A0gb7oJ2uG9g/dLTvI
         t89Q==
X-Gm-Message-State: AFq9FYIMyor8HSTi2daj9PpV/+zF1GTXgisPs+GyytjBGsbKqmLOmi7y
	fqCmto9FlXOq3L72kDgL1tGKS3Hx+MqIbldhINwwPykEUvgb5bFl3bJ2J+RLwBISOL0=
X-Gm-Gg: AYBFou0ZAXB4nRhQBbcdtEFko/4/4Ul5YBL36KXQVCx6kfgI0KRcc+CYN9gDFBaJyml
	Kkr3xpnuN/HvDAWiJ08sNsGcMZk7Stg53ZHEVnOAeKiGexAuM/KuZw1pYrGZWeBYvkBUH0iEG0E
	gZXAd4kjbRoNk4ERX1kXwAqDg+R8e2FEO73rM7fGNiE3s8rTnPEtSplF7Ox/lW7XyXCAlOxnFZC
	EoXxQcYshaXqmsPKZuvS+i73neNHElFZMQf7exe7A8FPRoCZJb8QMjsbacMnCNPMZmFi7O94XZr
	9LhOfiwJ398NXRXpu7WGYVEwl0gwK3Ei9xMG5ajJhMsMqxcO/JxxBZdC91lj7Lr5Mm1OnXy2T/j
	jDnCxyCLtn+/mEG4BvfLUXft2yiqtXUVjh9IZ8pDE2/z2q6lPC8K7raFTpphMjOnOFSXp+bBqh+
	sRDxucgvW8yteFQuheJEhIS8m3sfDewKh69EIcTrFYTswb+SIthPlbjJ7gDZdF8wTJ19yPTEfXA
	yDywyveMtA9JtL1++eLVPNvml4o3sw7guL4jcFZWI4gMifD5an7blXeqSlzBEs+QvhKnqAgirwv
	gnMCh5W2DONU08UzOpAjTBq6e9fUS08pUQM=
X-Received: by 2002:a05:6830:7181:b0:846:5201:5286 with SMTP id 46e09a7af769-85d364d3d77mr2969094a34.12.1793393789341;
        Fri, 30 Oct 2026 13:56:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.206.179.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d35499153sm2893816a34.9.2026.10.30.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:56:28 -0700 (PDT)
Message-Id: <pull.2248.v5.git.1793393787.gitgitgadget@gmail.com>
In-Reply-To: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 20:56:25 +0000
Subject: [PATCH v5 0/2] doc: add new git tutorial
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Richard Kerry <richard.kerry@atos.ai>,
    Julia Evans <julia@jvns.ca>

So far we've gotten 112 comments from 30ish beta testers who have tried to
learn Git for the first using this tutorial. Most of them were able to
finish it successfully. By far the most common piece of feedback was that
people want to learn more about collaboration and branching. I've written a
draft of a tutorial on branching, but this is already quite a lot of words
so definitely we can't cover it in this series.

I don't know if it's possible to get this merged quickly, but if it were I
think it would be amazing since people are so eager for a tutorial on
branching. If we spend a huge amount of time revising this I think there's a
real risk I'll run out of funding before we have time to write about
branching. Ideally I think it would be great if we could merge a "good
enough" version and then have a way on the website for users to give
feedback on it, so that we can later incorporate that feedback and
iteratively make it better over time.

Thanks to Paula, Agavi, Ken Wells, Michael / Chgowiz, Ishmaeel, and all 20
or so other test readers.

changes in v3: (v2 was the "first" real version since v1 was a WIP)

 * Say that the tutorial supports any version above 2.23.0, when git switch
   was introduced, since the next part of the tutorial on branches will use
   git switch
 * Mention that on Windows the tutorial will work best in Git Bash for and
   it might need adapting for PowerShell. (thanks to Ben)
 * Add a warning about how Git can dump you into vi, how to handle that
   situation, and how to write a longer commit message. I tried to strike a
   balance between lightly suggesting that it might be good to write longer
   commit messages, while making it clear that you can just use -m"" if
   you're not ready to navigate the world of editor configuration. I don't
   think we can use Pro Git here though since it's a bit outdated. (thanks
   to Ben)
 * Add Helped-by: Ben ...
 * Add output of "ls ~/.ssh/*.pub" (thanks to a test reader)
 * Suggest cat ~/.ssh/whatever.pub to make it clearer how to copy the
   contents of the file. One of the test readers said this was unclear as
   well. (thanks to Junio)
 * Mention that the public key might not be called ed25519.pub (thanks to
   Junio)
 * Add a short section on the importance of git status
 * Fixed the formatting around the headings. Kept it in the same style
   because I had issues with the docs linter when using == DESCRIPTION
   (thanks to Junio)
 * explain what --set-upstream does (thanks to Ben)
 * A few other small phrasing fixes from test readers

non-changes in v3:

 * didn't use git config set since the tutorial claims to be compatible with
   Git 2.23.0
 * kept using the term "folders" since my impression is that Mac OS and
   Windows use the term "folder" and those operating systems are more
   popular than Linux. I don't think any test readers were confused by this
   term, though "directories" might be fine too.
 * leave git init instead of git init myproject so that folks can use the
   same process when setting up Git in an existing project

changes in v4:

Make the instructions more Windows-friendly (thanks to Richard Kerry), by:

 * mentioning that Git for Windows will ask you to configure a text editor
   when you install it
 * saying that the SSH instructions are Mac/Linux only and suggesting using
   Git Credential Manager on Windows, and update the instructions for
   whether to use an HTTPS/SSH URL accordingly
 * using "folder" instead of "directory" in a few more places Also:
 * Say "bottom left" (thanks to Ben)
 * Add a link to how to configure various text editors
   https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Setup-and-Config#ch_core_editor
   (thanks to Ben)

non-changes in v4:

 * leave the comment about how vim is "extremely difficult if you're not
   used to it" alone, I couldn't come up with a better way to communicate it
   and I really don't want anyone to think that being able to use vim is
   expected.

changes in v5:

 * replace "it" with "GCM" in the commit message
 * remove some trailing whitespace the CI on GitHub told me about (make
   check-docs doesn't seem to check for this)

Julia Evans (2):
  doc: remove gittutorial
  doc: add new Git tutorial for beginners

 Documentation/gittutorial.adoc | 1051 ++++++++++++++++++--------------
 1 file changed, 589 insertions(+), 462 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2248%2Fjvns%2Fgit-tutorial-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2248/jvns/git-tutorial-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2248

Range-diff vs v4:

 1:  64d9811539 = 1:  64d9811539 doc: remove gittutorial
 2:  4b40588c90 ! 2:  051b2c4551 doc: add new Git tutorial for beginners
     @@ Commit message
            giving some instructions for how to translate an HTTPS URL to an SSH
            URL.
          - Use Git Credential Manager for authentication on Windows, since it's
     -      simpler, SSH auth is a very "unixy" thing to do,  and it comes with
     +      simpler, SSH auth is a very "unixy" thing to do,  and GCM comes with
            Git for Windows
          - Warn people about how `vi` is the default text editor and give some
            instructions for how to escape
     @@ -1,2 +1,2 @@
      +On Windows, you can skip this step and the next one because Git for
      +Windows comes with
      +https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager]
     -+to handle logging in. 
     ++to handle logging in.
      +
      +If you don't already have an SSH key, you'll need to create one.
      +You can check if you already have an SSH key by running:

-- 
gitgitgadget
