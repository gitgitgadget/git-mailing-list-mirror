From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 07:33:31 +0100
Organization: glandium.org
Message-ID: <20080306063331.GA7325@glandium.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site> <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site> <alpine.LSU.1.00.0803060212170.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 07:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX9cL-0002Fe-4P
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 07:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbYCFG3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 01:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756066AbYCFG3h
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 01:29:37 -0500
Received: from vuizook.err.no ([194.24.252.247]:37219 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756308AbYCFG3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 01:29:35 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JX9bM-00085F-OY; Thu, 06 Mar 2008 07:29:19 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JX9fX-0002BU-Gt; Thu, 06 Mar 2008 07:33:31 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803060212170.15786@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76343>

On Thu, Mar 06, 2008 at 02:14:43AM +0100, Johannes Schindelin wrote:
> 
> The most common use of addf() was to init a strbuf and addf() right away.
> Since it is so common, it makes sense to have a function strbuf_initf()
> to wrap both calls into one.
> 
> Unfortunately, C (and cpp) has no way to make this easy without code
> duplication, as we need to va_init() in strbuf_addf() possibly a few
> times.  So the code for addf() is copied.  Fortunately, the code is
> pretty short, so not too much had to be copied as-is.

The problem with code duplication is not about code size, but more about
not forgetting to fix bugs in all incarnations of the duplicated code.

Is it so ugly to use a macro ?

Mike
