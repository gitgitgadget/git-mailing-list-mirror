From: david@lang.hm
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 18:35:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709151831401.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 03:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWj2z-0002D3-MU
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 03:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbXIPBfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 21:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXIPBfh
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 21:35:37 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:54488
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbXIPBfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 21:35:36 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8G1ZDeu021452;
	Sat, 15 Sep 2007 18:35:13 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 15 Sep 2007, Daniel Barkalow wrote:

>> The reason why I say this should be done inside git rather than with 
>> hooks and an external tool, such as metastore is quite simple: git 
>> knows about every content entity in any tree of a repo and already has 
>> a data node for each object. Rather than introducing a parallel object 
>> database (shadow hierarchy or single file), it would make a lot more 
>> sense and be way more robust to attach additional information to these 
>> object nodes, wouldn't it?
>
> Git doesn't have any way to represent owners or groups, and they would 
> need to be represented carefully in order to make sense across multiple 
> computers. If you're adding support for metadata-as-content (for more 
> than "is this a script?"), you should be able to cover all of the common 
> cases of extended stuff, like AFS-style ACLs. And if you want to allow 
> meaningful development with this mechanism (as opposed to just archival 
> of a sequence of states of a live system)

don't underestimate the usefullness of the ability to archive and restore 
snapshots of a live system. just that ability would be wonderful to have.

the ability to checkout a copy of things elsewhere and tinker with it 
would be better, but the lack of that doesn't eliminate the utility by any 
means.

David Lang

> , the normal case will be that 
> the metadata beyond +x is manipulated by ordinary users in some way 
> other than modifying their working directory. So the normal case here 
> will be like working on a filesystem that doesn't support symlinks or an 
> executable bit when this is important content.
