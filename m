From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: frustrated forensics: hard to find diff that undid a fix
Date: Sat, 5 Mar 2011 10:00:45 +0000
Message-ID: <AANLkTinKmgnVN+zyhu03yiH4z2ucxqd9yBn+6f7ptnp0@mail.gmail.com>
References: <4D71D63E.3030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 12:02:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvpG4-00069J-QU
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 12:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab1CELCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 06:02:43 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:35667 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab1CELCm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 06:02:42 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55135)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1PvoIO-0002d3-5w
	for git@vger.kernel.org; Sat, 05 Mar 2011 05:01:08 -0500
Received: by qwd7 with SMTP id 7so2227744qwd.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 02:01:05 -0800 (PST)
Received: by 10.224.46.230 with SMTP id k38mr1425240qaf.325.1299319265408;
 Sat, 05 Mar 2011 02:01:05 -0800 (PST)
Received: by 10.229.188.205 with HTTP; Sat, 5 Mar 2011 02:00:45 -0800 (PST)
In-Reply-To: <4D71D63E.3030907@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168487>

On 5 March 2011 06:20, Adam Monsen <haircut@gmail.com> wrote:
> I made a fix a month ago on the master branch in a shared repo. A wee=
k
> later, a colleague did a merge that undid the fix. I didn't figure ou=
t
> the problem until just now because I'd been assuming the fix was stil=
l
> on master. I mean, if it wasn't, I should see a reverse patch using "=
git
> log -p master", right? Wrong. Turns out the fix was undone as part of
> merge conflict resolution (I think).
>
> Is there some way to include merge conflict resolutions in "git log -=
p"
> or "git show"? Apparently some important information can be hidden in
> the conflict resolution. Or, more likely, I just don't understand how
> this bit of git works.
>
> I also tried bisect and pickaxe. Bisect wrongly identified the first =
bad
> commit, and pickaxe just didn't see the change at all.
>
> =C2=A0 =C2=A0~ * ~
>
> Here's some details in case anyone wants to (a) point out where I mes=
sed
> up or (b) help me avoid this kind of blunder in the future.
>
> 1. The repo is git://mifos.git.sourceforge.net/gitroot/mifos/head
> (mirror: https://github.com/mifos/head ). Branch master.
>
> 2. My commit 2a1ed0436 introduced a fix that includes the text
> "native2ascii". Shows up in "git log -p -1 2a1ed0436" and "git show
> 2a1ed0436". Life is good.
>
> 3. It appears that the merge commit 0f8132386 tossed my "native2ascii=
"
> fix. The only way I could figure out to actually visualize this is "g=
it
> diff 58320586..0f813238".
>
> This took a while to figure out. Am I missing something obvious?


Seems like a bunch of people (myself included) have been tripped up by
this behaviour in the past few months.   Did something change to start
this, or has it always been there?

-Jonathan
