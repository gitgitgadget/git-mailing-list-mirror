From: "Vinubalaji Gopal" <vinubalaji@gmail.com>
Subject: Re: git-svn and SVK mirror between two repositories
Date: Fri, 25 May 2007 20:26:31 -0700
Message-ID: <7d8fb81e0705252026q46b7f58dx25f249e8e888c150@mail.gmail.com>
References: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
	 <4656464B.7010101@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat May 26 05:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrmvS-0003Ka-Rg
	for gcvg-git@gmane.org; Sat, 26 May 2007 05:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbXEZD0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 23:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbXEZD0f
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 23:26:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:31560 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXEZD0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 23:26:35 -0400
Received: by wa-out-1112.google.com with SMTP id j4so414749wah
        for <git@vger.kernel.org>; Fri, 25 May 2007 20:26:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WJ8EiJmSC0Q5353WegtrqVBOwEZuwJAABltG8XOcCqNV6BBh4OfUsfzDSKEVuHq3whq2wS6EO2RTkhgs8I6HdjI/x+cJ7+qrLFu4MY4p/xeZofQhieR8lHgaChGrPLHzIdEIQYPbpX49DWLkwH1gEeHaH3UyesIhlpyHqT+f9wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VVx4agogrxQGRNUUZJrETAdnjPBezjtaTHn9dlMXJE6J9DKS8hXBfZZK8ZmdFeFANTi/yNgrgQqkQQhRZrYTHykUn5Q3nBAlM/BrQfcSuRsrAG0oN5CLIBh8w3ppoFcftI4GvGv7PPQ6AGYfiYnKkbTgjvHPfcIb/9PRJF+I5VU=
Received: by 10.115.108.1 with SMTP id k1mr1791987wam.1180149991508;
        Fri, 25 May 2007 20:26:31 -0700 (PDT)
Received: by 10.115.55.16 with HTTP; Fri, 25 May 2007 20:26:31 -0700 (PDT)
In-Reply-To: <4656464B.7010101@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48444>

Hi Sam,

On 5/24/07, Sam Vilain <sam@vilain.net> wrote:
> However, you are in a relatively obscure use case, most projects
> wouldn't do this.  Note also that the merge tickets SVK would use are

hm I am not looking for a complete bidirectional flow. I have a
project (say my great open source project) in svn for which I have
only read access.  Since I don't have a write access, I have a
personal svn sandbox for which I have complete read-write access and I
branch the trunk into this svn sandbox. I commit all my changes to my
sandbox so that I don't loose all my data in case my system fails! I
also setup a local branch to which I can commit when I don't have a
network access.

With Svk it has been (skipping the local branch step for now)
svk mirror <myproject_svn_url>/trunk //trunk
svk mirror <myproject_svn_sandbox_url>/mybranch //mybranch
svk smerge --baseless //trunk //mybranch -m 'first merge'

I also have a local branch in svk: (local branch setup)
svk copy //mybranch //localbranch -m 'local svk branch'

and occasionally enter the following commands to get the latest in trunk:
svk smerge //trunk //mybranch
or
svk smerge //mybranch //localbranch

>the UUID and revision numbers in the property will not refer to revisions in
>svn://svn.paris.fr/ but to the (private) SVN repository in the SVK depot.
that is scary since I am not sure if I still have that local repository now.

I would look into your patch suggestion for sure, but also open for
other suggestions . I am thinking if I should host the project in a
different public git server  (for now) instead of my svn sandbox and
it will be easier :).

-- 
Vinu

In a world without fences who needs Gates?
