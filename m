From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cvs -> git tools?
Date: Fri, 21 Dec 2007 14:02:44 -0800 (PST)
Message-ID: <m3zlw3oged.fsf@roke.D-201>
References: <476C1D9E.4060700@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5pxc-00032q-0w
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 23:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbXLUWCu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 17:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbXLUWCu
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 17:02:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:3281 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbXLUWCs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 17:02:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so689707ugc.16
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 14:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=7ff2BsmUVKvSYdnVJvUzvKVOXj2p/LkMLlSEqIKt4VA=;
        b=WmRR1j3ozV2bN9rWIbzSZCdTwVVQU6CNEf111iuuHopEenhCfsc89qQRqGyF2MXCYfNdba6kCvFqccsVYrZFmgc0BrwlJFQRTgoO40hkrYuBJFYHQZqaiTiB4thEYBFvzSDnW3qPXq3nC92OwGKNbnQBVnqg0c3jgmqEMMKf68s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=nAlYM/ka7a+ERxII/5E5sGrmA4jko4gJx3D6TD5KcttjxG6ZkYq2GwRykrndsmKRaqZKrw/qgqXC9kfZB2kjQIPQmyUui+8xjjVrxAfFpRlExJcHSIDAEk1Fj8vqfpP9HEgE1uVawMugAWz4dTCU2Kkn3B13coxFA/UM5tHVdRg=
Received: by 10.67.116.16 with SMTP id t16mr357828ugm.55.1198274566579;
        Fri, 21 Dec 2007 14:02:46 -0800 (PST)
Received: from roke.D-201 ( [83.8.189.110])
        by mx.google.com with ESMTPS id j4sm4070008ugf.49.2007.12.21.14.02.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2007 14:02:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBLM2b6G015597;
	Fri, 21 Dec 2007 23:02:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBLM2ZB9015594;
	Fri, 21 Dec 2007 23:02:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <476C1D9E.4060700@advancedsl.com.ar>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69099>

Gonzalo Garramu=F1o <ggarra@advancedsl.com.ar> writes:

> I was wondering if there were any tools to keep a mirror repository o=
f
> CVS as a git repository.
>=20
> Basically, I would like to mirror a CVS repository (that I don't
> control) as a git "main" branch.  This CVS repository is live and
> expected to remain so.
>=20
> I would then work on another git branch and would do merges from the
> main branch to mine as I see fit to develop some stuff.
>=20
> Is there anything like that?   Basically, I'm looking for the
> equivalent of Tailor for Mercurial.

Tailor supports Git, too.

There are many CVS -> git tools: git-cvsimport (uses cvsps), parsecvs
(accesses ,v files directly), fromcvs (in Ruby), cvs2svn development
branch. But I think only git-cvsimport allows incremental import.

Another solution would be to set Git repository as a fake CVS
repository using git-cvsserver (now with beginning of authenticated
pserver access!).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
