From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 13:50:11 +0200
Message-ID: <200610201350.12273.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <vpqirigqzpd.fsf@ecrins.imag.fr> <20061019123349.GE20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Andreas Ericsson <ae@op5.se>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 13:50:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GastF-00074i-63
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 13:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946379AbWJTLuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 07:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946377AbWJTLuN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 07:50:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:50922 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946379AbWJTLuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 07:50:11 -0400
Received: by ug-out-1314.google.com with SMTP id o38so721279ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 04:50:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rb+yk5hy5566bnCIDpqcSJ6czSLQwOjzM7WRJTPa8ex7tit0ALH1iu6kQDAWS7hjvbGb3517+7qYJwyvLat+v90ubv7e9svF6nGgRVZm8h+Tg2ygCV+v7nQI01lwSZdlQIY+JNasjdfkS8DHH44cNU1oBKvvKw8OW1nbSqXCKFg=
Received: by 10.67.93.7 with SMTP id v7mr1289623ugl;
        Fri, 20 Oct 2006 04:50:09 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id l40sm1222482ugc.2006.10.20.04.50.08;
        Fri, 20 Oct 2006 04:50:09 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061019123349.GE20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29453>

I have lost somewhere among many emails in this thread the email I 
wanted to reply to, the one mentioning for the first time the lack of 
parents ordering in GIT, but this one should do.


Petr Baudis wrote:

> The lack of parents ordering in Git is directly connected with
> fast-forwarding.

There are exactly _two_ places where Git treats first parent specially 
(correct me if I'm wrong).

First, <commit-ish>^ is shortcut for <commit-ish>^1, i.e. for first 
parent of commit. <commit-ish>~<n> is shortcut for <commit-ish>^^...^ 
(n-times '^'), which means that <commit-ish>~<n> is n-th parent in 
1st-parent lineage of <commit-ish>. But you can always use names
like for example next~12^2^^2~2.

Second, git-diff with only one <commit-ish> generates diff to first
parent. But you can always use '-c' or '-cc' combined diff format
or '-m' with default diff format to compare to _all_ parents.
-- 
Jakub Narebski
Poland
