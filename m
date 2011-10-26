From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-fixup-assigner.perl -- automatically decide where to "fixup!"
Date: Wed, 26 Oct 2011 21:40:50 +0200
Message-ID: <201110262140.50786.trast@student.ethz.ch>
References: <201012140309.59378.trast@student.ethz.ch> <CADVrmKT1woYpJoe=L9sAbQ30TUw44zMc7y4WF=PMrT5Gj9kDNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 21:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ9LO-0006eE-UP
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 21:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab1JZTky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 15:40:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:29587 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab1JZTkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 15:40:53 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 26 Oct
 2011 21:40:47 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 26 Oct
 2011 21:40:50 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.6-44-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CADVrmKT1woYpJoe=L9sAbQ30TUw44zMc7y4WF=PMrT5Gj9kDNw@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184272>

fREW Schmidt wrote:
> 
>   $ git fixup-assigner.pl > fixups && less fixups
>   #!/bin/sh
> 
>   git apply --cached <<EOF
[...]
>   -   $self->set($c,
> $c->model('DB')->schema->kiokudb_handle->lookup('dashboard
> templates'));
>   +   $self->set($c, $c->model('Kioku')->lookup('dashboard templates'));
>    }
>   EOF
> 
>   git commit --fixup 7765cbd2
> 
> Looks fine to me.  But then I try to use it:

The shell will expand variables in the <<EOF section above.  You can
fix that by changing it to output <<\EOF instead, which is clearly a
bug in the original script.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
