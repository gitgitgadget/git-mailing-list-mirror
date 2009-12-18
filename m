From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save As" emails
Date: Fri, 18 Dec 2009 22:42:28 +0000 (UTC)
Message-ID: <loom.20091218T234129-280@post.gmane.org>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>  <1261172078-9174-1-git-send-email-bebarino@gmail.com>  <loom.20091218T223918-175@post.gmane.org> <1261173577.14059.5.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 23:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLlXR-0005zS-MD
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 23:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbZLRWm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 17:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933047AbZLRWm7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 17:42:59 -0500
Received: from lo.gmane.org ([80.91.229.12]:58560 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932936AbZLRWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 17:42:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NLlXB-0005u6-GF
	for git@vger.kernel.org; Fri, 18 Dec 2009 23:42:53 +0100
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 23:42:53 +0100
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 23:42:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.102 (Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; OfficeLiveConnector.1.4; OfficeLivePatch.1.3))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135446>

Stephen Boyd <bebarino <at> gmail.com> writes:

> > echo and \ do not portably mix.  For that matter, shell double quotes and 
> > backslash escapes that are not required by POSIX do not portably mix.
> 
> Thanks. Hopefully squashing this in will make it even more portable?
> 
> +               printf "X-Fake-Field: Line One\015\n" &&

Nope.  You need either "\\015\\n" or '\015\n', since "\015" and "\n" are both 
undefined in portable shell.

-- 
Eric Blake
