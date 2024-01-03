Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1418624
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoUgKetT"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6805941cb74so11331966d6.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704270750; x=1704875550; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=yuXkiA/Z2M/Doj4MguseXSAwEW8dJOQpS2y8a2mTMcQ=;
        b=IoUgKetTPOmb+ZX6MjkzB+mD5pMACUP/urRQv1uchwgC8rDnQr8bIyU51Pbs0R0xmj
         BarjAx/pINaF/n6zZBPwFfKAy6CHeiacDQFjcAbSqjXRXCWznwpBeTjQo6TkgrBBbXid
         VYHzmnxU/WYB90Y4U013rLSWkkOVjNjzhqEPtqHHADtY2Z32BjfkWtfEXd9FQeJHQ1wE
         BYg3j69rvcViLd1+n9h604L/fPLKomiZd/JYB++UvfgHYyYaPgIPEb1sV4ebILzShOLF
         xMIc4+VqvffyitwXx2glVYh+HxGYItMQNidCX4A19MiHKLxuiB/Zj4ZiZH86aN+fs7ab
         oWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704270750; x=1704875550;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuXkiA/Z2M/Doj4MguseXSAwEW8dJOQpS2y8a2mTMcQ=;
        b=cxDqgizxET1X6C/e4beefbcVd0LH8f6RpKUvrqjE8RJideuwKbvJe9T14veqdIxi7/
         g3Zt5cnTblwjwHtRinM7B8Y1+UD3itT7PrDHhv0QvmMxiBYck7M6Ekkr54mKTZ0Hsd/6
         whgRk8Uru1jlFrwSRbvwInv5oHm4ppbZp4NRkLnh31o3rlTm2SZaOcuMKKG6DhlYBXla
         GqtG5FaYXDWC1H20NAnKeU98odgjNPj7zTPP7JSq0yPpEVEmQ/A97mmNgxcJ61XYAmMi
         4VPcxGFXiLEq/e/63EFDgupRzGDs9a5Lf2Db6+K4i/qVIbNgE1jjkZFvZ1CuAbv7TS+Q
         jKVA==
X-Gm-Message-State: AOJu0YxoHsJaqm38xcPtyb8eBJcZ76/i6pfojIm60gF8/WWPSHq27AWR
	jKXXhGXd92Ku4fw0003MR9rfdmUZ8mI=
X-Google-Smtp-Source: AGHT+IEtCxV4yJg6+QMND3gt1dWZsrr9em2Xn5AJGL0WFKUeWz5sWFd66GNKc7zyPFeryF99gxMR9w==
X-Received: by 2002:a05:622a:1907:b0:425:4420:c5c3 with SMTP id w7-20020a05622a190700b004254420c5c3mr40629039qtc.1.1704270749969;
        Wed, 03 Jan 2024 00:32:29 -0800 (PST)
Received: from epic96565.epic.com ([2620:72:0:6480::1])
        by smtp.gmail.com with ESMTPSA id fd5-20020a05622a4d0500b00427f1fa87e6sm7007613qtb.56.2024.01.03.00.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:32:29 -0800 (PST)
References: <m0y1e7kkft.fsf@epic96565.epic.com> <xmqqcyvgz3ih.fsf@gitster.g>
 <m0sf43abw7.fsf@epic96565.epic.com> <xmqqa5qbmnrm.fsf@gitster.g>
 <35f24a01d15ce28932bb6be098d6a164a49cc542008f75673cd6221a9b24b578@mu.id>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Sean Allred <sallred@epic.com>
Cc: Junio C Hamano <gitster@pobox.com>, Sean Allred <allred.sean@gmail.com>,
 git <git@vger.kernel.org>
Subject: Re: What's the recommendation for forgetting all rerere's records?
Date: Wed, 03 Jan 2024 02:30:45 -0600
In-reply-to: <35f24a01d15ce28932bb6be098d6a164a49cc542008f75673cd6221a9b24b578@mu.id>
Message-ID: <m0frzeu89w.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


(Doesn't look like this actually got picked up by lore when I originally
sent it at Fri, 22 Dec 2023 12:19:50 -0600. This is a re-send; apologies
if you get this message twice.)

==

There might be a bug here.

Junio C Hamano <gitster@pobox.com> writes:
     # Now the fun command you seem to have missed.  You MUST give
     # "git checkout --merge" a pathspec.  I do not encourage it but
     # using "." to say "unresolve everything under the sun" should
     # also work.
     $ git checkout --merge builtin/mv.c
     Recreated 1 merge conflict

Yep, I definitely missed this! Very handy, thank you :-)

     # You should then be able to correct the resolution with your
     # editor.
     $ edit builtin/mv.c

     # If this is one-time fix (you are happy with the original
     # resolution and wanted to deviate from it only once this time),
     # there is nothing else need to be done.  If you want to record
     # this as a new resolution, you'd get rid of the old one and
     # record this one.
     $ git rerere forget builtin/mv.c
     $ git rerere

It's taken some time to investigate on our end, but it appears that the
issue we're seeing is particular to git-rebase.

Consider a run using git-merge, which works perfectly as you describe:

    # Let's set up our conflict; most output here elided for brevity.
    $ git init
    $ echo aaa >file
    $ git add file
    $ git commit -ambase
    $ git branch feature
    $ echo bbb >file
    $ git commit -amremote
    $ git switch feature
    $ echo ccc >file
    $ git commit -amlocal
    $ git --no-pager log --oneline --graph --all
    * 6b33f42 (HEAD -> feature) local
    | * 7e189f6 (main) remote
    |/
    * c5901f5 base

    # Now for the fun part!
    $ git config rerere.enabled true

    $ git merge main
    Auto-merging file
    CONFLICT (content): Merge conflict in file
    Recorded preimage for 'file'
    Automatic merge failed; fix conflicts and then commit the result.

    $ echo 'bad merge' >file
    $ git commit -ammerge
    Recorded resolution for 'file'.
    [feature 75d45f0] merge

    # Ack! That merge was bad. Let's try that again.
    $ git reset --hard @^
    HEAD is now at 6b33f42 local

    $ git merge main
    Auto-merging file
    CONFLICT (content): Merge conflict in file
    Resolved 'file' using previous resolution.
    Automatic merge failed; fix conflicts and then commit the result.

    # Your method to correct this single bad merge works flawlessly:
    $ git checkout --merge file
    Recreated 1 merge conflict

    $ git rerere forget file
    Updated preimage for 'file'
    Forgot resolution for 'file'

    $ echo 'good merge' >file

    $ git commit -ammerge
    Recorded resolution for 'file'.
    [feature 1770541] merge

Let's compare this with git-rebase:

    # Same setup as before
    $ git init
    $ echo aaa >file
    $ git add file
    $ git commit -ambase
    $ git branch feature
    $ echo bbb >file
    $ git commit -amremote
    $ git switch feature
    $ echo ccc >file
    $ git commit -amlocal
    $ git --no-pager log --oneline --graph --all
    * b4d7aeb (HEAD -> feature) local
    | * 2a0978d (main) remote
    |/
    * 91140a6 base

    # Now for the fun part! Just like before, but we're going to use
    # git-rebase instead of git-merge.
    $ git config rerere.enabled true

    $ git rebase main
    Auto-merging file
    CONFLICT (content): Merge conflict in file
    error: could not apply b4d7aeb... local
    hint: Resolve all conflicts manually, mark them as resolved with
    hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
    hint: You can instead skip this commit: run "git rebase --skip".
    hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
    Recorded preimage for 'file'
    Could not apply b4d7aeb... local

    $ echo 'bad merge' >file
    $ git add file

    $ EDITOR=: git rebase --continue
    file: needs merge
    You must edit all merge conflicts and then
    mark them as resolved using git add

    $ git rebase --abort

    $ git rebase main
    Auto-merging file
    CONFLICT (content): Merge conflict in file
    error: could not apply b4d7aeb... local
    hint: Resolve all conflicts manually, mark them as resolved with
    hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
    hint: You can instead skip this commit: run "git rebase --skip".
    hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
    Recorded preimage for 'file'
    Could not apply b4d7aeb... local

    $ git checkout --merge .
    Recreated 1 merge conflict

    $ git rerere forget .
    error: no remembered resolution for 'file'

    $ echo 'good merge' >file

    $ EDITOR=: git rebase --continue
    file: needs merge
    You must edit all merge conflicts and then
    mark them as resolved using git add

Is this a bug?

--
Sean Allred
