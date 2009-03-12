From: John Tapsell <johnflux@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 17:45:56 +0000
Message-ID: <43d8ce650903121045s74584d97o708d4f8fd2baf664@mail.gmail.com>
References: <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
	 <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
	 <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl>
	 <20090312153738.GA24690@coredump.intra.peff.net>
	 <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com>
	 <20090312163533.GA28205@coredump.intra.peff.net>
	 <EAF5D3F1-32F2-4BF3-9B10-F91C17D06A6A@ai.rug.nl>
	 <20090312165153.GA28401@coredump.intra.peff.net>
	 <43d8ce650903120958n18baf6c0w9d083976b52d6e40@mail.gmail.com>
	 <20090312171420.GA2192@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:49:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhp1a-0003Ba-Hy
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 18:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbZCLRqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439AbZCLRp7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 13:45:59 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:54898 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756497AbZCLRp5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 13:45:57 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1198603wfa.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qtZw9vGH7yAJAAEhzoUXVSm2eWRtURqbryx+mGrTW6g=;
        b=gnNCyC1AapcWGhTSZdr1cr7fwbpco/Az/KbeN4WCmrftOQVvgcJjo/WXuQC53www3g
         XkDcFAS+OZ4Fyh4hbB8AxigmH1gjYZ7pQ3+w287HDPtJ2zBuZpgReI+7eSYlvsA8+X0Z
         QWKP8LCxpOzg4WDK8xiMAeckInz30mZLnF3Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZbngLWtvR/ak1L6tT3uhZGWNDSLkxN5+FE3dBjhxrjoDLeG0b6h94Ty6y+AD+yAxaj
         uNJOuoYpebJXRwKCJ9rCOkMhsrsYtNdfa2Zq/3Qy1Xo2o4i/tsGW7C478T/jKNCY6lVs
         vvBtIpXpDtnfKGL9+njfyUw046zhYoaQ3ZNhk=
Received: by 10.142.82.13 with SMTP id f13mr87480wfb.290.1236879956104; Thu, 
	12 Mar 2009 10:45:56 -0700 (PDT)
In-Reply-To: <20090312171420.GA2192@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113096>

2009/3/12 Jeff King <peff@peff.net>:
> On Thu, Mar 12, 2009 at 04:58:22PM +0000, John Tapsell wrote:
>
>> > - =C2=A0 =C2=A0 =C2=A0 if (resolve_ref(ref.buf, sha1, 1, NULL)) {
>> > + =C2=A0 =C2=A0 =C2=A0 if (dwim_ref(name, strlen(name), sha1, &jun=
k)) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(junk);
>>
>> Presumably 'junk' is the resolved name? =C2=A0I wonder if it's worth
>> putting this info in the error message?
>
> Hey, I said it was sloppy, right? ;)
>
> Here's your suggestion, plus specifying which situation (existing bra=
nch
> or ambiguous ref) would occur. It would still need tests. But I'm
> curious to hear more opinions on this direction before cleaning it up
> much more (at the very least, it needs some tests).

I like :-)  Just minor comments:

> --- a/branch.c
> +++ b/branch.c
> @@ -133,6 +133,7 @@ void create_branch(const char *head,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char sha1[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *real_ref, msg[PATH_MAX + 20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf ref =3D STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 char *existing;

Don't suppose you could set this NULL.  Just in case dwim_ref doesn't
set &existing for whatever reason.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0int forcing =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int len;
>
> @@ -146,12 +147,18 @@ void create_branch(const char *head,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_ref_format(ref.buf))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("'%s' is n=
ot a valid branch name.", name);
>
> - =C2=A0 =C2=A0 =C2=A0 if (resolve_ref(ref.buf, sha1, 1, NULL)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!force)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("A branch named '%s' already exists.", name);
> + =C2=A0 =C2=A0 =C2=A0 if (dwim_ref(name, strlen(name), sha1, &existi=
ng)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!force) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!prefixcmp(existing, "refs/heads/"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("A branch named '%s' already ex=
ists.",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("Creating '%s' would be ambiguous with"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 " the existing %s", name, existing);

Maybe put single quotes around the second %s, for consistency with the =
first?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!is_b=
are_repository() && !strcmp(head, name))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die("Cannot force update the current branch.");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0forcing =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(existing);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0real_ref =3D NULL;
>
