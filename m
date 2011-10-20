From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 20:14:56 +1100
Message-ID: <CACsJy8B7CJ3VO-UKCym2kgfOOPadL25gt2sxApk95nKoWVk2yQ@mail.gmail.com>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net> <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 11:15:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGoir-0002yO-34
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 11:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab1JTJP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 05:15:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57934 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1JTJP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 05:15:27 -0400
Received: by bkbzt19 with SMTP id zt19so3275223bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RV6xjw7gWiNWOxkwQ2jqgeUynYDMO7/gk3pgrHSuhTU=;
        b=gOYNom/4BUs8t1I7QJfhUZpZPKUETk2l3Out/a0d9lnfyBpXkm8tP1xdJ1UgnzjLKC
         Vh4YGQXWDjqFYt3uZ6iOIwLqY4SRrSQjq1zcRRD2dumr0IARvuEuOV+hYt3yuDLxG8sq
         t8tW+JtsY+GC5ORMNy7BWmT0AzsbZd7GAXrCE=
Received: by 10.205.112.6 with SMTP id eq6mr7471097bkc.16.1319102126129; Thu,
 20 Oct 2011 02:15:26 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Thu, 20 Oct 2011 02:14:56 -0700 (PDT)
In-Reply-To: <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184018>

On Thu, Oct 20, 2011 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> And nothing shows up in the body, because git truncates at the NUL w=
e
>> added:
>>
>> =C2=A0 $ git show
>> =C2=A0 commit 31337a1093af2d97eb2e6c08b261c2946395fdd3
>> =C2=A0 Author: Jeff King <peff@peff.net>
>> =C2=A0 Date: =C2=A0 Wed Oct 19 15:34:00 2011 -0400
>>
>> =C2=A0 =C2=A0 =C2=A0 10
>>
>> =C2=A0 diff --git a/file b/file
>
> But you cannot hide from "cat-file commit" ;-)
>
> With the recent push to more (perceived) security, it may probably ma=
ke
> sense to teach "log" family commands to quote-show ^@ and what is beh=
ind
> in their output by default, perhaps with an option to turn it off.

What about NUL in file name in tree objects? Suppose the original tree
has an entry named "goodthing". With luck, they might be able to
create a new tree object with the entry renamed to "evil\x001234" that
has the same SHA-1. Could that possibly cause any problems?
--=20
Duy
