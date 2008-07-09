From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Wed, 9 Jul 2008 09:53:46 +0200
Organization: glandium.org
Message-ID: <20080709075345.GA22022@glandium.org>
References: <11911047823308-git-send-email-jean.guyader@linkea.org> <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709300039430.28395@racer.site> <7v4phdja01.fsf@gitster.siamese.dyndns.org> <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org> <20080709055150.GA28482@glandium.org> <7vlk0blgg0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 09:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGUWJ-0001LK-9s
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 09:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbYGIHyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 03:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbYGIHyF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 03:54:05 -0400
Received: from vuizook.err.no ([194.24.252.247]:46447 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbYGIHyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 03:54:04 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KGUUn-000401-TG; Wed, 09 Jul 2008 09:53:56 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1KGUUk-0005ka-M9; Wed, 09 Jul 2008 09:53:46 +0200
Content-Disposition: inline
In-Reply-To: <7vlk0blgg0.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87857>

On Tue, Jul 08, 2008 at 11:28:15PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Tue, Jul 08, 2008 at 10:44:58PM -0700, Junio C Hamano wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > On Sat, 29 Sep 2007, Junio C Hamano wrote:
> >> >
> >> >> We never supported URLs with embedded credentials (see
> >> >> Documentation/urls.txt), partly because nobody asked for it, but
> >> >> more importantly because giving -n to curl to have it read from
> >> >> user's .netrc is generally much more preferred approach.
> >> >
> >> > To elaborate on that: if you fetch from somewhere, your url, username and 
> >> > password can be read from the output of "ps ax | grep http" very easily.
> >> 
> >> Actually Documentation/howto/setup-git-server-over-http.txt
> >> talks about http://user@server/path/ format.  How well does this
> >> work in practice?  If it does, we should update Documentation/urls.txt
> >> to allow optional user@ there like...
> >
> > AFAIK, there is nothing to deal with asking a password to the user in git
> > in this case, so that doesn't work.
> 
> Then perhaps the howto needs updating?

Actually, the howto tells to setup a ~/.netrc file, which should make
the http://user@server/path/ format work. I don't know if dropping user@
would still work, that depends how libcurl works with it.

Mike
