From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Sun, 24 Apr 2011 00:11:11 +0200
Message-ID: <BANLkTinV4cFC5vzr25V-D3PMwWx284zgoQ@mail.gmail.com>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie> <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
 <20110423101500.GB1500@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 00:11:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDl3D-0007Yp-Dw
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 00:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278Ab1DWWLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Apr 2011 18:11:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64401 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab1DWWLb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2011 18:11:31 -0400
Received: by gwaa18 with SMTP id a18so373194gwa.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Xs4uAB5vt/s5zsUUJpY/Gy+lG/avIoPW5T4vdFchC7g=;
        b=QfGs8Gn4+wKKm0s40A2T0rVOCNqEoaoIR8a8mezpcvpmOFaq2aXkQPSXNUxmqoF1dZ
         ICKHo0MX9OZzlk+JI9XK1euL8cUXz6FRHntABZiwyD6rAWOuUHQE7OVA7cTPeBUCMHKJ
         K8UeHiwxIJoHR/TZEC0VUYyue07cA4dZahPVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HFLEwevM5OgQPvg6VnH60Z21YizgED2iB1OaD3limnzCQgdDye0Ja0ujKNoWc6mL1W
         kAwnVfi/gdD6pWg6LDs4OWZGHzftQ8LffONHqm08SP+Jl29ylN/FaKuI5Lv0AZu/5h8j
         F2WJiYtC9DY5LjrRPo+fPv+M2AfF8G8UUsOjk=
Received: by 10.236.79.136 with SMTP id i8mr2616366yhe.392.1303596691087; Sat,
 23 Apr 2011 15:11:31 -0700 (PDT)
Received: by 10.236.110.9 with HTTP; Sat, 23 Apr 2011 15:11:11 -0700 (PDT)
In-Reply-To: <20110423101500.GB1500@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171988>

2011/4/23 Jonathan Nieder <jrnieder@gmail.com>:

> Richard Hartmann wrote[1]:

Nice. Is that automagic? And if yes, may I steal it?


> I assume you mean --work-tree and --git-dir. =C2=A0But if true, that =
would
> be a bug.

With env variables set:

% git merge origin
fatal: origin - not something we can merge
%

With parameters:

% git '--work-tree=3D/home/richih/killme/fgit/target-default'
'--git-dir=3D/home/richih/killme/fgit/source' merge origin
fatal: origin - not something we can merge
%

In a normal worktree without any mangling:
% git merge origin
[...success...]
%

I think I reduced the test-case as much as I can, especially since the
script takes care of everything for you. If you simply run in on any
random git repo, you will be able to replicate this behaviour.
Unfortunately ;)


Thanks,
Richard
