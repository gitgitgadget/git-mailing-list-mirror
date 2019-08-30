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
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D8B1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH3Pv6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 11:51:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33303 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3Pv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 11:51:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id w18so6581318qki.0
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fClGmAg2Kg3G+1NC65gWV2sswEZeimk+COtrhusnxm0=;
        b=f6iMhMQw7evRvx1KyC908VssJkHwsQ7ZShsFi5qnFCf8jqMiqjNB+TTG/GRl3eiSZm
         kx90sRG/7ApZe0qVlP/JIoqHF/Xj0EiA5a5b8NHCZGMLLwr5IzX+TYIawUSGMsg+fk7w
         TksdAgoM7wkP8p5f8mtkzcn5e+1vUb4+BX2bpKOI2epsqcawraWrlCDPDoFbFwRP7Hjz
         cu0M3jdq22+N74BYJbQCQA0CMYJA6QsEcqDSQLOpLsxV98XCspKEzYpyIAJN3bIzJz8j
         cLo7lo1w04bW7w3fr2MldHyQSvxCFSJf14RwEZuifxz5nru6+kbQPxto/iL3cHMIXF8f
         DWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fClGmAg2Kg3G+1NC65gWV2sswEZeimk+COtrhusnxm0=;
        b=bTkPEw4n0tJs7Kdo/6CVGkDLRygz1DcoshkeFZxLYD+Wx/+USxBmiOm7vecLwAOLsf
         ivzp1UfT+ncBFjKVHTXSzWOGP0+Pl1cCafg+AGOiiA/wqj+p8ySarOgWAyjz5XPDHkit
         3PNqCEYx7wCDa5CyiyFB5AFLr8Ec18YQw4nH2Wg5iwf1aIOz6S7fRu1FVXrbUNo5d55G
         xeEh3fZm7tFXBlBkzffCrGS7VQ1XXSLbSTitwr5rKE2tsYR2f3kmK5GK+x7PWjQgtaTo
         awa4/QViVpjZw/gLAyz5arIZQrO0tfddXsMul7b2ZF0OvOZw3YllCcTIy/ooofFry9ho
         ccsw==
X-Gm-Message-State: APjAAAXsDdsU7Ay/RQlqdwE5IPN8yoWeAt844hECtj7Ec1LB1G0coZJe
        EQaksgGlo/OgAJz/50HkQcckSAVMKgUDHixOk4by7pyUDBS5KwGc
X-Google-Smtp-Source: APXvYqyWZ2F7+UQk+buT4GcZqthxW00+ZFNpVWdqB47QHrLuIf+714LTuvAMQ090/UXSpMr+4ji34a884rI2Op9fXd8=
X-Received: by 2002:a37:86c4:: with SMTP id i187mr15989433qkd.464.1567180317783;
 Fri, 30 Aug 2019 08:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com> <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
 <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com> <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
 <20190830142730.GB16327@sigill.intra.peff.net> <CAH53SyniovbvYoU1nhMobRq7nZREENiagJqN9LAYmZsGMpc+ww@mail.gmail.com>
In-Reply-To: <CAH53SyniovbvYoU1nhMobRq7nZREENiagJqN9LAYmZsGMpc+ww@mail.gmail.com>
From:   Dmitry Nikulin <pastafariant@gmail.com>
Date:   Fri, 30 Aug 2019 18:51:46 +0300
Message-ID: <CAH53SykYvushLUtjKK7x5p8dPxe4EwyJJpia==v6W1NAdFpy=Q@mail.gmail.com>
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've figured it out. It's not a bug, it's a peculiarity of pprint().
It splits strings to avoid long lines and abuses the fact that in
Python strings split with whitespace are concatenated by the parser.

Also, in my example newlines are not parsed correctly in the shell.
Escaping them, I get the exact same behavior as in
subprocess.check_call():

$ python2 print_argv.py $'similarity index 90%\nrename from
file1.txt\nrename to file1-mv.txt\nindex 2bef330..f8fd673 100644\n'
['print_argv.py',
 'similarity index 90%\nrename from file1.txt\nrename to
file1-mv.txt\nindex 2bef330..f8fd673 100644\n']
$ python3 print_argv.py $'similarity index 90%\nrename from
file1.txt\nrename to file1-mv.txt\nindex 2bef330..f8fd673 100644\n'
['print_argv.py',
 'similarity index 90%\n'
 'rename from file1.txt\n'
 'rename to file1-mv.txt\n'
 'index 2bef330..f8fd673 100644\n']
