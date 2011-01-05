From: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Subject: Re[2]: [PATCH 2/3] Fixes bug: git-svn: svn.pathnameencoding is not respected with dcommit/set-tree
Date: Wed, 5 Jan 2011 14:44:17 +0300
Message-ID: <707440142.20110105144417@mail.ru>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-2-git-send-email-zapped@mail.ru> <201101041818.09365.trast@student.ethz.ch>
Reply-To: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 12:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaRmZ-0004FN-FC
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 12:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1AELny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 06:43:54 -0500
Received: from smtp6.mail.ru ([94.100.176.48]:48807 "EHLO smtp6.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab1AELnx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 06:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=7H0wz99FRolXZ8OMxVDQ9D9R/NvsiVt5KN+x10QalRE=;
	b=aYQB8i7my+Mt4IuUdRkeWiD1hJhMbpkaSNTS4qxWvsPeWWd5vc8MyML/hACLN51gtIzoi2ViHqa/XFNe87lRuS95zwFdu+p7NMvW6f+YgSGfo4Q2HaES6D+67GuBgj6K;
Received: from [85.140.55.58] (port=40815 helo=ppp85-140-55-58.pppoe.mtu-net.ru)
	by smtp6.mail.ru with asmtp 
	id 1PaRmR-0008HO-00; Wed, 05 Jan 2011 14:43:51 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <201101041818.09365.trast@student.ethz.ch>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164559>

As I already said I'm newbie in submitting/distributing patches
but I'll try :)

Tuesday, January 4, 2011, 8:18:09 PM, you wrote:

TR> Zapped wrote:
>> git-svn dcommit/set-tree fails when svn.pathnameencoding is set for =
native OS encoding (e.g. cp1251 for Windows) though git-svn fetch/clone=
 works well

TR> I'll let Eric judge whether loading the encoding here is the right
TR> fix, but here too the commit message states only what is broken, no=
t
TR> why you fixed it that way.  Can you elaborate a bit?

TR> Also, this should be easy to cover with a test case, can you make o=
ne?

>>  git-svn.perl |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 757de82..399bf4c 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -4451,6 +4451,7 @@ sub new {
>>       $self->{path_prefix} =3D length $self->{svn_path} ?
>>                              "$self->{svn_path}/" : '';
>>       $self->{config} =3D $opts->{config};
>> +     $self->{pathnameencoding} =3D Git::config('svn.pathnameencodin=
g');
>>       return $self;
>>  }
>> =20
>>=20



--=20
=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC,
 =C0=EB=E5=EA=F1=E5=E9 =D8=F3=EC=EA=E8=ED                            ma=
ilto:zapped@mail.ru
