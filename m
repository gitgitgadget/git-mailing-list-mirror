From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 9/9] refs: use warning() instead of fprintf(stderr, 
	"warning: ")
Date: Tue, 24 Mar 2009 02:28:07 +0100
Message-ID: <40aa078e0903231828t2c5ff976m491ba0f739b0ea27@mail.gmail.com>
References: <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
	 <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
	 <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
	 <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org>
	 <5e3412be5d72bce2bf36fdcc2734b89386fdfc21.1237856682.git.vmiklos@frugalware.org>
	 <cover.1237856682.git.vmiklos@frugalware.org>
	 <607f1ab07464931305b62599805f898e2bf2ca98.1237856682.git.vmiklos@frugalware.org>
	 <f6b2ede9af2bd40ce89f0251b32861098af46aad.1237856682.git.vmiklos@frugalware.org>
	 <40aa078e0903231817g41fd1bc1s296121d85923f7ea@mail.gmail.com>
	 <20090324012334.GL27459@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvSX-0002Wl-E7
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZCXB2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbZCXB2M
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:28:12 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:56425 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbZCXB2K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 21:28:10 -0400
Received: by ewy9 with SMTP id 9so1889379ewy.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 18:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i+bpdbqS7NOTsFW7pQzIo9Gy808OMc599FXo1HFVuEE=;
        b=MM4IgtgR3n+Ori+nOhIg3Uanz6wcNb8bwnTWWUgMHsExlJMo3efw/xLpzQwvTGkgAS
         SH9pJoe8zYRIOAgnpMHE2wnVsd/FMrKRLQ7v4uFB6pr6lNoepl5EMDH3C83emsOCsOVs
         /LB6NgGeT7D8Dk96EAfNTpKj4ikfHa1wXmvaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vdAzHCdk8ZI4BibT6PM6+T6+hxNIvz7nY9AA0FbknFDRhBUbY0xKWi389e0/XsE9BC
         g0oa985W4yimSfjhYfXwNb4ivDwCXr0R4Q9o0LcZaBpowIyOAUcdVT4S1awuSF8jYrzm
         62Ph+qBxeJE2cJYAhrQZtQjMyLkMu4hI8qrKE=
Received: by 10.210.144.8 with SMTP id r8mr2773300ebd.28.1237858087227; Mon, 
	23 Mar 2009 18:28:07 -0700 (PDT)
In-Reply-To: <20090324012334.GL27459@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114387>

OK, sorry for not reading the old discussion before commenting. :)

On Tue, Mar 24, 2009 at 2:23 AM, Miklos Vajna <vmiklos@frugalware.org> =
wrote:
> On Tue, Mar 24, 2009 at 02:17:24AM +0100, Erik Faye-Lund <kusmabite@g=
ooglemail.com> wrote:
>> > @@ -996,7 +996,7 @@ int delete_ref(const char *refname, const unsi=
gned char *sha1, int delopt)
>> >
>> > =A0 =A0 =A0 =A0err =3D unlink(git_path("logs/%s", lock->ref_name))=
;
>> > =A0 =A0 =A0 =A0if (err && errno !=3D ENOENT)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "warning: unlink(%s)=
 failed: %s",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("unlink(%s) failed: %s",
>>
>> Doesn't this add a newline? The original string doesn't have a '\n' =
at
>> the end of the format-field, but AFAIK warning() terminates with one=
=2E
>> I'm not saying it's a problem, I'm just pointing it out.
>
> Yes, it adds. As Jeff pointed out earlier in this thread, the lack of
> newline was a bug:
>
> http://article.gmane.org/gmane.comp.version-control.git/110783
>



--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
