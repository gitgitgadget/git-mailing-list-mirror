From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Fwd: running "git init --shared" on an existing repo
Date: Mon, 22 Mar 2010 15:15:11 +0530
Message-ID: <2e24e5b91003220245p7de5cd7dqc5f21230c244a268@mail.gmail.com>
References: <2e24e5b91003212330r2f3fd118y18386ef61c28ee89@mail.gmail.com>
	 <7v8w9kq1ia.fsf@alter.siamese.dyndns.org>
	 <2e24e5b91003220244v2d21bf3ay5b18d1ef40781be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 10:45:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NteCH-0001bh-Lx
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 10:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439Ab0CVJpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 05:45:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41057 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab0CVJpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 05:45:13 -0400
Received: by vws6 with SMTP id 6so309466vws.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=fiE63JQTVRsy4PGLFEalr92IzFR1kCqvAODJwTb3P2U=;
        b=W9z2pUqR00poXbKDWPd/WmLdu4N4FQfoLRuHa8ZEUZXcwxSFDX/SS2V9c2u3eOC4ce
         Fa6ydLVW+NqZUltAQ0t7/cWTa8ToANjXZ3kxns/qHhNeMoX59qi7A8Y2m47c9YJWRV04
         9SsYdFAU0nmvY5T1zfIoi51qwBNv3o4iQbyJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ERGNanwG1eto0pQG1udVme8ITZTVZOSanXGwGUXESNo8+vMyLvckT3iQ4wTFaP6oI4
         GxqBlAxzvECQbXn0oRb+3dwUzJi1f9G4VyV1r+yM+Jl9bP2EudaWfv/imnARfJNzzXnZ
         zTZPAmLGpRKVGY4aLTYRUgPOxGumFhqokEUo0=
Received: by 10.220.107.81 with SMTP id a17mr3155867vcp.129.1269251111951; 
	Mon, 22 Mar 2010 02:45:11 -0700 (PDT)
In-Reply-To: <2e24e5b91003220244v2d21bf3ay5b18d1ef40781be2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142913>

oops-- forgot to "reply all"; so it only went to Junio...


---------- Forwarded message ----------
=46rom: Sitaram Chamarty <sitaramc@gmail.com>
Date: Mon, Mar 22, 2010 at 3:14 PM
Subject: Re: running "git init --shared" on an existing repo
To: Junio C Hamano <gitster@pobox.com>


On Mon, Mar 22, 2010 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> And it seems there was a beginning made.=C2=A0 builtin/init-db.c at =
line 220 says:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * We would have created the above under user's umask -- under
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * shared-repository settings, we would need to fix them up.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>
> That "the above" refers to "in this process that created the reposito=
ry
> directory and populated it halfway by calling copy_templates()", and =
never
> "some time ago by some other process that created the repository, in =
which
> this process is now being run", so it is not fair to say "a beginning=
".

Possible, but the fact remains that when you do that "some time ago",
and then come back and do this, it *does* fix up the perms of refs,
refs/heads, and refs/tags.

> You would need to run "find $GIT_DIR -print0 | xargs -0 chown/mod ...=
" or
> a moral equivalent of it, I guess. =C2=A0Shouldn't be a rocket surger=
y ;-)

true... the toruble with using perl for years is that it sorta spoils
you; I need to actually *think* now, despite it not being rocket
surgery :-)

I will send a patch by and by... =C2=A0I wonder if cheating and calling
system("find <whatever> -type d -exec chmod g+s") will be acceptable
;-)

--
Sitaram



--=20
Sitaram
