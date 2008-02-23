From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 14:35:33 -0800
Message-ID: <7v4pbz1etm.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <20080221000044.GB6429@coredump.intra.peff.net>
 <200802232113.40100.johannes.sixt@telecom.at>
 <20080223204005.GA12502@coredump.intra.peff.net>
 <7v1w732y97.fsf@gitster.siamese.dyndns.org>
 <20080223211219.GA13178@coredump.intra.peff.net>
 <20080223222837.GA13628@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT2yh-0006lu-0y
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbYBWWfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbYBWWfo
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:35:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbYBWWfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:35:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 27BCF1A1E;
	Sat, 23 Feb 2008 17:35:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2EBE31A1D; Sat, 23 Feb 2008 17:35:36 -0500 (EST)
In-Reply-To: <20080223222837.GA13628@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 23 Feb 2008 17:28:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74867>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 23, 2008 at 04:12:19PM -0500, Jeff King wrote:
>
>> > shell there.  If you used $SHELL not $SHELL_PATH and wrote to
>> > fake-editor.sh, you would have noticed that using $SHELL there
>> > was wrong as it would have said "#!bash" for you ;-)
>> 
>> Actually, my $SHELL is "/usr/local/bin/bash" on the box in question.
>
> Hmm. Actually, we just set SHELL_PATH to SHELL in the Makefile. So I
> really don't see the point of SHELL_PATH at all, unless there are some
> setups where it is already set outside of git.

Well, on one of my machines, I seem to be getting SHELL=bash
(not /bin/bash).

Honestly, I do not think it matters getting the value from
Makefile for this particular case, but I'd rather get people
into habits to run "make tXXXX-name", not "sh ./tXXXX-name.sh",
unless they know what they are doing.
