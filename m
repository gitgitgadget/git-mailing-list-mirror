Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8102207F8
	for <e@80x24.org>; Sat,  6 May 2017 19:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbdEFTOr (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 15:14:47 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36132 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdEFTOq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 15:14:46 -0400
Received: by mail-io0-f174.google.com with SMTP id o12so3668156iod.3
        for <git@vger.kernel.org>; Sat, 06 May 2017 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YnhwWwfXWXlPPWldB7vvqTqGYe3hnQtaWnKf75nVjMU=;
        b=QV2i+2sE3M/E13pywZR4E82jg3gJLVqbFe8s59vE1KweI8h/MFUGtjhBIpgGZmiy98
         tLLscijQEm4veWtvTnDe04/5QtEW1Jy/mIPeAikfR7xrPAMDTmIdJI/eYnnOQrjmwR9A
         3lpJ6Dhutu0Vv+rXNS6qWbLga65VzVxhkTc6UgSfLseKlPMpS8lb/dCH84CnWWbNkWXR
         r1f/WqzWFV3TYRTloiQWpyscnoTO687B28khFAkbkrQHaBniXn50XI1s/wwp8fjsqPl/
         inHBPzAe9cYs5PKwjoGmEQ3x+qRFIaFus1OWsDiGw4LKxdHeOHwSmHutBJEhylL6L406
         tIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YnhwWwfXWXlPPWldB7vvqTqGYe3hnQtaWnKf75nVjMU=;
        b=GxwehVT9m9hsBl3AVo8xtIIQj8seit1wuUIGMN9dYRSPXIUiEMgjS2tdkl+whL3SGl
         5qfNbzXupxPnde2S8OJhaUg9X/Vsw4fxhUda/VSDHECawH8DbKqFU6fIBsNFvwb9Z37j
         TpT+aJHwtQhwbre0oPSamUPyMKP7qRhi7aCINjSmKtT8oEXwBM1y3znlRsMWF25vbSBi
         Hgkbm87VXITchqGz1ht9IlnpH9dQDlT2bW6dSClkbH1uIYtxdtqdY/rbqqB3gLMoczX+
         oJh8IbLHFKNZ0XMIGD61pMPL0lM51ChT8nYk9SEM+nHbTD4aNp8eJ4Ca9Yci4Ag9eLjs
         fotA==
X-Gm-Message-State: AN3rC/5PNpLBEYIEhh0SAQitET8i+BGVfrwDpUEhJUFUR2nmJR2jfD32
        DsT/pKJoxQ2OGTmYmnUA5M9P1meXG/70
X-Received: by 10.107.131.205 with SMTP id n74mr21250700ioi.97.1494098085291;
 Sat, 06 May 2017 12:14:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.223 with HTTP; Sat, 6 May 2017 12:14:44 -0700 (PDT)
In-Reply-To: <7DA6022F-02F0-41AC-ABAB-64565E81481F@gmail.com>
References: <7DA6022F-02F0-41AC-ABAB-64565E81481F@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Sat, 6 May 2017 12:14:44 -0700
Message-ID: <CAGyf7-EDHPdL_YvNoC9QNy11=YfxSpmZBFZ5UR50ub1o2yqAug@mail.gmail.com>
Subject: Re: Git smart http: parsing commit messages in git-receive-pack
To:     akos tajti <akos.tajti@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2017 at 5:30 AM, akos tajti <akos.tajti@gmail.com> wrote:
> Dear All,
>
> we implemented a java servlet around the git-http-backend. This servlet i=
ntercepts the requests sent by the git client when pushing. One thing I wan=
t to achieve is parsing the commit messages in the pre push phase (request =
param service=3D=3Dgit-receive-pack) and after checking if the commit messa=
ges contain a given string reject/accept the request. The problem is that I=
 couldn't find a way of parsing the commit messages in git-receive-pack (I =
can do this in the post  push phase but in that case I cannot reject the pu=
sh because the changes are already on the server). Is there a way of gettin=
g the commit messages before they're actually on the server so that I can r=
eject the push?

The protocol isn't really intended for use to try and parse pack data
before it's spooled to disk. It might be possible, but it's likely to
be brittle (due to things like delta compression, for example).

I believe what you're looking for is a pre-receive hook[1] on your
server. This is how Bitbucket Server (which is also written in Java)
works. It opens a socket on localhost and installs a pre-receive hook
into each repository which uses a Perl script to pipe all of its input
to the listening socket and then read any response from the server
back. After the push has written all of its objects to disk, Git
invokes any pre-receive hooks and passes in all the ref changes. The
Perl script pipes those to the server, which applies whatever checks
are desired and writes any errors or info back to the hook, which then
prints it for Git to use before exiting with the correct status code
(0 to accept the push, 1 to reject it).

This means the objects are on the server, but in Git 2.11 Peff added
"quarantine" functionality which writes those new objects into an
"incoming" directory[2]. That means, while they're on disk, they're
_not_ in the repository itself. If the pre-receive hook rejects the
push, those objects are immediately deleted from disk.

That means if you pair a pre-receive hook with Git 2.11 or newer on
the server, you should be able to achieve what you're looking for.
Once the objects have been written to the quarantine directory, you
can use normal Git commands, like cat-file, rev-list or log, to review
them. If they don't meet your requirements, just reject the push and
Git will delete the objects automatically

Hope this helps!
Bryan Turner

>
> Thanks in advance,
> =C3=81kos Tajti
>

[1]: https://git-scm.com/docs/githooks includes documentation for
pre-receive inputs and outputs
[2]: https://github.com/git/git/blob/master/Documentation/git-receive-pack.=
txt#L219-L243
includes some additional documentation about the quarantine
environment
