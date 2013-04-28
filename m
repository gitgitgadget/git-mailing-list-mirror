From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] git-svn: fix occasional "Failed to strip path" error on fetch next commit
Date: Sun, 28 Apr 2013 10:58:36 +0200
Message-ID: <87obcz3ubn.fsf@linux-k42r.v.cablecom.net>
References: <1107347907.20130428123527@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 10:58:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWNRV-0007oF-SZ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 10:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab3D1I6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 04:58:41 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:37474 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab3D1I6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 04:58:41 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 28 Apr
 2013 10:58:33 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.209.190) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sun, 28 Apr 2013 10:58:37 +0200
In-Reply-To: <1107347907.20130428123527@gmail.com> (Ilya Basin's message of
	"Sun, 28 Apr 2013 12:35:27 +0359")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.209.190]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222733>

Ilya Basin <basinilya@gmail.com> writes:
>

You should Cc Eric on git-svn related patches.

> Test script:
>
>     rm -rf testrepo.svn testrepo.gitsvn
>     svnadmin create testrepo.svn
>     url=file://`pwd`/testrepo.svn
>
>     svn mkdir -m "" "$url/trunk" "$url/branches" "$url/tags"
>     rm -rf testrepo
>     svn co "$url" testrepo
>     cd testrepo/trunk
>
>     mkdir -p foo/bar/
>     svn add foo/
>     svn commit -mx
>
>     svn rm foo/bar/
>     svn commit -mx
>
>     svn up
>     mkdir -p baz/
>     svn add baz/
>     svn commit -mx
>
>     echo x > fil.txt
>     svn add fil.txt
>     svn commit -mx
>
>     cd ../..
>
>     git svn clone --stdlayout --preserve-empty-dirs "$url" testrepo.gitsvn

Please add an actual regression test, probably to t9160.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
