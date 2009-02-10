From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
	an asterisk
Date: Tue, 10 Feb 2009 08:52:14 +0100
Message-ID: <20090210075214.GC1320@atjola.homenet>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 08:54:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWnRU-0004tt-N7
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 08:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbZBJHwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 02:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbZBJHwh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 02:52:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:56585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751398AbZBJHwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 02:52:37 -0500
Received: (qmail invoked by alias); 10 Feb 2009 07:52:34 -0000
Received: from i577B8B51.versanet.de (EHLO atjola.local) [87.123.139.81]
  by mail.gmx.net (mp026) with SMTP; 10 Feb 2009 08:52:34 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/PpekSiSjP1RVfm/yp3aMZm1WnIqeTdbYDioPdPB
	ZuI9onbAD6AHVW
Content-Disposition: inline
In-Reply-To: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109184>

On 2009.02.09 18:32:06 -0500, Jay Soffian wrote:
> Teach git branch -{r,a} how to interpret remote HEADs and highlight t=
he
> corresponding remote branch with an asterisk, instead of showing lite=
ral
> "<remote_name>/HEAD".

Hm, what's the use case for having such a marker? And since only "git
clone" sets up origin/HEAD, while "git remote add foo git://..." won't
create foo/HEAD, you would get that marker for origin only. Also, the
origin/HEAD symref isn't updated, so it doesn't tell you which branch
is "active" in the remote repository now, but which one was active when
you cloned the repo.

So basically, what that marker would tell you is that you can use
"origin" as a short-shortname for the remote tracking branch that has
the marker. I don't see how that is very useful.

If the <name>/HEAD symref would be created for all remotes and would ge=
t
updated, that would at least make the marker more meaningful, but I
still don't really see what I'd use it for. From what I've heard, some
people just consider origin/HEAD a clone artifact without much use, and
so far, I think I agree. But maybe there's more to it?

Bj=F6rn
