From: Semen Vadishev <semen.vadishev@tmatesoft.com>
Subject: Delete gitlink entry but keep .gitmodules file unmodified
Date: Wed, 18 Apr 2012 17:19:25 +0400
Message-ID: <4F8EBF5D.5070301@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 15:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKUnJ-0005DS-5o
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 15:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab2DRNTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 09:19:32 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52480 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752082Ab2DRNTb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 09:19:31 -0400
Received: by lahj13 with SMTP id j13so5696685lah.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 06:19:30 -0700 (PDT)
Received: by 10.112.29.99 with SMTP id j3mr1049728lbh.47.1334755170283;
        Wed, 18 Apr 2012 06:19:30 -0700 (PDT)
Received: from vs.local ([217.148.215.10])
        by mx.google.com with ESMTPS id u4sm26293789lad.5.2012.04.18.06.19.27
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 06:19:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195866>

Suppose one has a properly initialized submodule in a tree like this:

$ git ls-tree HEAD
100644 blob d208248ba4ab1d1791dc27f451dcaedb87dc19e1	.gitmodules
160000 commit ec633ea81e3cf64c3735ef4acd5ff9a490ed54eb	ext
100644 blob 597d6924118c00054efd526d9e48f68198f7da12	file.txt

$ git show HEAD:.gitmodules
[submodule "ext"]
         path = ext
         url = $URL

Then one pulls a modification that replaces 'ext' gitlink by some blob 
or tree entry, but keeps '.gitmodules' the same:

$ git ls-tree HEAD
100644 blob d208248ba4ab1d1791dc27f451dcaedb87dc19e1	.gitmodules
040000 tree 82e3a754b6a0fcb238b03c0e47d05219fbf9cf89	ext
100644 blob 597d6924118c00054efd526d9e48f68198f7da12	file.txt

Are there any possible downsides of such modification we should be aware of?

Thanks,

-- 
Semen Vadishev,
TMate Software,
http://subgit.com/ - git+svn on the server side!
