From: Computer Druid <computerdruid@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 15:39:10 -0500
Message-ID: <AANLkTinkjhH6YR7VPC0hji9CK=qeQMAYr+ptJE3szUyR@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
	<AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
	<AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
	<AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
	<AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
	<AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
	<20110301194428.GD10082@sigill.intra.peff.net>
	<AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
	<20110301200805.GA18587@sigill.intra.peff.net>
	<AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:39:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuWLq-0000nc-PG
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510Ab1CAUjN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 15:39:13 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62413 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab1CAUjM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 15:39:12 -0500
Received: by wyg36 with SMTP id 36so5091584wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=brYdi2KG8MNOtDQmTykge+KlXUrIOCIaWjRJsalt58U=;
        b=rg+rXWVgNHEKEEEn+39FvdfOABi1Og7GhfYiQbsQPlbwrZOehlzu3fX2via1NIaahM
         iHRvUBRNuva4GzEUu5kHX1k4YjYHBXkun2UdXxJDM1lOBDjbz9LykR4gTaDij2BeV4IE
         0Cs0Av/DkPERvz/v7VnljiYNJGzOgwEaKZl70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hjf06+I1lSaAYw/QX8DU12GRoy/gKMncf4gmk64Hj/f67xpFAeQg5LYRglEsYO6V1l
         GNJ/gelplkvx8Ksm3TjFqPHeXoS3LrVyPm5wO+ErSuzvowS9MtX/BQBJs1c3v0/sR9tU
         2M7cc9EWbcu7djmhLgExUSdWgW44yat28Ea4M=
Received: by 10.216.181.199 with SMTP id l49mr3763057wem.68.1299011950779;
 Tue, 01 Mar 2011 12:39:10 -0800 (PST)
Received: by 10.216.161.79 with HTTP; Tue, 1 Mar 2011 12:39:10 -0800 (PST)
In-Reply-To: <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168255>

On Tue, Mar 1, 2011 at 3:30 PM, Chad Joan <chadjoan@gmail.com> wrote:
> On Tue, Mar 1, 2011 at 3:08 PM, Jeff King <peff@peff.net> wrote:
>> But it just seems horribly broken to me. This is CIFS to an OpenVMS
>> machine you said? Do the broken permissions appear to other clients =
or
>> across a remount (i.e., is it broken state in your CIFS client, or h=
as
>> the server actually munged permissions)? If so, have you tried repor=
ting
>> the issue to whoever writes CIFS server on OpenVMS (is it just samba=
)?
>>
>> -Peff
>>
>
> Yep, CIFS to OpenVMS.
>
> I don't know about other clients because there are none (yet). =C2=A0=
The
> permission change does survive remounting.
>
> I haven't reported it. =C2=A0I didn't know it existed until now ;)
>
> I'll do that, but it will probably take a long long time for me to se=
e
> the patch. =C2=A0I'm hoping there's some cheap hack I can use to work
> around it in the meantime.

A simple answer to preventing git from calling rmdir would be to run
rm and git rm separately:
$ rm file
$ git rm --cached -f file

But that doesn't solve the misbehavior of git under the previous
scenario. I'm not sure if this is something we should fix in git or if
it should be fixed in cifs.
