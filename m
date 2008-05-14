From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive description
Date: Wed, 14 May 2008 08:48:19 +0200
Message-ID: <FCA89971-FDBB-4E44-82CE-C0AA854A4667@ai.rug.nl>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl> <alpine.DEB.1.00.0805131251320.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 08:49:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwAnY-000130-B2
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 08:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbYENGsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 02:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYENGsW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 02:48:22 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:36294 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbYENGsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 02:48:21 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6207.orange.nl (SMTP Server) with ESMTP id 33F8A1C00083;
	Wed, 14 May 2008 08:48:20 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6207.orange.nl (SMTP Server) with ESMTP id CD5961C00082;
	Wed, 14 May 2008 08:48:19 +0200 (CEST)
X-ME-UUID: 20080514064819841.CD5961C00082@mwinf6207.orange.nl
In-Reply-To: <alpine.DEB.1.00.0805131251320.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82080>


On 13 mei 2008, at 13:52, Johannes Schindelin wrote:
>> The documentation for the --aggressive flag was misleading, hinting  
>> that
>> running git gc with --aggressive is a good thing. However, -- 
>> aggressive
>> only really makes sense if you have a bad pack file, such as from
>> git-fast-import.
>
> I disagree.  It makes sense to "git gc --aggressive" also after  
> cloning
> from somebody who did not do so.

The problem with this is that your pack might increase in size, which  
you can't know in advance. Running "git gc --aggressive" on the git  
repo for example increases its size from 20MB to 30MB.

The current wording at least makes it sound as if --aggressive will  
always result in a smaller pack, which is simply not true. Increasing  
the window and depth might help, but 250 or even 100 can be too much  
on any decently size repository.

How about dropping the last sentence ("Using --aggressive only makes  
sense if you have a badly packed repository, such as created by git- 
fast-import.") then?

- Pieter
