From: Kevin Ballard <kevin@sb.org>
Subject: git clone broken in next
Date: Wed, 14 May 2008 23:54:39 -0400
Message-ID: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 15 05:55:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwUZ3-00084N-GR
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 05:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbYEODym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 23:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYEODym
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 23:54:42 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:40421
	"EHLO randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751512AbYEODym (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 23:54:42 -0400
Received: from [192.168.0.203] (c-24-91-11-245.hsd1.ma.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 429B1EEF9A
	for <git@vger.kernel.org>; Wed, 14 May 2008 20:54:41 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82172>

Something's horribly wrong in next. I just installed the latest from  
next and then ran

   git clone git://github.com/kballard/github-gem.git

The resulting repo had absolutely nothing in the workdir. `git status`  
claims every single file is deleted but not updated. `git checkout -f  
HEAD` fixed the workdir.

This is 100% repeatable with different repositories.

$ git --version
git version 1.5.5.1.373.gce4aa

(this is the tip of next plus a single documentation patch).

Oddly, all of the tests with "clone" in their name seem to be passing  
just fine.

Ok, after running a git-bisect, I narrowed it down to  
8434c2f1afedb936e0ea8c07ce25733013c2f743 (Build in clone).

My system is Mac OS X 10.5.2.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
