From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-merge-recursive-{ours,theirs}
Date: Sat, 21 Jun 2008 09:56:45 -0700 (PDT)
Message-ID: <m3zlpeloah.fsf@localhost.localdomain>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
	<20080616092554.GB29404@genesis.frugalware.org>
	<48563D6C.8060704@viscovery.net>
	<bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
	<93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
	<7vve076d6t.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.00.0806181618070.6439@racer>
	<alpine.DEB.1.00.0806181627260.6439@racer>
	<7viqw6zovi.fsf@gitster.siamese.dyndns.org>
	<7vfxr8o8sx.fsf_-_@gitster.siamese.dyndns.org>
	<7vbq1wo8ck.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.DEB.1.00.0806201351370.6439@racer>
	<7vy74z9l3l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 18:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA6PP-0007vK-By
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 18:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbYFUQ4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 12:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbYFUQ4z
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 12:56:55 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:32235 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYFUQ4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 12:56:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so402394and.103
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=fOiYE7vcI07e770sRvR/es1vmsX/P8IeqO46W8uKOaQ=;
        b=tB/OdQKIo7B89S/6F0HODVJ1OvRNcmZs9/UqYgNjgG0akQD9KVtdDRa3L7//pTftyp
         7f9nKOim5CUk3sNbX8AR/whArynM0uMrbxlIHnUpDmw5r69DSEfUIEnkpA1XwaGSRKsi
         CBiEUAjHd0Ar/5LE3tXgRICZFds7jS42MqtEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=UEBN65RYCYKdiQBnwk5TFc4aRL59a3ds551ebJu2ShrM5Qo64f52VmcVqH4QDdNmdh
         +YHdumI8lDxDrjYbn7/1nVpsy9tVU2+vmw9jzEm9zpx1Ic6HBUYylw/rhEATfNGUnq9n
         TpWFniuSSGZsjJXX0a8OoGxeKqbvw2jkakR2k=
Received: by 10.100.197.7 with SMTP id u7mr8412414anf.27.1214067406252;
        Sat, 21 Jun 2008 09:56:46 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.245.230])
        by mx.google.com with ESMTPS id b7sm6848054ana.35.2008.06.21.09.56.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Jun 2008 09:56:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5LGufmk017109;
	Sat, 21 Jun 2008 18:56:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5LGucGK017104;
	Sat, 21 Jun 2008 18:56:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vy74z9l3l.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85714>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, I think "git-merge-recursive-theirs" is a mistake.  We should
> bite the bullet and give "git-merge" an ability to pass backend specific
> parameters to "git-merge-recursive".  The new convention could be that
> anything that begins with -X is passed to the backend.
> 
> E.g.
> 
> 	git merge -Xfavor=theirs foo
>       git merge -Xsubtree=/=gitk-git paulus

Gaaah... only after reading it for third time I see that it isn't
some funky "=/=" symbol, but subtree with grafing '/' in one side
to 'gitk-git' subdirectory in other side.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
