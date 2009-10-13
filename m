From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC PATCH v2 09/16] Move WebDAV HTTP push under remote-curl
Date: Tue, 13 Oct 2009 06:41:41 +0200
Message-ID: <20091013044141.GA18961@glandium.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
 <1255400715-10508-10-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 06:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxZE5-0003pV-Fz
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 06:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbZJMElk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 00:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbZJMElj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 00:41:39 -0400
Received: from vuizook.err.no ([85.19.221.46]:35492 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbZJMEli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 00:41:38 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1MxZBw-0001R5-Hy; Tue, 13 Oct 2009 06:40:59 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1MxZCf-00054s-Ea; Tue, 13 Oct 2009 06:41:41 +0200
Content-Disposition: inline
In-Reply-To: <1255400715-10508-10-git-send-email-spearce@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130126>

On Mon, Oct 12, 2009 at 07:25:08PM -0700, Shawn O. Pearce wrote:
> The remote helper interface now supports the push capability,
> which can be used to ask the implementation to push one or more
> specs to the remote repository.  For remote-curl we implement this
> by calling the existing WebDAV based git-http-push executable.
> 
> Internally the helper interface uses the push_refs transport hook
> so that the complexity of the refspec parsing and matching can be
> reused between remote implementations.  When possible however the
> helper protocol uses source ref name rather than the source SHA-1,
> thereby allowing the helper to access this name if it is useful.

It's been a while I haven't followed changes in the remote code but this
looks nice, though I haven't checked thoroughly. I guess the next step
would be to kill http-push as an external program.

Mike
