From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Thu, 27 Aug 2009 06:33:10 -0700 (PDT)
Message-ID: <m3ws4pl6x7.fsf@localhost.localdomain>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
	<12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
	<20090825184525.GC23731@coredump.intra.peff.net>
	<7vprajmp16.fsf@alter.siamese.dyndns.org>
	<7v1vmycfhd.fsf@alter.siamese.dyndns.org>
	<7vy6p69j6a.fsf@alter.siamese.dyndns.org>
	<9e0f31700908270509o1031a027y1b49efe7ea9a4fd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Johan Sorensen <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 15:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgf6P-0001mZ-Na
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 15:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbZH0NdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZH0NdM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 09:33:12 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50703 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbZH0NdL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 09:33:11 -0400
Received: by bwz19 with SMTP id 19so962842bwz.37
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=zlAojq7xpDWlo53rjH4oBSHb+NsgziF4h7izI4wzfYY=;
        b=PfypPYYiyL9DQMqXTAUU3qldoZkb9DkKoWA44JJCkQUDJ3T7WPhla2Hg/FvVzADwr3
         k6eE5F9//OustCrqHhmjwmeksZQS+704UpJbPCvvSzQd4pHarrBZs9ylEtIhCL62aAxw
         XNmMraqU+gvWQzfmuQ3Jkq5XcZlQEYaBi/7jA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=ujS1+vKVnxPBLksFxNNA+N9V/YD4TY0Ts04ZMqlbujH86zKLoeWfo5U10kF7pE8lgr
         xsQ/kunaCvG8SQHt1SbBsPYWl434ATFK1cYIxzSbLndEdOEHqMYzMfcXf1TglHkL233H
         ripo/wSb2+9GsnIjH1j2EF17tnCG7JDVXz9uI=
Received: by 10.102.165.24 with SMTP id n24mr4378603mue.47.1251379991576;
        Thu, 27 Aug 2009 06:33:11 -0700 (PDT)
Received: from localhost.localdomain (abwt249.neoplus.adsl.tpnet.pl [83.8.243.249])
        by mx.google.com with ESMTPS id y6sm695058mug.40.2009.08.27.06.33.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 06:33:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7RDW6TN007198;
	Thu, 27 Aug 2009 15:32:17 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7RDVXma007189;
	Thu, 27 Aug 2009 15:31:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9e0f31700908270509o1031a027y1b49efe7ea9a4fd3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127159>

Johan Sorensen <johan@johansorensen.com> writes:
> On Thu, Aug 27, 2009 at 2:47 AM, Junio C Hamano <gitster@pobox.com> w=
rote:

> > After upload-pack successfully finishes its operation, post-upload-=
pack
> > hook can be called for logging purposes.
> >
> > The hook is passed various pieces of information, one per line, fro=
m its
> > standard input. =A0Currently the following items can be fed to the =
hook, but
> > more types of information may be added in the future:
> >
> > =A0 =A0want SHA-1::
> > =A0 =A0 =A0 =A040-byte hexadecimal object name the client asked to =
include in the
> > =A0 =A0 =A0 =A0resulting pack. =A0Can occur one or more times in th=
e input.
> >
> > =A0 =A0have SHA-1::
> > =A0 =A0 =A0 =A040-byte hexadecimal object name the client asked to =
exclude from
> > =A0 =A0 =A0 =A0the resulting pack, claiming to have them already. =A0=
Can occur zero
> > =A0 =A0 =A0 =A0or more times in the input.
> >
> > =A0 =A0time float::
> > =A0 =A0 =A0 =A0Number of seconds spent for creating the packfile.
> >
> > =A0 =A0size decimal::
> > =A0 =A0 =A0 =A0Size of the resulting packfile in bytes.
>=20
> Neat. And feeding it lines gives more room for future additions.
>=20
> I'd like to suggest the following line from the original patch:
>=20
>    full-pack integer::
>         1 if the request was considered a full clone, 0 if it was a
> partial update (fetch)
=20
If it is all "want" and no "have", it is clone or fetch into empty
repository.  If additionaly "want"s cover all refs, it is a clone.
No need to pass this information: it can be derived.

> Also, on a similar note; in the little git-daemon (a tiny fork+exec
> server in ruby) included with Gitorious there's a geo-ip lookup based
> on the client addr. It would be fun if the client ip could be passed
> along to this hook as well, but that would require passing it along
> all the way from before fetch-pack is invoked as far as I can see..?

Well, we can pass at least `client-ip`...

[please don't quote what is not needed]
--=20
Jakub Narebski
Poland
ShadeHawk on #git
