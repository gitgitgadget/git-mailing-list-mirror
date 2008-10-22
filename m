From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 03:50:52 -0700 (PDT)
Message-ID: <m3ljwgj3xy.fsf@localhost.localdomain>
References: <20081022061730.GA5749@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Oct 22 12:52:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsbJx-0005YD-UJ
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 12:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYJVKu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 06:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYJVKu4
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 06:50:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38919 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbYJVKuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 06:50:55 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1316720ugf.37
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=BzTRvYHzPbh4DkAOhXHMreYOOvOfl5uSU1mq8TP98U0=;
        b=irg/QMW1kMb/O+NHRKPDU/jldU52y2+Bqc1YwW6NcpQBM2h6kM5gitIIZjoMLE1oZW
         tlu4yR0sm0frMjovR/Xztm2NZOhg8jP7GU26dB6e7a4ijQTZs5Vh/k8rKnACTAWQ81C7
         uAi+M0bJQzUrxbwMB03w22WiQCv2qEH+czLmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=BVtpb0jrDwBwj/zr154qRSj4Re+YyjQTHXFLKPqriSDCk6Ulcs5cf7PzdiLBCYRkxX
         StUqhSp4u9jgd4f3mLn8HQ1PTf1X8s5gze9clXnaMRiRj7P2NIcUMOjxoSdY1q8zduAk
         csrI8DCmlSrpyAyR0LaDl0kEGOJNuDRgg4lAQ=
Received: by 10.66.236.13 with SMTP id j13mr3468597ugh.7.1224672653848;
        Wed, 22 Oct 2008 03:50:53 -0700 (PDT)
Received: from localhost.localdomain (abxd135.neoplus.adsl.tpnet.pl [83.8.253.135])
        by mx.google.com with ESMTPS id k1sm4176880ugf.15.2008.10.22.03.50.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Oct 2008 03:50:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9MAs3xx008750;
	Wed, 22 Oct 2008 12:54:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9MAs16S008747;
	Wed, 22 Oct 2008 12:54:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081022061730.GA5749@elte.hu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98856>

Ingo Molnar <mingo@elte.hu> writes:

> Git recently started printing the branch name when creating commits:
> 
>   [irq/urgent]: created 3786fc7: "irq: make variable static"
> 
> very nice idea IMO! Having it all on one line allows me to double-check 
> that i indeed queued up a patch in the intended topic branch. Had it 
> read:
> 
>   [irq/urgent]: created 3786fc7: "printk: make variable static"
> 
> i'd have noticed the mistake immediately.
> 
> this welcome enhancement made me remember of three usage problems i had 
> with Git recently:
[...]

About printing either forward (git-describe, e.g. v1.6.0.2-590-g67f6062)
or backward (git-name-rev, e.g. tags/v1.6.0-rc2~8): you can use
git-name-rev in filter mode (git log ... | git name-rev --stdin), or
"git log --decorate", or '%d' in --pretty format specifier (this is very
new thing).

You might be also interested in --abbrev-commit (when used with
--pretty=oneline format), and --graph option to git-log (or
git-show-branch).  The "(--merged | --no-merged | --contains) [<commit>]"
options to git-branch might be also of interest...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
