From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] init-db.c: honor case on case preserving fs
Date: Sat, 01 Feb 2014 13:17:47 +0100
Message-ID: <52ECE5EB.6090304@web.de>
References: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dpotapov@gmail.com
To: Reuben Hawkins <reubenhwk@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 01 13:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9ZWE-0004yi-JS
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 13:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbaBAMRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 07:17:50 -0500
Received: from mout.web.de ([212.227.17.11]:50821 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaBAMRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 07:17:49 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MbQOe-1VqneB1yku-00Ijum for <git@vger.kernel.org>;
 Sat, 01 Feb 2014 13:17:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
X-Provags-ID: V03:K0:AGhil30kIAmdkT7pQpnOisdmthATKbCZea+iQ5vdk7YY2Lh72/D
 VgYJLT7KcUWcA7+MdspXbTZ8iPkCjHyzWHu+ulLcxkQJbYg8tjQrTSyWqE7IgQXEiQeNpO6
 fLftkfgPB+9ZuQspXr+Lukqnkiybj+BaE1m0WY5+qQmpvV/uLvJvwQGxa1/SDlXd50+fvyY
 a9vNwYqawttDhsipnoCtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241344>

On 2014-02-01 10.14, Reuben Hawkins wrote:
> Most case-insensitive filesystems are case-preserving. In these
> filesystems (such as HFS+ on OS X) you can name a file Filename.txt,
> then rename the file to FileName.txt.  That file will be accessible
> by both filenames, but the case is otherwise honored.  We don't want
> to have git ignore case on these case-preserving filesystem
> implementations.

Yes, we want.
Because the file system will treat "Filename.txt" and "FileName.txt"
the same.
Whatever is on disc, the OS will not distinguish them.
(On a case-insensitive HFS+ partition).

And when core.ignorecase == true, Git does the same what the OS does,
ignore the case.

Could you describe the problems more in detail ?

Could you supply a test case, (or a short script) which shows
the problem and makes it reproducable for others?

Which problems does your patch solve, which can not be solved
by setting core.ignorecase==false manually?
 
/Torsten
