From: Simon Perrat <simon.perrat@gmail.com>
Subject: Re: [PATCHv2 2/2] git-remote-mediawiki: refactoring get_mw_pages function
Date: Tue, 12 Jun 2012 11:56:18 +0200
Message-ID: <CA+hdvHhvnku_h95LT7se7JWOZh4cG2UB4AfwAs2jV1j2hefDQw@mail.gmail.com>
References: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
 <1339442945-8561-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
 <CA+hdvHhn1G=T=KjNvgXa-2M6oh2znbHmfZFZYPdqKhtybh_MoQ@mail.gmail.com> <vpqmx48x4o5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Volek <Pavel.Volek@ensimag.imag.fr>, git@vger.kernel.org,
	Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:56:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeNqA-00045p-1K
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 11:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2FLJ4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 05:56:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51735 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab2FLJ4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 05:56:39 -0400
Received: by obbtb18 with SMTP id tb18so8087560obb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pe96EGjDC28CNY+RJ6cpY+V9nUHK+ZEgkFw03hJ0QPI=;
        b=Db+MnvpU3/wzW7mCUT9/IXlEIGb2kbfaRAn4qQuz1J5H1/AvuyXlRuFFhpwTR/SOOF
         aVkl8YnOP4TJQHO0VLLwVdoeORRcOuZhy6Qdg9apBBh7TT71Kpczd+wQgP/mOPm7lBeE
         6Qy8FD9UzcWtNowDgKGRaP8Mnxn+7vMjPB6mv3ti+uzufxxmQbCtixy/Uj6+mMoqGAgu
         /Nwva9sIzr8Q2XHAm51EGZYPVVAsViw+uu7jf573nm/va3WWGPsA/FsfTuwdklaPBDh9
         yEd4bOe2RuDfK8hrv+d12e1Imy8L/8G3su/Lis3T6oXpXnl0w+jocoHQpvvtiQQHodMU
         hZFA==
Received: by 10.182.45.72 with SMTP id k8mr19733268obm.51.1339494998630; Tue,
 12 Jun 2012 02:56:38 -0700 (PDT)
Received: by 10.60.169.107 with HTTP; Tue, 12 Jun 2012 02:56:18 -0700 (PDT)
In-Reply-To: <vpqmx48x4o5.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199778>

2012/6/12 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Simon Perrat <simon.perrat@gmail.com> writes:
>
>> 2012/6/11 Pavel Volek <Pavel.Volek@ensimag.imag.fr>:
>>
>>> +sub get_mw_all_pages {
>>> + =A0 =A0 =A0 my $pages =3D shift;
>>> + =A0 =A0 =A0 # No user-provided list, get the list of pages from t=
he API.
>>> + =A0 =A0 =A0 my $mw_pages =3D $mediawiki->list({
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D> 'query',
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list =3D> 'allpages',
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 aplimit =3D> 500
>>> + =A0 =A0 =A0 });
>>
>> Indentation should be 8 columns wide.
>
> More precisely, indentation in Git is done with tabs, and should disp=
lay
> well with 1 tab =3D=3D 8 characters.
>
> It is actually the case in Pavel's patch. When seen as patches, the
> first column is used for + and -, so the first tab is rendered as onl=
y 7
> characters, but that's normal.
>
> Or did I miss something?
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

My bad, I was mistaken by my mailer, which displayed these two lines
with a four-columns tab while the others were eight-columns.
