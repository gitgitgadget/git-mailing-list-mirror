From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git commit generation numbers
Date: Thu, 21 Jul 2011 13:33:21 -0700
Message-ID: <CAJo=hJsi-cVdNC+T4RiwXdsjypL3FPc8gPOL5qL9=tGj05xPGg@mail.gmail.com>
References: <m3mxg7sasa.fsf@localhost.localdomain> <20110721202722.3765.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com, anthonyvdgent@gmail.com, david@lang.hm,
	git@vger.kernel.org, hordp@cisco.com, nico@fluxnic.net,
	torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:33:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjzwK-0005CN-5b
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 22:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab1GUUdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 16:33:43 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:51085 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab1GUUdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 16:33:43 -0400
Received: by fxd18 with SMTP id 18so4020745fxd.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 13:33:41 -0700 (PDT)
Received: by 10.204.47.131 with SMTP id n3mr191538bkf.301.1311280421381; Thu,
 21 Jul 2011 13:33:41 -0700 (PDT)
Received: by 10.204.144.195 with HTTP; Thu, 21 Jul 2011 13:33:21 -0700 (PDT)
In-Reply-To: <20110721202722.3765.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177622>

On Thu, Jul 21, 2011 at 13:27, George Spelvin <linux@horizon.com> wrote=
:
>
> be enough for the time being. =A0As a local cache, it can be extended
> with a software upgrade. =A0There's no need to ever have support for =
two
> formats in any given release; just notice that the cache format is wr=
ong,
> blow it away, and regenerate it.

Don't assume that. Consider a repository stored on NFS that is
read-only to you. The NFS server has one version of Git installed, and
is using cache format A. You have a newer version of Git installed on
your workstation, using cache format B. Now you cannot use this
repository as a local filesystem... its only available to you over the
Git protocols. This breaks a number of people's environments.  :-)

Its better if we can avoid having to change file formats very often,
even if they are a local "cache".

--=20
Shawn.
