From: William Pursell <bill.pursell@gmail.com>
Subject: Re: permissions
Date: Sat, 05 Jun 2010 08:23:17 -1000
Message-ID: <4C0A9615.4090307@wpursell.net>
References: <4C0A19FE.1020802@wpursell.net> <m27hmdn704.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: William Pursell <bill.pursell@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jun 05 20:23:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKy1z-0006eV-20
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 20:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab0FESXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 14:23:25 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:48841 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0FESXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 14:23:24 -0400
Received: by pzk15 with SMTP id 15so1583299pzk.15
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fdeK4ogTYKN+yD00QP2ViINnMpyS/79/SdZPzRmJeJQ=;
        b=psr0KKyPfviPMpQSrGAZpiYRceE2cAQ6uZVQSyazZpYgHgK8BowjhnuiiVpsPkbPfw
         7WcUugWfS9i3Vkpnqf1viBShpXNyCIr1k29p7zxn3xPeyMOe0MgceXXk7wwby1GowC/I
         wyF45UYcnvJGFhZhmRmx4UC9jIlYg0SsSstCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WDhyr8CWk43USt8gFQ8Z7QVD1U4FTR4dOGEanNGWGCPPFCWeOr9jhORTeG0MjfrT/I
         twclsWlSnEz4tXOfJX375WgXA8qUQI7G8ACXGKOXTth+aGpwHBLJfXh7joHWcTUXA/Xt
         +aQUmIjTvrsqWU5S3t5/j+1MjMYXxKExg52KU=
Received: by 10.142.9.33 with SMTP id 33mr2497433wfi.0.1275762201030;
        Sat, 05 Jun 2010 11:23:21 -0700 (PDT)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id b6sm20737011wam.9.2010.06.05.11.23.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 11:23:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <m27hmdn704.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148483>

Andreas Schwab wrote:
> William Pursell <bill.pursell@gmail.com> writes:
> 
>> After all, it is a git repository, so "Not a git repository"
>> is not accurate.
> 
> A valid git repository requires more than a .git directory.

True, but this doesn't address the issue.  In the example
you gave, the error message is accurate.  Consider this:

$ sudo sh -c 'umask 077; git init'
Initialized empty Git repository in /private/tmp/foo/.git/
$ git rev-parse --git-dir
fatal: Not a git repository (or any of the parent directories): .git

That's just weird.  And if there is a git repository in a
directory above, there may be great confusion, weeping
and gnashing of teeth.


-- 
William Pursell
