Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70D01F405
	for <e@80x24.org>; Sat, 29 Dec 2018 15:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeL2Psi (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 10:48:38 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:34787 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeL2Psi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 10:48:38 -0500
Received: by mail-it1-f169.google.com with SMTP id x124so32017536itd.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 07:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UKcjd8QdkBS8Z9M9s1enqc2SAPg3PQr5lG7qnDzOI0I=;
        b=TObodr3XMickUKqcFEVu1dtnxoQB6KRMlFqhOOR2PAMBtOHaNxAJ8P6kkqUn+blhHW
         vjSnJanJbFZaSUhwW+ihzW42xurKOyBMBi0KL7PRgzqKDeFDhWGS0iALQ36Sgxg7E9nL
         ezZ2U1UQDdotV1XLtVqDKiOdn0DiyH92oxnCePTFV/MCL1CVPl9d8BQPVNynUO2rVbcX
         UDfALLlroqPX3u1stBepu/0ojUS04LtUbuY9LYxMbSTrm75dNQkP0qmRJSPxK60ZK8cn
         z9G391/u2bfy2fyaFIhABmQ8CaWUE//9dZWuykwR3j3oILAZKeIABeoYxfDJ0cCrGDoB
         U7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UKcjd8QdkBS8Z9M9s1enqc2SAPg3PQr5lG7qnDzOI0I=;
        b=FfhuXkDFZRXf07Srx4Ew+zfPXQhdDHQPiliKcJGVcvJrwRI/cK1uNmqg3cmyIr5Qy/
         xzuyb4nS1vRJBViH+d34TmX8fQljnWjdzlFNr5xryWMwJHSB2et0rvkkcYycMKag5sR0
         fgmupKny45EkDMEIX02YN1K1oMPDdGkFaOc3HfwxVHLEPoMuQP4xBFyLY2RbZbJVsKUY
         CQ9vzYsPWHzY3nLW7hnbBXoJfYrfpQ3DQcF/d0tWnCcYWd9smfHY2Hn+DmMVe5LEuzyr
         PCkzZF8lzgwSG76JuAWBQjCEJeoc94E6w6ashfDDSBCWU5ZOvckbVv3AdXkh0owFrsVX
         1eRA==
X-Gm-Message-State: AJcUukeE1Yyu39pe285ZaoUXhCG7hPOE5BTbE25axAncuhIBjjRAuaew
        HbJ0T8oKxmCJlrLZtOYl8MJqXDlx1R5Q78MuXZU=
X-Google-Smtp-Source: ALg8bN4PE2Rs1Qf2YTRfU5Pt2fRIF+gYqXVLOo9f4ebOxawD+AUhVJaq+PddxrjR/m+6ZTPHn56f/JzQD3yR+Nd10KE=
X-Received: by 2002:a24:8ac7:: with SMTP id v190mr20174344itd.174.1546098517241;
 Sat, 29 Dec 2018 07:48:37 -0800 (PST)
MIME-Version: 1.0
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181229110924.26598-1-tboegi@web.de> <CADN+U_OccLuLN7_0rjikDgLT+Zvt8hka-=xsnVVLJORjYzP78Q@mail.gmail.com>
In-Reply-To: <CADN+U_OccLuLN7_0rjikDgLT+Zvt8hka-=xsnVVLJORjYzP78Q@mail.gmail.com>
From:   =?UTF-8?Q?Adri=C3=A1n_Gimeno_Balaguer?= <adrigibal@gmail.com>
Date:   Sat, 29 Dec 2018 16:48:25 +0100
Message-ID: <CADN+U_Mo4Ui-rmZe1+xoHOMA4koXGNpJ5XEGYoYZfYPGqP9VPQ@mail.gmail.com>
Subject: Re: [PATCH/RFC v1 1/1] Support working-tree-encoding "UTF-16LE-BOM"
To:     tboegi@web.de, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again.

I appreciate the grown interest in this issue.

Torsten, may I know what is the benefit on your code? My PR solved it
by only tweaking the utf8.c's function 'has_prohibited_utf_bom', which
is likely the shortest way:

https://github.com/git/git/pull/550/files

In order to make sure everything is clear, here is a case list of
current Git behaviour and new one after my PR, regarding this issue.

Current behaviour:

- Placing 'test.txt working-tree-encoding=UTF-16' for a new test.txt
file with either UTF-16 BE or LE BOM, and comitting everything -> The
file gets re-encoded from UTF-8 (as stored internally), to UTF-16 and
the default system/libiconv endianness -> Problem (as long as user
required the opposite endianness for any reason on his project). As a
note, user can see however human-readable diffs on that file.

- Placing  'test.txt working-tree-encoding=UTF-16LE' or 'test.txt
working-tree-encoding=UTF-16BE' for a new test.txt file with either
UTF-16 BE or LE BOM, and comitting everything: we assume user is doing
this because he requires that exact endianness, thus he writes it in
order to attempt preserving it -> Git prohibites commiting it, also no
human-readable diff is shown in the diff viewer/tool being used, but
file is simply shown as binary.

New behaviour:

-  Just got too lazy to repeat it all over, read my PR description:
https://github.com/git/git/pull/550

- Git translations may need to be tweaked to in order to be consistent
with new behaviour.

Thanks for your attention.
