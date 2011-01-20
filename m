From: Graham Sanderson <graham.sanderson@gmail.com>
Subject: Re: EOL strangeness
Date: Thu, 20 Jan 2011 10:29:27 -0600
Message-ID: <AANLkTimLFT48HCeFcqO_gn0XeBYkH=n8e124Y5RznLuC@mail.gmail.com>
References: <AANLkTiknxMh_OophKWsqkYO2C+PsfF0ZnNXKLbheM4wF@mail.gmail.com>
	<4D37F853.1020805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jan 20 17:29:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfxOU-0008OM-AB
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 17:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab1ATQ3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jan 2011 11:29:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35059 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1ATQ3j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jan 2011 11:29:39 -0500
Received: by wwa36 with SMTP id 36so829131wwa.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uLoIkNEWhnCKJ9tv+fVnun4hJBT2U/Y+itn3bZ3SJe4=;
        b=RtQ3zo9q0o518WrZumxCZQUnKgK4VieexDiCGAfjEkpfIPCukrhhYfNev5rP6M+pgN
         l3/ojuZzM/eRQUehgQS1q2APhFGioNZq4rHZwdilRocTnRZ4M23yVDR21kOMPm8nfBll
         LjJYeHwQDpkVkzVHrDsD5ji0cOwKzatS0/ydY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M6Z465xJmGMVZOOUWQIKdXOftawChQ1cH612z/fDqh5Hxw42Hiap5LiUWGumElloNn
         0DaqqePjn9I4BGOnuHsPjdf4VIX37m2WtzB4S+5och8X0zwqpJexJTZG2vEr/IY0WIez
         KASWS+XM11iQy/clItNNqAx1EYF9fUEvZs25g=
Received: by 10.216.30.80 with SMTP id j58mr3873722wea.64.1295540967412; Thu,
 20 Jan 2011 08:29:27 -0800 (PST)
Received: by 10.216.196.156 with HTTP; Thu, 20 Jan 2011 08:29:27 -0800 (PST)
In-Reply-To: <4D37F853.1020805@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165319>

Thanks, I think it must have been a bug - I realized that even though
I thought I was on the latest git, I had an older copy hiding in my
path; once I upgraded the problem went away.

On Thu, Jan 20, 2011 at 2:54 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 17.01.2011 20:56, schrieb Graham Sanderson:
>> Apologies if someone has answered this before:
>>
>> So we have moved some big teams over to git (awesome thx), and have
>> been using the msysgit default core.autocrlf=3Dtrue on Windows, and
>> making sure text files are LF on other platforms
>>
>> However we do continue to have a few problems with people storing CR=
LF
>> in the repository (partly because of lack of understanding, and part=
ly
>> it seems because of eGit on windows which ignores core.autocrlf).
>>
>> Anyway, this much is all fine, and we can fix; what I don't understa=
nd
>> is why for files stored as CRLF in the repository it seems
>> indeterminate when or if they show up locally modified (on my window
>> box with core.autocrlf =3D true) when I pull them from the repositor=
y. I
>> assume the idea is that that they "would be" modified if I were to
>> check them in, since they would be converted to LF, however this onl=
y
>> happens sometimes and for a seemingly random subset of the files
>> stored incorrectly.
>>
>> It also seems to depend on the state of the local index, as recreati=
ng
>> the local index often changes the set of files that are displayed th=
is
>> way (even without any changes to the files), and it also seems to be
>> different on different machines (perhaps based on when they happened
>> to pull code).
>>
>> If anyone can give me a quick mental picture of how this is supposed
>> to work (i.e. at what time the eol conversions are considered) then
>> that'd be great... otherwise I guess I'll go dig in the code.
>
> Perhaps this recent thread is of interest to you, even though it's on=
 a
> slightly different topic and inconclusive:
>
> =A0 =A0 =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git=
/163794
>
> It would be nice to have the expectations in your case codified in a
> test script -- based on the documentation, if possible.
>
> Ren=E9
>
