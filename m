From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Tue, 29 Apr 2008 19:58:28 +0200
Message-ID: <20080429175828.GA32301@cuci.nl>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org> <4816BD77.1060709@op5.se> <alpine.DEB.1.00.0804291153230.27457@eeepc-johanness> <4816FFEB.8050308@op5.se> <alpine.DEB.1.00.0804291615000.27457@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:59:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqu6p-0007hy-Js
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 19:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYD2R6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 13:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbYD2R6a
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 13:58:30 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:50437 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYD2R6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 13:58:30 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id AB9D5545E; Tue, 29 Apr 2008 19:58:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804291615000.27457@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80712>

Johannes Schindelin wrote:
>On Tue, 29 Apr 2008, Andreas Ericsson wrote:
>> What syslogd are you using? Perhaps it insists on re-creating the 
>> socket. That might cause the behaviour you're seeing, but then you 
>> should probably see it in a ton of other daemons as well.

Recreating the socket should not cause this to happen either, because
the git-daemon will still hold on to the old inode (even after the file
has been removed).

>This is sysklogd from Ubuntu, compiled for amd64.  The timestamp on 
>/dev/log is older than a month.

I'd still recommend trying to reproduce the problem, then find out which
filedescriptor/file the close is hanging on.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
