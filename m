From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sun, 22 Sep 2013 02:43:39 -0500
Message-ID: <CAMP44s0Lww+se6iA2NWSwkeuLdR9mc0ppnVBSjWu4d73YeP6oA@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
	<523e81f338f1e_547c41e7c166be@nysa.mail>
	<20130922073120.GC13262@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 09:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNeKX-00035d-Gw
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 09:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab3IVHnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 03:43:42 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:43063 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab3IVHnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 03:43:41 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so1567797lab.24
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0VkuaJWE0vvvTdUtBhCZi7zXmYzNpwQ+BkQ2kuz4rFc=;
        b=bBinNwKy7x2ntFAenXZqUpxPTYWOIyhyVOubGV3iHMNQJU/rCvs5rTXjaZmMTXSOl5
         MvOFw5TznsiBcT/ZpIYL0l9DJ0D3dFt5RAElQsDfcKDqHK2ixG9NOHYXGhxI9yJhHCwn
         hGAWhO8OxmvkORTUvE8GtMq9a2kWrVuJRx4oMymi8hPCruhC8US43sqrvSK8YPnaRWtp
         Ym3yQOoh5HdBc/GXpGcPqowKtD/Kj7Ud8jygccTdqwGIqdWSukDjWvZxO/JDh8WTV2gu
         +Ysr+0rMNrrnyur2pdLCHcs9hnVh41UztvxqynQwtEgZSVrlWfxElBjWm0JVHhdmbRZ9
         I/QA==
X-Received: by 10.152.36.98 with SMTP id p2mr14365494laj.14.1379835819935;
 Sun, 22 Sep 2013 00:43:39 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 22 Sep 2013 00:43:39 -0700 (PDT)
In-Reply-To: <20130922073120.GC13262@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235161>

On Sun, Sep 22, 2013 at 2:31 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Sep 22, 2013 at 12:36:51AM -0500, Felipe Contreras wrote:
>> > I think it's a bad idea to introduce an entirely new runtime, especially
>> > one known to occasionally blow up on less-common architectures, without
>> > some advance notice.
>>
>> This is just FUD. What do you mean blow up on less-common architectures? Do you
>> have actual evidence or can we just dismiss that as a baseless argument?
>>
>> > For example, at work I would not be able to deploy a git using Ruby
>> > immediately because Git is an RPM and Ruby is compiled from source, if it is
>> > even present at all.
>>
>> Again, what do you mean? In all the distributions I've seen, vim is compiled
>> with Ruby support by default, so unless you think vim is an essoteric package,
>> libruby is almost definetly packaged and available.
>
> It would actually be usefull to know stats on where git is runned. In my
> world of embedded computing, ruby support definitely isn't a standard,
> nor is glibc.

I come from the embedded world as well, and I've never seen Git used there.

I'd say Windows support is much more important than embedded, and we
are not supporting that properly.

>> > Also, the only Python script that is shipped with Git is git-p4, which
>> > is essentially optional, since most git users probably do not use
>> > Perforce. Otherwise, all the scripts in git are shell or Perl.
>>
>> Neither perl, nor shell, nor python scripts solve the forking problem. My
>> proposal does.
>
> It does,

No, it does not. All the **current** perl/shell/python scripts use
'git foo' commands to achieve everything.

> and so does Lua,

There is no lua in Git.

> which can be bundled with git and used in the
> configuration files as well and is pure ansi C. However bundling
> something has it bad sides too. At least this will solve the dependency
> problem. So let the language war begin =).

Talk is cheap, show me the code.

-- 
Felipe Contreras
