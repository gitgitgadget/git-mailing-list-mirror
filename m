From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Wed, 19 Dec 2007 00:11:52 +0100
Message-ID: <200712190011.52613.jnareb@gmail.com>
References: <20071218173321.GB2875@steel.home> <20071218222032.GH2875@steel.home> <Pine.LNX.4.64.0712182239500.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:12:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lbn-0004Lr-U2
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbXLRXL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 18:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbXLRXL5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:11:57 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:51639 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbXLRXL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:11:56 -0500
Received: by mu-out-0910.google.com with SMTP id i10so3703065mue.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 15:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=NyL/4yy5PLqJHRpO/nk0cLbSY990x9l1NX+yhwzhqyg=;
        b=AwDP5tGp58sZgmlLpn5qhGp1esrIuCE6pmho1WGZiULUkMqMod1yV3V22Re1CBgH0+ZTVLy5NG7zv6TKSR1pR0ViBuPzt4pVuxVr6Gtcmr1WTHwUp1xbZi96joBu7qsrmoUwA6h2cxaAkmIaYc+LO5oY3KxE7I/n3pYBfhpLcrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mylklmInfvx5OKc6+Cmd9akFXBKrHmrB7cpkzR2oqhsdV39Zpp0LoA0MXVUGZl/3H/oo/qjlpGAxiCPOZRAmXToHRgq6F+ucKvBfs9+PHnR+6NsWmgU/IXgDmaBaNYlBkd2RIuRtr5cnBebB+yr8hY18JWmwiiIYYIPvw8B4zus=
Received: by 10.82.174.20 with SMTP id w20mr635482bue.7.1198019514081;
        Tue, 18 Dec 2007 15:11:54 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id z33sm18284121ikz.2007.12.18.15.11.51
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 15:11:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0712182239500.23902@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68843>

Johannes Schindelin wrote:
> On Tue, 18 Dec 2007, Alex Riesen wrote:
>> Jakub Narebski, Tue, Dec 18, 2007 22:24:26 +0100:
>>> 
>>> What cwd? <path> in <tree-ish>:<path> syntax is "relative" to 
>>> <tree-ish>.
>> 
>> But the act of running "git-show <tree-ish>:<path>" does have a working 
>> directory relative to the project root.
> 
> Not necessarily.  My primary use of "git show <tree-ish>:<path>" (yes, I 
> already use the dash-less form ;-) is in _bare_ repositories.
> 
> And I still maintain that expecting <tree-ish>:<path> to take the current 
> relative path into account would be just like if you expected
[...]

> 	$ cd /usr/bin
> 	$ scp home:bash ./
> 
> No, this does not copy home:/usr/bin/bash but home:$HOME/bash.

Great example! In scp <machine>:<path>, <path> by default is relative
to the login (ssh) directory on <machine>. In git's <tree-ish>:<path>,
<path> by default is relative to <tree-ish>.

Although Linus argument about thinking that cwd affects translation
from _commit_ sha1 to _tree-ish_ is also sound. Nevertheless I'd rather
have separate syntax for cwd-relative paths, i.e. <commit>:./<relpath>.

-- 
Jakub Narebski
Poland
