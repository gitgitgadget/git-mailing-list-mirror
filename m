Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31E01F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeI0Bap (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:30:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39870 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeI0Bao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:30:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so76194wrw.6
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DnqspS/CBnHo1wrU0c86R1s1FrhNVNwNViOIChorJq0=;
        b=SPkgyGJN2eXPpGw0bO2PqFHJ50TYZaSk5POrpZjKcTkpZWOU0q+FD0zbvaVgmWloXl
         W9h8T1q61s4FX+mmi2Mrrf9J1TVlWnCcsUjtnN/dvgmOZABSvIAvZ/2ApxSzi+wgDrCZ
         oRhlIZ89JMFSp1gLfkOGo1CXIIFfTQk9og4JsckEBhKFEVN2MTwPGLQyD2XeEL8MYD+z
         Farh96bULtNK4eG7PjaROq+OkTnWpKFkQbyk26vFgAeOieUoMPtsyMap1HOg+Ko2VUwN
         y9zpR13MXXbipF8Dgh1E+KsjYh6lsQiI6Pb5xX6CbUVkEcVYOfrG6NEgx+ciEJAKqX43
         EyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=DnqspS/CBnHo1wrU0c86R1s1FrhNVNwNViOIChorJq0=;
        b=DbGco3K7kI5cwOKM5IlJEwULhiDlmOn+fCf58ZwAnSSNeeIEG6KjgKKw83VYLjN2cE
         7lSgupANnVq7rXURp6fmysJAl0EEsKJaQi29rzquxdMUwP7d69+Mm2iheNG29/K1PcY8
         q1R0+IKr1WGeJiyVsRbPxWD7KwmnITugAsJm0RpPWV0Fv2M8BF1zctVUKIOqCDLVbCat
         i7jjUpTMGUW5pOLt8NZ32zNkychfHeK+I4d86k8p7hTHywY+/72oLnQFxhy07FneOeqf
         vxamdiD4D4fZG/7dlwgxZ5If+R0KGB4I1q65N0aeKwx74R72aapZve+Rua+kngNocDOY
         84Mg==
X-Gm-Message-State: ABuFfoj65KKJJTH90eByNfQs1IW72HZxq2Dnc2TaUl/hTkr2bOTw3C4k
        NyUtiBVvvO3mrxRoNPuQDuM=
X-Google-Smtp-Source: ACcGV60zKAeZEanvopW5f96qc2RhaEiiVLFHX61Ai2H3noTwSBmOR4+lcCGaAJtHWvSE3FGPXd+5NA==
X-Received: by 2002:adf:b2d7:: with SMTP id g81-v6mr6051267wrd.48.1537989377610;
        Wed, 26 Sep 2018 12:16:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t4-v6sm7413051wrb.45.2018.09.26.12.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 12:16:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Alexander Pyhalov <apyhalov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: t7005-editor.sh failure
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
        <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
        <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
        <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
        <20180926121107.GH27036@localhost>
        <xmqqlg7oktto.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 26 Sep 2018 12:16:16 -0700
In-Reply-To: <xmqqlg7oktto.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Sep 2018 11:16:35 -0700")
Message-ID: <xmqq36twkr27.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> Having said all that, I didn't omit the quotes in 4362da078e with the
>> above in mind; in fact I tend to use quotes even when they are
>> unnecessary (e.g. in variable assignments: var="$1"), because unquoted
>> variables and command substitutions freak me out before I can think
>> through whether its safe to omit the quotes or not :)
>
> I quote >"$file" (but not var=$var) because the CodingGuidelines
> tells me to:
>
>  - Redirection operators should be written with space before, but no
>    space after them.  In other words, write 'echo test >"$file"'
>    instead of 'echo test> $file' or 'echo test > $file'.  Note that
>    even though it is not required by POSIX to double-quote the
>    redirection target in a variable (as shown above), our code does so
>    because some versions of bash issue a warning without the quotes.
>
> ;-)
>
>> Sidenote: this test should use the write_script helper to create this
>> editor script.
>
> Good suggestion.

Perhaps like this.

-- >8 --
Subject: t7005: make sure it passes under /bin/bash

In POSIX.1 compliant shells, you should be able to use a variable
reference without quoting for the target of the redirection, e.g.

	echo foo >$file
	echo bar >$1

without fear of substitution of $file getting split at $IFS.
However, some versions of bash throws a warning, especially when
they are invoked as /bin/bash (not as /bin/sh).  Those who build
with SHELL_PATH=/bin/bash and run t/t7005-editor.sh triggers an
unnecessary failure due to this issue.

Fix it by making sure that the generated "editor" script quotes the
target of redirection.  

While at it, update the way to creatd these scripts to use the
write_script wrapper, so that we do not have to worry about writing
the she-bang line and making the result executable.

Reported-by: Alexander Pyhalov <apyhalov@gmail.com>
Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7005-editor.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index b2ca77b338..b0c4cc4ca0 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -20,11 +20,9 @@ fi
 
 for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
 do
-	cat >e-$i.sh <<-EOF
-	#!$SHELL_PATH
+	write_script "e-$i.sh" <<-EOF
 	echo "Edited by $i" >"\$1"
 	EOF
-	chmod +x e-$i.sh
 done
 
 if ! test -z "$vi"
@@ -112,8 +110,9 @@ do
 done
 
 test_expect_success 'editor with a space' '
-	echo "echo space >\$1" >"e space.sh" &&
-	chmod a+x "e space.sh" &&
+	write_script "e space.sh" <<-\EOF &&
+	echo space >"$1"
+	EOF
 	GIT_EDITOR="./e\ space.sh" git commit --amend &&
 	test space = "$(git show -s --pretty=format:%s)"
 
