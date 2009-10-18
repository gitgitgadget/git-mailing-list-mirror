From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/3] DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Mon, 19 Oct 2009 05:20:43 +0900
Message-ID: <20091019052043.6117@nanako3.lavabit.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	<alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	<7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	<7vaazpxha4.fsf_-_@alter.siamese.dyndns.org>
	<20091018193448.6117@nanako3.lavabit.com>
	<20091018120053.GA11391@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: B.Steinbrink@gmx.de
X-From: git-owner@vger.kernel.org Sun Oct 18 22:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzcFL-0008C4-EJ
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 22:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbZJRUUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 16:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbZJRUUo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 16:20:44 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44403 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250AbZJRUUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 16:20:42 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id B940711B8CA;
	Sun, 18 Oct 2009 15:20:47 -0500 (CDT)
Received: from 4448.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id ABF5WG32B036; Sun, 18 Oct 2009 15:20:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vIZIw+7j9wFyvd9SLa9ClPxknjt6t4qPW0o6uITExjJ3luz6nUt6VYh27xa4syqC/F2aKPPmI4OoGYXU96j9MvD5SSkLBeDerKoTl5/XNLQmw/opoYzuh+JE2HCT0h/rHqLwZQKwq8QjQP8PSFgJXg46TWsjS+AEadqRjT2Zq64=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091018120053.GA11391@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130610>

Quoting Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.10.18 19:34:48 +0900, Nanako Shiraishi wrote:
>> Quoting Junio C Hamano <gitster@pobox.com>
>>=20
>> > When 'frotz' is not a valid object name nor a tracked filename,
>> > we used to complain and failed this command.  When there is only
>> > one remote that has 'frotz' as one of its tracking branches, we ca=
n
>> > DWIM it as a request to create a local branch 'frotz' forking from
>> > the matching remote tracking branch.
>>=20
>> In the subject you used 'git checkout -b frotz origin/frotz'. Did yo=
u
>> forget to say '-t'?
>
> Hm, the DWIMmery only triggers when opts.track is
> BRANCH_TRACK_UNSPECIFIED, i.e. -t was not used. And it doesn't change
> opts.track when it DWIMs, so it respects branch.autosetupmerge, which
> would be overriden by -t. So it seems correct that -t is not in there=
=2E

I see.

A user who always wants tracking can set the config option and use=20
the new "git checkout frotz" shortcut, but a user who usually=20
doesn't want tracking doesn't have the config option and when he=20
wants tracking only for this new branch he can explicitly say "git=20
checkout -t origin/frotz", right?

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
