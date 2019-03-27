Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7FC20248
	for <e@80x24.org>; Wed, 27 Mar 2019 13:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfC0NBX (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 09:01:23 -0400
Received: from insw.cz ([83.167.247.81]:58825 "EHLO insw.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfC0NBW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 09:01:22 -0400
Received: from localhost (insw.cz [127.0.0.1])
        by insw.cz (Postfix) with ESMTP id BB9C4DA262D7
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 14:01:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553691680; bh=UxBSINgbb3vcGplzAeMbAqoZsnLgQyJCvnMZGYfpq0g=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=RLeHVLoRCNtC7AH7xC8ieVGeCtRTbbjhCq0akzyvIQsbsVhrkDF66zQj7vih+FxaI
         SbbEfaT/2m9oE4IYH9CkWa6T8c7f6dQb7S5e/RwSOZO73JMa9raaaH8bf3uZqVxIdn
         VFlQZIbl7tInZi+Ag9B/33sIZhdpcRqFp+eTgtPg=
X-Virus-Scanned: Debian amavisd-new at server
Authentication-Results: insw.cz (amavisd-new); dkim=pass (1024-bit key)
        header.d=bena.rocks
Received: from insw.cz ([127.0.0.1])
        by localhost (insw.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ktz82iNkfG_4 for <git@vger.kernel.org>;
        Wed, 27 Mar 2019 14:01:20 +0100 (CET)
Received: from MacBook.local (83-167-247-37.static.masterinter.net [83.167.247.37])
        by insw.cz (Postfix) with ESMTPSA id 11A0ADA262D1;
        Wed, 27 Mar 2019 14:01:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
        t=1553691680; bh=UxBSINgbb3vcGplzAeMbAqoZsnLgQyJCvnMZGYfpq0g=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=RLeHVLoRCNtC7AH7xC8ieVGeCtRTbbjhCq0akzyvIQsbsVhrkDF66zQj7vih+FxaI
         SbbEfaT/2m9oE4IYH9CkWa6T8c7f6dQb7S5e/RwSOZO73JMa9raaaH8bf3uZqVxIdn
         VFlQZIbl7tInZi+Ag9B/33sIZhdpcRqFp+eTgtPg=
Subject: Re: Unable to change remote url of origin
To:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
References: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks>
 <20190327125737.GA20395@alpha>
From:   Petr Bena <petr@bena.rocks>
Message-ID: <1af53933-86ad-6272-c564-087a462d7336@bena.rocks>
Date:   Wed, 27 Mar 2019 14:01:19 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190327125737.GA20395@alpha>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/03/2019 13:57, Kevin Daudt wrote:
> On Wed, Mar 27, 2019 at 01:25:27PM +0100, Petr Bena wrote:
>> Hello,
>>
>> I used to change remote URL simply by editing .git/config (which may not be
>> most correct way), but out of sudden I am no longer able to do that. So I
>> decided to do it the "proper way" but still - to no avail. Here is what I do
>> and also it's visible what is wrong:
>>
>> # Display remote URL
>>
>> petr.bena@MacBook:~/Documents/grumpy$ git remote -v
>> origin    git@github.com:grumpy-irc/grumpy (fetch)
>> origin    git@github.com:grumpy-irc/grumpy (push)
>>
>> #Now change it to HTTPS instead of SSH
>>
>> petr.bena@MacBook:~/Documents/grumpy$ git remote set-url origin
>> https://github.com/grumpy-irc/grumpy
>>
>> # Verify if it has changed
>>
>> petr.bena@MacBook:~/Documents/grumpy$ git remote -v
>> origin    git@github.com:grumpy-irc/grumpy (fetch)
>> origin    git@github.com:grumpy-irc/grumpy (push)
>>
>>
>> It's still SSH. What am I doing wrong?
>>
>> petr.bena@MacBook:~/Documents/grumpy$ git --version
>> git version 2.21.0
>>
>>
>> petr.bena@MacBook:~/Documents/grumpy$ cat .git/config
>> [core]
>>      repositoryformatversion = 0
>>      filemode = true
>>      bare = false
>>      logallrefupdates = true
>>      ignorecase = true
>>      precomposeunicode = true
>> [submodule]
>>      active = .
>> [remote "origin"]
>>      url = https://github.com/grumpy-irc/grumpy
>>      fetch = +refs/heads/*:refs/remotes/origin/*
>> [branch "master"]
>>      remote = origin
>>      merge = refs/heads/master
>> [submodule "src/libgp"]
>>      url = http://github.com/grumpy-irc/libgp
>> [submodule "src/libirc"]
>>      url = http://github.com/grumpy-irc/libirc
>> [branch "remote_scripts"]
>>      remote = origin
>>      merge = refs/heads/remote_scripts
>>
> Hello Petr,
>
> What does git config --show-origin remoe.origin.url return?
>
> Kind regards, Kevin


Hello Kevin,

petr.bena@MacBook:~/Documents/grumpy$ git config --show-origin 
remote.origin.url
file:.git/config    https://github.com/grumpy-irc/grumpy

However git push is still accessing SSH version (which is blocked by FW 
in this place):

petr.bena@MacBook:~/Documents/grumpy$ git push -v
Pushing to git@github.com:grumpy-irc/grumpy

I need to change it to HTTPS

