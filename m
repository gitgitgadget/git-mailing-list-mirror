From: Jakub Narebski <jnareb@gmail.com>
Subject: Differences between git-applu and GNU patch (was: [JGIT PATCH 1/1] jgit: create a tag command)
Date: Fri, 11 Jul 2008 03:50:30 -0700 (PDT)
Message-ID: <m38ww8elu8.fsf_-_@localhost.localdomain>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com>
	<200807070116.39892.robin.rosenberg.lists@dewire.com>
	<e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com>
	<200807102002.11044.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mike Ralphson" <mike.ralphson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Marek Zawirski" <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 12:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHGDv-0002Zx-OS
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 12:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYGKKue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 06:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbYGKKue
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 06:50:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:9728 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbYGKKud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 06:50:33 -0400
Received: by ug-out-1314.google.com with SMTP id h2so62622ugf.16
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=D2Jpct4ncJV4R7XyiOR9dHhicVHft/h/tKHWQYrZWLU=;
        b=tk9kxkEbsJ6BJnxMOFvsWgMaa5BdPghnLUqszwBxf4kmUU830zW3PSJgJ6bczZ/njS
         yoo82gEqIpvh1kSG5YPKE/aQ/pI0iUwL+i/o3ycoIDnP9VuLNS8ABT3wVy+IIg+X9mhb
         a3PnfpEEeA1/EhUoANrX/HA8slFqykdNPMhnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=r9uoZT6v3H07TFDbuuHbXh/9miagRaui0q5f9hIvViru1rcnB0tjWTU/QcOJAoi6dg
         Hy0OvQfilzrdy2fkHSIfQjXbhZMIU1wCOsilik45SEVbz+Qrug5VFFxuzdxsCq1yRng0
         ulSmB4A9rOkpO5jThrk+G7K0Mvl92CqjqTonA=
Received: by 10.66.244.11 with SMTP id r11mr485903ugh.47.1215773431326;
        Fri, 11 Jul 2008 03:50:31 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.227.34])
        by mx.google.com with ESMTPS id 39sm326155ugb.48.2008.07.11.03.50.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jul 2008 03:50:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6BAoQ8V013456;
	Fri, 11 Jul 2008 12:50:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6BAoNAb013453;
	Fri, 11 Jul 2008 12:50:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200807102002.11044.robin.rosenberg.lists@dewire.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88105>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> torsdagen den 10 juli 2008 17.31.06 skrev Mike Ralphson:

> > 
> > Apologies this will be whitespace damaged, but it's trivial.
>
> Don't do like that again : Had to use patch -l to apply this.
> Why doesn't git am have that?

It is not git-am that should have implemented -l / --ignore-whitespace
option, but git-apply... well, beside passing it to git-apply of course.


I tried to look up how git-apply is implemented (builtin-apply.c),
but it looks like it implements patching itself, and I am not familiar
at all with this code... BTW. why applying patch is not left to xdiff
code?

It would be nice if git-apply implemented larger subset of GNU patch
options, for example --dry-run (which is similar but I think not
exactly the same as --check), --fuzz=<num> (how it differs from -C<n>?)
--strip=<num> as equivalent to -p<n>, -l / --ignore-whitespace, 
--reject-file=<rejectfile> together with --reject...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
