Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F48F1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755867AbdLOTMo (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:12:44 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:43862 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755675AbdLOTMn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:12:43 -0500
Received: by mail-pf0-f181.google.com with SMTP id e3so6776393pfi.10
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 11:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3FijmkQaphKf6t++pZ8fnn+iP+DDYDB33frJEn8fLTY=;
        b=ZPPRJ5IhUzioSNtK7eksy/eGQZepFmkjW+ilAuFjV9xd7dpfI8arnwJWPInX2CwzPc
         HE2j/75MkiM/NJ+2vuq/zUD29OxGS8jiL5QiBzAw1GcDKmlEK6QZkHV9ukSpQIeP8NRy
         6Z28cXTlLtiJo1eJ6sc/U+kka0w20uRch56u75s4BnAiAsuY8TyKAEU99sDuLJpQ/Q1E
         kmGeiC1NU1v/8JQgWgJ4DGhErBBD7Lh/XpuFIv0PzsFse2N/ts10OO9bTaiFRYJvXUTG
         f2C9clPCzWMPmoMq5rTIjfcbE7Ip0Z05tmNCEieX9i57yHN1DwLkkuELbJMODMI+HeWA
         wK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3FijmkQaphKf6t++pZ8fnn+iP+DDYDB33frJEn8fLTY=;
        b=sxCHhR6x//zhDtgb+ZSVJ4Chnkit1m6gMyvTCeXAR6X+2QczaE/QAtY+4bQng+Mjp3
         mmApesCm2gfTwasxKBCkubWOGqrFyMyJsI9aDEuf6gnqWHHGPMbK6sIIqXsr7c1Jj6Oy
         tanlow/dd7LU+62ZYPpaG9Bh1P9SJZ+6Nk+Cvt1+DDYcx1vrP+fkkw4GTBkbQuxnMmBo
         L6P35EvjBynlWxBsb4jqQKOg5CxTFdu3AnrPOBZNZlBWyrf9VGSPiVvjr4Zyv2Cuaa5N
         DopFVJatjcm+URq8bQIh7MKREAlGHVhLEHCzX/u77Z7uQSMviEknIgfCgOCZobKeaPIS
         A7CA==
X-Gm-Message-State: AKGB3mLygKaFbRkVBaEviWaWqCcZauG/JJA7fzNexLAsVNyogVBrb60E
        nDkt8QzVEint95wL9SSD6nv88s5CmznhIqjGJe6lCg==
X-Google-Smtp-Source: ACJfBou7bcoqhl6Cdxw9T6R+ac+vywlh4SECzujUhmVMsGohO9BEB/fHkTWh65yRPK2GNC//aUXFI2fj37GpvWgrhKA=
X-Received: by 10.159.242.196 with SMTP id x4mr14440853plw.342.1513365163173;
 Fri, 15 Dec 2017 11:12:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.189.1 with HTTP; Fri, 15 Dec 2017 11:12:42 -0800 (PST)
From:   Satyakiran Duggina <satya0521@gmail.com>
Date:   Fri, 15 Dec 2017 11:12:42 -0800
Message-ID: <CAMZug24WGWS3TaNPOVWPufGZ+67EbLggr4W3pxJtis9X375mag@mail.gmail.com>
Subject: Git Hooks
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see that `git init` creates a .git directory and hooks are to be
placed in that directory and these hooks are not tracked by version
control. To achieve tracked hooks, either each developer has to copy
the hooks or use tools like overcommit, pre-commit, husky etc.

I'm wondering why hooks are not made external like .gitignore. I guess
it would be better to have two git configuration directories in a
repo, one hosting all the metadata managed by git and the other with
user configured data (hooks, ignore/exclude, repo config etc).

Kindly let me know why the current design choice is made and if the
proposed change would introduce unseen issues.


Thanks,
Satya
