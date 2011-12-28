From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT and SSH
Date: Wed, 28 Dec 2011 03:02:40 -0800 (PST)
Message-ID: <m38vlxez79.fsf@localhost.localdomain>
References: <loom.20111228T091942-66@post.gmane.org>
	<CA++fsGFOC6bV4gC+ozBKP3EmoAX4CcfTrHjjpMWPkh7vYOfgAw@mail.gmail.com>
	<20111228101512.GA2192@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dov Grobgeld <dov.grobgeld@gmail.com>,
	Reza Mostafid <m.r.mostafid@gmail.com>, git@vger.kernel.org
To: =?utf-8?b?Q2FybG9zIE1hcnTDrW4gTg==?= =?utf-8?b?aWV0bw==?= 
	<cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Dec 28 12:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfrHY-0006op-4i
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 12:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab1L1LCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Dec 2011 06:02:44 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40401 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab1L1LCm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2011 06:02:42 -0500
Received: by wibhm6 with SMTP id hm6so5497456wib.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 03:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=m4oybvcaA71u+A53N6+CnLlIQ6NuNm9ZXqEeEJay2oY=;
        b=T1bRcdimtzLqGBH8QUGzScjtK7EqemyhVKEIjca+4uUyBIICqro3OEQXgrVBUoRuoY
         QeUmDjypeNGPquO0AcKIuNfQUILu44kPVrA8dVN+A7wsSPWboPOE5eCHV4AHqq66Ydwu
         /1fORJbkmPsRQTtEtJJdzWLKAERQqHjQooKVQ=
Received: by 10.180.19.106 with SMTP id d10mr69425286wie.2.1325070161306;
        Wed, 28 Dec 2011 03:02:41 -0800 (PST)
Received: from localhost.localdomain (abwj79.neoplus.adsl.tpnet.pl. [83.8.233.79])
        by mx.google.com with ESMTPS id w8sm73513061wiz.4.2011.12.28.03.02.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Dec 2011 03:02:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBSB2a3b011335;
	Wed, 28 Dec 2011 12:02:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBSB2Zeo011332;
	Wed, 28 Dec 2011 12:02:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20111228101512.GA2192@beez.lab.cmartin.tk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187750>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> On Wed, Dec 28, 2011 at 11:55:24AM +0200, Dov Grobgeld wrote:

> > Git supports multiple transport protocols. Among them are git, ssh,
> > and https. (You can also use direct file system access, but it is
> > questionable whether to call that a protocol). Each of the protocol=
s
> > have their advantages and drawbacks. The git protocol is only used =
for
> > reading, and not for writing, but is supposed to be very fast. The

=46YI git:// protocol can theoretically be used for pushing, but it is
not recommended because git:// protocol is not authenthicated - that
is why you need to enable pushing via git:// explicitly.

Just git trivia.

> > common firewall filtering of the git protocol port 9418 is another
> > problem. ssh is the prefered protocol for writing to a remote
> > protocol. But if ssh is filtered, then http/https may be used, whic=
h
> > is very slow for large repositories, but it has the advantage that =
it
> > is the least blocked protocol.
>=20
> Slow for large repositories? Are you thinking of the dumb HTTP
> transport? That one shouldn't be used for doing any serious work. The
> Smart HTTP transport is just the git smart protocol (the same one
> git:// and ssh:// URLs speak) wrapped inside HTTP communication. The
> negotiation phase is a more expensive than with either git or ssh, as
> HTTP is stateless and you need to remind the remote what you want and
> what you've already agreed on, but the actual transfer of data is don=
e
> the same way than with the others so overall it shouldn't be that
> noticeable.

Note that for "smart" transports ("smart" HTTP, SSH) you need to have
git installed on server, or at least have git-upload-pack and
git-receive-pack somewhere (you can configure client where it is to be
found on server).
=20
Note that git uses curl for both smart and dumb HTTP transports, so
things like 'http_proxy' and 'HTTPS_PROXY' environment variables
should work.

> Now, to the OP's concerns: yes, the ssh transport does generate ssh
> transport, as that's the whole point. You authenticate against the
> remote machine's ssh daemon and run git-upload-pack or
> git-receive-pack as needed (for fetching or pushing). If corporate
> policy doesn't allow ssh you should either fix the policy or use the
> smart HTTP protocol, though this involves messing with passwords and
> their associated problems. I'm not saying ssh keys don't have their
> complications, but I much prefer them.

Note that if the problem is giving shell accounts with SSH access, the
solution is to use one of git repository management tools, like
Gitosis (Python + setuptools, no longer developed) or Gitolite (Perl).
=46rom what I remember both use _single_ *restricted* account and
public-key authenthication.
=20
If I am not mistaken Gitolite can help with "smart" HTTP transport
access too.

> We can't help you diagnose why your clone is stalling without more
> information. It could be that the connection between the computers is
> flaky, git trying to take too much memory on the remote or local
> machines or any number of things. See if setting GIT_TRACE=3D1 in the
> environment helps to see what's going on.

Or even undocumented (!) GIT_TRACE_PACKET.

--=20
Jakub Narebski
