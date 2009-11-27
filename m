From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Makefile: determine the list of header files using a
 glob
Date: Fri, 27 Nov 2009 09:26:24 +0100
Message-ID: <20091127082624.GA19875@glandium.org>
References: <4B0F8825.3040107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDwAk-0004ol-K7
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 09:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbZK0I1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 03:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZK0I1L
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:27:11 -0500
Received: from vuizook.err.no ([85.19.221.46]:40482 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbZK0I1K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 03:27:10 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NDwAV-0000ig-LG; Fri, 27 Nov 2009 09:27:11 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1NDw9o-0005CW-MY; Fri, 27 Nov 2009 09:26:24 +0100
Content-Disposition: inline
In-Reply-To: <4B0F8825.3040107@viscovery.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133875>

On Fri, Nov 27, 2009 at 09:04:53AM +0100, Johannes Sixt wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> The list of header files was incomplete because a number of header files
> were added to the code base, but were not added to the list LIB_H that we
> have in the Makefile. This meant that no rebuild was triggered if one of
> the missing headers was changed because we do not have automatic
> dependency tracking, either.
> 
> Sidestep the issue by computing the list using $(wildcard).

I don't know if the current Makefile works with Solaris' make, or if GNU
make has to be used, but $(wildcard) is definitely not supported by
Solaris' make.

Mike
