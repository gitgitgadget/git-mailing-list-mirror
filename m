From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Wed, 31 Aug 2005 10:12:11 +0100
Message-ID: <tnxhdd6o4gk.fsf@arm.com>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
	<20050819194832.GA8562@fanta>
	<1124572356.7512.21.camel@localhost.localdomain>
	<20050821094059.GA5453@fanta>
	<Pine.LNX.4.63.0508221707520.23242@iabervon.org>
	<tnxvf1wd24m.fsf@arm.com>
	<Pine.LNX.4.63.0508231304130.23242@iabervon.org>
	<20050823212305.GA5936@fanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 11:12:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAOeA-0002Ce-EH
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 11:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVHaJMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 05:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVHaJMh
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 05:12:37 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:15511 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932495AbVHaJMg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 05:12:36 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7V9CKQb002190;
	Wed, 31 Aug 2005 10:12:20 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA08879;
	Wed, 31 Aug 2005 10:12:13 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 31 Aug 2005 10:12:12 +0100
To: Jan Veldeman <jan.veldeman@gmail.com>
In-Reply-To: <20050823212305.GA5936@fanta> (Jan Veldeman's message of "Tue,
 23 Aug 2005 23:23:05 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 31 Aug 2005 09:12:12.0662 (UTC) FILETIME=[12B50160:01C5AE0C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7973>

Jan Veldeman <jan.veldeman@gmail.com> wrote:
> The parents which should be visible to the outside, will always be versions
> of my development tree, which I have previously pushed out. My way of
> working would become:
> * make changes, all over the place, using stgit
> * still make changes (none of these gets tracked, intermittent versions are
>   lost)
> * having a good day: changes looks good, I want to push this out:
>   * push my tree out
>   * stgit-free (which makes the pushed out commits, the new parents of my
>     stgit patches)

When the tree status looks good, you could tag it and the whole stack
(the commits corresponding to the patches) would be available via this
tag.

As I said, I agree with the idea of freezing a patch and even having
multiple parents to a commit but this commit should not be visible via
HEAD. We could have another id for a patch, 'frozen', which stores the
last frozen state with the parents being the previous frozen
states. Its SHA1 value could be accessed via 'stg id <patch>/frozen'
(in the same way as /top and /bottom ids).

-- 
Catalin
