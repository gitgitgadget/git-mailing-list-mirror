From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
	case
Date: Fri, 4 Sep 2009 21:35:21 +0200
Message-ID: <fabb9a1e0909041235x74a3b9b4gf65e650ca0d00831@mail.gmail.com>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> 
	<fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com> 
	<alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org> 
	<alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0909041429540.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 21:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjeZg-0007tc-8n
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 21:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbZIDTfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 15:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757260AbZIDTfp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 15:35:45 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:60427 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757258AbZIDTfk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 15:35:40 -0400
Received: by ewy2 with SMTP id 2so719718ewy.17
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Zm+So3SSp9FKmfpsM62SmdkQOqQNAsYUxJL3N1VB/x8=;
        b=fjXGirDdz3S5hH+Jv0mQIQQK441obVoDXvRbNqu9jknieWjMerSFubTDXizmn98zHU
         qRgDx6/3yy5+GtoxCC0jlPKJRU1ISMLInBADueR1hv39gMbyT0OqWwCAXSI0Ro/aSC7i
         pCbY96T+09ZWBT55Sm0jjkBFb4IGdDAtALwwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eWSnvms4B1/OiNriHkGZPhZOBJVtn3P3vT6MF/KVs7d+ZhyamvpMLa4kJGTRbKH4E+
         3gl07wS9R3D0/ctshnB3MGA+m9mV+hTd+VTJMENqWOPwfmiKARy+NfB5Xk1ht3DOI1AO
         yaIOkmPxE96BxbrQT/vc2lyF4/bNN1rzXYack=
Received: by 10.216.45.207 with SMTP id p57mr2250186web.94.1252092941425; Fri, 
	04 Sep 2009 12:35:41 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0909041429540.28290@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127762>

Heya,

On Fri, Sep 4, 2009 at 21:05, Daniel Barkalow<barkalow@iabervon.org> wr=
ote:
> Some foreign vcses, including the only one I ever personally use, do =
not
> have URLs, and require a bunch of options and paths to specify a
> repository. I don't want to have to use:
>
> =A0 =A0 =A0 =A0url =3D p4://rsh:ssh+-q+-a+-x+-l+p4ssh+-q+-x+perforce+=
%2Fbin%2Ftrue//projects/foo/bar-1.0/...,//projects/foo/bar-1.1/...

Btw, doesn't p4 have these config files that you can download that
contain the configuration? In that case
'p4://example.org/p4/main-development.configfile' would be very
convenient.

Regardless, I do think there should be some way to specify all this
outside of the url, but to me that's secondary. I think the primary
usecase is/should be cloning from some url in the form of
'hg://example.org/foo', rather than 'http://example.org/some-hg-repo'
or 'p4://.......', since those are both exceptions (the former being
an ambiguous url, and the latter being a non-url). Now I do understand
if you don't want to spend your time on implementing the specialized
url support since it doesn't scratch your itch, but at least your
series shouldn't impend supporting that in the near future.

> For cases where the foreign vcs has something to put in the "url" spo=
t,
> you don't need to set "vcs". In fact, you are only allowed to set one=
 or
> the other of "vcs" and "url" with my current version. What you're
> interested in is explicitly left for later, when we have a prototype
> helper for such a foreign vcs and can try it out with potential users=
=2E

I need to hurry up and get working on that hg implementation then :).

--=20
Cheers,

Sverre Rabbelier
