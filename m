From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: cmd_cherry in builtin/log.c?
Date: Thu, 09 Dec 2010 22:14:34 +0100
Message-ID: <4D0146BA.2090801@lsrfire.ath.cx>
References: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com> <20101207173923.GA21483@burratino> <4CFE83A2.8070004@lsrfire.ath.cx> <7vaakhpbq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Dec 09 22:14:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnpD-00013R-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab0LIVOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 16:14:47 -0500
Received: from india601.server4you.de ([85.25.151.105]:56892 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab0LIVOq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:14:46 -0500
Received: from [10.0.1.101] (p4FFDA1CE.dip.t-dialin.net [79.253.161.206])
	by india601.server4you.de (Postfix) with ESMTPSA id D28C02F80C1;
	Thu,  9 Dec 2010 22:14:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vaakhpbq2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163322>

Am 07.12.2010 21:30, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Am 07.12.2010 18:39, schrieb Jonathan Nieder:
>>> while the core of the builtin version is
>>>
>>> 	get_patch_ids(&revs, &patch_id_opts, prefix);
>>>
>>> The latter function is static, introduced by v1.4.1~12^2~5
>>> (format-patch: introduce "--ignore-if-in-upstream", 2006-06-25).
>>>
>>> So the answer is that "git cherry" is considered a variant on
>>> "git log" (like format-patch, show, and whatchanged) and that it us=
es
>>> "git log" internals.
>>
>> That's right.  get_patch_ids() could be moved into patch-ids.c now a=
nd
>> then cmd_cherry() could get its own file in builtin/, though.
>=20
> Right, but the key word is "could".  Is it hurting _anything_ to have=
 it
> in the current place?  I doubt it.

Indeed.  Moving cherry's code into its own file is be a code clean up.
There would be no benefit to users, future developers should have a
somewhat easier time navigating the code while any developers currently
working on the code would get it pulled from under them.

Such a clean up can be useful to include at the start of a patch series
that contains actual user visible improvements.

Ren=C3=A9
