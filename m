Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6657C1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 14:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeGNPKw (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 11:10:52 -0400
Received: from mail.aegee.org ([144.76.142.78]:36529 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbeGNPKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 11:10:52 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2018 11:10:51 EDT
Authentication-Results: mail.aegee.org/w6EEkHjU003280; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1531579578; i=dkim+MSA-tls@aegee.org; r=y;
        bh=OcUUFzs/iCiMrDvQN6YC64tQyR4m9rqfW7RY7WvFFbE=;
        h=Subject:From:To:Date;
        b=JuJ7nkw7ipgtG1477dO09aU9XjnIJkhLZfw3wTrIFs/kcPVDgYrYxogeJSq3gUQxR
         qEOfLkkb2NouCY3x3Xn/nJRatqNiAA5iDJZEdz+1sD1AIEpT8PlTMHM6TK2u6fx+QB
         acs5WNJTA9kWb2jw8Bm78zLFS/bB8+w/epRY8DnZKtS4xpw7V4DSidNC/TgHKrao+n
         d1OYpE8/rZkUYZg0t8/Ye+2z8BEPeIU5xq90W/xlMzCKAyq9i8vvYzdJEFIJUgIDGl
         8yJnk64SP5qu6f9pWY0Xa2Flpeh5JK/udeEgZ8gCXApygoQzP9j4CpzIVzGoi3Z/nR
         dk7zooDaMIxYnt0P5LvK5tixjAHjbFUOoJJGh6NpHabfb+uDDL4Buyq2QrVzgK7bih
         C0M2K+LKa75XHQfO6+TeG38bMoyLV4SfNXS8F2e2KJ2TFXl5HjHmgVPhxU1tsFox8S
         aveOAQ9ZoTbaYK0qTKIaKGfOBHViGYZz+FGk1ojSSBG4/gmWEYpGoa0JU9RK3sJuyM
         lENIm4AbxNg4Umg5UrFocSjC42tIRz4JJ52dWJlgO53zvxLkaLF3peaOp7axJYOheK
         GJyyFaJPel4rRCILuZHDLac5eXln+Iom3JqR7Vb1tV3U0pOjg4Ygdf6bLzmtjF8aZY
         mOcpOeXJCsiEPQGgK8wak3Yg=
Authentication-Results: mail.aegee.org/w6EEkHjU003280; dkim=none
Received: from Tylan (80-110-70-253.cgn.dynamic.surfer.at [80.110.70.253])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id w6EEkHjU003280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:46:18 GMT
Message-ID: <d9272a12c2a38429857777f7811010956b7b6ed5.camel@aegee.org>
Subject: bash completion with 2.18.0/maint: unknown options
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
         =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
        <Dilyan.Palauzov@aegee.org>
To:     git@vger.kernel.org
Date:   Sat, 14 Jul 2018 14:46:17 +0000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.29.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.1 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

in /git/git I have v2.18.0 and in ~/.bashrc : 
export
PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[00m\]:\[\
e[
01;34m\]\w\[\e[36m\]$(__git_ps1 " %s")\$ \[\e[0m\]'
source /git/git/contrib/completion/git-completion.bash 
source /git/git/contrib/completion/git-prompt.sh

After upgrading to 2.18 the completion does not work:

typing "git de<TAB>" prints
my@host:~$ git deUnknown option: --list-cmds=list-
mainporcelain,others,nohelpers,alias,list-complete,config
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-
path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [
--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]
l.txt

with l.txt being part of a file called "del.txt"

or typing "git reb<TAB>" I expect to have rebase, but I see
my@myhost:~$ git rebUnknown option: --list-cmds=list-
mainporcelain,others,nohelpers,alias,list-complete,config
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-
path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [
--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

Ideas?

Doing in git/git/ "git checkout v2.17." followed by 'source
/git/git/contrib/completion/git-comletion.bash" does help (makes the
completion functioning).

In the likely case this is fixed by now on master, please backport the
fix soon to the maint branch.

Greetings
  Дилят	

