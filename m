Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6184C1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfH3P2S (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 11:28:18 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:41031 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfH3P2S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 11:28:18 -0400
Received: by mail-qk1-f181.google.com with SMTP id g17so6457086qkk.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kW0roDM0ZD70FWD5IuxwItg8CPGA9/t8vaJPO7TIhPY=;
        b=Z6nZHyrILvFfRb30m+a5AbIYtN4w4anSOyhGaCmrDfalbkaRDJPbNm2buHNIqgqtDj
         vbF6my8T+JMcTJ8D2QrgYhLi7nvmaSExyzduLNpMUxQZeW4nLm5D8hwpaluF5br+uSOg
         J+kRR23vV2rd755gXGfxKwippaFy1wxaxKRgWBDtc0wi64AmS9khMAiIqnDBDwNgRhRN
         EDkPZO497GTiTStkTuZalohtflCkx2zEWiBU75xp2TshvsXS9CTFvEyzC2aTcCN4OQl9
         tB2Zie2XWb6XcY0cSoh6j/rKxfg1Y70IgG13XplucBBjXczbGjkmTd8WOq9wDLD7+Rap
         C59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kW0roDM0ZD70FWD5IuxwItg8CPGA9/t8vaJPO7TIhPY=;
        b=T8aZ8KJbwe2F42JVLZpI2pEuAdJpWVXo9dhn+Q6agcEGDwa1eFj9/Fgr1nfOofEKiH
         +2iHmB24LwCRjD5p1ZWurbzF7k1J78uFazW62eJGtXq8WtQzyLlp/GY0qmwx8GL8JtSD
         hwdp0q5pEL16wl1xWLJYJsOaITrQqbBOHeCvWaacqms9xbFmPJWQsBKPxPcQuJWyIorJ
         e17RiRoSXh0EumnxKlXMds3tqyxsc/3yciNtvj8Dv4WZsPOxcEfMfCZ24FttVx1zgT1a
         CXdSeo2nX0/NDO6qmxXpqMpwzmsXBQ2tfJLfLFDZITG5pQn9dmgJuM7fHOaCCtZUW6hg
         /uWA==
X-Gm-Message-State: APjAAAUulW3Ni5WLYtre2doHxQdEQOPP4Mj9TG2fdwm3jN03O44yNXpN
        K3jBrPVZIuJVVsDUD1kyhbaj7Du/yCss3EM+tcI=
X-Google-Smtp-Source: APXvYqwgt2GQzSlhJR6+1C3th/0VJtr/XjI0XyiE/QZ3Sr30qJmq8AtSyhhQOSQD5ZmeHOgTVtMFMtaO5omDvbdcV9g=
X-Received: by 2002:a37:9cce:: with SMTP id f197mr15835560qke.129.1567178897056;
 Fri, 30 Aug 2019 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com> <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
 <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com> <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
 <20190830142730.GB16327@sigill.intra.peff.net>
In-Reply-To: <20190830142730.GB16327@sigill.intra.peff.net>
From:   Dmitry Nikulin <pastafariant@gmail.com>
Date:   Fri, 30 Aug 2019 18:28:05 +0300
Message-ID: <CAH53SyniovbvYoU1nhMobRq7nZREENiagJqN9LAYmZsGMpc+ww@mail.gmail.com>
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Aug 2019 at 17:27, Jeff King <peff@peff.net> wrote:

> I think you have an extra "old-filename" in the second list.
Agreed. My misunderstanding was that I had thought that when
documentation said "path", it meant "argv[0], the path to the diff
executable".

> Interesting. I _don't_ see that splitting when I run the same command in
> your demo repo (nor, looking at Git's code, do I see how it could
> happen; we always add the metainfo as a single argument).
Szeder G=C3=A1bor below has guessed at the cause. I have tested it a little=
 more:

# Test script to ensure that shell does not get in the way
$ cat test.py
import sys
import subprocess

subprocess.check_call([
    'python%s' % sys.argv[1],
    './print_argv.py',
    'similarity index 90%\nrename from file1.txt\nrename to
file1-mv.txt\nindex 2bef330..f8fd673 100644\n',
])

# Python 2, expected behavior
$ python3 test.py 2
['./print_argv.py',
 'similarity index 90%\nrename from file1.txt\nrename to
file1-mv.txt\nindex 2bef330..f8fd673 100644\n']

# Python 3, broken behavior observed before
$ python3 test.py 3
['./print_argv.py',
 'similarity index 90%\n'
 'rename from file1.txt\n'
 'rename to file1-mv.txt\n'
 'index 2bef330..f8fd673 100644\n']

# Directly via shell. Python 2, expected behavior
$ python2 print_argv.py 'similarity index 90%\nrename from
file1.txt\nrename to file1-mv.txt\nindex 2bef330..f8fd673 100644\n'
['print_argv.py',
 'similarity index 90%\\nrename from file1.txt\\nrename to
file1-mv.txt\\nindex 2bef330..f8fd673 100644\\n']

# Python 3, WTF
$ python3 print_argv.py 'similarity index 90%\nrename from
file1.txt\nrename to file1-mv.txt\nindex 2bef330..f8fd673 100644\n'
['print_argv.py',
 'similarity index 90%\\nrename from file1.txt\\nrename to '
 'file1-mv.txt\\nindex 2bef330..f8fd673 100644\\n']
