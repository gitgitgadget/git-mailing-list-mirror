From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge after git cherry-pick?
Date: Wed, 23 Jul 2008 10:56:25 -0700 (PDT)
Message-ID: <m3y73sv60v.fsf@localhost.localdomain>
References: <48876709.3090504@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Peter_Valdemar_M=F8rch_ (Lists) ?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLiaf-00082f-7X
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYGWR4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbYGWR4a
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:56:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:21934 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYGWR43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2008 13:56:29 -0400
Received: by ug-out-1314.google.com with SMTP id h2so526800ugf.16
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=iFedTvWfXOzFBIF1eD8wlwZRue8vxCy1oqHOxz6JtK8=;
        b=c9YcfL0Plwq+RnYpqwYqYB9pIdGCCxgEG4A/LIuE40okig1UMBWhTDKMOBwQ4G0B/2
         KcnCpciqbTyfNCrZapQwQKKPbzh77vENAiunQIbdYLa9yoDYjuPdUw8VBV5209HWWnOo
         tZQ8gn+PLOGIKb1IqyBW1FZySLkzn5svKvHDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=V3b8zQyL0jAvHtLWcW0Ty6SRJkwOX+DXTVGqcZF3KSD5A3pd5jR92jZ7Kug1GI0vXw
         1cDBYbzC5re9xm2DPwP97JovT7m6fX85LdPrwHGvjTdYCxr5Vmd3Bb5xBYN2DUNza4+q
         xZMffP24IyyCjSHiei5Y+vF8Nn0KoFNqLRjbk=
Received: by 10.66.233.14 with SMTP id f14mr550975ugh.12.1216835787662;
        Wed, 23 Jul 2008 10:56:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.1])
        by mx.google.com with ESMTPS id i30sm2412099ugd.43.2008.07.23.10.56.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 10:56:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6NHuKhA030600;
	Wed, 23 Jul 2008 19:56:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6NHuG3i030597;
	Wed, 23 Jul 2008 19:56:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48876709.3090504@sneakemail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89723>

"Peter Valdemar M=F8rch (Lists)"    <4ux6as402@sneakemail.com> writes:

> On a branch, b, made off of master, I've made the commits b1, b2, b3
> and b4.
>=20
> Back on master, I need commit b1 and b3 immediately. So I:
>=20
> $ git checkout master
> $ git cherry-pick "b1's SHA"
> $ git cherry-pick "b3's SHA"
>=20
> Now, both b and master contain b1 and b3. How do I now create a log o=
f
> "what remains to be merged from b to master", i.e. only b2 and b4?

You can use "git cherry master b" command (or just "git cherry master"
if you are on branch 'b') to check which commits (based on patch id)
on branch 'b are already present on branch 'master'.

Alternatively you can use "git log --left-right master...b" to check
which comits are on which branch, although I think it wouldn't mark
duplicated commits.

> And how do I merge b2 and b4 to master, so master's log shows b1,
> b3, b2 and b4 and doesn't show b1 and b3 twice, which is what I get
> if I:
>=20
> $ git merge b
>=20
> after the cherry-picks above. Also I noticed, that if I merge master
> into b (to keep up-to-date with master) b1 and b3 are also mentioned
> twice.

You can instead of merging branch 'b' into master rebase it on top of
master.

This would create instead of the following history (for merge):

   ---*---b1'---b3'--------------M         <-- master
       \                        /
        \-b1----b2----b3----b4-/           <-- b

the following

   ---*---b1'---b3'---b1'---b4'            <-- master, b
       .                       =20
        ..b1....b2....b3....b4             <.. b@{1} (reflog)        =20

[cut]

HTH
--=20
Jakub Narebski
Poland
ShadeHawk on #git
