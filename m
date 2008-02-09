From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a file
Date: Fri, 08 Feb 2008 21:12:49 -0800
Message-ID: <7vzluag1bi.fsf@gitster.siamese.dyndns.org>
References: <20080208174654.2e9e679c@pc09.procura.nl>
	<118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com>
	<7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
	<47ACC261.6060404@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNi1y-0000Xz-N7
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbYBIFNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 00:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbYBIFND
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:13:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341AbYBIFNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 00:13:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F9DA105F;
	Sat,  9 Feb 2008 00:13:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F45105C;
	Sat,  9 Feb 2008 00:12:54 -0500 (EST)
In-Reply-To: <47ACC261.6060404@nrlssc.navy.mil> (Brandon Casey's message of
	"Fri, 08 Feb 2008 14:58:09 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73190>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>
>> And have Makefile set FOPEN_OPENS_DIRECTORIES on appropriate
>> platforms.
>
> Which ones _don't_ open directories?

Ahh, sorry, of course you are right.  We need to fix the
callers.
