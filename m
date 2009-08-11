From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: How do gmail users try out patches from this list?
Date: Tue, 11 Aug 2009 22:47:17 +0200
Message-ID: <20090811224717.785dcd27@eleanor>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 11 22:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayKc-0006WZ-Vk
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbZHKUwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 16:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbZHKUwW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:52:22 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62225 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZHKUwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 16:52:21 -0400
Received: by ewy10 with SMTP id 10so4097549ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=E+VSZpDPqaAtBPIqjS58jmkNvIQxjRzBOHTtdJbvjaU=;
        b=cja8gaPSOWbNs4WhdxmsEqI9jZLYRDy4uhJBGQZJrtHSl6ubHToCkua83n04cVn8bp
         eYx3PEXoMMHoiDAYugjX6mcK/005/R2YtC3R3gBGAZtGuWy9y+PEpBuLICd1hhmtFPee
         Qpno4gD0NJwjX8X2XeB27hLTVcGwGy3tHXdU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=t0HHjr1tSzRY+zWOb2zBclq5SvZZraL22Ih1cEE1kLQNbLaq2T3ESkzV9M3xArUg4h
         fFC/8M2uj9GZWy8tRxDGWyy/+0NEnc+iOpCREh2RJyF/FFemeCrrFoF7cYpNT8XRXT+Y
         ki7Vg1gixS4XxWnQvN4wFPVRvmlPfOobHn4rg=
Received: by 10.211.201.8 with SMTP id d8mr1461675ebq.50.1250023941422;
        Tue, 11 Aug 2009 13:52:21 -0700 (PDT)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 10sm873004eyz.21.2009.08.11.13.52.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 13:52:21 -0700 (PDT)
In-Reply-To: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125596>

To quote Documentation/SubmittingPatches:

GMail does not appear to have any way to turn off line wrapping in the =
web
interface, so this will mangle any emails that you send.  You can howev=
er
use any IMAP email client to connect to the google imap server, and
forward the emails through that.  Just make sure to disable line wrappi=
ng
in that email client.  Alternatively, use "git send-email" instead.

Submitting properly formatted patches via Gmail is simple now that
IMAP support is available. First, edit your ~/.gitconfig to specify you=
r
account settings:

[imap]
	folder =3D "[Gmail]/Drafts"
	host =3D imaps://imap.gmail.com
	user =3D user@gmail.com
	pass =3D p4ssw0rd
	port =3D 993
	sslverify =3D false

You might need to instead use: folder =3D "[Google Mail]/Drafts" if you=
 get
an error that the "Folder doesn't exist".

Next, ensure that your Gmail settings are correct. In "Settings" the
"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.

Once your commits are ready to send to the mailing list, run the follow=
ing
command to send the patch emails to your Gmail Drafts folder.

	$ git format-patch -M --stdout origin/master | git imap-send

Go to your Gmail account, open the Drafts folder, find the patch email,
fill in the To: and CC: fields and send away!

Best Regards

Emmanuel Trillaud

Le Tue, 11 Aug 2009 13:43:13 -0700,
skillzero@gmail.com a =C3=A9crit :

> Sorry if this is dumb question, but I didn't see any good info in my
> searches.
>=20
> How do gmail users normally apply patches that come through the list?
> Do you just manually copy and paste the email to patch files and use
> git apply? Do you use a tool to export to mbox files and use git am?
>=20
> I've been just doing it manually via copy and paste, but it's kinda
> tedious. --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
