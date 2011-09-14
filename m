From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [Survey] Signed push
Date: Wed, 14 Sep 2011 13:49:31 -0700
Message-ID: <CAObL_7Er5mMuNaNgLDptBHw-zrqEeHHqXkC+TNf9G81_+NmFKw@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <4E7101F3.1090204@mit.edu>
 <7vwrdasvr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 22:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3wP7-00034z-88
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 22:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321Ab1INUtw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 16:49:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40831 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933235Ab1INUtw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 16:49:52 -0400
Received: by ywb5 with SMTP id 5so1749246ywb.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oVNQ7hjVTPMmVQEbJ7oTyMePfuYai5b1C2Diqv5UWdo=;
        b=WrZiIHgsUyf73Q9IoPkPD8wsM/CnWKRmkCztHTLIZLRFO/FWgPr7UyEZXKJkSpfYWh
         Qxbo7zJEktBRZL2mA9PhS1R0cwcyoGkucU/XnNciHUaKP988aHxQmnXE81YJxt6Gp7HX
         S6QolFvZJ2M2aHc8qZkM5XGHYjes0xoalIO3E=
Received: by 10.68.1.233 with SMTP id 9mr534518pbp.370.1316033391046; Wed, 14
 Sep 2011 13:49:51 -0700 (PDT)
Received: by 10.68.52.129 with HTTP; Wed, 14 Sep 2011 13:49:31 -0700 (PDT)
In-Reply-To: <7vwrdasvr7.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: -6TXWmwRwP3Z1U24PpUih9sNQ5U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181398>

On Wed, Sep 14, 2011 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Andy Lutomirski <luto@MIT.EDU> writes:
>
>>> An alternative that I am considering is to let the requester say th=
is
>>> instead:
>>>
>>> =A0 =A0 are available in the git repository at:
>>> =A0 =A0 =A0 git://git.kernel.org/pub/flobar.git/ 5738c9c21e53356ab5=
020912116e7f82fd2d428f
>>>
>>> without adding the extra line.
>>>
>>> That is, to allow fetching the history up to an explicitly named co=
mmit
>>> object. This would only involve a change to fetch-pack at the recei=
ving
>>> end; just match the commit object name given from the command line =
against
>>> the ls-remote response and ask upload-pack to give the history lead=
ing to
>>> it....
>>
>> I would love this feature on the pull/fetch interface, but for a
>> completely different reason. =A0Sometimes I want to pull a particula=
r
>> object (usually a commit, but sometimes just a tree or blob) from
>> *myself*, and having to stick it on a branch is annoying.
>
> I am afraind that it is not going to happen; see
>
> =A0 =A0http://article.gmane.org/gmane.comp.version-control.git/181317
>
> for a rationale.
>

Do you mean that it's a security feature?  What if a .git/config
option existed to allow this use?  Or even a git upload-pack option
that turned it *on* and was stripped by git-shell?

--Andy
