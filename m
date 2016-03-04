From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 04 Mar 2016 11:12:23 -0800
Message-ID: <xmqqbn6uys4o.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 20:12:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abv9L-0002Ct-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 20:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757AbcCDTM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 14:12:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758491AbcCDTM0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 14:12:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59146481EA;
	Fri,  4 Mar 2016 14:12:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Km+pD3OUmzcc
	VWZknGQEfNfB5mA=; b=Hou+Ku2T/BasiJC9HpSxE5xMnrK0mQSDJLzNY9W26eNm
	olVVjnJCaC8ofGx+t4Fu49vD6K+LYmD/lQYhb+/5IN+JMgmK3kftxqXOF4DBRXlM
	1fUVv3kH5AvKRhSERZ0s+Pi5xKkgCxA5jpaUFqenz3VfxLKt71Z8ugsUKuJjNQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ocCaei
	6nC4BuJSQb35euhbTF1qDE+2HfNGKBtUsTjyQNTrBwDNfxr4wWv/vGTihdGXttLv
	qZV2kvoX8BxrsauUacHAF5g8KEMi9NucPiBez5em557MVd7f8tG/gX33xXU3ETiV
	J048il4iEC8YgXXEE/+WQ/OQ/bMtALDsAZqaA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 509ED481E9;
	Fri,  4 Mar 2016 14:12:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2651481E7;
	Fri,  4 Mar 2016 14:12:24 -0500 (EST)
In-Reply-To: <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 04 Mar 2016 09:28:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07586750-E23D-11E5-886D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288273>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Mar 4, 2016 at 6:56 PM, Kevin Daudt <me@ikke.info> wrote:
>>> Verified that it's different in 2.7.0, but 2.7.2 gives expected out=
put.
>>
>> Thanks. 2.7.1 reverts the faulty commit from 2.7.0 that generated tw=
o
>> other regression reports before this one. I guess it's all good then
>> (except for the people still on 2.7.0)
>
> Are we good at 2.8.0-rc0, too?  Somehow I had an impression that we
> queued "another attempt to do it differently" or something.
>
>  ... goes and looks ...
>
>     $ rungit maint status -suall
>     ?? baz/quux/corge/wibble.txt
>     ?? baz/quux/grault.txt
>     ?? foo/bar.txt
>     $ rungit master status -suall
>     ?? baz/quux/corge/wibble.txt
>     ?? baz/quux/grault.txt
>     ?? baz/waldo.txt
>     ?? foo/bar.txt
>     ?? foo/garply.txt

It seems to bisect down to this one between maint..master:

commit a60ea8fb66945a886ea53fd3f41e61cc5fb3201e
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Mon Feb 15 16:03:36 2016 +0700

    dir.c: fix match_pathname()
   =20
    Given the pattern "1/2/3/4" and the path "1/2/3/4/f", the pattern
    prefix is "1/2/3/4". We will compare and remove the prefix from bot=
h
    pattern and path and come to this code
   =20
        /*
         * If the whole pattern did not have a wildcard,
         * then our prefix match is all we need; we
         * do not need to call fnmatch at all.
         */
        if (!patternlen && !namelen)
                return 1;
   =20
    where patternlen is zero (full pattern consumed) and the remaining
    path in "name" is "/f". We fail to realize it's matched in this cas=
e
    and fall back to fnmatch(), which also fails to catch it. Fix it.
   =20
    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

But I do not think this change alone is the culprit; the change
itself does make sense in the context of the series.

At this point, we have two choices.  Either we revert the merge of
the whole series:

    commit 5e57f9c3dfe7dd44a1b56bb5b3327d7a1356ec7c
    Merge: e79112d d589a67
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Wed Feb 24 13:25:59 2016 -0800

        Merge branch 'nd/exclusion-regression-fix'

        Another try to add support to the ignore mechanism that lets yo=
u
        say "this is excluded" and then later say "oh, no, this part (t=
hat
        is a subset of the previous part) is not excluded".

        * nd/exclusion-regression-fix:
          dir.c: don't exclude whole dir prematurely
          dir.c: support marking some patterns already matched
          dir.c: support tracing exclude
          dir.c: fix match_pathname()

to go back to the 2.7.2 behaviour, or add a follow-on change to the
nd/exclusion-regression-fix topic to fix what it wanted to fix
without breaking Charles's use case.  I am inclined to go for the
former (unless the follow-on fix is really trivial), but I haven't
dug into the codebase myself yet, so...
