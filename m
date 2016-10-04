Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C56F1F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 10:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbcJDKkq (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 06:40:46 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35839 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbcJDKkp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 06:40:45 -0400
Received: by mail-lf0-f54.google.com with SMTP id l131so178941120lfl.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TK9xI/05Is7RE3BDMBCUrmru1NOQ0g4GnRTED8Gp8MQ=;
        b=hM1RiHG4nDMMsNOFoEWi6boWUr+PRvSaTAwcw2Hm2qXtYf7orkkpmRkvcX5HlHekqa
         7Iyk04yHf1CEFc7NYxswJy5Qfe/TN2vHzaaCbolk/QVRST72yQtNga92FnH6B5HvyFax
         bQY4gUPwOeez6cOQlJW8MqQSFFcyQNhNhPDFJW5iJ4GefJJuuxsgUl4CScpi9tH2UwYL
         IjOPdoNxPw10tNTtc1PZTzBX2RKHw12g84ixhVtMf+HyzRtPWrx5HQ8gz2ggsfb52RsW
         SR6ww8j3yCDWDL3ZYfCnT2PhvPrXFJ3VzLvILMvODQZK5yvZtDx0ec71P05IzZA3M0xK
         5F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=TK9xI/05Is7RE3BDMBCUrmru1NOQ0g4GnRTED8Gp8MQ=;
        b=OgCr11+fAN5BNGFCjC861K9BwFpaRXd/Xu0QIjIU+yRK+7NmRN+VuR1MlVR4gKEuHO
         7MdD8SKcZUaSiGRe+lzaoZ32zML2tjUhTKzZOS98aIPGfFG1+x/8mhP6g43zO8wdjjkY
         r8fdNTPTcyLMcLoX7VaoLvRmyl9P7OZ5VAPpYonyZewxto+ZqHG31otJxvzAs54/Olk8
         VPc5VqajauT/Z0XaH5GE8qYd9l90MIYGk9hSoOIS6O2odDyXJEWVHIWFxAwBJTFPvmPw
         52fsUpg9uFhwqSlaO7cf8HFgtCxaVUuZFSchc982Ggm7vH9P18DhdoRq5M9zMXNw+9w7
         fsSg==
X-Gm-Message-State: AA6/9Rke0xpgds2imOt7DqWEXpKrybvrR6hpEK1BKBIDZV4/dox9rYEwA3JVKjB6RqRz1mAHSKmCjkz3HZBcxQ==
X-Received: by 10.25.137.86 with SMTP id l83mr955092lfd.31.1475577643511; Tue,
 04 Oct 2016 03:40:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.20.219 with HTTP; Tue, 4 Oct 2016 03:40:22 -0700 (PDT)
From:   ern0 <ern0@linkbroker.hu>
Date:   Tue, 4 Oct 2016 12:40:22 +0200
X-Google-Sender-Auth: 8LUj7c-bBlGH8LaCz9jpPbTqeQ0
Message-ID: <CALhephTkohVhEjdP7TwQAcBrEBiHGtp0Hd+UxPUiJHtubMWKGA@mail.gmail.com>
Subject: GL bug: can not commit, reports error on changed submodule directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I say:
 $ gl commit -m "blah blah"
It reports:
 =E2=9C=98 Failed to read file into stream: Is a directory

Reason: I have a submodule which has changes.

 $ git status
 On branch develop
 Your branch is up-to-date with 'origin/develop'.
 Changes not staged for commit:
   (use "git add/rm <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory=
)

         modified:   remoting (new commits)

 no changes added to commit (use "git add" and/or "git commit -a")

Workaround: I should sync the directory...

 $ cd remoting
 $ git commit -am "yada"
 $ cd ..
 $ git commit -am "yada yada"
 $ git push
 $ echo I feel clean now
 $ echo "# wow" >> test.py
 $ gl commit -m "added wow"

...and it works again.
--=20
ern0
dataflow evangelist
