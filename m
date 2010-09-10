From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: possible gitattributes eol bug with new eol=crlf | lf support?
Date: Fri, 10 Sep 2010 17:27:13 -0400
Message-ID: <AANLkTi=xPpPZzUqVEHEkH2sKvSVZH+MzunET6vEA_tw5@mail.gmail.com>
References: <AANLkTinC8g9m=2ka=7LiHH4MtfxC-NbxbsYQEbmMyXmN@mail.gmail.com>
	<1F2D74A7-1C9C-47D9-9C3D-E430E446CB94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 23:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuB7x-00058k-Nu
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 23:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab0IJV1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 17:27:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47305 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab0IJV1O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 17:27:14 -0400
Received: by eyb6 with SMTP id 6so2081078eyb.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C1CTxdUzgkJYYE7MsyfDdrJxG2kaEzfSSxGVVJSt9Lk=;
        b=nOdt3l8n4zHpAjO2FaLuUW/S4J28G7VhSVV5U4r+rPI32uv5tKl4NAZ0mPN+yoX+Me
         4CmGf6ZslYcRHvadaJ24HvF4KU0ykXmTI4EwF17SuBtN6AmCQKsG90qXye3T3kFCVe4c
         FTgXnwXl3QpkM8AF9ZaGJvovZtg8MRN6rpEVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dkw6yJX4IRVpS7RzXZh0utICIDAW+kPrf/OdfyKUxlsgtJMorCcpDv1c/Srgvp36nW
         O+10VK9r3d/BvlTq/Buxg4+6AvgKeWPMTojh9HfmKFvG/4iJAeISCPaBoNhBzGlOHfBz
         qfDmCa9bd6gn8xf1UsfJ43vhAS5o0IF9htY24=
Received: by 10.213.59.76 with SMTP id k12mr135167ebh.13.1284154033199; Fri,
 10 Sep 2010 14:27:13 -0700 (PDT)
Received: by 10.14.4.11 with HTTP; Fri, 10 Sep 2010 14:27:13 -0700 (PDT)
In-Reply-To: <1F2D74A7-1C9C-47D9-9C3D-E430E446CB94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155970>

I don't understand the inner workings of .git/index, but is removing
that file destructive to history or anything? What are the
implications of that delete-command?

Bob

On Fri, Sep 10, 2010 at 2:25 PM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> On 10. sep. 2010, at 00.31, Robert Buck wrote:
>
> [...]
>
>> Conversion of LF-EOL files to CRLF works fine, but conversion of CRL=
=46
>> to LF fails to occur.
>>
>> The doc is a little unclear if this is expected behavior, which if I
>> recall correctly from the email threads related to the new eol
>> support, this should not have occurred.
>
> Unfortunately, this is expected behaviour: you need to "manually" rem=
ove CRLFs when you turn on eol conversion. =C2=A0The simplest way to do=
 this is "rm .git/index && git reset", then commit the modified files (=
ideally in the same commit that modifies .gitattributes--this is mentio=
ned in gitattributes(5)).
>
> To make this work as it should, git would have to notice changes to .=
gitattributes and check files which have had their attributes changed. =
=C2=A0It's on my "I wish I had time to do this" list.
>
> - Eyvind
>
>
