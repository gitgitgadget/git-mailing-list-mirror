From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 4/4] read-tree: add --no-sparse to turn off sparse
  hook
Date: Tue, 11 Aug 2009 08:50:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908110846050.4638@intel-tinevez-2-302>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> <1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com> <1249917562-5931-4-git-send-email-pclouds@gmail.com> <1249917562-5931-5-git-send-email-pclouds@gmail.com>
 <alpine.DEB.1.00.0908101842530.8324@intel-tinevez-2-302> <fcaeb9bf0908101838k37751fclac5c572eb042138e@mail.gmail.com> <7vhbwforvk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1580555074-1249973410=:4638"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqM3-0002qk-74
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbZHKMQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZHKMQw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:16:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:35812 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbZHKMQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:16:50 -0400
Received: (qmail invoked by alias); 11 Aug 2009 06:50:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp038) with SMTP; 11 Aug 2009 08:50:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+I7r5IabaIMuwp6dNI1z5cKXryj5h/kmEh89QKqt
	+FD/NZ1WOsjdY3
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vhbwforvk.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125530>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1580555074-1249973410=:4638
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Aug 2009, Junio C Hamano wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> >> Hmm.  I understand that the assumption is that memset(&opts, 0,
> >> sizeof(opts)); should give you a sensible default, but I cannot avoid
> >> noticing that "no_sparse_hook = 0" is a double negation, something to be
> >> avoided...
> >
> > skip_sparse_hook then? :-)

It nicely avoids the double negation, indeed.

> Why not making the hook to be skipped by default, and pass an explicit 
> option to trigger the hook?
> 
> I like Dscho's other suggestion to use patterns like .gitignore instead 
> of using hook scripts that needs to be ported across platforms, by the 
> way.

I forgot to mention that I checked dir.c to verify that 
add_excludes_from_file_1() (which is static, so you'll either need to use 
it in the same file, or even better, export it renaming it to something 
like add_excludes_from_file_to_list()) and excluded_1() (same here) 
already do a large part of what you need.

Ciao,
Dscho

--8323329-1580555074-1249973410=:4638--
