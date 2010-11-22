From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Mon, 22 Nov 2010 08:49:47 -0500
Message-ID: <AANLkTi=VXpT0PZvm4by0CvaLQ=EfuhMywQiHszYyQ_v_@mail.gmail.com>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<vpqoc9hsemy.fsf@bauges.imag.fr>
	<201011221414.15982.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Nov 22 14:50:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWmj-0005bx-NG
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 14:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab0KVNts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 08:49:48 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43651 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab0KVNtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 08:49:47 -0500
Received: by qyk11 with SMTP id 11so245416qyk.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OwrOt1z1nTHd/+PBPeq7fZu5cF9DU1ed6eO3Anxu6sI=;
        b=H0fRr5hybRQ3r5TkR/b/zNO4yffgPAXRtYsHKc9WqSNjcKY+cvVqBo1REzBrtnHWbe
         dMfJHARLAnv254vz13ojuizpk7gMBSClDZHIKwM8skrZ6z9Iuppfg7dqNHH12QpMNtAs
         NOBUGgdKkc7b0zvyCrwYOzWmXEcEe2vorOXNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=isUl2yfcHiKQiWC7hGG9zfKR5UFPtFYgBZGYGf0BG4XT7VcpNdgApOWkFS9sj6/K0G
         PjTpA6Ff3613io5XSmE2nn8X4kdPNkCvcpWyWxaS4qsGuazh3+rwPRrvZsUGEMZw+IDQ
         ZXF3estboLuOdXkBw6CW0/RTrsTEnXng7v3z4=
Received: by 10.224.137.75 with SMTP id v11mr5165045qat.244.1290433787065;
 Mon, 22 Nov 2010 05:49:47 -0800 (PST)
Received: by 10.224.200.138 with HTTP; Mon, 22 Nov 2010 05:49:47 -0800 (PST)
In-Reply-To: <201011221414.15982.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161893>

On Mon, Nov 22, 2010 at 8:14 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Matthieu Moy wrote:
>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>>
>> > Remove the undocumented and unused '--verify' flag from interactiv=
e
>> > rebase.
>>
>> I don't think this change is good. If a command has a --no-whatever
>> flag, one expects the --whatever flag to exist too, even if it's a
>> no-op.
> [...]
>> I think a better change would be to add a comment like
>>
>> --verify)
>> =C2=A0 =C2=A0 =C2=A0 # no-op, exists because --no-verify exists too.
>
> Shouldn't that be
>
> =C2=A0OK_TO_SKIP_PRE_REBASE=3D
>
> instead, so that it undoes the effect of an earlier --no-verify?
>

Yes. But because it did not work like that, it was not documented and i=
t
was only accepted by interactive rebase, I thought it was best to just
remove it.

However, I do understand Matthieu's point about having a '--whatever'
option for every '--no-whatever' option. So, if that is the general
opinion, I wouldn't mind adding the flag to non-interactive rebase as
well. As long as it is consistent, it would simplify things for the use=
r
(and, which is more important to me right now :-), for me while
refactoring this code.)

/Martin
