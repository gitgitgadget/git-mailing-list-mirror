From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save As" emails
Date: Fri, 18 Dec 2009 21:42:49 +0000 (UTC)
Message-ID: <loom.20091218T223918-175@post.gmane.org>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org> <1261172078-9174-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 22:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLkbX-0006oM-BO
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 22:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbZLRVnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 16:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755704AbZLRVnP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 16:43:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:51038 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646AbZLRVnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 16:43:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NLkbQ-0006mA-5q
	for git@vger.kernel.org; Fri, 18 Dec 2009 22:43:12 +0100
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 22:43:12 +0100
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 22:43:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.102 (Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; OfficeLiveConnector.1.4; OfficeLivePatch.1.3))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135441>

Stephen Boyd <bebarino <at> gmail.com> writes:

> +	{
> +		echo "X-Fake-Field: Line One\015" &&

echo and \ do not portably mix.  For that matter, shell double quotes and 
backslash escapes that are not required by POSIX do not portably mix.  To 
reliably create carriage returns in shell, you need to use printf, or else 
something like:

echo "...@" | tr '@' '\015'

-- 
Eric Blake
