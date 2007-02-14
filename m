From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: re-map repository URLs and UUIDs on SVK mirror
 paths
Date: Wed, 14 Feb 2007 18:18:21 +1300
Message-ID: <45D29B9D.5010701@vilain.net>
References: <20070210233750.A333013A384@magnus.utsl.gen.nz> <20070213222102.GA25092@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 06:18:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHCXU-0005UQ-Jw
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 06:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbXBNFSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 00:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbXBNFSl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 00:18:41 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:35113 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbXBNFSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 00:18:41 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 72A1A13A384; Wed, 14 Feb 2007 18:18:39 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id E138C13A303;
	Wed, 14 Feb 2007 18:18:35 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20070213222102.GA25092@localdomain>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39616>

Eric Wong wrote:
>> If an SVN revision has a property, "svm:headrev", it is likely that
>> the revision was created by SVN::Mirror (a part of SVK).  The property
>> contains a repository UUID and a revision.  We want to make it look
>> like we are mirroring the original URL, so introduce a helper function
>> that returns the original identity URL and UUID, and use it when
>> generating commit messages.
>>     
> If somebody is using these options with git-svn and wants to dcommit,
> they should only be committing to the svm:source repository and not to
> the repository managed by SVN::Mirror, right?

Yes. Only SVM::Mirror should write to paths below where svm:source and
svm:uuid are seen.

Sam.
