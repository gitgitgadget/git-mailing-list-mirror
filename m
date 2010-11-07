From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: import determinism
Date: Sun, 7 Nov 2010 17:20:17 -0500
Message-ID: <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com>
 <m2lj54u9uj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	weigelt@metux.de, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Nov 07 23:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFDbZ-0003GW-Dr
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 23:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab0KGWUk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 17:20:40 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40013 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0KGWUj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 17:20:39 -0500
Received: by iwn41 with SMTP id 41so3306858iwn.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V0smgV3bH6xU1fwn1c7wKSn3B+UbRae5zarXfKEkNPo=;
        b=fcKYdDvqny3bQMAhcXsDXMiahl4LvcDWTLO2vMMvMSCXmx9U+9iecjwl3uDq+Nh0Dn
         yjUNk4TjlmZDq8o9CiDQamdIHKLumJQTyYMH7a2j4gSyfgCSXAMd+b0CXNZN6MVKxWlq
         A5qpqpY59e7Zafr0VTO0oifudB/t8Anga3POc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oLCP6YuamkOjTzPW1UibRJ96wk9dVDOBi3RB5ag7kNjvSkJiCY57BZRnpjmQSbZjh5
         JiD3vXBfocyWvOsvEB4FsK2z7eij/R+2hdz3WzDMVed1y4V17qMMhSpZE5bhlki6SHpu
         qi3x2ZYCc/ZFaVhZ3m0Zr1e9VpvPGZOlcHhr0=
Received: by 10.42.169.2 with SMTP id z2mr223848icy.452.1289168437605; Sun, 07
 Nov 2010 14:20:37 -0800 (PST)
Received: by 10.231.16.65 with HTTP; Sun, 7 Nov 2010 14:20:17 -0800 (PST)
In-Reply-To: <m2lj54u9uj.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160904>

On Sun, Nov 7, 2010 at 4:01 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> The committer info in every commit will be the same as the author inf=
o,
> so the repository conversion is completely deterministic.

=46or cvsimport, it is not deterministic. Given cvs'
ambiguous/buggy/inconsistent internal semantics around some
operations, cvsps makes educated guesses about what happened.

Later commits can affect those educated guesses.

IIRC, this affects the exact tree at the birth of a branch, and files
added on a branch (instead of on HEAD).

If you use cvsimport in 'incremental' runs you won't have this
problem. Whatever it decided to do, sticks.

I haven't worked in detail with Keith Packard's parsecvs but I assume
it has similar issues.

hth,


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
