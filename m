From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: git diff returns fatal error with core.safecrlf is set to true.
Date: Mon, 24 Jun 2013 14:42:12 +0200
Organization: OPTEYA
Message-ID: <b8e932cba326588db09ebd0986913ac2@meuh.org>
References: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org>
 <7vobazo4ds.fsf@alter.siamese.dyndns.org>
 <7vip17ktyz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 14:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur668-000828-SG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 14:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab3FXMmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 08:42:17 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:50260 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3FXMmP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 08:42:15 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Ur661-0002oS-7W; Mon, 24 Jun 2013 14:42:13 +0200
In-Reply-To: <7vip17ktyz.fsf@alter.siamese.dyndns.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228807>

Hi,

Le 21.06.2013 23:57, Junio C Hamano a =C3=A9crit=C2=A0:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The helper may want to learn a way to be told to demote that error
>> to a warning.
>
> Perhaps something like this?
>

Thanks for the patch.

I run my test again, eg. run git diff after a rebase failure (see my=20
other mail about core.safecrlf),
I'm able to run git diff a get a meaningful output:

# git version 1.8.1.4
fatal: CRLF would be replaced by LF in test.

# git version 1.8.3.1.741.g635527f.dirty (eg. next + your patch)
warning: CRLF will be replaced by LF in test.
The file will have its original line endings in your working directory.
diff --git a/test b/test
index b043836..63ba10f 100644
--- a/test
+++ b/test
@@ -1,4 +1,4 @@
-Hello World 1
-Hello World 2
-Hello World 3
+Hello World 1
+Hello World 2
+Hello World 3
  Hello World 4
\ No newline at end of file

It seems better. The removed lines have CRLF EOL while the added line=20
have LF line ending characters.

Tested-By: Yann Droneaud <ydroneaud@opteya.com>


Regards.

--=20
Yann Droneaud
OPTEYA
