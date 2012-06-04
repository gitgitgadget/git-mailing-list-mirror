From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Mon, 4 Jun 2012 14:00:26 -0400
Message-ID: <CABURp0r0R0fDFEYqUbv9OLJ8eOsVuFRi3yO_Xjdmo638JZ4uGg@mail.gmail.com>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpq8vg7jue4.fsf@bauges.imag.fr> <20120601132710.Horde.j1U5UHwdC4BPyKcOgc8zbbA@webmail.minatec.grenoble-inp.fr>
 <CABURp0rm2JKBmrm62uAVj1WSc3BE_LoKoHbjmxvkQhPNgnozpA@mail.gmail.com> <7vy5o72cnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 20:00:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbbaF-0007K3-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 20:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab2FDSAr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 14:00:47 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39062 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab2FDSAq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 14:00:46 -0400
Received: by ghrr11 with SMTP id r11so3581116ghr.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZJf2w7c1j2rxk0Q3UlSkJaxoZPNhoOcY90BAVq9Ownk=;
        b=feXGPocn1H1bMFzD8Nc7IZHcjQkK32K9USXua/w2Dw7NBgX4Gf5pccb1CjLmftX3D4
         qCFWq8CErtCV6tndyDIyA5OMuOyzFfpa2Cvy7sYQryqNujIaJBBTs+KaxErwmXsr3YGR
         XtrwDnfMHn4aj+eFer2Oa1gJELhCDZaLkKztp7PLMJ4p0yKT2Yfxr6kANzuhGBI7qvLp
         RttoBTb1zziSfxElZpdha/FfXKwwfKVrn/b1VzwTs0+GqsFHmF0SRxqD1bpv53x12/ts
         VnY8nOSTHWJiEUre++aaX91Pxyk614im4UR7zUY4F9mV1L6t/m8U6Ifbh7OnUvn7SNu3
         /+AA==
Received: by 10.236.153.8 with SMTP id e8mr8112701yhk.80.1338832846320; Mon,
 04 Jun 2012 11:00:46 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 4 Jun 2012 11:00:26 -0700 (PDT)
In-Reply-To: <7vy5o72cnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199166>

On Fri, Jun 1, 2012 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> =A0 $ git status --sequencer
>> =A0 You have unmerged paths.
>> =A0 You are in an am session.
>> =A0 You are in the middle of an interactive rebase.
>>
>> =A0 $ git status --porcelain --sequencer
>> =A0 airu
>>
>> The "--porcelain --sequencer" combination I am imagining here would
>> show the status as a script-parseable sequence of single-letter
>> indicators telling the status of these same various conditions:
>> =A0 u - unmerged paths
>> =A0 a - git-am session
>> =A0 i - interactive rebase
>> =A0 r - rebase
>> =A0 c - cherry-pick
>> =A0 m - merge
>> etc.
>
> Some people seem to think that machine-readable has to mean
> unreadable cryptic line noises. =A0It's a disease.
>
> If you have to write "etc.", you clearly do not know what the
> range of possible values of these things will eventually be.
>
> And I do not think it is your fault not to know what we would want
> to add in the future. =A0But it is your fault to choose unreadable
> cryptic line noises as an output format.
>
> Just spell them out, and do not mark them for translation.

I agree.  And I waffled a bit between single-letter indicators,
abbreviated token-words, and fully spelled out words as you suggested.
 But I do think about future spelling or wording corrections (see
--indexed and http-referer), and I opted for letters in this example.

Thanks for the suggestion.  If I push this along, I'll use words and
let the list sort out the spellings.

Phil
