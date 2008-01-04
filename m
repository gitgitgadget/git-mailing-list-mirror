From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 04 Jan 2008 09:51:05 -0800 (PST)
Message-ID: <m3abnlo4xv.fsf@roke.D-201>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	<Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>
	<477E6D26.9020809@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 18:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAqhp-0005dm-Hx
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 18:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYADRvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jan 2008 12:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYADRvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 12:51:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:50441 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYADRvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jan 2008 12:51:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2812872ugc.16
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=FIolq4MTGcH/NDYGukuqjdNUgLUC4FwPWyo7HkD4WZQ=;
        b=a7E3aPGGlHgJRhmeUBcv8loulEBlMlhH8Z5Yk6hnuMYrNMXu5CCoPmqVHFH6DDq9ctkth+J6XHKOEM1S3XqO9eaJYDzrdcqYrnFUhIoshrzSbyHEnLtAYkhtBmItz38FwscGhAeKugWqYpg0mnXSDD/0WV4k3HtMAtcS7WQe9Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=bBRyLamslpIrWVO9f63MbN1TYVEhB56BzFjouA/Szh5g/TUAJm2u7vV0/YjO9ew4NFJOKb0OGzkjL2rBAALqTFtoYtoMZ5OMi/IwGyzAiMkD1jOm0u4HkQzds+UL+goE8aegSUKErUMOUl3t7sverJFgRG50DdQL+WH0DqNKdfY=
Received: by 10.67.196.2 with SMTP id y2mr16501802ugp.60.1199469067093;
        Fri, 04 Jan 2008 09:51:07 -0800 (PST)
Received: from roke.D-201 ( [83.8.189.34])
        by mx.google.com with ESMTPS id h1sm17694505ugf.11.2008.01.04.09.51.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Jan 2008 09:51:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m04Hos2c031260;
	Fri, 4 Jan 2008 18:50:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m04HoqF2031257;
	Fri, 4 Jan 2008 18:50:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <477E6D26.9020809@obry.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69587>

Pascal Obry <pascal@obry.net> writes:
> Brandon Casey a =E9crit :
> >
> > Not sure how often such a command would be used though, so
> > it may not be worth it.
>=20
> I've missed it many times. Especially in some scripts when I want to =
use
> the stash-stack to store current working tree and clear it before
> exiting. This is not possible today as all the stash-stack would be c=
leared.
>=20
> I agree that drop seems better.

or "git stash delete"

This probably would require the command to delete single reflog,
which was posted some time ago and is in either pu or in offcuts,
or in next.

But I guess this is post 1.5.4
--=20
Jakub Narebski
Poland
ShadeHawk on #git
