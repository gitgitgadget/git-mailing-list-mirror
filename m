From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: start of git2 (based on libgit2)
Date: Fri, 25 Mar 2011 23:12:03 +0000
Message-ID: <20110325231203.GA7961@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 00:12:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3GAt-0004At-Dc
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 00:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab1CYXMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 19:12:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49141 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1CYXME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 19:12:04 -0400
Received: by wwa36 with SMTP id 36so1907220wwa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=+GVulWTcVUAXdkGWg8hvZKdaV5dKoQKL+7cWPd6ioo4=;
        b=lwoimaHqRk2qYYuICAt27ysny4QIDNFZQ3RwlQm9RNbpW9cQb7XacaSxAkltXvkGU8
         3NpwyTxyCKobS/lYLuXlO/LetiqBzI8gLjl2bJVs6qp1F9Gvl7RRi5YjQ62UY4NcLxMD
         8UNMKK4z5F/1Ixkt/Wv4EtnH6bl5dZXda/V9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=mCTyl8SQHy4cBHFaSmiZ4cmaxrFGXb8Tl2Qe7Sm2BulAtQ5VHU3YhoDFd7bRVhNrmn
         WEb2RXAAzS+VuLe07BQewEe9MePR5aZ/eeIAGEbv/aU34048Ky3QNERBv7hNMW0Vrxan
         Zx//3dhe8WM5C7uYH4z2qozPpNvbbZd7d9moo=
Received: by 10.227.53.206 with SMTP id n14mr1266694wbg.14.1301094723012;
        Fri, 25 Mar 2011 16:12:03 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id u9sm674902wbg.51.2011.03.25.16.12.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 16:12:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170032>

Hello,

I wrote similar letter before, but did not receive feedback I was expec=
ting.

I think libgit2 is an amazing thing, and I started writing[1] cli clien=
t for
it. This is what it can do now:
    $ git2 rev-list <anything>

Which is roughly equivalent to:
    $ git rev-list HEAD

I do not know how it will figure out past merge history, but that's for
the future.

I want to get started with it, but before that I want and discuss some
architectural questions.

According to Jeff King[2], I should start with plumbing commands. I
agree.  However, how deep?  I.e. do I have to make sure all git rev-lis=
t
possible arguments are implemented?

Are we aiming for a distributed 100s of executables architecture
(current git), or single huge binary? I would go for single executable
for to higher portability. Is that ok?

Build tool. Currently libgit2 uses waf. I am not against it (I've chose=
n
waf for one of my own C++ projects), However, it's too clumsy for me. I=
s
it me who lacks experience? Scons looks much easier for me. Moreover, w=
e
do not need automatic configuration, so it makes waf "overfeatured".

Build configuration. Git-send-email is not really a must-have for an
embedded device, so we should be able to specify these features in
configure-time. How do you think it should be taken care of?

1) <buildtool> configure  --disable-everything --enable-email
2) make menuconfig and enjoy the blue screen of choice
3) anything else?

Waiting for your answers, will go on working.

I am a student and would like to do this take this up in GSOC. I just
received a letter from Vicent Marti with sort of confirmation that the
project is interesting for the community. I'm happy about it.  Currentl=
y
I am a full-time python programmer, but have done some C++. I created
SoundPatty[3], a real-time sound recognition (record) application for m=
y
job VoIP recognition needs.

In case you have any questions, opinions, please ask. Thank you.

[1] https://github.com/Motiejus/git2/
[2] http://marc.info/?l=3D3Dgit&m=3D3D130081966214059&w=3D3D4
[3] https://github.com/Motiejus/SoundPatty/=20
[CV] http://m.jakstys.lt/

Motiejus Jak=C5=A1tys
