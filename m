From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (May 2012, #06; Wed, 23)
Date: Thu, 24 May 2012 07:59:02 +0200
Message-ID: <4FBDCE26.1080904@viscovery.net>
References: <7vmx4yzgce.fsf@alter.siamese.dyndns.org> <4FBDC8FA.9050501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 24 07:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXR4t-0008Te-3b
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 07:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2EXF7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 01:59:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51713 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab2EXF7H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 01:59:07 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SXR5X-0003Vp-8H; Thu, 24 May 2012 07:59:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A31761660F;
	Thu, 24 May 2012 07:59:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FBDC8FA.9050501@lsrfire.ath.cx>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198355>

Am 5/24/2012 7:36, schrieb Ren=E9 Scharfe:
> Am 24.05.2012 00:24, schrieb Junio C Hamano:
>> * rs/maint-grep-F (2012-05-21) 4 commits
>>    (merged to 'next' on 2012-05-23 at b24143c)
>>   + grep: stop leaking line strings with -f
>>   + grep: support newline separated pattern list
>>   + grep: factor out do_append_grep_pat()
>>   + grep: factor out create_grep_pat()
>>
>> "git grep -F", unlike the case where it reads from a file, did not t=
reat
>> individual lines in the given pattern argument as separate patterns =
as it
>> should.
>=20
> This is not specific to -F; grep(1) accepts newline-separated pattern
> lists with -E etc. as well, as does git grep with the patches above.

Shouldn't we worry that this change breaks existing users?

Consider a script that generates a pattern that sometimes contains NL.
Yes, it would not match anywhere, but what if that is a deliberate choi=
ce
of the script writer? With this change, the script would now observe
spurious matches where earlier there were no matches.

-- Hannes
