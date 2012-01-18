From: Sam Steingold <sds@gnu.org>
Subject: Re: modifying the commits before push
Date: Wed, 18 Jan 2012 16:47:20 -0500
Message-ID: <87sjjc3cpj.fsf@gnu.org>
References: <87wr8o3nq0.fsf@gnu.org> <4F17291A.8020600@dirk.my1.cc>
Reply-To: sds@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed Jan 18 22:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RndLt-0007N8-IG
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 22:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab2ARVrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 16:47:25 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41898 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2ARVrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 16:47:24 -0500
Received: by qcsf13 with SMTP id f13so2994363qcs.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent
         :mail-copies-to:return-receipt-to:reply-to:x-attribution
         :x-disclaimer:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=FL5P7pPTUefRq4r1XMPVwT/gurKvWpJtNzTeNQiT4wY=;
        b=TMUetUl87MvzD23VUuXYoATp+9RsA7K4vLl3u2rgubxhCQ1tkxExy0y2iTYnrpoE1K
         gfqlHzpadwjcQyzG7xy3Z7o3EHISWUer5N4KzoJ6HhCAx39qbRgiBQjlKWpm7jDqpHnh
         LOO7SlF7g0yoejYUEcOD3Ru9pgmYyZJiwNJl4=
Received: by 10.229.134.197 with SMTP id k5mr9338209qct.58.1326923243339;
        Wed, 18 Jan 2012 13:47:23 -0800 (PST)
Received: from t520sds (cl-pat-tr.clearspring.com. [8.18.54.254])
        by mx.google.com with ESMTPS id f12sm38847236qad.15.2012.01.18.13.47.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 13:47:22 -0800 (PST)
In-Reply-To: <4F17291A.8020600@dirk.my1.cc> ("Dirk \=\?utf-8\?Q\?S\=C3\=BCsserot\?\=
 \=\?utf-8\?Q\?t\=22's\?\= message of
	"Wed, 18 Jan 2012 21:18:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Mail-Copies-To: never
X-Attribution: Sam
X-Disclaimer: You should not expect anyone to agree with me.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188765>

Hi Dirk,

> * Dirk S=C3=BCsserott <arjfyrggre@qvex.zl1.pp> [2012-01-18 21:18:34 +=
0100]:
> Am 18.01.2012 18:49 schrieb Sam Steingold:
>
> to modify the last 4 commits you can use git filter-branch (see the
> manpage):
>
> $ git checkout master
> $ git filter-branch --env-filter \
>    'GIT_COMMITTER_EMAIL=3D"sds@gnu.org" \
>     GIT_COMMITTER_NAME=3D"Sam Steingold"' \
>    HEAD~4..HEAD
>
> It should tell you that it rewrites 4 commits.

I did this; I got a few messages which scrolled very quickly.
status code was 0, apparently, I was successful.

> The original tree is saved under original/refs/heads/master.

where is that?

> If sth. went wrong, reset your master to that point (easiest with
> gitk, it's steel blue). If it worked, you can delete the
> original/refs/heads/master like so:
>
> $ git for-each-ref --format=3D"%(refname)" \
>     refs/original/ | xargs -n 1 git update-ref -d
>
> Note: Whether it worked or not, remove the original refs afterwards,
> because a second run of git filter-branch will fail if there's alread=
y
> an "original" tree.

alas, I could not push because the remote tree was modified in the
meantime, I pulled and now:

# On branch master
# Your branch is ahead of 'origin/master' by 23 commits.
#
nothing to commit (working directory clean)


so, what do I do now?

is there a way for me to get back my original 4 patches, reset my tree
(maybe by rm-rf+clone) and then re-apply them?

thanks!

--=20
Sam Steingold (http://sds.podval.org/) on Ubuntu 11.10 (oneiric) X 11.0=
=2E11004000
http://jihadwatch.org http://memri.org http://thereligionofpeace.com
http://www.PetitionOnline.com/tap12009/ http://palestinefacts.org
I don't have an attitude problem. You have a perception problem.
