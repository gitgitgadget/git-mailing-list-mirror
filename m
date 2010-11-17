From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 07/10] checkout: add -S to update sparse checkout
Date: Wed, 17 Nov 2010 22:02:50 +0700
Message-ID: <AANLkTim=beQhCvXmV6NvDiNHAYC+SBgvw36FzSthXHN2@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-8-git-send-email-pclouds@gmail.com> <20101115211636.GH16385@burratino>
 <87bp5qmez1.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Nov 17 16:03:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIjXd-0005cM-Ib
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 16:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881Ab0KQPDP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 10:03:15 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45697 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419Ab0KQPDO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 10:03:14 -0500
Received: by eye27 with SMTP id 27so1208078eye.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GxDdS9ue1UEpK4sf1twGOR6Ha/Ykl01HyJONv7H/+sQ=;
        b=d+lywSzxbwf4vFlJ4KIYppkcVyj+RSCUVfM4n7o2QAJtB81pnanZ4YJM2xVVsUYTEv
         OM+QNTY9l21ZnWow33Qj57cRJJBOCz1IgIDIt+dJzhyN3YbOEj8NCG2tRq138krKyGMQ
         S3yCQWjV0/B+0lXYvm4PO5mTgEVu4d0HCJabw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XYDyTDZO1b8d4H1nn06Xjs/leNfrnm1A4ElorbkD1nPqiNMaC8jKuGSPAMlTKVpVlX
         sVIwW0ihb6bydOxYNRoaIxG/FuhZh0RzkcySM42XN27THRbbwqm6GnGzgZK4rbp3njuJ
         tHn6aogBItwClVWGRQMi5OfpVdHObaT8cCGg4=
Received: by 10.216.255.148 with SMTP id j20mr8197865wes.11.1290006191715;
 Wed, 17 Nov 2010 07:03:11 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 17 Nov 2010 07:02:50 -0800 (PST)
In-Reply-To: <87bp5qmez1.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161619>

2010/11/16 Miles Bader <miles@gnu.org>:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> +-S::
>>> +--update-sparse-checkout::
>>> + =C2=A0 =C2=A0An editor is invoked to let you update your sparse c=
heckout
>>> + =C2=A0 =C2=A0patterns. The updated patterns will be saved in
>>> + =C2=A0 =C2=A0$GIT_DIR/info/sparse-checkout. The working directory=
 is also
>>> + =C2=A0 =C2=A0updated. An empty file will abort the process.
>>
>> Wording nit: this doesn't make the worktree more up-to-date. =C2=A0H=
ow
>> about:
>>
>> =C2=A0--edit-sparse-checkout
>> =C2=A0--define-work-area
>> =C2=A0--narrow-worktree
>>
>> Hmph.
>>
>> --edit-sparse-checkout seems best for consistency of the choices I c=
an
>> think of.
>
> "--change-sparse-checkout"?
>
> Onna-account of "edit" sounding like you're actually somehow editting
> the checkout itself... =C2=A0OTOH, since it invokes the editor... hmm=
m
>
> BTW, wouldn't it be more convenient to allow specifying patterns
> directly via the command line? =C2=A0I'd think in many (maybe the maj=
ority
> of) cases people will really only want one entry, and having to edit =
a
> file to specify it seems vaguely annoying...

A command line option to append patterns only sounds good to me. But
it would clutter up sparse-checkout file over time and may decrease
performance. The same option can also be reused for git-clone. Do you
suggest any name? I'm bad at naming.

I don't think I can make an option to remove patterns though.
--=20
Duy
