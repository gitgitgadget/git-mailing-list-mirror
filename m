From: Luiz-Otavio Zorzella <zorzella@gmail.com>
Subject: "Use of uninitialized value" running "git svn clone" when having svn
 tag branches
Date: Fri, 7 Oct 2011 11:01:22 -0700
Message-ID: <CAFjr8Eu5rZ-Fv4Zo__8k577vWf7VmKboBPbK6BJ2vwA8zuhHUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 20:01:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCEk0-00065b-Dh
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 20:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396Ab1JGSBo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 14:01:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58200 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab1JGSBn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 14:01:43 -0400
Received: by vws1 with SMTP id 1so3334406vws.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=6f5OSK8Q0Bskxqb/gSb2lZn67WEln0RNZa/rP6Bnd5Q=;
        b=umDk1o2RndMcbdM7ijo5vxKCzB8r072waWz2O4gWs2VGrzCgsBFEwOxvL3A/twpoPo
         srfFEYsO/FufDEleEigoXG9LaHvTbN3GEssfWvn96PkF6cVytQTlVurqhcNuw9bNSpHA
         27Jge35xibRmU2YxYCTUb+hkXiUfzkhRi4Rqg=
Received: by 10.52.32.195 with SMTP id l3mr3813440vdi.30.1318010502067; Fri,
 07 Oct 2011 11:01:42 -0700 (PDT)
Received: by 10.52.36.142 with HTTP; Fri, 7 Oct 2011 11:01:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183093>

I'm trying to convert a project (hosted in googlecode.com) from svn to
git, using the "git svn clone" command, and I'm getting an "Use of
uninitialized value" error. Here's the truncated output:

$ git svn clone https://test-libraries-for-java.googlecode.com/svn
--no-metadata -A ~/tmp/authors.txt -t tags -b branches -T trunk
test-libraries-for-java
 r1 =3D c3adafa93a420f19b1bcfb6765fe0eb90aaa751c (refs/remotes/trunk)
=A0 =A0 =A0 =A0A =A0 =A0 =A0 .classpath
=A0 =A0 =A0 =A0A =A0 =A0 =A0 .project
=A0 =A0 =A0 =A0A =A0 =A0 =A0 COPYING
=A0 =A0 =A0 =A0A =A0 =A0 =A0 build.properties
=A0 =A0 =A0 =A0A =A0 =A0 =A0 build.xml
W: +empty_dir: trunk/src
[...]
r10 =3D 8d5d7fdebdb7f822388fd3e4f4061abbfd1fb0cf (refs/remotes/trunk)
=A0 =A0 =A0 =A0M =A0 =A0 =A0 test/com/google/common/testing/junit3/JUni=
tAssertsTest.java
r11 =3D 4c8a77660bf353ed55c9d583b39e263203c685a4 (refs/remotes/trunk)
=46ound possible branch point:
https://test-libraries-for-java.googlecode.com/svn/trunk =3D>
https://test-libraries-for-java.googlecode.com/svn/tags/release-1.0,
11
Use of uninitialized value $u in substitution (s///) at
/usr/lib/git-core/git-svn line 1731.
Use of uninitialized value $u in concatenation (.) or string at
/usr/lib/git-core/git-svn line 1731.
refs/remotes/trunk:
'https://test-libraries-for-java.googlecode.com/svn' not found in ''

=46or completeness, here's the authors.txt file I'm using:

$ cat ~/tmp/authors.txt
zorzella =3D Luiz-Otavio 'Z' Zorzella <zorzella@gmail.com>
(no author) =3D Luiz-Otavio 'Z' Zorzella <zorzella@gmail.com>

**************

The same command works fine if I don't use the "-t tags" part, but
then it does not create the tag branches in my converted git.

Thanks in advance,

Z
