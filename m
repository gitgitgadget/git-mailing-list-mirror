From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: Git Master Master Replication
Date: Sat, 8 May 2010 18:44:42 +0100
Message-ID: <n2y86ecb3c71005081044pae211c37lc01ddc5f9f2ff146@mail.gmail.com>
References: <o2tc2f2fad1005080341z42b389e0i791c6c7a02dee5e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: amitesh kumar <amitesh.a.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 19:45:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAo5P-0005In-FS
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 19:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab0EHRpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 13:45:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39323 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0EHRpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 13:45:02 -0400
Received: by pxi5 with SMTP id 5so1037233pxi.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=W8iXRcfJ/1+DNpy2nTE52eVkwn9go432ykofzFHb4qE=;
        b=i2Q/9bT13ulLEBMsgD29VoeYVTQzgsIdz915uEJI2qYhV6NFWMfVNumZ0pVOALljhJ
         h/3CqqfkKNfW3vAMKHOAHbF8HW6HXdD6sSviN0fFvxtemr/us1IHEYVIHGynQJk3U/DD
         65ykVnvrEnOz5dfVT9YGB26BPD++iHe28Y+x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=m7px4mr1cqyfWjlvkQymUHPK+tbSNkQHXDDBJp9WTpUx1xRbFDKPeOYNbjyY3W6spX
         B7QDasHasl5qdlWEXlhFfzWVFHQ5yC8UoysxXaHxDFsczlsifDv6tjJUkh4R5PZKoW9e
         8JboUBe48H1gZWbAPr8pXuG086uexhXVQLoV0=
Received: by 10.142.117.14 with SMTP id p14mr1096884wfc.144.1273340702110; 
	Sat, 08 May 2010 10:45:02 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Sat, 8 May 2010 10:44:42 -0700 (PDT)
In-Reply-To: <o2tc2f2fad1005080341z42b389e0i791c6c7a02dee5e5@mail.gmail.com>
X-Google-Sender-Auth: a79ddd83f319f621
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146668>

On 8 May 2010 11:41, amitesh kumar <amitesh.a.kumar@gmail.com> wrote:
> Hi im working on a project the will be deployed in many countries,
> Is it possible with Git to host n masters?
> Can any change on a particular master be propagated to others?
>
> I have had a look at Gerrit2 but it only looks one way.
>
> Cheers
> Amitesh

In one git repository you can have only one branch with exactly the
same ref e.g. refs/heads/master.

By editing .git/config you can setup unlimited amount of locations of
where to pull from and where to push to (and you can pull from many
locations to a same branch and push one branch to many locations)

[remote "server-uk"]
      push = +refs/heads/master:refs/heads/master
      push = +refs/heads/uk/*:refs/heads/*
      pushurl = bla.co.uk

Similarly you can specify pulls using * or specifing each one.

.git/config is extremly flexible I'm sure you can make it work with
any amount of remotes =)

hope this helps.
