From: Dave Bradley <dbradley2@bell.net>
Subject: #178  parsing of pretty=format:"%an %ad" causes fatal: bad revision '%ad'
Date: Fri, 2 May 2014 07:50:25 -0400
Message-ID: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 02 13:55:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgC44-00048h-Ai
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 13:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaEBLzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 07:55:36 -0400
Received: from blu0-omc3-s10.blu0.hotmail.com ([65.55.116.85]:37052 "EHLO
	blu0-omc3-s10.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733AbaEBLzf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 May 2014 07:55:35 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 May 2014 07:55:35 EDT
Received: from BLU0-SMTP11 ([65.55.116.73]) by blu0-omc3-s10.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 2 May 2014 04:50:28 -0700
X-TMN: [lYoyi0sKMZoG5XsiVyPX2lKgksYJM4w3]
X-Originating-Email: [dbradley2@bell.net]
Received: from prbrad2 ([70.54.91.155]) by BLU0-SMTP11.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 2 May 2014 04:50:28 -0700
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3522.110
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3522.110
X-OriginalArrivalTime: 02 May 2014 11:50:28.0884 (UTC) FILETIME=[B6B9FD40:01CF65FC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247932>

Hi,

I=E2=80=99m very new to =E2=80=98git=E2=80=99 github. I reported the #1=
78 issue in github and the=20
issue has been closed, I believe this means no further discussion.

There are a three additional comments, thank you to the contributors. T=
he=20
advise was to discuss upstream which meant nothing to me (again thanks =
to=20
another contributor for clarification).

Summary
------------
The issue reported is (in my opinion) a defect in argument processing=20
(happens on Windows and Linux (as per another contributor)).

The issue (in my opinion) is a defect for argument processing by Git. T=
he=20
decision (agreement or otherwise) I guess is for this upstream discussi=
on.

I appreciate the open-source git and its usage to the community. But th=
is is=20
owned by the discussion group and I doubt my involvement is wanted. So =
this=20
will be my last communication on this issue.

Context
----------
Over many years, I=E2=80=99ve used command-line on Unix/Linux/Windows i=
n both hobby=20
and professional modes. In the latter case the processing of arguments =
with=20
spaces has often been the cause of defects (none expected behaviour) fo=
r=20
newly introduced products.

I=E2=80=99ve found no documentation about the pretty=3Dformat behaviour=
 as described=20
by the #178 issue. Also, there are many (but incomplete) google-it=20
second-hand documents(?) about. So a document fix in the internet age i=
s not=20
necessarily the approach to solve an issue, as all those google-it item=
s=20
create fog.

=46or this issue I was processing a git command to run in a GUI and hap=
pened=20
upon it. The GUI (original design by me) allows interfacing with CVS, S=
VN,=20
HG and maybe now GIT in a similar manner. The GUI holds the interfacing=
 and=20
access information and concatenates it onto the VCS command/sub-command=
s as=20
appropriate for a request. Thus, the concatenated VCS request may be=20
processed for copy-paste onto a command line window/terminal or (for my=
 GUI)=20
executed via a programming language=E2=80=99s command-line-execution cl=
ass/function=20
(Perl, Java, C,.....).

With the argument being further processed within git, it behaves in a m=
anner=20
that wasn=E2=80=99t expected.


Thx
Dave

the Issue as reported


Getting a fatal failure when using the following --pretty=3Dformat:"%an=
 %ad"=20
via a programmed execution from within a programming language. (Java us=
ing=20
the execution capabilities puts the ' --pretty=3Dformat:"%an %ad" ' as =
an=20
argument). This is reproduced on a Windows command-line entry by puttin=
g=20
double-quotes around the argument. (see below for various examples of p=
ass,=20
fail and testing around).

The git argument parser appears to perform a split on spaces within the=
=20
arguments passed to it also. This is not a normal behaviour for any par=
sing.=20
Also, the split is happening within a string quote, it would appear ("%=
an=20
%ad").
Even tried %20 to represent the space.

Thx

G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git=20
log --all --pretty=3Dformat:"%an %ad" -- pom.xml
xxxx xxxx Mon Nov 23 03:09:17 2009 +0000
xxxx xxxx Mon Nov 23 02:42:24 2009 +0000

G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all=20
"--pretty=3Dformat:"%an %ad"" -- pom.xml
fatal: bad revision '%ad'

G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all=20
"--pretty=3Dformat:"%an" "%ad"" -- pom.xml
xxxx xxxx Mon Nov 23 03:09:17 2009 +0000
xxxx xxxx Mon Nov 23 02:42:24 2009 +0000

G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all=20
"--pretty=3Dformat:"%an" " %ad"" -- pom.xml
fatal: bad revision '%ad'

G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all=20
"--pretty=3Dformat:"%an" "%ad"" -- pom.xml
xxxx xxxx Mon Nov 23 03:09:17 2009 +0000
xxxx xxxx Mon Nov 23 02:42:24 2009 +0000
