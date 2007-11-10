From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: *[PATCH] builtin-commit: Refresh cache after adding files.
Date: Sat, 10 Nov 2007 02:02:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711100201310.4362@racer.site>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
 <Pine.LNX.4.64.0711091702190.4362@racer.site> <7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
 <7v640ari76.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 03:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqfgX-0008EY-11
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 03:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXKJCCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 21:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbXKJCCl
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 21:02:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:54491 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751659AbXKJCCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 21:02:41 -0500
Received: (qmail invoked by alias); 10 Nov 2007 02:02:39 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 10 Nov 2007 03:02:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2ezMpap3249Dud/1o+RrZTVB4PzGUMRtXm2nI2X
	KmySEnHFhVgPjV
X-X-Sender: gene099@racer.site
In-Reply-To: <7v640ari76.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64298>

Hi,

On Fri, 9 Nov 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > This discussion exposes a problem with add_files_to_cache()
> > function.
> > ...
> > And add_file_to_cache(), which calls add_file_to_index() on
> > the_index, does call the fill_stat_cache_info() to sync the stat
> > information by itself, as it should be.  I am still puzzled with
> > this.
> 
> Blech.  I think it is 0781b8a9b2fe760fc4ed519a3a26e4b9bd6ccffe 
> (add_file_to_index: skip rehashing if the cached stat already matches) 
> that broke "git add".  I get the same problem not just with "git add -u" 
> but also with an explicit "git add Makefile".

But I think that we still need to refresh the index.  It outputs which 
files names were new, and which ones were removed.  Otherwise git commit 
would be eerily silent on those.

Ciao,
Dscho
