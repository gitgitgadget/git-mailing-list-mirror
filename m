From: Michael Lutz <michi@icosahedron.de>
Subject: Re: [PATCH] git-svn: add hook to allow modifying the subversion commit
 message
Date: Tue, 01 Nov 2011 21:45:43 +0100
Message-ID: <4EB05A77.4050901@icosahedron.de>
References: <1319228708-9052-1-git-send-email-michi@icosahedron.de> <20111101202806.GB29769@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:46:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLLDa-0005j3-9X
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab1KAUpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 16:45:49 -0400
Received: from dude.icosahedron.de ([77.37.19.40]:58764 "EHLO
	mail.icosahedron.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab1KAUpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:45:49 -0400
Received: from [127.0.0.1] (p5B042198.dip.t-dialin.net [91.4.33.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.icosahedron.de (Postfix) with ESMTPSA id 877CE64860;
	Tue,  1 Nov 2011 21:45:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111101202806.GB29769@dcvr.yhbt.net>
X-Enigmail-Version: 1.3.2
X-Antivirus: avast! (VPS 111101-2, 01.11.2011), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184590>

Am 01.11.2011 21:28 schrieb Eric Wong:
> I'm not convinced this is a good feature to support.  We already have
> --no-metadata to remove git-svn-id: lines and I hate that feature
> because it introduced extra variables for testing/debugging/recovery.
> 
> Metadata in the commit message is important, if you want to remove
> it after-the-fact, there's git-filter-branch.

The actual use case here is to replace a custom hack that adds some info
to the git commit message. In this case filter-branch isn't an option
because git-svn continuously pulls from the subversion master repository.
Additionally, especially for *adding* information, the information might
not be available later any more.

The only current metadata (the git-svn-id line) isn't affected by this
change as git-svn outputs it separately after the svn commit message that
the proposed hook can modify.

I fully realize that this is a rather specialized feature but I wanted to
publish it in case somebody else finds a use for this as well.


Michael Lutz
