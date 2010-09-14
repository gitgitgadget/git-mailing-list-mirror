From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/8] tree_entry_interesting(): support negative pathspec
Date: Wed, 15 Sep 2010 08:46:26 +1000
Message-ID: <AANLkTinkGpWGXTEpDqm4zPRky06C9X9xUoo2roKH2kG=@mail.gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
	<1283961023-4491-9-git-send-email-pclouds@gmail.com>
	<7vd3sg8fjn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 00:53:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OveNc-0000tA-Sz
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 00:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab0INWxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 18:53:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52558 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0INWxP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 18:53:15 -0400
Received: by wwd20 with SMTP id 20so349936wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EDUhwbZ+wWR7rK6maZ4evOjkm0qMNlR3bm+AwORXe5M=;
        b=SCWzHeGTXKa3Efzkm2zvdE9FoV1VLikgWf+gJWLoye4BZhvnV1HOWFxV3HF5ukbHLW
         jW1CQYzJb39cFfi6PlPK6QnRQ0S4J6ev5Ne4xOxPHNrBFndHmb79wT5ydSlX/pxAGxdl
         8ywJUMYDYXk2VTrt7pbCTdsdBxAlYg6PvLZNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oeV44IuH39lY45mmt5Xuu/UIbLFYT+OSux5q/Xs7Dj+z4EZ+pInpnL4IPHqi6DcAJS
         JqQGvNBdkQ5MlZWOBUMewGQQfjBFL9oMi4fabb8pGc3y1ks9NfiE86VjQ7hMn3XkubM1
         GJsdVO+shPSaWcsrihnXcmBnMb6K/EoIHs/3U=
Received: by 10.216.38.71 with SMTP id z49mr4544984wea.76.1284504386273; Tue,
 14 Sep 2010 15:46:26 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Tue, 14 Sep 2010 15:46:26 -0700 (PDT)
In-Reply-To: <7vd3sg8fjn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156216>

2010/9/15 Junio C Hamano <gitster@pobox.com>:
>> diff --git a/tree-walk.c b/tree-walk.c
>> index a2f4a00..fd19681 100644
>> --- a/tree-walk.c
>> +++ b/tree-walk.c
>> @@ -532,7 +532,7 @@ int tree_entry_interesting(const struct name_ent=
ry *entry, const char *base, int
>>
>> =C2=A0 =C2=A0 =C2=A0 pathlen =3D tree_entry_len(entry->path, entry->=
sha1);
>>
>> - =C2=A0 =C2=A0 for (i =3D 0; i < ps->nr; i++) {
>> + =C2=A0 =C2=A0 for (i =3D ps->nr-1; i >=3D 0; i--) {
>
> No explanation in the commit log message why. =C2=A0Besides, spell bi=
nary "-"
> operator with a SP each on both ends, please.
>
> Also the code seems to use a new term subpathspec without defining no=
r
> explaining. =C2=A0Not good.

No, not good. It also has bugs as Elijah pointed out. I'm going to
submit these last two patches as a separate series that will make
negative match work on (hopefully) all commands.

Thanks for your comments.
--=20
Duy
