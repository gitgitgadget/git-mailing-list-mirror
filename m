From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git svn fetch error
Date: Mon, 23 May 2011 10:16:23 +0200
Message-ID: <4DDA17D7.8020504@alum.mit.edu>
References: <3504B354-D3F2-4419-B2EC-E14F83EC0371@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Mon May 23 10:16:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOQJb-0001QX-4C
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 10:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab1EWIQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 04:16:34 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37895 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab1EWIQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 04:16:33 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p4N8GP2m000457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 23 May 2011 10:16:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <3504B354-D3F2-4419-B2EC-E14F83EC0371@apple.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174230>

On 05/23/2011 01:39 AM, Dave Zarzycki wrote:
> Has anybody seen the following error with git svn fetch? I've seen this both with 1.7.4.4 and top-of-tree.
> 
> Argument "195270*" isn't numeric in numeric le (<=) at /usr/libexec/git-core/git-svn line 3840.
> Argument "195270*" isn't numeric in numeric le (<=) at /usr/libexec/git-core/git-svn line 3840.
> Argument "195270*" isn't numeric in numeric gt (>) at /usr/libexec/git-core/git-svn line 3822.
> Argument "195270*" isn't numeric in numeric ge (>=) at /usr/libexec/git-core/git-svn line 3823.
> Argument "195270*" isn't numeric in numeric gt (>) at /usr/libexec/git-core/git-svn line 3118.
> 
> How alarmed should I be?

I haven't looked into the code, but from the argument shown in the error
message my guess is that git-svn is being confused by Subversion's
non-inheritable merge information.  Non-inheritable merge information
can arise from partial-tree merges.  The hairy details about
non-inheritable merge information are in the section entitled "Mergeinfo
Inheritance and Non-Inheritable Ranges" in [1].

Michael

[1] http://www.collab.net/community/subversion/articles/merge-info.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
