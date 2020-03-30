Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2901C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB04206DB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXZ3nmuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgC3Uji (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:39:38 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:42643 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgC3Uji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 16:39:38 -0400
Received: by mail-qk1-f178.google.com with SMTP id 139so10788596qkd.9
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4e0c3F/mCucZ7ZA5pXh/c8LNCKiRNv+VAwYJthG4IFo=;
        b=EXZ3nmucEL3WDD7eyUiDXDSKCU8XDiUSvC698XjDkK1rBYf9EAxeVmIOLSJ6MHNEpC
         tGcAPrQ40CcDps9jc392T0eMgtwPoVpBrbBIg4HCav6GsfL2vhQyMI/3WqZWJ0wdpoIT
         UvEgmhvlaMKRwZ1C4yqz4jiUFtl5d+xTK2GswmmPz+7Mc/to5daKOfWLl1bXqZ35si5c
         hDVhSn7Qgm5RrtrFkmZWC5N1Xz23x6Z7WTZLjQUpAYL3y3yDOB4cj0CHIOgP7QIZkh5S
         mL4Jz/Me8zWL1yAmTPmqpsidD6GVt1l1e7wZK+cHGTNs/KZ5tADBVMXysOLacIBHAq2W
         9U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4e0c3F/mCucZ7ZA5pXh/c8LNCKiRNv+VAwYJthG4IFo=;
        b=pMDHm1vS+goGVD4KeWSarQhs3JJvlgCr2NqjzcqJJf0JhXrK/ySX3agjTv4oaPZUdf
         bOIlsZtKDUf+lq/Gcng8INeMcTaBe/fQhm5xzy7Xv8kjxC+PmQ/4W8DB46wWfYbA6ukM
         TjOJJknge7SXA/y41ITGY8tUEXl93OBE52YAQOKP+X0Y6/iNcnWVeYQygiVdr6dGyGBq
         GU+Du1kkXNYBXFNV81rQoFgreAlS/m6dpST1xbDitj9VwBQewZehQ14zNMXIhJZwxJ37
         yn3EA5wUog9a1f2rO+peR81uXyOkNFZkvy/toHa7DMiklwjripTORmDFDM3Eo4kB3C38
         Wolg==
X-Gm-Message-State: ANhLgQ0i6Uq6m1h7WXj5FLKp68IS9enpUilgzeo7Q/YxOwhjF9DY3Kv4
        FV1Z6cfo0NhLQLkz9UtjjVPYvfUtqvM60+l9Hm4/EUrvqHA=
X-Google-Smtp-Source: ADFU+vuTTN2YC5VGJPHwWtrsc7uyXBaq4wmtIObyEXwH9FVVBGX2fLjNGorphMajcseCrOzaoC5rhMABhv8KtBWWdt4=
X-Received: by 2002:ae9:ed56:: with SMTP id c83mr1799567qkg.200.1585600776925;
 Mon, 30 Mar 2020 13:39:36 -0700 (PDT)
MIME-Version: 1.0
From:   Angel Pan <dinoallosaurus1111@gmail.com>
Date:   Tue, 31 Mar 2020 04:39:25 +0800
Message-ID: <CAFk=nY5QSWk+2_eLdyS+4Nzbm23R7i1A4NEOEVxHueCSytgBTQ@mail.gmail.com>
Subject: [GSoC][Proposal v1] My proposal for GSoC 2020
To:     Angel Pan <dinoallosaurus1111@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone.
Here is my proposal for GSoC. A review or criticism would be appreciated.

Google doc version:
https://docs.google.com/document/d/19Nkesmet7X7U42lsvksXoiEBrnOppKicWHYKneE=
QsQ8/edit?usp=3Dsharing

Best regards,
Angel

----------
# Unify ref-filter formats with other `--pretty` formats

## Contact Information

Full name: Yun Pan(Angel Pan)

Email: [dinoallosaurus1111@gmail.com](mailto:dinoallosaurus1111@gmail.com)

IRC: dinoallosaurus

GitHub: dinoallo

Timezone: UTC+8

## Short Biography

I am a first year student in Computer Science at Zhejiang University
in China. It's my first time participating in GSoC. I have had
experience working with C/C++, shell scripts, Python, Go and Perl. I
am interested in writing CLI or system scripts/configurations, which
is the main reason I apply to Git project. I might be relatively new
when it comes to contributing on-line project. However, I am a quick
and avid learner so if I don=E2=80=99t have enough skills to complete the j=
ob,
I can self-learn immediately.

## Working Environment

My operating system is Arch Linux, which I started using it about half
an year ago. Before then I was using Debian-based systems like Ubuntu.
And I have some experience using git on Windows as well.

I mainly use Emacs and VS Code as my editor but I can use Vim also. I
am able to use both markdown and Org-mode on Emacs for documenting

## Coding/Contributing Experience

C is my *native* language I like to config my computer and automate
some work on it by myself so I learned shell-scripts and other
scripting languages.  Now I write code related to back-end for the
student club at my university.

Since I used to develop web before, there is a small-project written
in Python with Django on my GitHub page. From the experience of
applying to git, I obtained much deeper knowledge about git and how it
works. No matter what the outcome is, I am looking forward to
contributing more to git and work with all the developers.

### Microproject

Mailing list: https://lore.kernel.org/git/pull.595.git.1585588586605.gitgit=
gadget@gmail.com/T/#u

GitHub: https://github.com/gitgitgadget/git/pull/595

Status: waiting to be review.

## Introduction

Currently, the placeholder used in ref-filter expansion `%(foo)` has
not yet supported in `--pretty` format.

Using the new ref-filter formats has its own convenience.  For
example, the format `%(foo)` is more human-readable, easy to process,
and extensible if we want to add some options in each placeholder(like
`%(trailers:only=3Dbogo)`) . Hence,  users can just simply add the
options in the placeholder if needed, reducing their frustration in
constructing long and complex output command.

My goal is to unify the the ref-filter formats with `--pretty` formats
and generalized them in git:

* Get rid of unrecognizable placeholders like `%an` to `%(authorname)`.
* Introduce format-scripting(like the one used in `git-for-each-ref`)
to `--pretty` and even make a field in user's configuration to use
default format-script for `--pretty`.

## Deliverables/Timeline

### ~ May 5th

* I will keep an eye on git project and make more patches to it if possible=
.
* At the same time, getting to know more about the community and
collaborating with others.

* Also I will talk to my potential mentor, to get more concrete and
constructive advise about my project. Last, finalize my project.

### May 5th ~ June 2nd

Community-bonding period:

After having rounded understanding about the community and all the
past work, I would like to revise my previous ideas regarding to my
project if there is a much better solution or other problems. Then, I
will start to work on a part of my project:

* Carefully examine `ref-filter` related code to see what I can learn
from(the implementation, etc...) and what to avoid doing.
* Replace the placeholders in `--pretty` with new formats and names.
* Commit patches to obtain reviews from the community.

### June 2nd ~ June 10th

The cushion period. Finish the unfinished work from last phase. If all
the job is done, add test scripts and future documentation.

### June 11th ~ July 3rd

I will be occupied in this phase since the final exams take over. I
might not be able to work on some actual change but is free to reply
to anyone in the community.

### July 3rd ~ July 17th

* Gathering all reviews and criticisms from the community and revise
my previous patches if needed.

* Add test scripts and documentation.

### July 17th ~ July 28th

* Implement the format-scripting in `--pretty`
* Commit the patches to obtain reviews from the community

### July 28th ~ August 12th

* Gathering all reviews and criticisms from the community and revise
my previous patches if needed.

* Add test scripts and documentation.
* [option] configuration on pretty

### August 12th ~ August 25th

Final revision and discussion.

### August 25th ~

Submission

*If I complete my job earlier than I plan, than I would like to come
up with more improvements and new features in my project.*

 ### Side-note

* Before my summer vacation, I can code for 2-3 hours per working day
and 4-6 hours on weekend.
* My summer vacation starts from July 3rd to early September, which
fits well with GSoC's schedule. I will be able to spend half of my day
on my project.
* English is not my first language so if I have grammatical or other
errors in documentation or communication, a review will be
appreciated.



## Conclusion

First, I would like to say thank you to all developers that have
helped me or replied to me in the mailing list.

I want to join an active open-source community online for a really
long time but I was too shy before and got caught up with the college
entrance exam. I think GSoC is a good platform to start my journey.
Though I was not able to get the information in time and it's late for
me to commit my submission before deadline, I still decided to apply.
Because if I hadn't, I would regret someday.

As I mentioned before, maybe I have little experience to
online-contributing, but I will learn the required skills to overcome
obstacles. My lust for knowledge is my greatest power.

Last but not least, it's a pleasure to join the open-source community.
Let's collaborate and make the online world better.

----------
