From: Junio C Hamano <gitster@pobox.com>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 14:28:45 -0700
Message-ID: <7vbqc25mgi.fsf@gitster.siamese.dyndns.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	<7vwsur590q.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161054380.5298@iabervon.org>
	<Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Sep 16 23:29:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX1fs-0002go-LD
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 23:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbXIPV27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 17:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbXIPV27
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 17:28:59 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbXIPV26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 17:28:58 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AA3BD134148;
	Sun, 16 Sep 2007 17:29:09 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
	(david@lang.hm's message of "Sun, 16 Sep 2007 14:12:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58348>

david@lang.hm writes:

> my initial thoughts were to have git do all it's normal work and hook
> into git at the point where it's writing the file out (where today it
> chooses between writing the data to a file on disk, pipeing to stdout,
> or pipeing to a pager) by adding the option to pipe into a different
> program that would deal with the permission stuff. this program would
> only have to write the file and set the permissions, it wouldn't have
> to know anything about git other then where to find the permissions it
> needs to know.
>
> it sounds like you are suggesting that the hook be much earlier in the
> process,...

Well, you misread me or what I said was confusing or both.  I
was suggesting totally opposite.  Let git do all its normal
work, and then call your hook to munge the work tree in any way
you want.
