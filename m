From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 16:43:09 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161640010.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <m37ii9nagt.fsf@roke.D-201> <alpine.DEB.1.00.0801161600030.5260@bender.nucleusys.com> <200801161520.44668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9Vi-0003xO-Ip
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbYAPOoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbYAPOob
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:44:31 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:40040 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754932AbYAPOo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:44:29 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF9V5-0007Sc-U7; Wed, 16 Jan 2008 16:44:19 +0200
In-Reply-To: <200801161520.44668.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70684>

On Wed, 16 Jan 2008, Jakub Narebski wrote:

> Petko Manolov wrote:
>> On Wed, 16 Jan 2008, Jakub Narebski wrote:
>>
>>> You can always tag a blob (like junio-gpg-pub tag in git.git repository),
>>> but it wouldn't be in a working directory. But it would get distributed
>>> on clone.
>>
>> Hm, how does it work?
>
> You use git-hash-object to put file (-t blob) into the object database.
> It would return sha1 of added object. Use git-tag to create tag to blob
> (use returned sha1 for head). You can get file (to stdout) with
> "git cat-file blob tagname^{blob}".

Sounds like i'll have to play with the above.  Thanks for the tip.

> The file would be in object database, but not in working directory
> by default.

Not a big problem.

>> Unfortunately this is not the case.  These binary blobs are already
>> compressed and/or encrypted and adding even a few bytes ends up storing
>> new version in full size.
>
> Can't you store them uncompressed?

Not really, but i can convert them into ascii format and store only the 
delta.  This will admittedly increase the initial size of the repository, 
but hopefully not by much.


 		Petko
