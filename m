From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 21:59:57 +0200
Organization: <)><
Message-ID: <20140423195957.GA3187@camelia.ucw.cz>
References: <20140416141519.GA9684@camelia.ucw.cz> <20140416154653.GB4691@sigill.intra.peff.net> <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info> <20140417213238.GA14792@sigill.intra.peff.net> <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info> <20140417215817.GA822@sigill.intra.peff.net> <20140423075325.GA7268@camelia.ucw.cz> <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:00:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3Kx-0004Mh-P5
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924AbaDWUAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:00:00 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59404 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbaDWT77 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:59:59 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 3DAF81C00DB;
	Wed, 23 Apr 2014 21:59:58 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3NJxvFk003261;
	Wed, 23 Apr 2014 21:59:57 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3NJxvLX003260;
	Wed, 23 Apr 2014 21:59:57 +0200
Content-Disposition: inline
In-Reply-To: <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246880>

Hi,

On Wed, Apr 23, 2014 at 12:12:14PM -0700, Junio C Hamano wrote:
> [Administrivia: please refrain from using Mail-Followup-To to
> deflect an attempt to directly respond to you;

thanks a lot for telling me.
Actually, this was a mistake: I added git to the list of discussion
lists, without realizing the consequences.
I'm glad to have separate copies of "my threads" that do not fall
to the git-list folder.

> > +>expect
> Move this inside test_expect_success?

Of course.  Had this in mind, then forgot.

> So this runs a separate "bash", [...]
> run "git tag" in the original shell?
> 
> Ahh, no, I am mis-pairing the quotes.

Point taken.  I admire how nicely you explained that!

> 	run_with_limited_stack () {
> 		"$SHELL_PATH" -c "ulimit -s 64 && $*"
> 	}

Elegant. But I agree with Peff that we shall run "a bash" instead.

I'll mail an updated patch tomorrow.

Stepan
