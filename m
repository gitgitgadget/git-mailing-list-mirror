From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Problem with git svn clone --authors-file
Date: Thu, 27 Oct 2011 08:58:17 +0200
Message-ID: <4EA90109.4070504@alum.mit.edu>
References: <CABDh3gSsi9xwvw-6stw7URGK112LvF8Rt4XJeTwGM3q-tML=2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: edman747 <edman747@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 08:58:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJJv3-00035v-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 08:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab1J0G6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 02:58:20 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59553 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1J0G6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 02:58:19 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9R6wH2G031505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 27 Oct 2011 08:58:17 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CABDh3gSsi9xwvw-6stw7URGK112LvF8Rt4XJeTwGM3q-tML=2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184285>

On 10/27/2011 01:51 AM, edman747 wrote:
> Hello,
> Attempting to clone a remote svn repo where I don't know all the
> previous SVN author names.
> installed msysgit (vista)
> gitbash,
> $ mkdir test
> $ cd test
> 
> create authors file with a few known authors.
> 
> $ git svn clone --authors-file=authors http://svn.repo/trunk
> ...
> runs fine until
> Author: (no author) not defined in authors file
> 
> edit authors file add line: (no author) = none <email>
> 
> ------
> rerun previous git svn command
> 
> $ git svn clone --authors-file=authors http://svn.repo/trunk
> Using existing [svn-remote "svn"]
> svn-remote.svn.fetch already set to track :refs/remotes/git-svn

I'm not quite sure what your complaint is.

"git svn clone" is equivalent to a "git svn init" followed by "git svn
fetch".  I would have thought that by the time "git svn clone" notices a
problem with the authors file, it would already be in the "git svn
fetch" phase.  So it seems to me that after the first "clone" fails, one
should probably run "git svn fetch" instead of "git svn clone" again.

If this is the case (and the cause of your problem), then the
documentation and error message should be made clearer.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
