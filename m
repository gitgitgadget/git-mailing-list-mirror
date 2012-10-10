From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 14:12:54 +0200
Message-ID: <50756646.5060505@viscovery.net>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net> <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 14:13:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLv9x-0000XZ-29
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 14:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab2JJMM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 08:12:58 -0400
Received: from so.liwest.at ([212.33.55.24]:4602 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857Ab2JJMM6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 08:12:58 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TLv9j-0000F6-E2; Wed, 10 Oct 2012 14:12:55 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2FC691660F;
	Wed, 10 Oct 2012 14:12:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207406>

Am 10/10/2012 14:03, schrieb Nguyen Thai Ngoc Duy:
> On Wed, Oct 10, 2012 at 6:51 PM, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
>> Thanks for working on this issue!
>>
>> Am 10/10/2012 13:34, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy:
>>> +     linkgit:gitattributes[5]). Note that .gitattributes are only
>>> +     support for searching files in working directory.
>>
>> Does this mean it does not work for 'git grep --cached'? That would =
be a
>> real loss.
>=20
> I missed this case. I don't think it works correctly before as it
> reads worktree's .gitattributes instead of the index version. But at
> least we support reading .gitattributes from index. Patches coming
> soon.

Is there already an established definition which the "correct"
=2Egitattributes are? IIRC, everywhere else we are looking at the
=2Egitattributes in the worktree, regardless of whether the object at t=
he
path in question is in the worktree, the index, or in an old commit.

-- Hannes
