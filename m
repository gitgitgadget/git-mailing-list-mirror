From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Wed, 29 May 2013 22:04:04 -0500
Message-ID: <CAMP44s0YbQLAtmFxhgeY-18U63hF2n8L2LUOxaCnO8Mm7nsONQ@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
	<CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 05:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhtAL-0005bF-NU
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 05:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967384Ab3E3DEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 23:04:21 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:56025 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967393Ab3E3DEG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 23:04:06 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so9432058lab.35
        for <git@vger.kernel.org>; Wed, 29 May 2013 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zEvaIz1rCCk8boa58SLG2q5LIyEw+jq/QaFVdT5SXE8=;
        b=z01YD56BlhHGL+V7svdAwQ5qxqrg56G4cxexCWIB6y2sy5ojd6ZsO6zOVfi2oZBDGH
         3hv98JnZT85Q18E7hkqPoV5RdBVIoXklVTQnxjJ5Ar7VwXlemPD/HPq4x6UlxOobaLTW
         7Y3//KfwhdbgnCxPlaXX3GkOue/lC+wNPOiszPauu61TGOSyWFVHagPfecE1bOc+XBVS
         ka8SO0W1Rd1Qf/GuZf/rhAlwEMS3UYx/6KNHA3A5YUf4t/FlBbUv12gbe+Kcj7xmb46t
         p24TE0iZJjqU7UpgdQfa4B2/RyKD5CK6JTFWIaBjZgfmvrdL0CGzWyVK/ZA9CnG0dqsw
         YDWw==
X-Received: by 10.112.33.17 with SMTP id n17mr2727516lbi.72.1369883044222;
 Wed, 29 May 2013 20:04:04 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 20:04:04 -0700 (PDT)
In-Reply-To: <CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225916>

On Wed, May 29, 2013 at 3:27 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> We should probably also add typical shortucts:
>>
>> d = diff
>> l = log
>> f = fetch
>> p = push
>> r = reset
>> ci = commit
>> rb = rebase
>> co = checkout
>> st = status
>> pi = cherry-pick
>> mt = mergetool
>
> Terrible idea.

A "terrible idea" that somehow each and every other SCM tool in the planet does.

I don't see Mercurial users demanding that they take their useful
shortcuts away, I see the opposite; they demand useful shortcuts for
Git.

I say it's a terrible idea **not** to do that.

> We'll be eating up more subcommands that the user
> cannot override.

We won't. We can easily implement these as special aliases that the
moment the user specifies something else.

But actually, we don't have to do anything because the current
implementation already does that.

If the user has 'alias.ci=commit -v', and then we specify a default
'alias.ci=commit', the user's configuration takes precedence.

> I'm already unhappy with am not having been called
> apply-mailbox, because I want am to mean am -3 -c (too lazy to write
> those configuration variables).

cat > ~/bin/git-am <<EOF
#!/bin/sh
git am -3 -c "$@"
EOF
chmod +x ~/bin/git-am
echo export GIT_EXEC_PATH=$HOME/bin:$(git --exec-path) >> ~/.profile

Done.

And I don't see what that has to do with default *aliases* the user
can override. This is a red herring.

-- 
Felipe Contreras
