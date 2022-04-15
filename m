Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD7FC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 12:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiDOMEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352940AbiDOMEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 08:04:44 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686FBCB4D
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 05:02:16 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nfKeU-0002oJ-5n;
        Fri, 15 Apr 2022 13:02:15 +0100
Message-ID: <488bf3f0-7859-7b7c-b46d-48248aacca62@iee.email>
Date:   Fri, 15 Apr 2022 13:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: safe directory on shared drives
Content-Language: en-GB
To:     Andrew Noblet <andrewbnoblet@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAO=QCg5+M-=dOf=AFTDL8z9-LrK-7vau+=JV-7QJfVOhdFp1Aw@mail.gmail.com>
 <3a02bf6c-54c1-39c8-5f3e-9f246c9e87b8@iee.email>
 <CAO=QCg6+J-dA2U9F5dseKbb=HA_pLFmZ9tbHydnLRSk5Dg2UXg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAO=QCg6+J-dA2U9F5dseKbb=HA_pLFmZ9tbHydnLRSk5Dg2UXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glad it worked!
copying in the list in case others can be helped by the confirmation.
P.

On 15/04/2022 12:55, Andrew Noblet wrote:
> Thank you! Adding `git config --global --add safe.directory
> '%(prefix)///192.168.0.120/config/'` <http://192.168.0.120/config/'`>
> worked!
>
> Andrew
>
> On Fri, Apr 15, 2022 at 7:43 AM Philip Oakley <philipoakley@iee.email>
> wrote:
>
>     Hi Andrew,
>
>     On 15/04/2022 11:14, Andrew Noblet wrote:
>     > The new git security rules creates an issue on Windows systems where
>     > the git repository is hosted in a shared folder.
>     >
>     > $ git status
>     >
>     > ```
>     > fatal: unsafe repository ('//192.168.0.120/config/
>     <http://192.168.0.120/config/>' is owned by someone else)
>     > To add an exception for this directory, call:
>     >
>     >         git config --global --add safe.directory
>     //192.168.0.120/config/ <http://192.168.0.120/config/>
>     > ```
>     >
>     > $ git config --global --add safe.directory
>     //192.168.0.120/config/ <http://192.168.0.120/config/>
>     > $ git status
>     >
>     > ```
>     > warning: encountered old-style '//192.168.0.120/config/
>     <http://192.168.0.120/config/>' that should
>     > be '%(prefix)//192.168.0.120/config/ <http://192.168.0.120/config/>'
>     > fatal: unsafe repository ('//192.168.0.120/config/
>     <http://192.168.0.120/config/>' is owned by someone else)
>     > To add an exception for this directory, call:
>     >
>     >         git config --global --add safe.directory
>     //192.168.0.120/config/ <http://192.168.0.120/config/>
>     > ```
>     >
>     > There seems to be no way to add a shared drive path to the safe
>     directory list.
>
>     This (instruction clarification) is being discussed / sorted at
>     [git-for-windows/git] Include trailing slash in prefix migration
>     instructions (PR #3790)
>     https://github.com/git-for-windows/git/pull/3790
>
>     The key point being that for a `//server` path you will need three
>     slashes. (IIUC) One for magic prefix string, and then two as part
>     of the
>     server name.
>
>     There is now also the `*` option that permits all as safe
>     directories. 
>     Worth checking how the user and group security is being handled
>     locally,
>     especially for accidental failures.
>     Philip
>
>

