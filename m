From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: receive.denyCurrentBranch
Date: Sun, 08 Feb 2009 14:03:40 -0800 (PST)
Message-ID: <m3eiy8vb7t.fsf@localhost.localdomain>
References: <20090208042910.19079.qmail@science.horizon.com>
	<alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
	<76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 23:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWHmn-0007Uf-6S
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 23:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbZBHWDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 17:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbZBHWDp
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 17:03:45 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:49959 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbZBHWDn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 17:03:43 -0500
Received: by fxm13 with SMTP id 13so2271464fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 14:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zo5JlLl+sRCJiRJOdl2O8ydN0p3HGJkzNFtUS4m2epo=;
        b=VRNkUcqqNs3GHKG7VyaWgnvQ7mVqStUYX7aumB6FPPK5rmOEnO7Mn3D2ii1tCHksJ6
         xhhgjyjkwJr/qDPfbtkCsSft47duFEkSe0RuQl6sviDTql83r3qY1B24jck6B82VQraB
         wnuq2WwUo6QAaYP/ac0b2UigY1GljOUp7LuxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=n23nwBskRsez7DtybntXRIdXKAicE/56zxmE+onsYKlUYWh6Q0tmANJWnQT+KeWjRP
         aDv775RcPOYHy62ZfOymYNIMLZydGFqzRcKrEqUEckNm5grDqr8tnhgGZLEQuqMc2hxK
         OI3efaDrvfAkIvBgZLCLyJ7hwQtMx8g3ZVXCk=
Received: by 10.103.138.16 with SMTP id q16mr1798269mun.114.1234130621614;
        Sun, 08 Feb 2009 14:03:41 -0800 (PST)
Received: from localhost.localdomain (abvy83.neoplus.adsl.tpnet.pl [83.8.222.83])
        by mx.google.com with ESMTPS id j2sm2289601mue.24.2009.02.08.14.03.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 14:03:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n18M2xUw007018;
	Sun, 8 Feb 2009 23:03:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n18M2V6E007013;
	Sun, 8 Feb 2009 23:02:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109018>

Jay Soffian <jaysoffian@gmail.com> writes:

> What I especially like about Mercurial here is that pushing from A is
> perfectly symetrical to pulling from B.
> 
> With git, cloning sets things up to fetch into a tracking branch,
> but then the push is not symetric to the fetch. That makes sense if
> you're cloning from a bare repo, but I think leads to confusion for
> new users when they clone a non-bare repo they wish to later push
> into. I dunno, I guess we'll see if the new message helps any.

Push _is_ symmetric to fetch; it is not symmetric to pull, and it
cannot be.  BTW. Mercurial's pull is equivalent to Git's fetch.

That is of course provided that you have the same refspec(s) for
push and for fetch.  And up to the point: push needs to be via
authenticated channel, for obvious reasons.

The fact that default setup is not symmetric reflect the fact
that in most cases the situation is not symmetric: you fetch
from other remote repository into separate remotes layout,
you push into your own public bare publishing repository set
up in mirroring mode.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
