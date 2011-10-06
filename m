From: Luiz-Otavio Zorzella <zorzella@gmail.com>
Subject: "Use of uninitialized value" running "git svn clone"
Date: Thu, 6 Oct 2011 10:23:19 -0700
Message-ID: <CAFjr8EsTFsnX2J51L0tofo_EuFyh70aeHu=Cs1xXkjGP12oz7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 19:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrfh-0003Q5-9f
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758730Ab1JFRXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:23:41 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57388 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758718Ab1JFRXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:23:40 -0400
Received: by vcbfk10 with SMTP id fk10so2402171vcb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=GGiFw/SXXZvkIuKGzfxwlV9sN7wya80se4V0l9gTPDg=;
        b=nB0R569Q/w/LuYdRJMyItFbtuA8+cisyZt9Yz9j2HTMRfI4WVug2zsG66skdxWhSra
         TGfEXCwg7+PZTBZ9DnM3b+nwLKSb7WvrporoyzZISElcNVBPW2982y/LXIpuTt3SWe+e
         zTVzyhUPOtNdbwXn+TGiyqINp3EnUTlWBHr7w=
Received: by 10.52.75.34 with SMTP id z2mr946985vdv.297.1317921819159; Thu, 06
 Oct 2011 10:23:39 -0700 (PDT)
Received: by 10.52.36.142 with HTTP; Thu, 6 Oct 2011 10:23:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182990>

I'm trying to convert a project (hosted in googlecode.com) from svn to
git, using the "git svn clone" command, and I'm getting an "Use of
uninitialized value" error. Here's the truncated output:

$ git svn clone https://test-libraries-for-java.googlecode.com/svn
--no-metadata -A ~/tmp/authors.txt -t tags -b branches -T trunk
test-libraries-for-java
r1 = c3adafa93a420f19b1bcfb6765fe0eb90aaa751c (refs/remotes/trunk)
	A	.classpath
	A	.project
	A	COPYING
	A	build.properties
	A	build.xml
W: +empty_dir: trunk/src
[...]
r10 = 8d5d7fdebdb7f822388fd3e4f4061abbfd1fb0cf (refs/remotes/trunk)
	M	test/com/google/common/testing/junit3/JUnitAssertsTest.java
r11 = 4c8a77660bf353ed55c9d583b39e263203c685a4 (refs/remotes/trunk)
Found possible branch point:
https://test-libraries-for-java.googlecode.com/svn/trunk =>
https://test-libraries-for-java.googlecode.com/svn/tags/release-1.0,
11
Use of uninitialized value $u in substitution (s///) at
/usr/lib/git-core/git-svn line 1731.
Use of uninitialized value $u in concatenation (.) or string at
/usr/lib/git-core/git-svn line 1731.
refs/remotes/trunk:
'https://test-libraries-for-java.googlecode.com/svn' not found in ''

For completeness, here's the authors.txt file I'm using:

$ cat ~/tmp/authors.txt
zorzella = Luiz-Otavio 'Z' Zorzella <zorzella@gmail.com>
(no author) = Luiz-Otavio 'Z' Zorzella <zorzella@gmail.com>

**************

Thanks in advance,

Z
