From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc --auto: warn gc will soon run, give users a chance to
 run manually
Date: Mon, 7 Nov 2011 17:55:53 +0700
Message-ID: <CACsJy8DytH+2WcSpxFYWOR-chgorumzDawYyY1S+MKKDzRa6zw@mail.gmail.com>
References: <1320489212-524-1-git-send-email-pclouds@gmail.com> <7vfwi031ts.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 11:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNMuI-0007AM-8K
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 11:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab1KGK40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 05:56:26 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50078 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1KGK4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 05:56:25 -0500
Received: by bke11 with SMTP id 11so3461917bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hdcqoVTFs4pnQvoGr8Nb3KV86ulkAtlWBJ2oHx0q+1U=;
        b=jY2ZMa0DD69d5Z8nLne14bb42pS3bqeOzZRuipjrwGZBkGV4qPqHPwbxY9vVGwk5lE
         AUlsDZsLwXOr6UZv+pCHCZFCL24R4Ku/PrMSLFcyeXuWlc6c0JzFFzVQ+hBDOhntJ6GM
         ua3FpB4HeMHsnbkrlyGeyovhBh5qm7tLOwXug=
Received: by 10.204.9.205 with SMTP id m13mr18672203bkm.32.1320663384141; Mon,
 07 Nov 2011 02:56:24 -0800 (PST)
Received: by 10.205.134.1 with HTTP; Mon, 7 Nov 2011 02:55:53 -0800 (PST)
In-Reply-To: <7vfwi031ts.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184973>

2011/11/7 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0I hate it every single time git hangs because gc is activated.
>> =C2=A0Opening another terminal is an option but I would lose all ter=
minal
>> =C2=A0settings I have on the current one (e.g. access to suspended v=
im
>> =C2=A0sessions).
>>
>> =C2=A0I don't think gc_warn_* need their own config vars. Hopefully
>> =C2=A0hardcoded offset is good enough.
>
> Let's think about How the user chooses a custom value for the thresho=
ld
> (or accepts that the default threshold value 6600 is good enough).
>
> ...
>
> Now, I suspect that busier users would need longer window than slower
> ones, which leads me to suspect that a good default would not be a
> hardcoded constant offset (e.g. once you see the new warning, the aut=
o-gc
> kicks in after creating 100 objects) but some ratio of the threshold
> (e.g. you have 2% margin after getting a warning before the auto-gc k=
icks
> in).

Speaking for myself, as soon as I see the warning, I would immediately
start a new shell for git-gc alone and get back to my work (hopefully
gc will not be activated again while another gc is running) so one or
maybe three warnings may be enough. But yes, some ratio may be better
for different users.
--=20
Duy
