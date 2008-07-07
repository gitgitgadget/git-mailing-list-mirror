From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH v2] git daemon: avoid calling syslog() from a signal handler
Date: Mon, 7 Jul 2008 08:54:39 +0200
Message-ID: <20080707065439.GA25877@cuci.nl>
References: <200807031552.26615.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031531320.9925@racer> <alpine.DEB.1.00.0807031624020.9925@racer> <7vej68u6mr.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness> <7vabgwtf6m.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807060337480.3557@eeepc-johanness> <7vmykvo87w.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061414320.3486@wbgn129.biozentrum.uni-wuerzburg.de> <7vmykua2et.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Foster <brian.foster@innova-card.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:56:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFkdb-0007vl-CN
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 08:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbYGGGym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 02:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbYGGGym
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 02:54:42 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42843 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbYGGGyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 02:54:41 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 688155465; Mon,  7 Jul 2008 08:54:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmykua2et.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87588>

Junio C Hamano wrote:
>Another thing we might want to consider to make this logic much more
>simpler would be to move everything out of child_handler(), except the
>write() whose sole purpose is to allow us break out of the poll().

As a general rule, keep the work done in a signal handler down to the
bare minimum (like setting an integer flag, and perhaps unblocking the
main thread through a write to this signallingpipe).
-- 
Sincerely,
           Stephen R. van den Berg.

A truly wise man never plays leapfrog with a unicorn.
