From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/13] revert: Introduce skip-all to cleanup sequencer data
Date: Sat, 2 Jul 2011 11:54:27 +0530
Message-ID: <BANLkTimy17b-F7eg+R9ReRUrx0rhA1cumg@mail.gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-13-git-send-email-artagnon@gmail.com> <7vtybj6ji2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 08:24:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QctdS-0001nB-5s
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 08:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967Ab1GBGYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 02:24:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45944 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab1GBGYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 02:24:48 -0400
Received: by wyg8 with SMTP id 8so2562808wyg.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Nr7FufZ0i9b92OkL/wGXnRWv59bvpgBpFKG6X+/E5Og=;
        b=HzZ6zLRu8K88+m6mnnz7PmDx1B+WSsBOUdFTbahLtsAAeLBNdCyDk17o9Yd6BUtwMj
         BgJez9/SCGajp+BGuzUgqQpcyTDgy0e6hPhN7kxb4Wa53M3cgAYMwpnm0pBmcPn842OH
         e+1vp+a2sICN1Vu+xCDjaYIE6UQJtruXWgsIM=
Received: by 10.216.62.3 with SMTP id x3mr1716755wec.77.1309587887167; Fri, 01
 Jul 2011 23:24:47 -0700 (PDT)
Received: by 10.216.134.194 with HTTP; Fri, 1 Jul 2011 23:24:27 -0700 (PDT)
In-Reply-To: <7vtybj6ji2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176545>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index 5c0b97e..eb68068 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -46,6 +46,9 @@ enum replay_action { REVERT, CHERRY_PICK };
>> =C2=A0struct replay_opts {
>> =C2=A0 =C2=A0 =C2=A0 enum replay_action action;
>>
>> + =C2=A0 =C2=A0 /* --skip-all */
>> + =C2=A0 =C2=A0 int skipall_oper;
>
> Yikes what is that "oper" doing there? =C2=A0Don't truncate a word in=
 the
> middle only to shorten names and make it unclear what you want to say=
=2E Is
> that operand? operation? In this case, I think "int skip_all" is
> sufficient, and you can lose the comment that adds no extra informati=
on.

Interesting side note: I'd initially wanted to use "skip_all" and
"continue", but "continue" is a C keyword.  That's why I'd reluctantly
suffixed "_oper" to both for consistency.

-- Ram
