Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45092070C
	for <e@80x24.org>; Wed,  6 Jul 2016 18:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbcGFSCz (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 14:02:55 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38904 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbcGFSCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 14:02:54 -0400
Received: by mail-wm0-f42.google.com with SMTP id r201so2878137wme.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 11:02:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hc4ivNT436Cpf5j/a9dAgvOPVC7VB+8R5yzihPAlPhY=;
        b=ZdLl2gXkhycukBGRSb83nu0a7DqwsAzj3623rH2Bvww9oMzPlJUhwfVZep8R1T14aD
         I46r1orP8S+kyTioiQBoOWtfBbkR7GY9micRbbhXfxmH8YIKMK8rsh2wJz+cUaFWLNo1
         9yLAUEoEap7Bmwq58ukePwofJHOm8mC+/xcgUDk0giLhbsjlXDAnzFaI+03WZ16OvJeX
         FO9g9bVUMk71C0AYDBwE6btyzOcRFtoyREsvUGclt1I8Ea3A68JaKMe7VsmGamW7kA0O
         aArncb6VhRAw6NLE/7vFDkI0XZgv2jmyqdz/SFMlSshbFF/HlIEuYOycsLuG/QYuWICD
         alZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hc4ivNT436Cpf5j/a9dAgvOPVC7VB+8R5yzihPAlPhY=;
        b=RyvjnpQGj768NfVCKBfI8rkaTJgxXdCbMqLX9YogltSCY69qUtKQ71hZiCFVLBkO7u
         sXjuzAUs/mPzpka4w7B8BLYpFpdYn6A7boctjYAKgi/CU/BqYxIm+pIdmNqR6AusENMl
         Ivl+oPsEAUen5l5YHZ0brIZTxrcBOBZj7xkuXI3CYIC0kpYHsyumFgBzfCj2WaS8bs0u
         kxgodkQ3CPvRHnQUCvrjBtriddLw44DfPmM3P2LAZVb3prJKn4NDkCgoojOWMc01TKku
         IaqfMq+/c7mBIlCMYn9HRm3B/VQTj5of2wECF8VpIM+mPDGFmsZZ26dvMcaPm8eSEErB
         jsPQ==
X-Gm-Message-State: ALyK8tKsYl0I/5svQIHlA2SzyLdtm0xIN5R7PFDM/yRBX+uBPmZAQvDIT72Btwf/5uQYiw==
X-Received: by 10.28.38.5 with SMTP id m5mr22969276wmm.82.1467828170122;
        Wed, 06 Jul 2016 11:02:50 -0700 (PDT)
Received: from christoph-laptop-16-04 (ip-103-010-005-185.cpe.my-wire.de. [185.5.10.103])
        by smtp.googlemail.com with ESMTPSA id cx8sm6496068wjb.37.2016.07.06.11.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 11:02:49 -0700 (PDT)
Message-ID: <1467828168.6286.5.camel@gmail.com>
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
From:	Christoph Michelbach <michelbach94@gmail.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Date:	Wed, 06 Jul 2016 20:02:48 +0200
In-Reply-To: <CACsJy8BDQbanGsf=3z3K-OuH0++EuqQFEB22udXJT+WZnFKSBg@mail.gmail.com>
References: <1466807902.28869.8.camel@gmail.com>
	 <20160705170558.10906-1-pclouds@gmail.com>
	 <1467756891.4798.1.camel@gmail.com>
	 <CACsJy8BDQbanGsf=3z3K-OuH0++EuqQFEB22udXJT+WZnFKSBg@mail.gmail.com>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I now created a repo on a 64 bit system (same command as before), then
duplicated it. One copy I applied git gc to on the 64 bit host system,
the other copy I gave to my 32 bit virtual machine to apply git gc to
it.

The 64 bit host uses git from the Ubuntu repositories, the 32 bit
virtual machine uses git 2.9 from github with the patches applied.

git gc worked without problems on the host but I got

frank@frank-virtual-16-04-32-bit:~/g$ git gc
Counting objects: 6, done.
Compressing objects: 100% (3/3), done.
error: bad packed object CRC for
f595ad71c1a1ecc312ddcb32a84a4bfc4a2ed1c8
Writing objects: 100% (6/6), done.
Total 6 (delta 0), reused 0 (delta 0)
error: failed to validate delta base reference at offset 342896 from
.git/objects/pack/pack-630b5a3f28cd9d02a546462bf0d0bc640ffde784.pack
error: bad offset for revindex
error: failed to read object 4246d27f8e0149d45687b0cc23bc29a67f1f0c79
at offset 342887 from .git/objects/pack/pack-
630b5a3f28cd9d02a546462bf0d0bc640ffde784.pack
fatal: packed object 4246d27f8e0149d45687b0cc23bc29a67f1f0c79 (stored
in .git/objects/pack/pack-
630b5a3f28cd9d02a546462bf0d0bc640ffde784.pack) is corrupt
error: failed to run prune
frank@frank-virtual-16-04-32-bit:~/g$ 

on the virtual machine.

Not including the mailing list in CC wasn't intended.

-- 
With kind regards
Christoph Michelbach

On Wed, 2016-07-06 at 17:23 +0200, Duy Nguyen wrote:
> On Wed, Jul 6, 2016 at 12:14 AM, Christoph Michelbach
> <michelbach94@gmail.com> wrote:
> > 
> > I now tried git gc again and it failed (in a different way, though;
> > and
> > the error message only appeared once git gc terminated).
> > 
> > Full input and output:
> > 
> > christoph@virt-16-04-32-bit:~$ mkdir test && cd test && git init &&
> > touch someFile && git add someFile && git commit -m "Initial
> > commit."
> > && dd if=/dev/urandom of=bigBinaryFile bs=1MB count=4294 && git add
> > bigBinaryFile && git commit -m "Introduced big biary file."
> > Initialized empty Git repository in /home/christoph/test/.git/
> > [master (root-commit) 20507ef] Initial commit.
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  create mode 100644 someFile
> > 4294+0 records in
> > 4294+0 records out
> > 4294000000 bytes (4.3 GB, 4.0 GiB) copied, 435.236 s, 9.9 MB/s
> > [master 88e5dbb] Introduced big biary file.
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  create mode 100644 bigBinaryFile
> > christoph@virt-16-04-32-bit:~/test$ git gc
> > Counting objects: 6, done.
> > Compressing objects: 100% (3/3), done.
> > Writing objects: 100% (6/6), done.
> > Total 6 (delta 0), reused 1 (delta 0)
> > error: inflate: data stream error (incorrect header check)
> > error: failed to read object
> > 705f438ccb845871ffba9d4b56f16ac763652937
> Sigh.. I'll try again :) BTW if you have a 64-bit machine too, try
> create the repo with it (so we are sure the repo is not corrupted in
> the first place) then you can run tests like this on 32-bit systems.
> The previous "bad crc" message was a fault in the code, not the data.
> 
> PS. I have just let gc run till the end (last time I tried
> pack-objects, which is only part of gc) and got a(nother) error.
> Checking... BTW, you should send these mails to git@ as well, no need
> for private message exchange.
