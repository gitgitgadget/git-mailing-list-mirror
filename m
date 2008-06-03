From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Maintaining two branches.
Date: Tue, 3 Jun 2008 20:08:09 +0200
Message-ID: <08056802-BBBC-4F1D-A1A6-2F8C381CDA2B@ai.rug.nl>
References: <20080603163431.GA1244@old.davidb.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:09:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3awh-0007eM-Ds
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 20:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbYFCSIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 14:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbYFCSIU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 14:08:20 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:16140 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586AbYFCSIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 14:08:19 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6008.orange.nl (SMTP Server) with ESMTP id BC8DF70000A4;
	Tue,  3 Jun 2008 20:08:17 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6008.orange.nl (SMTP Server) with ESMTP id 6A17C70000A0;
	Tue,  3 Jun 2008 20:08:11 +0200 (CEST)
X-ME-UUID: 20080603180815434.6A17C70000A0@mwinf6008.orange.nl
In-Reply-To: <20080603163431.GA1244@old.davidb.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83685>


On 3 jun 2008, at 18:34, David Brown wrote:

> We have three branches of the code:
>
>  - upstream - The upstream release versions, tracks outside git repo.
>  - external - Other external patches not included in the main git  
> repo.
>  - local - Our local development.
>
> For release reasons, we need to keep our local branch separate, but  
> normal
> development needs to be done on a merge of 'external' and  
> 'local' (the tree
> needs the merge of both just to build).  Developers will generate  
> patches,
> and maintainers will apply these patches to 'local'.

You might do the same workflow that Git has with stable / master / next

If there is a new upstream release, merge it into external. If you  
have patches you want to show to the outside, apply those patches to  
external. Then you can merge external into local. The trick is to  
never merge local into external.

By going only one way (upstream --> external --> local), you'll never  
have to worry about having to separate the different patches. Your  
history will be displayed much nicer too.

- Pieter
