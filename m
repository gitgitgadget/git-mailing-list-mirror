From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Wed, 9 May 2007 13:43:21 +0200
Message-ID: <4BA4CF7D-40CB-4A55-ADDC-56DE179FD6C1@zib.de>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de> <Pine.LNX.4.64.0705091303280.4167@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 13:43:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlkZk-0005wj-74
	for gcvg-git@gmane.org; Wed, 09 May 2007 13:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbXEILnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 07:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756091AbXEILnO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 07:43:14 -0400
Received: from mailer.zib.de ([130.73.108.11]:39779 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639AbXEILnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 07:43:12 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l49BhBgx016078;
	Wed, 9 May 2007 13:43:11 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l49BhACE014489
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 9 May 2007 13:43:10 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0705091303280.4167@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46699>

Hello,

On May 9, 2007, at 1:04 PM, Johannes Schindelin wrote:

> On Wed, 9 May 2007, Steffen Prohaska wrote:
>
>> The old implementation executed 'cvs status' for each file touched by
>> the patch to be applied.
>
> I did not follow development of that script closely, but could it  
> be that
> this is a safety valve, to make it unlikely to commit something  
> which was
> changed by somebody else in the meantime?

Right. My patch doesn't change the functionality of the safety check.  
It's just a magnitude faster if you commit a lot of files. I'm now  
able to apply a patch that changes 900 files to a cvs working copy  
using ssh over DSL. I wasn't before, at least not in reasonable time.

Another solution would be to make the safety checks optional as they  
are not needed for the core functionality. If you have a clean, up-to- 
date cvs working copy you're fine.

- Steffen
