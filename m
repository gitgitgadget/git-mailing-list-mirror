From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: git merge <tag> behavior
Date: Fri, 22 Mar 2013 10:16:20 +0100
Organization: OPTEYA
Message-ID: <cdc4f45e7520ce1fc48588c260214717@meuh.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <loom.20130321T212911-611@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Max Nanasy <max.nanasy@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 10:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIy5l-0004zj-6g
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 10:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab3CVJQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 05:16:24 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:60644 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab3CVJQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 05:16:23 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1UIy5E-000A96-8j; Fri, 22 Mar 2013 10:16:20 +0100
In-Reply-To: <loom.20130321T212911-611@post.gmane.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218786>

Hi,

Le 21.03.2013 21:31, Max Nanasy a =C3=A9crit=C2=A0:
> Yann Droneaud <ydroneaud <at> opteya.com> writes:
>
>>
>> 3) Merge options can't be overridden.
>>
>> If I modify .git/config to set a merge option, for example forcing
>> fast-forward merge, this option cannot be overridden on command=20
>> line:
>>
>
> (git merge --no-ff-only --no-ff) should work.  The --no-ff-only=20
> overrides
> the --ff-only configuration setting, and the --no-ff ensures that the=
=20
> merge
> is not a fast-forward.
>

Thanks. I wasn't aware of the --no-ff-only option and
thought --no-ff would be the opposite of --ff-only,
or at least disable it given the order of the options.

Please find a patch to document option --no-ff-only

   Documentation/merge-options.txt | 4 ++++
   1 file changed, 4 insertions(+)

diff --git a/Documentation/merge-options.txt
b/Documentation/merge-options.txt
index 0bcbe0a..20a31cf 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -37,6 +37,10 @@ set to `no` at the beginning of them.
  	current `HEAD` is already up-to-date or the merge can be
  	resolved as a fast-forward.

+--no-ff-only::
+	Disable `--ff-only` behavior, eg. allows creation of merge commit.
+	This is the default behavior.
+
   --log[=3D<n>]::
   --no-log::
  	In addition to branch names, populate the log message with
