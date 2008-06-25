From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Wed, 25 Jun 2008 08:14:53 +0200
Organization: glandium.org
Message-ID: <20080625061453.GA32178@glandium.org>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home> <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org> <7vd4m66rfp.fsf@gitster.siamese.dyndns.org> <20080625055605.GD28563@glandium.org> <7viqvy59qr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 08:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBOIX-00062O-Fm
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 08:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbYFYGPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 02:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYFYGPJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 02:15:09 -0400
Received: from vuizook.err.no ([194.24.252.247]:35191 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbYFYGPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 02:15:08 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KBOHO-0008Jq-K1; Wed, 25 Jun 2008 08:15:01 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KBOHN-0008PF-Oj; Wed, 25 Jun 2008 08:14:53 +0200
Content-Disposition: inline
In-Reply-To: <7viqvy59qr.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86242>

On Tue, Jun 24, 2008 at 11:06:36PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Wouldn't it be a good idea to add a warning in git update-server-info
> > when it detects pack.indexVersion is not 1, too ?
> 
> Can you describe how that warning will help whom in the bigger picture?
> 
> The way as I understand everybody runs "git update-server-info" is:
> 
>  * "git push" pushes into a publishing repository, then
>  * "post-receive" (or "post-update") hook triggers "update-server-info".
> 
> If you spit out a warning from update-server-info, it will be shown to the
> pusher over sideband, but this will not necessarily help the pusher, who
> may or may not have shell access to the repository.

There are also those that get the message to run update-server-info when
trying to clone over dumb protocol when the info/refs file is not
there... I actually didn't think about the post-receive hook.

Well, then, update-server-info could output the warning only if stderr
is a tty.

Mike
