From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 07 Dec 2010 08:22:54 -0800 (PST)
Message-ID: <m3fwu9365i.fsf@localhost.localdomain>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
	<AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
	<7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
	<AANLkTinDyix3KEdLLGJEWQ8X+a3zQZOAiTh2mLf5wuvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:24:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0LB-0006Zy-GS
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab0LGQYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 11:24:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43658 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab0LGQYN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 11:24:13 -0500
Received: by fxm20 with SMTP id 20so77488fxm.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=dQmOVr4GxyRmyJnJQCgVp7PxRE/pgZY6k6ptgtAlSWE=;
        b=hJ/6YfCwjGR8u7sXsWPi9wbrRZR7onHap4IeVGhDE9GG3h9TVg95JlhhgDGODkMe1J
         3rza1ddXwPM3CIXpPLrlqyjsOIXdhgGWtO6fBVyGQ6Yas5LsgTyOh1JnWBJtHKOjDWRv
         mrOsUtNfw54+sqIMYLQVzf0XhQOUnqfQkvtpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=O3rfEtCCj8btogPSnm0l7wHloFe7LtPpwBXNW9FK8RMkir23ViXXuPC9HdkbozYkWm
         8Joe2Ej1p1+crHj1KcqmgSC9bN4j+ywBh2CcGZkvjXtzywEEaiNRN7cBKF5pIKWFhHbC
         xAOTFMnpuIm1JlUSC5p+5viHuGEJFL9kxM1gM=
Received: by 10.223.112.71 with SMTP id v7mr7380427fap.60.1291738975046;
        Tue, 07 Dec 2010 08:22:55 -0800 (PST)
Received: from localhost.localdomain (abws249.neoplus.adsl.tpnet.pl [83.8.242.249])
        by mx.google.com with ESMTPS id z25sm1977180fam.42.2010.12.07.08.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 08:22:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB7GLxAr017735;
	Tue, 7 Dec 2010 17:22:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB7GLj3U017731;
	Tue, 7 Dec 2010 17:21:45 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinDyix3KEdLLGJEWQ8X+a3zQZOAiTh2mLf5wuvQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163085>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> On Tue, Dec 7, 2010 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> On Tue, Dec 7, 2010 at 4:16 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>> +#define BRANCH_DELETION_LOG "DELETED-REFS"
>>>> +
>>>
>>> Should this special log be mentioned in git-update-ref.txt or
>>> gitrepository-layout.txt?
>>
>> Perhaps, but I wasn't sure if this patch itself is a good idea to be=
gin
>> with. =A0Not the problem it tries to solve, but its approach.
>>
>> For example, this cannot be shown with "reflog show" or "log -g" due=
 to
>> the way these frontends locate the reflog file to read (the logic wa=
nts to
>> have an underlying ref).
>>
>=20
> I think you have thought of this. What's wrong with keeping reflog
> when a branch is removed and appending "delete" line to the said
> reflog? I don't know how reflogs are managed, but those reflogs
> without associated branch will (or should) be cleaned when they are
> expired.
>
> I stick with this idea because I also want to archive old branches an=
d
> am thinking those reflogs ending with "archive" line will be kept
> forever, or until I feel like digging up them again.

The problem with this idea is deleting branch 'foo' and creating 'foo/b=
ar',
or deleting branch 'foo/bar' and creating branch 'foo'.  Old reflog wit=
h
"delete" line would block creating reflog for new branch.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
