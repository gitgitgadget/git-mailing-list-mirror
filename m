From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Sat, 29 Jan 2011 21:26:16 +0100
Message-ID: <4D4477E8.8030703@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx> <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx> <7v1v3wd1al.fsf@alter.siamese.dyndns.org> <4D437CA0.1070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Jan 29 21:26:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjHNq-0001Hh-7F
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 21:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab1A2U0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 15:26:48 -0500
Received: from india601.server4you.de ([85.25.151.105]:60706 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1A2U0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 15:26:47 -0500
Received: from [192.168.2.104] (p4FFDB056.dip.t-dialin.net [79.253.176.86])
	by india601.server4you.de (Postfix) with ESMTPSA id B39ED2F80DC;
	Sat, 29 Jan 2011 21:26:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D437CA0.1070006@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165670>

Am 29.01.2011 03:34, schrieb Ren=C3=A9 Scharfe:
> Am 29.01.2011 01:02, schrieb Junio C Hamano:
>> Let's look at the original code before your patch again.
>>
>>  1. If all the parents of a commit are the same, we will see (tree_s=
ame &&
>>     !tree_changed), so we get TREESAME.
>>
>>  2. If some but not all of the parents are the same, we will see (tr=
ee_same
>>     && tree_changed), and we end up getting TREESAME.
>>
>>  3. If none of the parents is the same, (!tree_same && tree_changed)=
 holds
>>     true, and we do not get TREESAME.
>=20
> For completeness, a fourth case (!tree_same && !tree_changed), which
> would be triggered by commits whose parents are all classified as
> REV_TREE_NEW.  That's another corner case for sure, but the old code
> would mark it TREESAME and your patch changes that.

Ugh, forget this part, I failed to notice the /* fallthrough */ at the
end of the REV_TREE_NEW case..

Ren=C3=A9
