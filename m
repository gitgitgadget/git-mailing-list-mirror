From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 1/2] push: Don't push a repository with unpushed
	submodules
Date: Tue, 23 Aug 2011 21:45:21 +0200
Message-ID: <20110823194521.GB57187@book.hvoigt.net>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com> <1313791728-11328-2-git-send-email-iveqy@iveqy.com> <7vwre9yodc.fsf@alter.siamese.dyndns.org> <7vippszj70.fsf@alter.siamese.dyndns.org> <7vmxf3xnsf.fsf@alter.siamese.dyndns.org> <20110822194728.GA11745@sandbox-rc> <7vd3fxulw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 21:45:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvwug-0003jm-Pb
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 21:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab1HWTp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 15:45:26 -0400
Received: from darksea.de ([83.133.111.250]:42544 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756027Ab1HWTpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 15:45:23 -0400
Received: (qmail 2216 invoked from network); 23 Aug 2011 21:45:21 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Aug 2011 21:45:21 +0200
Content-Disposition: inline
In-Reply-To: <7vd3fxulw8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179964>

On Mon, Aug 22, 2011 at 03:22:31PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Junio since you are one person listed in the api docs could you maybe
> > quickly explain to me what this flag is used for?
> 
> It is used in order to avoid walking the object we have walked already.
> 
> Which in turn means that once you walk chain of objects, unless you
> remember the ones you walked and clear the marks after you are done, you
> cannot walk the object chain for unrelated purposes.  See how functions
> like get_merge_bases_many() walk portions of graph for their own purpose
> and then avoid disrupting others by calling clear_commit_marks(). The use
> of TMP_MARK (and its clearing after the function is done with the marked
> objects) in remove_duplicate_parents() serve the same purpose.

Thanks I will have look at those places and try to cook up something.

Cheers Heiko
