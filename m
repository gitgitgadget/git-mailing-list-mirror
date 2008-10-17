From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: Excluding files from git-diff
Date: Sat, 18 Oct 2008 01:38:55 +0200
Message-ID: <48F9220F.5060009@cup.kalibalik.dk>
References: <20081017145313.GA23471@eriks>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Hahn <erik_hahn@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:40:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqyvT-0007fk-7i
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbYJQXi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbYJQXi6
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:38:58 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:50717 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbYJQXi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:38:58 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 41EEE14062;
	Sat, 18 Oct 2008 01:38:59 +0200 (CEST)
Received: from [192.168.0.201] (unknown [192.168.0.201])
	by mail.hotelhot.dk (Postfix) with ESMTP id 05D541405A;
	Sat, 18 Oct 2008 01:38:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081017145313.GA23471@eriks>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98500>

Erik Hahn wrote:
> I'm currently working on a script whose developer does not use
> git. Hence, when I mail him the patch, I don't want to include the
> .gitignore file. Is it possible to exclude a file from git-diff (except
> not adding it to git, of course?)
>   


I don't think that this is what you are asking about, but it's a neat 
trick anyway :-).

To permanently exclude files from git diff, set up a custom diff driver 
in ~/.gitconfig:

[diff "nodiff"]
    command = /bin/true

and then mention the files that should use this driver in 
.git/info/attributes:

.gitignore diff=nodiff
