From: tzachi perelstein <tzachi_perelstein@yahoo.com>
Subject: Re: git-describe recognize modified files
Date: Tue, 19 Jan 2010 04:59:17 -0800 (PST)
Message-ID: <780857.77695.qm@web45209.mail.sp1.yahoo.com>
References: <829260.92036.qm@web45202.mail.sp1.yahoo.com> <alpine.DEB.1.00.1001191134130.3164@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 13:59:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXDg3-0004GK-7W
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 13:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab0ASM7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2010 07:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458Ab0ASM7T
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 07:59:19 -0500
Received: from web45209.mail.sp1.yahoo.com ([68.180.197.122]:48589 "HELO
	web45209.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751033Ab0ASM7S convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 07:59:18 -0500
Received: (qmail 79178 invoked by uid 60001); 19 Jan 2010 12:59:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1263905957; bh=ysv34jDNOxEGGlioM7g1HROi2QpPfEKET8hRdQ+9Fi0=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=OuccX88bAeg7RPCabWbSSV2hCq4c7LOluB8/MlhQdSvIsGzfG4ax8o8BTzOUptd6LjN2bmw35JiKz2zuax+yHc9btupY/u8kmJF/bdFARjirJQOsJR8CZHZ8zd8czqFNS539a9u3g5+4NR9FtORAI40cv8Uwi3gI1dwj5QXAZ7c=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1rXBu2dmlFgUra5BjA/9IZNCS3lPF4nd3jWKFkVxt0uvWQ/mFFpjJpyg5L4rIKnbrHdHa5nn9FhtGZI+2bg6PyxIHC6kyzz0w6zmhOJEr7xvOltZZGxvcRWqTHGFi31yJV5Qusif4GqLkLVkHr7t009+acdFEsWVTYR7ZcR7kOo=;
X-YMail-OSG: h4h9OogVM1nG6_DnuIYcsQCaoe0uY2H9npu_2pV8lQfVe3xlLOk1joJy3_znZV0zCYUvq_rw1a3t2W.eKAjP1dH7G43gy.m1YsnpiSEQfB3dXhsDIqX5UIe6amNOisYAzYC4WqpQvWCC7t6k9hxx847H3Bmf0O4MaeEroNhH20qPMGl6YgdhMBzVmzoE7QOpwWixH6kGnhPVen75g5au5kGEAr2Qj_Cz7X1cIrOxRfR6dC5lB6hSgo2veq.8QUBk76A.roByjfDzZ5xxQ5hmqjjzz_NUTIu0SH8sWCJC4WDw8z9NNMIBiA--
Received: from [80.179.89.178] by web45209.mail.sp1.yahoo.com via HTTP; Tue, 19 Jan 2010 04:59:17 PST
X-Mailer: YahooMailRC/272.7 YahooMailWebService/0.8.100.260964
In-Reply-To: <alpine.DEB.1.00.1001191134130.3164@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137454>

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> To: tzachi perelstein <tzachi_perelstein@yahoo.com>
> Cc: git@vger.kernel.org
> Sent: Tue, January 19, 2010 12:35:41 PM
> Subject: Re: git-describe recognize modified files
>=20
> Hi,
>=20
> On Tue, 19 Jan 2010, tzachi perelstein wrote:
>=20
> > I use git-describe to form a build version automatically. This allo=
ws me
> > to deliver temporary builds for testing without having to make manu=
al
> > tags for them. The only thing that bothers me about this is that fr=
om
> > the output of git-describe I cannot tell if there are some modified
> > files in tree or not. In both cases I will get the same version.=20
> >=20
> > To solve this issue, in addition to git-describe, my do_version scr=
ipt
> > also run git-status, and if there are "modified:" files then it
> > concatenates the string "+dirty" to output of git-describe.
>=20
> The problem is that this does not describe the exact version you used=
 very=20
> well.=A0 If you are really serious about describing the exact state y=
ou=20
> described, make a tag (committing the changes to a detached HEAD firs=
t, if=20
> you do not want the changes in a real branch).
>=20


Well yes, this is valid, but you will end up with a tag for every build=
=2E.. this goes way too far.

Consider the case where you have no modified files in your tree. The ou=
tput of git-describe at some given point is 'v1.0.0-2-g123457' and duri=
ng the build it becomes the build version. Now you make some changes, b=
ut before committing them you build, install, and run a test. During th=
e second build, the output of git-describe remains the same 'v1.0.0-2-g=
123457' although it represent two different trees. This behavior looks =
like somewhat incomplete to me. It sounds reasonable to me to let git-d=
escribe have the option of indicating about modified files in tree, say=
=A0'v1.0.0-2-g123457-modified' or something similar. While 'v1.0.0-2-g1=
23457' is something you and git can refer to (i.e. checkout), 'v1.0.0-2=
-g123457-modified' is not. By adding the "-modified" string, git tells =
you explicitly that it cannot fully describe the exact tree you're usin=
g.



     =20
