From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in archive files)
Date: Tue, 04 Sep 2007 17:19:03 -0700
Message-ID: <7v642qm0aw.fsf@gitster.siamese.dyndns.org>
References: <46DC4D45.4030208@lsrfire.ath.cx>
	<7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
	<46DDE6B3.8010507@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Sep 05 02:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISic0-0004RJ-DR
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 02:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbXIEATL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 20:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbXIEATL
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 20:19:11 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbXIEATK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 20:19:10 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A2F112E7A9;
	Tue,  4 Sep 2007 20:19:27 -0400 (EDT)
In-Reply-To: <46DDE6B3.8010507@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Wed, 05 Sep 2007 01:13:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57663>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Here's that ugly code, by the way.  It adds two placeholders, %d for
> description and %D for description depth.  Shortcomings of this code:
> it adds three members to struct commit, it unconditionally computes
> the description when format_commit_message() -- even if the format
> string doesn't contain %d and %D, the patch is not nicely split up.
> But it convinced me that describe *can* indeed be librarified. :-)

Yeah, unconditional computation for %d/%D is really a killer.
Otherwise the change itself does not necessarily look too ugly,
though.
