From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 08:39:33 +0000
Message-ID: <200612220839.36067.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <200612220750.49644.alan@chandlerfamily.org.uk> <7vfyb85ojf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Alan Chandler <alan@chandlerfamily.org.uk>
X-From: git-owner@vger.kernel.org Fri Dec 22 09:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfwU-0008Oc-8y
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945977AbWLVIjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945986AbWLVIjr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:39:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945977AbWLVIjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:39:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2909713uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 00:39:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y5WmpbG3Ks3IJykZFapF1AnvfEIpKrpN/JWUoQsla38wX5TAyc6OJHMi0woxPT7Q+LNqa2hIYdVNfXE1/Mz1noI9TVsnudAnLVsDOLQIM7DEtVokR1X8MJJnoJdKp2FYJ58D1vBtNGYOrDDBu+TI0T0p6TXUB+QNAZxpsxCZ8x4=
Received: by 10.67.97.7 with SMTP id z7mr428696ugl.1166776784697;
        Fri, 22 Dec 2006 00:39:44 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id 54sm15313533ugp.2006.12.22.00.39.43;
        Fri, 22 Dec 2006 00:39:43 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vfyb85ojf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35148>

On Friday 2006 December 22 08:21, Junio C Hamano wrote:

> Heh, sounds like you spotted a bug -- patches welcome (or I'll
> fix it myself if I get around to it before everybody else).
> Thanks.

I can't reproduce this bug.  I tried having an identically named branch in 
both remotes and heads.  Output was fine.  I don't like to say "impossible", 
but it certainly seems that

This from append_ref():
    } else if (!strncmp(refname, "refs/remotes/", 13)) {
        kind = REF_REMOTE_BRANCH;

and this from print_ref_list():
    if (ref_list.list[i].kind == REF_LOCAL_BRANCH &&
        !strcmp(ref_list.list[i].name, head)) {
            c = '*';

Make it almost inconceivable that a remote branch is being starred, or that a 
local branch is making it into the "-r" output.

Alan: could you show a tree of your .git/refs/heads and your .git/refs/remotes 
for the repository that is displaying this error?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
