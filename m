From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 21:05:02 +0100
Message-ID: <AANLkTimRu13gfyoprwugxb0D64LZmSkSoJZBVLpTXOo3@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
	<7v8vx4aqun.fsf@alter.siamese.dyndns.org>
	<AANLkTinzhd_nL265e7DZA4xEnXqDn-5m=9GPS7JsFY-S@mail.gmail.com>
	<7vei6vao0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:05:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3vB-00064P-97
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882Ab1BYUFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 15:05:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35599 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644Ab1BYUFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 15:05:40 -0500
Received: by fxm17 with SMTP id 17so2027452fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g3OOHRzmzi+kZL3JsnKEShUAxkSpoLps/p19oDz5Q8U=;
        b=P8gzWFtgvGDgg7gu0h39AsgZKvQ+3fkQ5ivyuCaR11eqS7KBB9XTOnHaiGgfHe8YcR
         oCil5VBQW/HoQJyE6DkeTZXsOfxgfqXzIfxh3fWrRFyOc0Oth0Zd5EMn64VwLP/wrTzQ
         EIBLaCU5Nl7zuhfKL+XQWbgZPHGEqh0vMmUYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tf3R6qEJ1v0qWND8Lo/7n02aNd6NipWm4X0LbNrSqK+pgg2aH09vKPQ/AXLsuNk9Jg
         v52GTtWFWq3qFyqaOeqe0oaoYXCGQmGfmc044o/LZ0YVRcd/bP5eE8RmiCZ1WzOaPiCN
         dkMTQoyPFSW+bJ6bd6ww6JFkVsPfgdqheQQnw=
Received: by 10.223.83.201 with SMTP id g9mr3188685fal.140.1298664302631; Fri,
 25 Feb 2011 12:05:02 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 12:05:02 -0800 (PST)
In-Reply-To: <7vei6vao0p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167933>

On Fri, Feb 25, 2011 at 20:54, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> But just like we now have:
>>
>> =C2=A0 =C2=A0 Revert "some commit"
>>
>> =C2=A0 =C2=A0 This partially reverts commit <sha1>.
>>
>> We could have with <path>:
>>
>> =C2=A0 =C2=A0 Revert "some commit"
>>
>> =C2=A0 =C2=A0 This partially reverts commit <sha1>. Only the path <p=
ath> has
>> =C2=A0 =C2=A0 been reverted, which is X out of Y files changed in th=
e original
>> =C2=A0 =C2=A0 commit.
>>
>> Or something like that.
>
> Yes, that is exactly what I was suggesting, no?

Yes in the second paragraph, I was mainly just going to expand on it
and provide a suggestion.

But I mainly wanted to point out that not having this feature means
that people do completely manual reverts. So I think we'd have less
"broken" history (message), not more as a result of this sort of
thing.

> On the similar line of thought, it might be a good idea to update the
> commit template we give slightly perhaps like...
>
> =C2=A0 =C2=A0 Revert "some commit"
>
> =C2=A0 =C2=A0 This partially reverts commit <sha1>.
> =C2=A0 =C2=A0+#
> =C2=A0 =C2=A0+# DESCRBE HERE how the change in <sha1>
> =C2=A0 =C2=A0+# was a wrong thing to do.

Yes this looks very good. Aside from the UI issue of someone expanding
on why they did that *inside the comment* because that's what it sugges=
ts :)

    This partially reverts commit <sha1>.

    # DESCRIBE ABOVE ...

Would probably be better.
