From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb commitdiff output error
Date: Tue, 03 Oct 2006 11:01:38 +0200
Organization: At home
Message-ID: <eft8sm$un0$1@sea.gmane.org>
References: <4b3406f0609280020m43695511qb5da5a3394ad6417@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 11:02:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUg9i-0005Aw-T2
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWJCJBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWJCJBg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:01:36 -0400
Received: from main.gmane.org ([80.91.229.2]:29929 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932564AbWJCJBf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 05:01:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUg9S-00058S-Dz
	for git@vger.kernel.org; Tue, 03 Oct 2006 11:01:22 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 11:01:22 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 11:01:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28254>

Dongsheng Song wrote:

> When the file enconding is not utf8, the gitweb commitdiff output
> error for non-ascii characters.
> 
> Can I do iconv for commitdiff  ?

You can, most probably, but perhaps not as something that is universal.
In git you can set commit message encoding, but git does not remember
(and has no set place where to save it) information about file encoding.
You would have either use default UTF-8 encoding of gitweb page, and do
iconv equivalent, by using "encoding" module and/or "Encode" module,
and by opening diff with "-|:encoding(utf16)" (where of course you have
to put correct encoding). And you would have to set default file encoding
(and perhaps filename encoding) somewhere.

Still, it wouldn't help for example diff of encoding _change_...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
