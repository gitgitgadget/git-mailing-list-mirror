From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-svn and mergeinfo
Date: Thu, 01 Sep 2011 10:59:51 +0200
Message-ID: <4E5F4987.5040205@alum.mit.edu>
References: <20110829132052.0ad7a088@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 11:00:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz37w-0008G2-Gl
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 11:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab1IAI7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 04:59:54 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37098 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab1IAI7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 04:59:53 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p818xpkl000856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 1 Sep 2011 10:59:52 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.20) Gecko/20110805 Lightning/1.0b2 Thunderbird/3.1.12
In-Reply-To: <20110829132052.0ad7a088@robyn.woti.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180526>

On 08/29/2011 07:20 PM, Bryan Jacobs wrote:
> I have been (ab)using git-svn for committing to a central SVN
> repository while doing my work locally with git. To this end, I've
> written a set of scripts and hooks which perform squash merges locally
> and then dcommit them with proper svn:mergeinfo annotations. The final
> result is the perfect appearance of having done a native SVN merge in
> the central repository, while using only local git commands and
> gaining the full benefit of git's conflict resolution and developer
> convenience.
> 
> However, to make this work with git 1.7.6, I needed to make *one* change
> to the git internals: --merge-info does not allow setting mergeinfo for
> more than one branch. Because it's a complete overwrite operation
> instead of an update, this is a serious issue preventing its use for
> nontrivial branches.
> 
> Might I suggest adding a block like the following around line 552 of
> git-svn?
> 
>     if (defined($_merge_info))
>     {  
>         $_merge_info =~ tr{ }{\n};
>     }

Naive question: why can't you pass a newline (properly quoted, of
course) directly within the string argument to the --mergeinfo option?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
