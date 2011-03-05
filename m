From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Sat, 5 Mar 2011 10:49:58 +0000
Message-ID: <AANLkTimp8B5Lv15qhGOwOzh+kqOS0g3Xwvgib8vyk+m+@mail.gmail.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com> <AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ruben Laguna <ruben.laguna@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 11:50:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvp49-0001Fc-7W
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 11:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab1CEKuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 05:50:24 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:35090 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1CEKuX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 05:50:23 -0500
X-Greylist: delayed 2951 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Mar 2011 05:50:23 EST
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64128)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1Pvp40-0004Mt-Fz
	for git@vger.kernel.org; Sat, 05 Mar 2011 05:50:20 -0500
Received: by qwd7 with SMTP id 7so2240959qwd.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 02:50:18 -0800 (PST)
Received: by 10.229.67.142 with SMTP id r14mr1311753qci.209.1299322218329;
 Sat, 05 Mar 2011 02:50:18 -0800 (PST)
Received: by 10.229.188.205 with HTTP; Sat, 5 Mar 2011 02:49:58 -0800 (PST)
In-Reply-To: <AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168485>

On 5 March 2011 10:05, Ruben Laguna <ruben.laguna@gmail.com> wrote:
> Hi,
>
> I had a repo which was big 143MB because it contained a bunch of jar
> files. So I decided to remove those completely from the history.
>
> In short I used the git-large-blob [1] to find all the jars and used
> the git-remove-history script [2] which does the filter-branch thing,
> prune, etc.
>
> I did this on all branches (that I know of) and now I can see that th=
e
> jars are gone because I can't find them with git-large-blob. =C2=A0an=
d the
> repo size has dropped from 143Mb to 87Mb.
>
> My concern is that 87Mb is still really big taking into account he
> size of the project. =C2=A0in fact if I run "git diff-tree -r -p $com=
mit
> |wc -c" for each commit and sum all I get 5.5Mb.
>
>
> I also ran the git-rev-size [3] script that I found in this mailing
> list and I only see that the size grows steadly from commit to commit
> up to 1482731 bytes. So again how come the .git directory is 87MB?
>
>
> So, Can anybody tell me if this repository size is "normal" for a
> project with 1.4MB source and 352 commits?
> Is there a better way to calculate the size (in bytes) of each commit=
?
>
> Is there any other thing I could do to reduce and audit =C2=A0the rep=
ository size?
>
>
> Thanks in advance!
> Rub=C3=A9n
>
> ---
> [1]=C2=A0http://stackoverflow.com/questions/298314/find-files-in-git-=
repo-over-x-megabytes-that-dont-exist-in-head
> [2]=C2=A0http://dound.com/2009/04/git-forever-remove-files-or-folders=
-from-history/
> [3] http://markmail.org/message/762zzg5zckbiq2i7

What happens if you clone that repo?
git-gc will only pruned unused objects that're older than 2 weeks by
default, so it's possible that your repo size will suddenly shrink in
2 weeks time (or sooner, if you run git-gc with the appropriate
options)
