From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 09:19:37 -0700
Message-ID: <20080808161937.GC9152@spearce.org>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, nico@cam.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRUi0-0002Mw-VE
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbYHHQTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbYHHQTi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:19:38 -0400
Received: from george.spearce.org ([209.20.77.23]:39707 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbYHHQTh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:19:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1028338420; Fri,  8 Aug 2008 16:19:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91686>

Pieter de Bie <pdebie@ai.rug.nl> wrote:
> On 8 aug 2008, at 16:41, Johannes Schindelin wrote:
>
>> fatal: corrupt packed object for  
>> 2c1e128aa51e3a64bd61556c0cd488628b423ccf
>> error: failed to run repack
>>
>> What's
>> the best way out?
>
> I don't know how to replace the object, but you can expand the pack,  
> replace
> the loose file, delete the old pack, and then create a new one

I don't think that will work here.  The unpack-objects process will
fail when it finds this bad object, and everything after that in
the pack file will be dropped on the floor and not get unpacked.

-- 
Shawn.
