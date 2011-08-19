From: Richard Hansen <rhansen@bbn.com>
Subject: Why isn't the index a tree?
Date: Fri, 19 Aug 2011 17:24:44 -0400
Message-ID: <4E4ED49C.6050405@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 23:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuWx0-0004iq-2q
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 23:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab1HSVt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 17:49:56 -0400
Received: from smtp.bbn.com ([128.33.1.81]:59288 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab1HSVtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 17:49:55 -0400
X-Greylist: delayed 1509 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Aug 2011 17:49:55 EDT
Received: from socket.bbn.com ([192.1.120.102]:35843)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1QuWYX-0003yK-9m
	for git@vger.kernel.org; Fri, 19 Aug 2011 17:24:45 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 94FCA4076D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
X-Enigmail-Version: 1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179729>

I expected the index to be implemented something like a ref to a tree 
object (per stage) plus some stat()/assume-unchanged/etc. metadata. 
Instead, it appears to be a (sorted?) flat list of full paths with their 
associated SHA1s and metadata.

Is there a reason why each stage in the index isn't implemented as a tree?

If the index was a tree, I believe it would make several tasks easier:
   * you could easily get the diff between stage 1 and some arbitrary 
revision (e.g., git diff HEAD^^ :1:)
   * you could commit and checkout empty directories
   * you could use update-index --cacheinfo to directly insert/replace 
an entire subdirectory
   * etc.

Thanks,
Richard
