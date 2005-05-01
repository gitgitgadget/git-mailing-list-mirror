From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: update-cache ./test.c
Date: Sun, 1 May 2005 10:47:10 +0200
Message-ID: <20050501084710.GJ26663@cip.informatik.uni-erlangen.de>
References: <20050501084145.GA30692@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 10:41:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSA11-0006Ti-2q
	for gcvg-git@gmane.org; Sun, 01 May 2005 10:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVEAIrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 04:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVEAIrO
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 04:47:14 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:29174 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261556AbVEAIrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 04:47:11 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j418lAS8009836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 1 May 2005 08:47:10 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j418lAcx009835
	for git@vger.kernel.org; Sun, 1 May 2005 10:47:10 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050501084145.GA30692@xi.wantstofly.org>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> update-cache seems to ignore paths containing path components
> starting with a dot:

> 	pi% update-cache --add ./test.c
> 	Ignoring path ./test.c
> 	pi% update-cache --add test.c
> 	pi%

> This is slightly annoying as 'find -type f | xargs update-cache --add'
> doesn't work because of this.  ('find * -type f | ...` does.)  Instead
> of ignoring the file, can we just strip off the leading "./" ?

just use a shell script to obtain that:

find -type f | sed "s#^./##" | xargs update-cache --add

Greetings,
	Thomas
