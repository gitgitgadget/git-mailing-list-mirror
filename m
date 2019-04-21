Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B4020248
	for <e@80x24.org>; Sun, 21 Apr 2019 12:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfDUMed (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 08:34:33 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44843 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfDUMed (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 08:34:33 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 447E721947;
        Sun, 21 Apr 2019 08:34:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 08:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        reply-to:subject:to:cc:references:from:message-id:date
        :mime-version:in-reply-to:content-type
        :content-transfer-encoding; s=fm2; bh=eAr+7pYm30AgaKAAHy97tPRrw1
        k8hs65hHNjGGPWj2w=; b=FteeQQc8KXAu08XiY6M0yyfEotKuLobZzQqsAu3FPb
        oVncncXltfeBg04LvFuu0NDYbire2CEx1oGaNLZfRiRRw6kGpdRX1NTwdsbsXdsi
        OwJEVLzPMwYa+ml3vVTiwiLn+QS4hpmd3fivaHNSlYpXY1SIE+DrWkFn8N13bCZT
        4PiO1f5WkWnGG27c6KX9UrcchWk3jcjHUjHtj46qgnGgESXby75pLX2mJUrXdQIw
        atswefcr8Ds5jgjjZwO5EYL7d8pP8XjYnstBmTj9fJmZJq3IQlbFrkxLTA7XZgY7
        W1+eXttk3/bMkyz1OuoChShl6FHMzitbQR3UeNQ9+faQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=eAr+7pYm30AgaKAAHy97tPRrw1k8h
        s65hHNjGGPWj2w=; b=MNsrJ4xG2xaNh8aJKPyQItmSTFHPQJli8fEYNDX7ok5Ol
        9IxN0SESn8lDOz5lzCKdNfc01ai/FEL76s1OXs6GH+1tKHWeVJj98XMJ1DbFeB6x
        BZAPIG+rwbR4jmUH6Rzf9x9kIgtG8F1P9QUDg192vE65pj5VVRlU2xToa1IOEoJM
        yMdnBSIYrsYQbWLvWegJlcYiVe6pKqnd3UG9Q5KqmicbJ0Di0mp5wu9W/2s5sveU
        AIPuKDVZOVoK+jjimtod8QaEgtNUp/pMJtC3FNwI3AOf3kknXzOmk+bBweuZYZvQ
        olv/nKm1GhEQjSgvVgTq0EgfaBYIddCQbim56iE3w==
X-ME-Sender: <xms:V2O8XC6zk7m-l8tko0MS872rXqFKVoQibG6zJtxFm08r96KxGKueAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurheprhfuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpehrohgsuceoughrrhhosgdutddtsehfrghsthhmrghilhdr
    tghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepjedvrdekledrle
    eirddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpegurhhrohgsuddttdesfhgrshht
    mhgrihhlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:WGO8XBY10Q_1SXuwGIrrvSd9WxaEM5uBGi1k3Udp2QOiJtu2olg-Sw>
    <xmx:WGO8XAgwDOHC4iHHZY9TG_xjphWzVQZhZ_jpjSwNdzs4-F_9di4-1g>
    <xmx:WGO8XDexUMbXCm39MqiqXvepdwOhlbdzMMkYlhrElvnlZv7eI-JxUQ>
    <xmx:WGO8XAQdjaZw7DNHz25zgb5kH7Fg5FLiHT7VeS5MmJVvjBQVBb4Uyw>
Received: from [192.168.1.153] (pool-72-89-96-188.nycmny.fios.verizon.net [72.89.96.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94E38E415C;
        Sun, 21 Apr 2019 08:34:31 -0400 (EDT)
Reply-To: rob@drrob1.com
Subject: Re: I messed up my own git tree and I don't know how to fix it.
To:     Adrian H <adrianh.bsc@gmail.com>, rob@drrob1.com
Cc:     git@vger.kernel.org
References: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
 <CAP_kE8XaFW=G1f_qrS2sEp+ELQ9otk=j0-ZtbF1dATQX8ZjrAA@mail.gmail.com>
From:   rob <drrob100@fastmail.com>
Message-ID: <b0a8d228-78c5-a355-1ded-dc2904d8216e@fastmail.com>
Date:   Sun, 21 Apr 2019 08:34:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAP_kE8XaFW=G1f_qrS2sEp+ELQ9otk=j0-ZtbF1dATQX8ZjrAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

didn't work.  I did not get any error messages, just didn't work.  After 
I did

   git reset --hard

   git status

I see the same 3 files that say changes not staged for commit: modified 
and it lists the same 3 files.

--rob


On 4/21/19 1:03 AM, Adrian H wrote:
> If I understand the commands you are using correctly, you are
> referencing the remote repo.  You need to reference the local repo.
> So try using the following commands:
>
> git checkout -- alecthomas/gometalinter
> git checkout -- kisielk/errcheck
> git checkout -- rogpeppe/godef
>
> Or if those are the only files that have been modified, then you can
> use the following single command:
>
> git reset --hard
>
> and that will reset all files that have not been staged.
>
> HTH
>
>
> A
>
>
> On Sat, Apr 20, 2019 at 11:22 PM rob <drrob100@fastmail.com> wrote:
>> I have my own code at a github repository, using Go.  Part of using Go
>> libraries not part of the official Go people is by using a system they
>> call go get.  This essentially uses git to, well, go get source code.
>> Mine are at github.com and golang.org.  My computer runs LinuxMint 19.1.
>>
>> I used goland IDE from jetbrains to run go fmt on my entire project.
>> Now I am getting this message that I cannot get rid of:
>>
>> changes not staged for commit:
>>
>>     modified: github.com/alecthomas/gometalinter (modified content)
>>
>>     modified: github.com/kisielk/errcheck (modified content)
>>
>>     modified: github.com/rogpeppe/godef (modified content)
>>
>>
>> I do not want any changes to central repos to be tracked or committed,
>> but I cannot undo this.  I tried, for example,
>>
>> git checkout -- github.com/alecthomas/gometalinter
>>
>> I don't get an error message but it does not do anything.  The file is
>> not changes, and git status show me the same information, ie, these
>> files have changes not staged for commit.
>>
>> I do not know how to restore these files to the state they were in in
>> the repo, and to have my own git tree not to flag this as an unstaged
>> alteration.  Running rm -rfv on the repos on my computer, then running
>> go get to restore them does not change git status. It still sahs changes
>> not stated for commit: modified.
>>
>> This happens for the above 3 tree items.
>>
>> How do I restore these to the github remote repository condition and not
>> have my own git tree mark these as changed?
>>
>> --rob solomon
>>
>
