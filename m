From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: disabling PROPFIND when using smart http
Date: Wed, 24 Nov 2010 01:10:42 +0530
Message-ID: <AANLkTimvKg3mwfZUoRHoj=uW0FxGS=meF-ChLJKEtHcp@mail.gmail.com>
References: <AANLkTikwqtPDDk6i0nMKJiXn5cc3DmTGYp0==daX96yd@mail.gmail.com>
	<20101123161018.GB10420@LK-Perkele-V2.elisa-laajakaista.fi>
	<AANLkTikoGS4X8YbNgLT=Akx5RBj2d4Uybdx5QnJ+CWNo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 20:40:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKyjR-0006Bq-He
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0KWTko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 14:40:44 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42062 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab0KWTkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 14:40:43 -0500
Received: by eye27 with SMTP id 27so4901298eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QfyBCiFcAej3t/avTUm5H/0QcicN2FYCDN3F99NllVA=;
        b=MgPDP+ZGQO2AHViw6dlVhmnNho8zN7if+fsFigesB8pjXRzsb3rStkZv35I24236sL
         /JXGq+2XFXq0XtOBYO9KjjBTtOAwWs1acKUt+ZbQpN5a97FO76M0GbRC7kjehoBiQGZz
         W3zeVhrDRzH5BXGQBdpegNgAdxTou6zuuFOGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gbpJVBRNtD5Z1+SVpsiENY5hLy+m298P+cS5ckJ2QcA/a37XYbbKBggSQmcSoP57o7
         1jd88N1jn/WzzofJrELNGFV8JAmIVa/8faD3lDrjslSMPIMbhrqR3bkRwgVUQcnPAvXE
         Q9a38KDzusM5dhUR6lazHB8y5z3Q+/vJnOGt0=
Received: by 10.213.27.66 with SMTP id h2mr7369553ebc.42.1290541242383; Tue,
 23 Nov 2010 11:40:42 -0800 (PST)
Received: by 10.213.108.81 with HTTP; Tue, 23 Nov 2010 11:40:42 -0800 (PST)
In-Reply-To: <AANLkTikoGS4X8YbNgLT=Akx5RBj2d4Uybdx5QnJ+CWNo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162014>

On Tue, Nov 23, 2010 at 11:01 PM, Scott Chacon <schacon@gmail.com> wrot=
e:
> Hey,
>
> On Tue, Nov 23, 2010 at 8:10 AM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
>> Apparently pusher is falling back to dumb WebDAV push for some
>> reason. And then failing because server does not support it
>> or isn't configured apporiately for it.
>
> Yes, the client will fall back to 'dumb' HTTP stuff if the server doe=
s
> not respond properly to the initial /info/refs GET call. =C2=A0I beli=
eve
> it's something like if the client asks for
>
> /info/refs?service=3Dgit-upload-pack
>
> and the server does not respond with the first line being:
>
> # service=3Dgit-upload-pack
>
> or the Content-Type header being:
>
> application/x-git-upload-pack-advertisement
>
> I believe either of those being absent will cause the client to think
> that it's not a smart server, so it falls back to the DAV based push.
> If you let us know what the curl output before that point was, or wha=
t
> your apache config looks like, we might be able to help figure out
> what's wrong with the server.

Well it was someone else, but the pastie he has sent was
http://pastebin.com/eaB0G1gx -- which may or may not help, because it
doesn't seem to show the response *body*, only the headers.

If that doesn't help I'll try and reproduce the problem myself first.

Thanks,

Sitaram
