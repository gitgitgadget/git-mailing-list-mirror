From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Permissions of objects within shared repo
Date: Fri, 01 May 2009 08:58:15 -0500
Message-ID: <b_0Yr2BIOq-ZcTAxvkSlKVaJjU1_GJhkRLKGCkG7Uj5ft73JWFjWlA@cipher.nrlssc.navy.mil>
References: <799406d60904301849t1e77e81bgc6d58ecd0e9d6b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 15:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LztG2-0001SB-8I
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 15:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806AbZEAN6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 09:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756557AbZEAN6U
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 09:58:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58065 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbZEAN6T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 09:58:19 -0400
Received: by mail.nrlssc.navy.mil id n41DwGoc027525; Fri, 1 May 2009 08:58:16 -0500
In-Reply-To: <799406d60904301849t1e77e81bgc6d58ecd0e9d6b7d@mail.gmail.com>
X-OriginalArrivalTime: 01 May 2009 13:58:15.0939 (UTC) FILETIME=[DFF07D30:01C9CA64]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118078>

Adam Mercer wrote:

> [ram@g3 ~]$ cd /path/to/repo.git/objects/00/
> [ram@g3 00]$ ls -l
> total 43
> -r--r--r--+ 1 user1           1000  2729 Apr 19 13:13
> 028ade623678384fca34c51e0ea3ae91b8a50d

> will this cause a problem when git gc --auto decides its time to put
> these loose objects into a pack, i.e. will they be able to be removed?

On POSIX filesystems it's the _directory_ permissions which control whether
or not the directory contents can be deleted.

Do:

   ls -ld /path/to/repo.git/objects/00/

and you should see that the group has write permission to this directory
which will allow group members to delete files residing in the directory.

-brandon
