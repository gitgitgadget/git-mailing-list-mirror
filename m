Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB221481AA
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878345; cv=none; b=lNVCV85H8zUuSTrut/0CkElPl3LKnlrwKwcj5OlKI5sPYpKo6MkfX/jscjNdUwxoPo984jW3mP/5JIpZJaD9z30NZEeNBkWUbMJi8J76MiuzMTMIwTH2HQuVHxGmvFoZjYdYx1MT8k30fzObY1/sZdQbNPytUT7NWLhUaZ3+FtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878345; c=relaxed/simple;
	bh=gdBtpA/kYF/+tnEmGAnEPZoEDfL1rWJ0hAbihI4lKjQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OPn92SLbGjr9TeUd3XL8Y8x3Kg1H8bNdNpqnFD0QxFneGsn2kWaZCHnrl77j3P9AInNOnQMboZa3hsEf6MhRFPgmXySLiIyPcTw6sJlZzEPlzD9shjQeGW5Sj3zVIm9VhmYdDGNJlRUWWL1mQk3EFLS4uyu41if7GMiGKJFiHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW40wNwE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW40wNwE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-417d02ab780so2995215e9.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878341; x=1713483141; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w2hS+lIt9qSONlP65F/bJ1mUXQ2dUCqAr8V9+s2Dws=;
        b=PW40wNwEmBO7B8FLB8zE1H1k5/p8tJjUYChbm0YsaLbaCQu/hPx8Wk3ZO5RQ/0Uwr2
         LxUCvQ/Juj2O9W/ywlnTjU/0G0QMeNhpHypu4tKML2jeGggPZSmdg/3Pq4kPr2qhefb4
         VWM0qXkdLzNn6bYNP3DyqMFWUYnTYpR7LUVRaJ8EnM5KOH8NXt9c29UWZnMnGzFFLOdy
         5MtcG225/HMSuflLNp8+SY9ztemwSuYvi3fBJJqbjqL0DjONNkjp7J8Nbt3SsHp4AmG2
         Sq1gEDdOqvwKTvBVoQTokIX5IdPO9vrIjw9gcUlENRWo6r7ppm32BHQXV1mCb+YcDXHV
         pUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878341; x=1713483141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w2hS+lIt9qSONlP65F/bJ1mUXQ2dUCqAr8V9+s2Dws=;
        b=gYMQqJf5zbGfT6l8UF9xhtpByKBF17RAxmgDzLlPrwIz8Wpu3RFiEaGY4/WQKzjJef
         q6gqiaqT0WYqn08cRV3gp4K8v2WKi60O2q4suZ0OwpE17BdQE18DSmIjYxogiZRxvWG1
         ipUVHlLb8SpBDOtoZ32MhR6Zd12XSRUj8odpcChfz35lNZeBir/E8SXnqL9+OyPUlpDs
         1KLxTb5IgRtmjlkgSSI4A62S19z7f6YcO8glxop8q4FY6OrpENPwqLGHcOoi7sVZvAJc
         CtiMgRVw8Xfrs12D1VizihRYX/qAdn+VDoI+BlklX+MgqeaF8tfwv+YwS5m4SuvWs0D7
         4MMw==
X-Gm-Message-State: AOJu0YwlIJeFZFuGpt8ck/fhzpXD3tGOKbQErwlIWJK5Ai0SVXBnnc+I
	17BRdAjOVYImzw9yhcRI6lstGvwuriwa2Hu3DZ1j4WyO5vH97cWNT3ORfQ==
X-Google-Smtp-Source: AGHT+IGnZu3mxNzSjwFsYtsKA1pc9DAXouUkTGRwO85rdbQw8PqrrQO6cjfR9QVcB8+qmyuENQh28Q==
X-Received: by 2002:a05:600c:3d8d:b0:416:2c78:5ecc with SMTP id bi13-20020a05600c3d8d00b004162c785eccmr681274wmb.36.1712878341056;
        Thu, 11 Apr 2024 16:32:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b00416aca5ff66sm6930471wmq.19.2024.04.11.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:20 -0700 (PDT)
Message-Id: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:11 +0000
Subject: [PATCH v4 0/8] docs: recommend using contrib/contacts/git-contacts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>

Make git-contacts more prominent in our docs.


Notable changes in v4
=====================

 * Avoid using "should" for guidance around using "git-contacts"
 * Clarify where to find the "git-contacts" script (because it's not a
   default builtin command)


Notable changes in v3
=====================

 * Refer to GitGitGadget via a link to MyFirstContribution (instead of
   sending readers to GGG's homepage directly)
 * Soften the advice for using git-contacts


Notable changes in v2
=====================

 * Improve existing mention of git-contacts in SubmittingPatches (instead of
   adding a separate, entirely new paragraph)
 * Add example usage of integrating git-contacts with git-send-email with
   the latter's --cc-cmd flag.
 * Various smaller fixes to SubmittingPatches

Linus Arver (8):
  MyFirstContribution: mention contrib/contacts/git-contacts
  SubmittingPatches: clarify 'git-contacts' location
  SubmittingPatches: mention GitGitGadget
  SubmittingPatches: quote commands
  SubmittingPatches: discuss reviewers first
  SubmittingPatches: dedupe discussion of security patches
  SubmittingPatches: add heading for format-patch and send-email
  SubmittingPatches: demonstrate using git-contacts with git-send-email

 Documentation/MyFirstContribution.txt | 12 +++++
 Documentation/SubmittingPatches       | 75 ++++++++++++++++-----------
 2 files changed, 57 insertions(+), 30 deletions(-)


base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1704

Range-diff vs v3:

 1:  1f65dc5ba3d ! 1:  ad469e4e6db MyFirstContribution: mention contrib/contacts/git-contacts
     @@ Commit message
          git-contacts helper, 2013-07-21), we don't mention it in our
          introductory docs. Do so now.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## Documentation/MyFirstContribution.txt ##
     @@ Documentation/MyFirstContribution.txt: $ git send-email --to=target@example.com
       NOTE: Check `git help send-email` for some other options which you may find
       valuable, such as changing the Reply-to address or adding more CC and BCC lines.
       
     -+NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
     -+list of reviewers you should include in the CC list. In addition, you can do
     -+`git send-email --cc-cmd='git contacts' feature/*.patch` to automatically pass
     -+this list of emails to `send-email`.
     ++:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     ++part of the core `git` binary and must be called separately. Consult your +
     ++package manager to determine where it is located. For example&#44; on Ubuntu-based +
     ++systems it could be installed under +
     ++`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     ++with `perl ...` if it does not have the executable bit set.]
     ++
     ++NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts` can
     ++list potential reviewers. In addition, you can do `git send-email
     ++--cc-cmd='/path/to/git-contacts' feature/*.patch`{contrib-scripts} to
     ++automatically pass this list of emails to `send-email`.
      +
       NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
       please don't send your patchset from the tutorial to the real mailing list! For
 2:  6e8b1b50ac5 ! 2:  c43de19d867 SubmittingPatches: make 'git contacts' grep-friendly
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    SubmittingPatches: make 'git contacts' grep-friendly
     +    SubmittingPatches: clarify 'git-contacts' location
      
     -    Avoid splitting up the command over two lines. This way, a command like
     +    Use a dash ("git-contacts", not "git contacts") because the script
     +    is not a core builtin command that is compiled into the `git` binary.
     +    This also puts the script on one line, which should make it easier to
     +    grep for with a loose search query, such as
      
              $ git grep git.contacts Documentation
      
     -    will return a positive hit for this location.
     +    . Also add a footnote to describe where the script could actually be
     +    located, to help readers who may not be familiar with such "contrib"
     +    scripts (and how they are not accessible with the usual "git
     +    <subcommand>" syntax).
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## Documentation/SubmittingPatches ##
     -@@ Documentation/SubmittingPatches: mentioned below, but should instead be sent privately to the Git
     +@@ Documentation/SubmittingPatches: security relevant should not be submitted to the public mailing list
     + mentioned below, but should instead be sent privately to the Git
       Security mailing list{security-ml-ref}.
       
     ++:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     ++part of the core `git` binary and must be called separately. Consult your +
     ++package manager to determine where it is located. For example&#44; on Ubuntu-based +
     ++systems it could be installed under +
     ++`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     ++with `perl ...` if it does not have the executable bit set.]
     ++
       Send your patch with "To:" set to the mailing list, with "cc:" listing
      -people who are involved in the area you are touching (the `git
      -contacts` command in `contrib/contacts/` can help to
     -+people who are involved in the area you are touching (the `git contacts`
     -+command in `contrib/contacts/` can help to
     ++people who are involved in the area you are touching (the `git-contacts`
     ++script in `contrib/contacts/`{contrib-scripts} can help to
       identify them), to solicit comments and reviews.  Also, when you made
       trial merges of your topic to `next` and `seen`, you may have noticed
       work by others conflicting with your changes.  There is a good possibility
 3:  7f8fdc053f7 = 3:  cd941704176 SubmittingPatches: mention GitGitGadget
 4:  ef26bdb75c5 = 4:  44470a5d70e SubmittingPatches: quote commands
 5:  6f71b1731f2 ! 5:  15f9356ff97 SubmittingPatches: discuss reviewers first
     @@ Documentation/SubmittingPatches: letter.
      +mentioned below, but should instead be sent privately to the Git
      +Security mailing list{security-ml-ref}.
      +
     ++:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     ++part of the core `git` binary and must be called separately. Consult your +
     ++package manager to determine where it is located. For example&#44; on Ubuntu-based +
     ++systems it could be installed under +
     ++`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     ++with `perl ...` if it does not have the executable bit set.]
     ++
      +Send your patch with "To:" set to the mailing list, with "cc:" listing
     -+people who are involved in the area you are touching (the `git contacts`
     -+command in `contrib/contacts/` can help to
     ++people who are involved in the area you are touching (the `git-contacts`
     ++script in `contrib/contacts/`{contrib-scripts} can help to
      +identify them), to solicit comments and reviews.  Also, when you made
      +trial merges of your topic to `next` and `seen`, you may have noticed
      +work by others conflicting with your changes.  There is a good possibility
     @@ Documentation/SubmittingPatches: patch, format it as "multipart/signed", not a t
      -mentioned below, but should instead be sent privately to the Git
      -Security mailing list{security-ml-ref}.
      -
     +-:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     +-part of the core `git` binary and must be called separately. Consult your +
     +-package manager to determine where it is located. For example&#44; on Ubuntu-based +
     +-systems it could be installed under +
     +-`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     +-with `perl ...` if it does not have the executable bit set.]
     +-
      -Send your patch with "To:" set to the mailing list, with "cc:" listing
     --people who are involved in the area you are touching (the `git contacts`
     --command in `contrib/contacts/` can help to
     +-people who are involved in the area you are touching (the `git-contacts`
     +-script in `contrib/contacts/`{contrib-scripts} can help to
      -identify them), to solicit comments and reviews.  Also, when you made
      -trial merges of your topic to `next` and `seen`, you may have noticed
      -work by others conflicting with your changes.  There is a good possibility
 6:  f5e44f69941 ! 6:  e889e64bd45 SubmittingPatches: dedupe discussion of security patches
     @@ Documentation/SubmittingPatches: letter.
      +security relevant should be submitted privately to the Git Security
      +mailing list{security-ml}, instead of the public mailing list.
       
     - Send your patch with "To:" set to the mailing list, with "cc:" listing
     - people who are involved in the area you are touching (the `git contacts`
     + :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     + part of the core `git` binary and must be called separately. Consult your +
      @@ Documentation/SubmittingPatches: Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
       `Tested-by:` lines as necessary to credit people who helped your
       patch, and "cc:" them when sending such a final version for inclusion.
 7:  e64fc5c888a = 7:  81556298599 SubmittingPatches: add heading for format-patch and send-email
 8:  4fcab0d3319 = 8:  84b1cf3f914 SubmittingPatches: demonstrate using git-contacts with git-send-email

-- 
gitgitgadget
