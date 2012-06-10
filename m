From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH/RFC] Documenation update: use of braces in if/else if/else chain
Date: Sun, 10 Jun 2012 16:52:18 -0400
Message-ID: <CAA3EhHLepTC2WThDvAWk5WPcMPQapqo=D7KhpdCESy9D9JO4vg@mail.gmail.com>
References: <1339349190-84552-1-git-send-email-muhtasib@gmail.com> <20120610202205.GA2052@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	konglu@minatec.inpg.fr
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 22:52:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdp7s-0004tp-83
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 22:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831Ab2FJUwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 16:52:40 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57392 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab2FJUwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 16:52:39 -0400
Received: by vcbf11 with SMTP id f11so1777026vcb.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FqRgLWyVVtqE+9cEj1P+NRvH0jM8iV1STERp1xsLLNE=;
        b=IKcGYkKAdVlGXB5dkecxYdgpcadbixv7Th69GEDjk6eF/PopeAGQarf3UehY5SAoJo
         mnEK6XYzf8hdvLHydoChLN2pphvygZ/NmDh+fxxs9ZP/lpmOZm+TiDZrERqZxkR/UEYR
         vzu/i5xhDFUBlD+/RYoV5YczK4Z8ymcmhAPZNOz2MTxmfpcgjbAhWS/i1j+GkZ9kF3pV
         Wvyh7SuTwfLxxUti9oTCD/oEfW4Iuge5MJDhubH/oDlBAiVGwZJScZGTqGl3qeOhqzeI
         p0t9zxEC2szZ1GtA7h8vCtfIKGe/FgRNRwI+2yc6LhJfZ+PW2Ebj/ivJR4wfBwYLA+5+
         P+fA==
Received: by 10.220.230.135 with SMTP id jm7mr11275630vcb.23.1339361558644;
 Sun, 10 Jun 2012 13:52:38 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Sun, 10 Jun 2012 13:52:18 -0700 (PDT)
In-Reply-To: <20120610202205.GA2052@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199625>

On Sun, Jun 10, 2012 at 4:22 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Also true. =A0But:
>
> =A0 =A0 =A0 =A0/* correct */
> =A0 =A0 =A0 =A0if (bla) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D 2;
>

According to a discussion on my patch, this was cited (not in ref to my=
 code):
Junio C Hamano <gitster@pobox.com> a =E9crit :

Two points on style (also appear elsewhere in this patch):

       if (!"applying") {
               ...
       } else {
               state->rebase_in_progress =3D 1;
       }

 - "else" comes on the same line as closing "}" of its "if" block;

 - if one of if/else if/else chain has multiple statement block, use {}
  even for a single statement block in the chain.


So I opened this documentation patch to gain consensus around this
issue, and update the docs accordingly. Depending on the agreement
reached, I can modify the wording of the patch. I don't need to site
the linux Kernel part, I can just say what is supported in this
project.


I think we should still keep this part of the patch:

+    And "else"
+   should come on the same line as the closing "}" of its "if" block.


> And:
>
> If you have a long "if" with a one-line "else", consider whether you
> are needlessly keeping the reader in suspense about something simple.
> It might be more pleasant to read with the exceptional case up front:
>
> =A0 =A0 =A0 =A0if (!bla) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D 2;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0}
>
> This is especially true when the exceptional case returns or exits.
>
> =A0 =A0 =A0 =A0if (bla && no_bla)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error("--blah and --no-blah can=
not be used together");
> =A0 =A0 =A0 =A0x =3D 1;
> =A0 =A0 =A0 =A0...

Agreed!

Thanks,
Leila
