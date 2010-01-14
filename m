From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 13:21:17 +0800
Message-ID: <be6fef0d1001132121w4e25c7f0j760d71c136012401@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix>
	 <op.u6haiiiog402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Miles Bader <miles@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:21:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVI94-0002wu-Qh
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab0ANFVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 00:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506Ab0ANFVS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:21:18 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:37359 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab0ANFVS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 00:21:18 -0500
Received: by iwn32 with SMTP id 32so229009iwn.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 21:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0JzejMjA8pkEoeGnreQmFWHom+4PqBBSxjd6gGyGbPY=;
        b=taFANWq+BVtQlDvgKJJBZIkKwz2MWVGaj+b1MV2uRr91YPHCMksJKqV8XFM6SdC+We
         Ys8x4WOyDSO9OSaaeOLfu9+xmP8LYkDx/7Afp7QFWPrUATk3/3MWEQNHLYnsVZN053OU
         HOmq8EA8rAQXxzelTaBjy3eNm/p5y2Q1AAquc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XpQsmTkT6e5GQ3BD3yQ/aKV6vL3lppYC+W7IOgwvYBRg9PynCIDh2MDRlhReH55zRg
         P1koxqYni1pbd5dbddTKPvYllB2Vf2wA4vwwzx8SHhihjgHpNMB4HKfoRxeUTTSJD4Il
         v1n1+w3KK1dvoI6fywL44H68C275v4M25CCic=
Received: by 10.231.125.19 with SMTP id w19mr387293ibr.8.1263446477610; Wed, 
	13 Jan 2010 21:21:17 -0800 (PST)
In-Reply-To: <op.u6haiiiog402ra@nb-04>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136928>

Hi,

generally, it would be better if you could add some tests for this.

If I'm not wrong, the place to put it would be t5516-fetch-push.sh.

On Wed, Jan 13, 2010 at 11:55 PM, Rudolf Polzer <divVerent@alientrap.or=
g> wrote:
> On Wed, 13 Jan 2010 16:43:10 +0100, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:

please don't drop people from the Cc list - especially when you're
replying to somebody!

> From 123598516c7d4e1f83591e8dae64e2c76dc87c90 Mon Sep 17 00:00:00 200=
1
> From: Rudolf Polzer <divVerent@alientrap.org>
> Date: Wed, 13 Jan 2010 16:42:04 +0100
> Subject: [PATCH 1/2] Add a feature "git push --track" to automaticall=
y make
> the pushed branches tracking

Each patch should be sent out in its own mail. (As Matthieu has
recommended, you should check out Documentation/SubmittingPatches.)

> =A0static const char * const push_usage[] =3D {
> @@ -115,6 +116,36 @@ static int push_with_options(struct transport
> *transport, int flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "Pushing to %s\n", tra=
nsport->url);
> =A0 =A0 =A0 =A0err =3D transport_push(transport, refspec_nr, refspec,=
 flags,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &nonfastforwa=
rd);
> + =A0 =A0 =A0 if (err =3D=3D 0 && flags & TRANSPORT_PUSH_TRACK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ref *remote_refs =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transport->get_refs_lis=
t(transport, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ref *local_refs =3D get_local_he=
ads();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int match_flags =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & TRANSPORT_PUSH_ALL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_flags |=3D MATCH_=
REFS_ALL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & TRANSPORT_PUSH_MIRROR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_flags |=3D MATCH_=
REFS_MIRROR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!(flags & TRANSPORT_PUSH_DRY_RUN))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!match_refs(local_refs, &remote_refs=
, refspec_nr,
> refspec,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 match_flags)) {

It would be better if you can move this to
transport.c::transport_push(). It repeats what's already there, so you
don't have to configure match_flags, nor call match_refs, etc.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ref *next =3D re=
mote_refs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while(next) {
> [snip]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D=
 next->next;

In most places, this is done like this:

  struct ref* ref;
  for (ref =3D remote_refs; ref; ref =3D ref->next) {
    ...
  }

--=20
Cheers,
Ray Chuan
