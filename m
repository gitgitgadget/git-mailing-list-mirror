From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] pack-objects: Allow missing base objects when creating
 thin packs
Date: Tue, 12 Aug 2008 14:43:45 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808121439150.22892@xanadu.home>
References: <20080811182839.GJ26363@spearce.org>
 <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
 <20080811224404.GQ26363@spearce.org> <20080812012859.GT26363@spearce.org>
 <alpine.LFD.1.10.0808120023250.22892@xanadu.home>
 <20080812164149.GB31092@spearce.org>
 <alpine.LFD.1.10.0808121402440.22892@xanadu.home>
 <20080812181843.GD31092@spearce.org>
 <alpine.LFD.1.10.0808121426100.22892@xanadu.home>
 <20080812183106.GE31092@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSyrZ-0007bc-1a
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbYHLSnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYHLSnv
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:43:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44143 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbYHLSnv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:43:51 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5I00DZ6405CG00@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Aug 2008 14:43:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080812183106.GE31092@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92130>

On Tue, 12 Aug 2008, Shawn O. Pearce wrote:

> If we are building a thin pack and one of the base objects we would
> consider for deltification is missing its OK, the other side already
> has that base object.  We may be able to get a delta from another
> object, or we can simply send the new object whole (no delta).
> 
> This change allows a shallow clone to store only the objects which
> are unique to it, as well as the boundary commit and its trees, but
> avoids storing the boundary blobs.  This special form of a shallow
> clone is able to represent just the difference between two trees.
> 
> Pack objects change suggested by Nicolas Pitre.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  Nicolas Pitre <nico@cam.org> wrote:
>  > On Tue, 12 Aug 2008, Shawn O. Pearce wrote:
>  > I'm not talking about the last command but the "test $(git rev-parse 
>  > HEAD) = $B" line.
>  
>  Oh, right.  Good catch.

Acked-by: Nicolas Pitre <nico@cam.org>

> +++ b/t/t5306-pack-nobase.sh
> @@ -0,0 +1,80 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Google Inc.

Heh.  ;-)


Nicolas
