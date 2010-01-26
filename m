From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 18:19:00 +0100
Message-ID: <20100126171900.GA14092@glandium.org>
References: <20100125225139.GA3048@fredrik-laptop>
 <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain>
 <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com>
 <alpine.LFD.2.00.1001260728260.3574@localhost.localdomain>
 <4B5F1894.4070509@googlemail.com>
 <alpine.LFD.2.00.1001260836520.3574@localhost.localdomain>
 <alpine.LFD.2.00.1001260846330.3574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Kramer <benny.kra@googlemail.com>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 18:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZp4O-000114-NV
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 18:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0AZRTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 12:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666Ab0AZRTN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 12:19:13 -0500
Received: from vuizook.err.no ([85.19.221.46]:36726 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab0AZRTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 12:19:12 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NZp49-0001ZR-Oy; Tue, 26 Jan 2010 18:19:04 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1NZp48-0004gM-ME; Tue, 26 Jan 2010 18:19:00 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001260846330.3574@localhost.localdomain>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138058>

On Tue, Jan 26, 2010 at 08:56:50AM -0800, Linus Torvalds wrote:
<snip>
> although it is worth noting that that machine has an Intel SSD, which is 
> why it gets sped up so much by parallel IO (there's no seek penalty, and 
> it is able to read multiple channels in parallel, so this gives much 
> better IO patterns for it - with rotational media the numbers might be 
> very different).

For rotational disks, using FIEMAP to get the position of the files on
disk to reorder how we read them could help.

Mike
