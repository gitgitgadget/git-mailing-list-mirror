From: Jason Merrill <jason@redhat.com>
Subject: Re: git clone sending unneeded objects
Date: Sun, 27 Sep 2009 00:35:30 -0400
Message-ID: <4ABEEB92.1020307@redhat.com>
References: <alpine.LFD.2.00.0908082246020.440@xanadu.home> <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com> <vpqvdj6izt6.fsf@bauges.imag.fr> <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com> <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com> <4ABD9C2C.60800@redhat.com> <alpine.LFD.2.00.0909262059520.4997@xanadu.home> <20090927020409.GK14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Hin-Tak Leung <hintak.leung@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 06:40:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrlYR-0004Me-5E
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 06:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbZI0Efd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 00:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbZI0Efd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 00:35:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbZI0Efd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 00:35:33 -0400
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8R4ZVdn008138;
	Sun, 27 Sep 2009 00:35:31 -0400
Received: from [IPv6:::1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8R4ZUIj024380;
	Sun, 27 Sep 2009 00:35:30 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20090925 Shredder/3.0pre
In-Reply-To: <20090927020409.GK14660@spearce.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129194>

On 09/26/2009 10:04 PM, Shawn O. Pearce wrote:
> Actually, if those refs have not changed, quickfetch should kick in
> and realize that all 410610 objects are reachable locally without
> errors, permitting the client to avoid the object transfer.
>
> However, if *ANY* of those refs were to change to something you
> don't actually have, quickfetch would fail, and we would need to
> fetch all 410610 objects.

Right.  That seems unfortunate to me; couldn't fetch do a bit more 
checking before it decides to download the whole world again?

Jason
