From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 3 Apr 2013 00:41:38 +0530
Message-ID: <CALkWK0kCcSgHfmTuQc-0XGHOdm6PPaVHqFeD4bko-zq3pH8mUw@mail.gmail.com>
References: <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
 <51597A37.1010301@web.de> <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
 <20130402185426.GG28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6dU-0004Ex-3R
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444Ab3DBTMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:12:19 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34674 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab3DBTMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:12:18 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so801222ieb.8
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=73neflRrsB6Zx3SMR+u0zWiHuszrOWi7DPUiLI9yexw=;
        b=hnSB2yqr71uj/Jg6C86JSJPtitaIXiZDYwoBXvoB4PD0aXS2oYn6r8TI2vAKqv7D5y
         tCEHpbqghv0euBu391Njx65Muqp/7StT8Yermwvtp0lErhODOHCq4oG1gjWFe56wH7Z7
         qDMjx9Deb9RFa7CmbnPkC6iVoZbdPn0m0fPcyAIpKGTgu+ZuHZAgkzRkOuHG/8b61Cq3
         WTp34VUyeBV1VdXPNLteQ70sqKotnuqkUlm+wZ8+Xvsz4OgWm9Ai8XVLvayeK4wDSa/y
         qXHi1qie7uuFiGZcQ0znWn9Lwy69Plfo3Tjkbpc48D3irzszVfVIDGhO3f74iiakHplF
         V41Q==
X-Received: by 10.50.50.71 with SMTP id a7mr5617068igo.14.1364929938565; Tue,
 02 Apr 2013 12:12:18 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 12:11:38 -0700 (PDT)
In-Reply-To: <20130402185426.GG28148@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219852>

Jonathan Nieder wrote:
> That sounds similar to what Junio does with the Meta subdirectory in
> his git development worktree.  I don't think submodules are a good
> fit, but it might make sense to start respecting a .motd file to allow
> the following in a hypothetical world where everyone who clones git
> uses the same scripts Junio does:
>
>         $ git clone git://repo.or.cz/git.git
>         Cloning into 'git'...
>         remote: Counting objects: 151283, done.
>         remote: Compressing objects: 100% (38546/38546), done.
>         remote: Total 151283 (delta 111004), reused 151073 (delta 110797)
>         Receiving objects: 100% (151283/151283), 36.39 MiB | 7.66 MiB/s, done.
>         Resolving deltas: 100% (111004/111004), done.
>
>         Don't forget to "git clone -b todo git://repo.or.cz/git.git git/Meta"
>         for maintenance scripts.
>         $

Nope, it's not mandatory for everyone to use dotfiles.git in exactly
the same way either.  In other words: I'm not sitting in an office and
working with my colleagues on exactly the same things, in exactly the
same way; wasn't that the Subversion age?  Some might decide to
initialize a few submodules, change the URLs of some, and remove some.
 I'd want my private fork to have commits changing "initialize
submodule quux" to "don't initialize submodule quux", and be able to
rebase that on top of upstream.  Why are you leaning towards solutions
for very narrow usecases?
