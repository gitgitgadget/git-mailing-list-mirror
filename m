Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F78F20248
	for <e@80x24.org>; Wed, 27 Mar 2019 12:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfC0Mek (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 08:34:40 -0400
Received: from insw.cz ([83.167.247.81]:57837 "EHLO insw.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfC0Mek (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 08:34:40 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 08:34:39 EDT
Received: from localhost (insw.cz [127.0.0.1])
        by insw.cz (Postfix) with ESMTP id 474AFDA24F8B
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 13:25:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553689530; bh=XJpInYLKLCs3bN0yClaBKfgnO8g1Ehvf+E+B2Jtcd04=;
        h=To:From:Subject:Date;
        b=Bo+k9Vdc67GSYWqD9OlpgZc1KSBw7zU2i5ozUwmFVqoLuIH3QWgXnGzcZ14fQEBxv
         b/QPkifKRvgQVlUcudWXQ8Q3gJNY5pql0xCNP2AZwLxanpnhRGIjelE2mTo9Cdhar4
         fdaaXnRCFnFS3MYdsbdG3WOf2+mwX0T9XoSwPF94=
X-Virus-Scanned: Debian amavisd-new at server
Authentication-Results: insw.cz (amavisd-new); dkim=pass (1024-bit key)
        header.d=bena.rocks
Received: from insw.cz ([127.0.0.1])
        by localhost (insw.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5t_pSNS4sLQ7 for <git@vger.kernel.org>;
        Wed, 27 Mar 2019 13:25:28 +0100 (CET)
Received: from MacBook.local (83-167-247-37.static.masterinter.net [83.167.247.37])
        by insw.cz (Postfix) with ESMTPSA id AB5C3DA24F88
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 13:25:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553689528; bh=XJpInYLKLCs3bN0yClaBKfgnO8g1Ehvf+E+B2Jtcd04=;
        h=To:From:Subject:Date;
        b=HvBvo0M5t5Igzlz4lmSzMiOczfk5olUc+ImdZuKHAoSr5qoYyjhdQOoZ4d51Vqh5x
         x1vTha1Y4RjebrThuvcRusTwlOG+EfwvqSvO5gsTCdEox9C2N6RHww1gAuUBmB1c/B
         3ccn8ehBmAchCIMDTL45CZP2b1KtEG4T0srEoym4=
To:     git@vger.kernel.org
From:   Petr Bena <petr@bena.rocks>
Subject: Unable to change remote url of origin
Message-ID: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks>
Date:   Wed, 27 Mar 2019 13:25:27 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I used to change remote URL simply by editing .git/config (which may not 
be most correct way), but out of sudden I am no longer able to do that. 
So I decided to do it the "proper way" but still - to no avail. Here is 
what I do and also it's visible what is wrong:

# Display remote URL

petr.bena@MacBook:~/Documents/grumpy$ git remote -v
origin    git@github.com:grumpy-irc/grumpy (fetch)
origin    git@github.com:grumpy-irc/grumpy (push)

#Now change it to HTTPS instead of SSH

petr.bena@MacBook:~/Documents/grumpy$ git remote set-url origin 
https://github.com/grumpy-irc/grumpy

# Verify if it has changed

petr.bena@MacBook:~/Documents/grumpy$ git remote -v
origin    git@github.com:grumpy-irc/grumpy (fetch)
origin    git@github.com:grumpy-irc/grumpy (push)


It's still SSH. What am I doing wrong?

petr.bena@MacBook:~/Documents/grumpy$ git --version
git version 2.21.0


petr.bena@MacBook:~/Documents/grumpy$ cat .git/config
[core]
     repositoryformatversion = 0
     filemode = true
     bare = false
     logallrefupdates = true
     ignorecase = true
     precomposeunicode = true
[submodule]
     active = .
[remote "origin"]
     url = https://github.com/grumpy-irc/grumpy
     fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
     remote = origin
     merge = refs/heads/master
[submodule "src/libgp"]
     url = http://github.com/grumpy-irc/libgp
[submodule "src/libirc"]
     url = http://github.com/grumpy-irc/libirc
[branch "remote_scripts"]
     remote = origin
     merge = refs/heads/remote_scripts

