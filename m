From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] exclude: reuse last basename comparison
Date: Fri, 8 Jun 2012 09:37:19 +0700
Message-ID: <CACsJy8BChqegyvo8Oqj6Rk+kWR245sSngWeQcBZXKWLgTw9t_w@mail.gmail.com>
References: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
 <1339055617-23028-4-git-send-email-pclouds@gmail.com> <7vd35bge2u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 04:38:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scp5P-0001YV-KC
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 04:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760474Ab2FHChx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 22:37:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49583 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760461Ab2FHChv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 22:37:51 -0400
Received: by bkcji2 with SMTP id ji2so1250263bkc.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5URNSprbJY64eXEQmNwvvW2uhNwyLE2QflqTl35cblY=;
        b=1F94D1QNUTqVGVlNHwvw8SXV+N1BML1mTnJAtEqwwJMuFDlkuydqR5dDE6eW3hPKeQ
         bAM4HpV70aFoty6UD60hAf7PqrkQQzekfvXOVHbr8/f0WScoBImQXLz+InAdJW+fW8z3
         epWXO9exq/VBAJI+MLrj8QJE/SJ93zfL31v8omKSJu+KyVRGNoFgAAzaUrT6kIYE4Pyc
         gFYFHmJnl8LXL09OgA4I72gDvdp+soTr/HIzOHCBHUkZE78AO0CiNyw5+PUR9Y4OT9Zv
         ucPQAkUj9jxkb0c0kKE76VHKE4GoTrP/0SRlfcADye5NB3ICzRIqa+VA+haJmLjaUhV5
         zlVA==
Received: by 10.204.130.194 with SMTP id u2mr3953503bks.2.1339123070058; Thu,
 07 Jun 2012 19:37:50 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 7 Jun 2012 19:37:19 -0700 (PDT)
In-Reply-To: <7vd35bge2u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199462>

On Fri, Jun 8, 2012 at 1:40 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> diff --git a/dir.c b/dir.c
>> index 94fe9f8..2964076 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -511,6 +511,7 @@ int excluded_from_list(const char *pathname,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct exclude_list *el)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int i;
>> + =C2=A0 =C2=A0 int last_basecmp =3D el->nr, basecmp_result;
>
> Gcc complains that basecmp_result may be used without initialized in
> this function.

I'm pretty sure it's fault positive.
--=20
Duy
