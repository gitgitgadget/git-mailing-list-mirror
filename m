From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Newbie question: Is it possible to undo a stash?
Date: Wed, 14 May 2008 13:42:56 -0700 (PDT)
Message-ID: <m3y76c4nxv.fsf@localhost.localdomain>
References: <509f40850805141256gce6ac1brf5ced6436f81dae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?iso-8859-15?q?Iv=E1n_V.?=" <elterrible@ivanyvenian.com>
X-From: git-owner@vger.kernel.org Wed May 14 22:44:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNpO-0004Sr-EM
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbYENUnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 May 2008 16:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYENUnF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:43:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:47150 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYENUnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 16:43:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so77845fgg.17
        for <git@vger.kernel.org>; Wed, 14 May 2008 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=tPGWn2wmfmSPBVKWb/c9ZHil8UYawZkiSpTQ0lrVZcQ=;
        b=KC/QnLQgrImZe2z0Eqny4UEHk+lN7FN3gOmsaAY8+3Qz+3JVx54YOn/eMnX5xSIQFHr5urwt12iLKzPhbOStwZODI1goP/yZDc9FeCq9thvECSMhaeriPZToZu5P4WwkWdd9h1lmjsleDzBu9kzeJ8zYzl4D/BG1HK/ow+u9yvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=buJZZsHcByPrRhFff3FmkOMggLhL1K8EJwtPXH/c1jBzplibgd0LYqAJlaJ6PVWkvTUnbOM67/V4LW4oaDIJC48llFEC3rasXmLvDDRZsaVk0iY0vjcrap3j/etpoLIMaofkiEZDSxAGsVlffr8nX2LqGeD6TOGPpCkx/ghfI78=
Received: by 10.125.165.15 with SMTP id s15mr833064mko.27.1210797778057;
        Wed, 14 May 2008 13:42:58 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.222.61])
        by mx.google.com with ESMTPS id d6sm2130440fga.2.2008.05.14.13.42.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 13:42:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4EKgsUw031427;
	Wed, 14 May 2008 22:42:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4EKgqPr031424;
	Wed, 14 May 2008 22:42:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <509f40850805141256gce6ac1brf5ced6436f81dae8@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82148>

"Iv=E1n V." <elterrible@ivanyvenian.com> writes:

> I just did a git stash, and then changed my mind and ran git apply,
> thinking that would get me back to where I was...

You meant "git stash apply" here, didn't you?
=20
> Now I have lots of conflicting merges and files that came back from
> the dead (and some files seem lost)... I've been trying to go step by
> step to try to get the tree to where it was, but it's very
> complicated, so I was wondering if there is anything I can do to get
> my working tree exactly to where it was before I ran git stash...

To get your working tree and index to exact state as it was before
git-stash, you have first to bring current HEAD to the state it was
when you did the stash.  So if you changed branch, you have to change
it back; if you did any commits, you have to rewind (reset) it.

If the "base" state isn't the same as it was during "git stash", then
"git stash apply" would have to do a merge... which can fail...


P.S. Please provide with the exact (best if minimal) sequence of
commands, if you want for us to dianoze if there is a bug in git, or
user error.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
