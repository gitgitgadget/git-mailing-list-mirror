From: John McIntyre <joh98.mac@gmail.com>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 11:58:03 +0100
Message-ID: <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
	<20150518102633.GA15186@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 12:59:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuIlI-0005k2-JR
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 12:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbbERK7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 06:59:01 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:34351 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbERK6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 06:58:05 -0400
Received: by laat2 with SMTP id t2so213169490laa.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CtwG0FcekbxckcNlqANRlFrMqOZ18VkVAq0JfROQwVM=;
        b=q3SkcyQkU5UPYQV2+riQYIONx6OO7l3ni/4chICjWaL1INntPYJdVdFTz2HwrKpF9H
         ELKsmpWMaD8y1X6Fo24UZp4OcKTvw0tQWeXmGUXCLrrMf6wYrcGnbB/+DTJVDS+OdsqS
         UQKevoD9PHvSC8A2NKTFu6d/UUwndyA/VHOAsdT8Z6jcQhJJkC5NtkuJpBz7QcwRdiZu
         Ufodb3NRXqxTZropEkoWbNa/4mKGQdp8bmaFMzp8/F+Pwy38DnmttmMu0qFZr0o9XiMl
         L862oUC2TSzq/A4+J9AmyLhyG9OMix9eWND4NaQYeIXbcrbAZQkaknezr5vxO7//ADkm
         /P7Q==
X-Received: by 10.152.19.8 with SMTP id a8mr4383055lae.121.1431946683068; Mon,
 18 May 2015 03:58:03 -0700 (PDT)
Received: by 10.152.129.228 with HTTP; Mon, 18 May 2015 03:58:03 -0700 (PDT)
In-Reply-To: <20150518102633.GA15186@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269227>

2015-05-18 11:26 GMT+01:00 Heiko Voigt <hvoigt@hvoigt.net>:
> Hi,
>
> On Mon, May 18, 2015 at 11:07:02AM +0100, John McIntyre wrote:
>> Hi,
>> I've been asked to set up a git repository for a few projects.  So I
>> have a Linux CentOS server running git.   I place the repositories
>> under /opt and I use the .ssh/authorized_keys of the git user, to
>> grant access. The user sends me his private key, and I paste it into
>> the end of the file.
>>
>> And now, I realise that there's a problem.  If I have /opt/repo1.git
>> and /opt/repo2.git, then all users can access both repositories.
>>
>> Is there a way to prevent this?
>
> If you want a simple tool using ssh-keys have a look at gitolite[1].
> It quite simple to setup and with it you can specify all kinds of access
> rights.

That's adding a separate level of complexity.

I looked into filesystem-level permissions.  I don't see any means of
doing so, because everyone accesses the repositories using the 'git'
user.  So even if I add a group like 'devClient1' and then change the
group ownership of a repo to that user, they'll still be able to
access all repos..?

John.
