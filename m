From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 10:56:57 +0100
Message-ID: <fabb9a1e0911300156l7f8dbe55p7da26540b0360773@mail.gmail.com>
References: <20091130075221.GA5421@coredump.intra.peff.net> 
	<fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com> 
	<20091130075927.GA5767@coredump.intra.peff.net> <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com> 
	<7v4oocwh5o.fsf@alter.siamese.dyndns.org> <fabb9a1e0911300035o532153b7qdc2ecd768200ce09@mail.gmail.com> 
	<7vr5rgv1lr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 10:57:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF30Z-0001Po-0c
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 10:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbZK3J5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 04:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbZK3J5M
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 04:57:12 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:35858 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbZK3J5L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 04:57:11 -0500
Received: by vws35 with SMTP id 35so1007696vws.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 01:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+cW3kv83W6baX7urrEOlWOvNfKzmFYft6gXaopo2k94=;
        b=bfop3LLWK11dWLXQnjaBdscrdWxGcam4vWc78B7dCdrLLhWmpxbhburOqw9GP2P1FN
         TuQTR78U5sdUH0k+eFoEYzLhPvjFxzj6+OXHqcrUKVERkMluSRWKxtWGDvRGR2OnJX9d
         lqfbVV11XjHS45ut8XPkOF5HOLFB6Q1YIEq2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=S1cU1Kt3VCEYX8O5w+8Zy6VxryRh75b7KRZm4LFzvOd3A7LMFYKVaFC7EADMQK6ItU
         puGB3j1UkrQmF3rOzW0SvY/euFMEepRlWaiJeNUyK0dAvJYCPpDv+PM2vJBQIuK8SLhK
         X2s3y55oonqW/Io9fZQFt9elJO1bRvQiMRA8o=
Received: by 10.220.123.105 with SMTP id o41mr4855745vcr.88.1259575037307; 
	Mon, 30 Nov 2009 01:57:17 -0800 (PST)
In-Reply-To: <7vr5rgv1lr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134089>

Heya,

On Mon, Nov 30, 2009 at 09:49, Junio C Hamano <gitster@pobox.com> wrote=
:
> Sorry, I don't understand that. =A0With that reasoning, isn't having =
a
> single git package, be it python or not, even easier? =A0Why would an=
ybody
> want a separate egg that includes everything that _happen_ to be writ=
ten
> in Python in the first place? =A0It doesn't make sense at all from pa=
ckaging
> point of view to me.

Because that's the recommended way to create a python package, create
a new directory, put the files in it, and distribute it.

> A separate egg per remote-helper that you can pick and choose which o=
nes
> to install and which ones to leave out would make perfect sense, exac=
tly
> the same way that distros already split git into "git-core", "git-svn=
",
> etc., though. =A0Your "git-hg" may consist of a single egg and perhap=
s some
> other supporting code, and people who want to convert away from legac=
y Hg
> repository may want to install it, but it is entirely up to them if t=
hey
> also want to install "git-cvs" that is implemented as a remote-helper=
 that
> happens to be written in Python, no?

Yes, fair enough, but we don't do that for any other files in git.git.
The packagers do so, sure, but a different concern. The reason we want
to distribute the git_remote_helpers package is so that
git-remote-hg.py, which lives in git.git/ and is installed as
git-remote-hg can say "from git_remote_helpers.hg import export".

The only reason this is needed in the first place is because we can't
just add the python files to libgit.a or embed it in git-remote-hg
statically, python does not support that. That is the only reason we
need to distribute the package, which is why we need a separate
directory.

That is, if I've understood Johan's reasoning and intention correctly.

--=20
Cheers,

Sverre Rabbelier
