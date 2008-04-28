From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 20:29:17 +0200
Organization: glandium.org
Message-ID: <20080428182917.GA4794@glandium.org>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 20:31:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqY8V-0005Lq-2U
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966114AbYD1S37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966108AbYD1S37
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:29:59 -0400
Received: from vuizook.err.no ([194.24.252.247]:36500 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966103AbYD1S35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:29:57 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JqY6h-0005u9-PJ; Mon, 28 Apr 2008 20:29:50 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JqY6H-00030O-IL; Mon, 28 Apr 2008 20:29:17 +0200
Content-Disposition: inline
In-Reply-To: <20080428182114.GF26880@genesis.frugalware.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80578>

On Mon, Apr 28, 2008 at 08:21:14PM +0200, Miklos Vajna wrote:
> On Mon, Apr 28, 2008 at 07:08:50PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > With rotating logs, there is a problem when the syslog is opened only 
> > > > once (in the beginning).  So open the log everytime we write 
> > > > something, and close it directly after writing.
> > > 
> > > Gaah, this is ugly.
> > > 
> > > Is this something all the daemons need to deal with?
> > 
> > I have no idea, but it seems to fix a real issue.
> 
> logrotate supports sending a signal (typically SIGHUP) to the process
> after it rotated the log. Couldn't we just re-open the log on SIGHUP?

Isn't the problem that git-daemon loses its connection to the syslog
daemon when logrotate sighups syslog?

Mike
