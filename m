From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Painless namespaces design
Date: Wed, 15 Jun 2011 07:00:00 -0700
Message-ID: <BANLkTiktjki43wCX5d2SV+tKjp_fqmGznw@mail.gmail.com>
References: <1307487890-3915-1-git-send-email-jamey@minilop.net> <4DF894FD.9040808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jamey Sharp <jamey@minilop.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 16:00:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWqdv-00064m-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 16:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab1FOOAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 10:00:22 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48438 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab1FOOAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 10:00:21 -0400
Received: by ywe9 with SMTP id 9so234869ywe.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 07:00:20 -0700 (PDT)
Received: by 10.236.148.193 with SMTP id v41mr870135yhj.32.1308146420188; Wed,
 15 Jun 2011 07:00:20 -0700 (PDT)
Received: by 10.147.35.2 with HTTP; Wed, 15 Jun 2011 07:00:00 -0700 (PDT)
In-Reply-To: <4DF894FD.9040808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175832>

2011/6/15 Jiang Xin <worldhello.net@gmail.com>:
> I like the idea of new namespaces feature from Josh Triplett, Jamey S=
harp and others.
> I think it is better to pass namespace through remote.remote-name.nam=
espace variables,
> not through GIT_NAMESPACE environment.
=2E..
> =A0 =A0[remote "origin"]
> =A0 =A0 =A0 =A0namespace =3D foo
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/remotes/origin/*
> =A0 =A0 =A0 =A0url =3D ssh://Host1/path/to/project.git
>
> When UserA runs `git fetch`, it's just like
>
> =A0 =A0git fetch origin refs/namespaces/foo/refs/heads/*:refs/remotes=
/origin/*

This is less than ideal. Part of the rationale for the GIT_NAMESPACE
environment variable is to allow the server to restrict the namespace
and only show that specific slice of the repository's refs to the
client. It allows a server administrator to put several logical
repositories into a single repository, and have clients be oblivious
to this fact.

--=20
Shawn.
