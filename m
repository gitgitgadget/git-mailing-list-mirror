From: Shannon Pekary <spekary@gmail.com>
Subject: Mac OS Git non-interactive shell problem
Date: Sat, 21 May 2016 08:05:26 -0700
Message-ID: <91B3CC94-4955-4AAB-B461-E6F5C5D9F682@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 17:05:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b48TL-0005eI-3m
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 17:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbcEUPFb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2016 11:05:31 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35693 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcEUPFa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2016 11:05:30 -0400
Received: by mail-pf0-f181.google.com with SMTP id b66so29546127pfb.2
        for <git@vger.kernel.org>; Sat, 21 May 2016 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=fsmVB/NTv/fadMx2D831DmV9VqpnkcY58osnaM5JCl8=;
        b=ursXGURU3K0EI7Pc/9pwXux7f+u3HTQNksgaiZx/fxuVKEe2e8KPzIhgw0Kqyk9LdQ
         dfqdUjSj3qcfBL/V83WGbpiFn0I/1jzkPCt6JgRX0hq41YKxIwmAXFIl9PFuzHAcB61i
         unEt0TIhk0odVrwLaGuKFkBqxedlkniH03HdpZkHtPRYUnsYbBgWe9TCqSEouQPW/4f1
         de6vnZL1TQ4oAq58lRLgSjS7eZMrlDhE6dgHoAYq7lycwZAWdegkg0HbkMidWVXkI5KQ
         kJusfowBwP6OivH6+8Qxa818dNHuHYK/W5lTJBXvSSBoZTfdQwsTYXSXaB7/bFnWISze
         VTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=fsmVB/NTv/fadMx2D831DmV9VqpnkcY58osnaM5JCl8=;
        b=HSvJyjtW+fwiYK5ZtYHxmMTK0XuxjkH3GIOh1N0+mgZ3wN16im2VHBHTrKjF2OFsAO
         bfpW1/lx085shdprAYmNKB+zi/m4SO4riNZXUJScdmZ0c+actovUM3yczUCrY+m8anV+
         rgu8Ljap7TXrabAxc1DH/ms5vg/DdtzUWaFgj+RTxd4Bm1ESd+2sPN3SKT2q0a0EaCQg
         DvTvPlwr4ZMID+Gm6laTq9jTEyvOAGwaNzn2bdI/7z+ggvlLj4M1pucL9rcTsN9Q7B5Q
         P4z20n/6n2NMKwoPrBXWaGpCu5V5I8RKfOIZBTCFR3eFvjlPp+pp78nC2ZKGYWLV+M5p
         dO1A==
X-Gm-Message-State: AOPr4FUbiz50X8mlvpUcSeo5ezcWwsZQXHOhbqo1qT5O64W05MzjvJusMxGRhebJOZgFzQ==
X-Received: by 10.98.88.66 with SMTP id m63mr13330403pfb.79.1463843129204;
        Sat, 21 May 2016 08:05:29 -0700 (PDT)
Received: from [192.168.123.90] (c-98-210-100-59.hsd1.ca.comcast.net. [98.210.100.59])
        by smtp.gmail.com with ESMTPSA id o6sm34774065pfo.64.2016.05.21.08.05.27
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2016 08:05:27 -0700 (PDT)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295231>

I recently had a problem with SmartGIt that I think is related to the M=
ac version of the Git install, or perhaps git itself. Its hard for me t=
o tell. Here is the recreation steps:

- Install a clean El Capitan
- Install the latest SmartGit
- Install the latest Mac OS Git from the Git website
- enable the keychain credential helper (perhaps as a global git option=
)
- Set the SmartGit preference to point to the newly installed git in /u=
sr/local/bin such that it specifically starts that git.
- Try to push to a github repo that uses a keychain credential

Result: Multiple error messages that osxkeychain-credential is not a gi=
t command.

Running git from the command line in Terminal works fine.

The problem is that when SmartGit tries invokes git, it does it from a =
non-interactive shell, and in this mode, all the usual .profile and .ba=
sh_profile files are not sourced. I do not know where or if the MacOS g=
it installer is trying to put /usr/local/bin into the path, but its not=
 in the default path in non-interactive mode. Thus, git, when invoked i=
n non-interactive mode cannot find the credential-helper, since El Capi=
tain seems to come with version 2.7 by default, and that does not have =
a credential helper.=20

It was driving me crazy, because git worked perfectly fine from Termina=
l. The reason being, bash was reading my local .bash_profile where I wa=
s putting /usr/local/bin in the path.

So, the fix. Not so easy perhaps. Should the Git Mac OS installer put /=
usr/local/bin in the path for all invocations of shells? Probably OK if=
 it is last in line. It certainly isn=E2=80=99t there by default. Or ca=
n git itself be changed to look for a credential helper in the same loc=
ation as where git was invoked, if git is not in the path (in other wor=
ds, if git is specifically invoked with a path, like /usr/local/bin/git=
, should it not also look for the credential helper in the same place, =
even if /usr/local/bin is not in the PATH environment variable?).

Shannon Pekary
spekary@gmail.com
