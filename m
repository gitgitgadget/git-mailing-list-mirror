From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/3 v2] tests: factor HOME=$(pwd) in test-lib.sh
Date: Wed, 1 Sep 2010 15:40:50 +0000
Message-ID: <AANLkTi=+_+62LqhnO6dee9fv=1_naGoNzsusNt9OpX_N@mail.gmail.com>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
	<1283210123-19752-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTik7d9Rhx5NudeKvVMFAYvVhGxoYzK2y+g3CP=Zj@mail.gmail.com>
	<AANLkTim6Cb4vegGYG0ZtJxXvAwBxHYGOY7bQFbGSAcXV@mail.gmail.com>
	<7vaao17ahi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 17:40:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqpQp-0001yr-8b
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 17:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0IAPkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 11:40:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47510 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0IAPkw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 11:40:52 -0400
Received: by fxm13 with SMTP id 13so4797725fxm.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BZsxYFuipOsR1D4A+BF9w2lsaxwBLVWUs1m897poYmA=;
        b=OxSccjtwh9HYL5CPOa4rJ6eCG7l6xyuZvvQDkNagEHwIc08kxb7RvRXNUQ49DVb3qt
         WqErLEhDys6nlCFjiDEt9Ss0lXaJUtcRAC98xHl75/r1OhyEdiO11xBf0HhUpf6z4Al8
         PFwr2KeuSZVYC0CyiBSpGwjSy/TiW9ErN8+Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lq9FgTtmxiWlNFwT0SJ9nH6BQsxQHW7B74j5IF4AdNoHqF5F967/8fQYFsRs6t8SvP
         eMlt00H809jSxeLr0RS2qnNfHu22vQO5goUmOf0aKaDjDJiAS7vJVZQTdS+YMMV6WuyF
         ZGy1JDQqgjlrVlYsUdJP+/8ick+Ky2MIVYh90=
Received: by 10.223.108.84 with SMTP id e20mr3945692fap.57.1283355650859; Wed,
 01 Sep 2010 08:40:50 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Wed, 1 Sep 2010 08:40:50 -0700 (PDT)
In-Reply-To: <7vaao17ahi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155054>

On Wed, Sep 1, 2010 at 15:24, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Aug 31, 2010 at 07:42, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
>>> On Mon, Aug 30, 2010 at 23:15, Matthieu Moy <Matthieu.Moy@imag.fr> =
wrote:
>>>> The same pattern is used in many tests, and makes it easy for new =
ones to
>>>> rely on $HOME being a trashable, clean, directory.
>>>>
>>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>>>> ---
>>>> Just re-ordered the patch to make this one the first.
>>>>
>>>> I took =C3=86var's suggestion of using $TRASH_DIRECTORY instead of=
 $(pwd).
>>>
>>> Thanks,
>>>
>>> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>
>> Junio: FYI you picked up v1 of this for next/pu, not this v2.
>
> I know.
>
> The originals all used $(pwd) as far as I saw, and it _is_ more faith=
ful
> and correct refactoring not to use $TRASH_DIRECTORY in this patch, no=
?
> You can choose to change it to use $TRASH but that should be done in =
a
> separate patch.

I just wanted to note it in case you didn't see it. It's a trivial
issue and I don't really care, I just wanted to note it in case the v2
went past you.
