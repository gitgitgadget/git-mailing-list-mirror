From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re* [PATCH] man: git pull -r is a short for --rebase
Date: Fri, 17 Aug 2012 19:22:04 +0100
Organization: OPDS
Message-ID: <4E6C3BEFBD5345CC9FE0DC3C3AD41788@PhilipOakley>
References: <20120816095018.GD5489@suse.cz> <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <2BB1E674DD214C66B06660612F34109D@PhilipOakley> <7vk3wy1t7l.fsf@alter.siamese.dyndns.org> <B7310EA0CC00423EB5B26E3FAAB54541@PhilipOakley> <7vfw7mvy40.fsf_-_@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01CE_01CD7CAD.957AC590"
Cc: "Miklos Vajna" <vmiklos@suse.cz>, "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 20:22:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2RBS-0003Ws-M0
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 20:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765Ab2HQSWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 14:22:05 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:37638 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758706Ab2HQSWB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2012 14:22:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuAKAMpvLlBZ8rLq/2dsb2JhbABFi0CuBQJ1gQiCGwUBAQUIAQFMAiELAgMFAgEDEQMBAQEKJRQBBBoGBw8IBhMIAgECAwGGAIIAukeLC4FqPYN0YAOIGYVCf5cHgmGBYA
X-IronPort-AV: E=Sophos;i="4.77,785,1336345200"; 
   d="scan'208,223";a="548217688"
Received: from host-89-242-178-234.as13285.net (HELO PhilipOakley) ([89.242.178.234])
  by out1.ip06ir2.opaltelecom.net with SMTP; 17 Aug 2012 19:21:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203639>

This is a multi-part message in MIME format.

------=_NextPart_000_01CE_01CD7CAD.957AC590
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, August 17, 2012 7:19 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>> Sent: Thursday, August 16, 2012 9:23 PM
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>> I wasn't aware of the  "abbreviated options" capability. Is meant 
>>>> to
>>>> be in the man pages as I couldn't find it, or is it described
>>>> differently?
>>>
>>> $ git help gitcli
>>>
>>> is the closest that comes to mind.
>>>
>>> If it is not reachable from "git help git", we may want to sprinkle
>>> some more linkgit:gitfoo[$n] around the documentation sources.  I
>>> didn't check.
>>>
>>
>> I eventually found a reference in the parse-options API to the fact 
>> that
>> 'Long options may be abbreviated, as long as the abbreviation is
>> unambiguous.'
>>
>> It may be worth bringing some of those parse-options API basics 
>> bullets'
>> forward into the gitcli page, if appropriate.
>
> OK, how about doing this?  Sort of killing two birds with one stone.
>
> -- >8 --
> Subject: [PATCH] gitcli: describe abbreviation of long options
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/gitcli.txt | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index ea17f7a..3e72a5d 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -62,6 +62,14 @@ scripting git:
>    `git log -1 HEAD` but write `git log -1 HEAD --`; the former will 
> not work
>    if you happen to have a file called `HEAD` in the work tree.
>
> + * many commands allow a long option "--option" to be abbreviated
> +   only to their unique prefix (e.g. if there is no other option
> +   whose name begins with "opt", you may be able to spell "--opt" to
> +   invoke the "--option" flag), but you should fully spell them out
> +   when writing your scripts; later versions of Git may introduce a
> +   new option whose name shares the same prefix, e.g. "--optimize",
> +   to make a short prefix that used to be unique no longer unique.
> +
>
> ENHANCED OPTION PARSER
> ----------------------
> -- 
> 1.7.12.rc3.2.gbd120e3

Acked-by: Philip Oakley philipoakley@iee.org

 I'd also suggest a patch to the 'git' page to bring out the command 
line interface man page, including an emphasis on each of the other 
information pages, along the lines of (probably managled/see attached):

 -- >8 --
From 655c6e968fc4bb497e7ade90f2d879aadec795d9 Mon Sep 17 00:00:00 2001
From: Philip Oakley <philipoakley@iee.org>
Date: Fri, 17 Aug 2012 17:53:48 +0100
Subject: Include 'see gitcli' link, and separate the other links

Provide a link to the git command line interface information,
and separate for readability, the differing Tutorial, User-manual,
and CVS instruction links.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git.txt |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index ca85d1d..75b35ce 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -22,11 +22,13 @@ unusually rich command set that provides both 
high-level operations
 and full access to internals.

 See linkgit:gittutorial[7] to get started, then see
-link:everyday.html[Everyday Git] for a useful minimum set of commands, 
and
-"man git-commandname" for documentation of each command.  CVS users may
-also want to read linkgit:gitcvs-migration[7].  See
-the link:user-manual.html[Git User's Manual] for a more in-depth
-introduction.
+link:everyday.html[Everyday Git] for a useful minimum set of commands.
+Use "man git-commandname" for documentation of each command, or "git 
help".
+
+CVS users may also want to read linkgit:gitcvs-migration[7].
+
+See the link:user-manual.html[Git User's Manual] for a more in-depth
+introduction, and linkgit:gitcli[7] for details of git's command line 
interface.

 The '<command>' is either a name of a Git command (see below) or an 
alias
 as defined in the configuration file (see linkgit:git-config[1]).
-- 
1.7.8.msysgit.0




------=_NextPart_000_01CE_01CD7CAD.957AC590
Content-Type: application/octet-stream;
	name="0001-Include-see-gitcli-link-and-separate-the-other-links.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Include-see-gitcli-link-and-separate-the-other-links.patch"

>From 655c6e968fc4bb497e7ade90f2d879aadec795d9 Mon Sep 17 00:00:00 2001=0A=
From: Philip Oakley <philipoakley@iee.org>=0A=
Date: Fri, 17 Aug 2012 17:53:48 +0100=0A=
Subject: Include 'see gitcli' link, and separate the other links=0A=
=0A=
Provide a link to the git command line interface information,=0A=
and separate for readability, the differing Tutorial, User-manual,=0A=
and CVS instruction links.=0A=
=0A=
Signed-off-by: Philip Oakley <philipoakley@iee.org>=0A=
---=0A=
 Documentation/git.txt |   12 +++++++-----=0A=
 1 files changed, 7 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/Documentation/git.txt b/Documentation/git.txt=0A=
index ca85d1d..75b35ce 100644=0A=
--- a/Documentation/git.txt=0A=
+++ b/Documentation/git.txt=0A=
@@ -22,11 +22,13 @@ unusually rich command set that provides both =
high-level operations=0A=
 and full access to internals.=0A=
 =0A=
 See linkgit:gittutorial[7] to get started, then see=0A=
-link:everyday.html[Everyday Git] for a useful minimum set of commands, =
and=0A=
-"man git-commandname" for documentation of each command.  CVS users may=0A=
-also want to read linkgit:gitcvs-migration[7].  See=0A=
-the link:user-manual.html[Git User's Manual] for a more in-depth=0A=
-introduction.=0A=
+link:everyday.html[Everyday Git] for a useful minimum set of commands.=0A=
+Use "man git-commandname" for documentation of each command, or "git =
help".=0A=
+=0A=
+CVS users may also want to read linkgit:gitcvs-migration[7].=0A=
+=0A=
+See the link:user-manual.html[Git User's Manual] for a more in-depth=0A=
+introduction, and linkgit:gitcli[7] for details of git's command line =
interface.=0A=
 =0A=
 The '<command>' is either a name of a Git command (see below) or an =
alias=0A=
 as defined in the configuration file (see linkgit:git-config[1]).=0A=
-- =0A=
1.7.8.msysgit.0=0A=
=0A=

------=_NextPart_000_01CE_01CD7CAD.957AC590--
