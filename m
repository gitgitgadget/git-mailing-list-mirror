From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Can't handle renamed resources on case insensitive filesystems.
Date: Mon, 14 Dec 2009 15:52:15 +0100
Message-ID: <4B26511F.5040804@dbservice.com>
References: <63135FDB-C8EF-4DBC-AEF5-4B0636C8D349@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Lhunath (Maarten B.)" <lhunath@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 15:52:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKCHi-0001ZL-1T
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 15:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245AbZLNOwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 09:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756910AbZLNOwV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 09:52:21 -0500
Received: from office.neopsis.com ([78.46.209.98]:35492 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891AbZLNOwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 09:52:20 -0500
Received: from calvin.caurea.org ([147.88.200.144])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Mon, 14 Dec 2009 15:52:16 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.3a1pre) Gecko/20091214 Lightning/1.1a1pre Shredder/3.1a1pre
In-Reply-To: <63135FDB-C8EF-4DBC-AEF5-4B0636C8D349@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135216>

On 12/14/09 3:27 PM, Lhunath (Maarten B.) wrote:
> GIT has quite a few issues concerning renamed files on case insensitive filesystems, such as Mac OS X's default HFS+.
>
> For instance:
>
> lhunath@Myst t $ git mv Foo foo
> fatal: destination exists, source=Foo, destination=foo
>
> Moreover, when a repository contains Foo and foo in one commit and in a subsequent commit, "foo" is removed; "Foo" will also disappear when checking out the latter.
>
> Most of these issues are likely just a result of the underlying file system's handling of GIT's commands; though considering that Mac OS X's default fs is case insensitive by default, and the Mac and Windows userbases combined are quite large; it might be very much appropriate to do a check for this (if needed) and handle renames (and other operations?) in a way that they would not cause conflicts on these file systems (eg. rename to a temporary filename first and then rename to destination).
>
> In particular; these issues make it awfully painful to refactor Java class names from things like JndiUtils ->  JNDIUtils.  Not only is it hard to get the commit INTO the repository correctly; it is also hard to check the commit OUT for somebody who has no idea any of this is needed.--

Create a disk image and format it with case-sensitive HFS+, create a new 
partition and format it with case-sensitive HFS+, or reinstall Mac OS X 
and choose case-sensitive HFS+ as the filesystem for the system partition.

After I found out that the default install of Mac OS X uses 
case-insensitive filesystem, the first thing I did was reinstall the OS.

tom
