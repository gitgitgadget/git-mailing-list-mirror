From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc4
Date: Mon, 21 Jan 2008 03:33:37 -0800
Message-ID: <7vy7ajxvji.fsf@gitster.siamese.dyndns.org>
References: <1JGuDL-2AugiG0@fwd26.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGuus-0007T5-Oz
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684AbYAULdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 06:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758735AbYAULdo
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:33:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482AbYAULdn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 06:33:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 80A34432E;
	Mon, 21 Jan 2008 06:33:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1196D432D;
	Mon, 21 Jan 2008 06:33:38 -0500 (EST)
In-Reply-To: <1JGuDL-2AugiG0@fwd26.aul.t-online.de>
	(MichaelTiloDressel@t-online.de's message of "Mon, 21 Jan 2008
	11:49:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71266>

"MichaelTiloDressel@t-online.de"
<MichaelTiloDressel@t-online.de> writes:

> Concerning RPM specs.
>
> I created rpm packages on a x86_64 SuSE 10.3 system.
>
> There were two complains about unmatched dependencies for expat-devel
> and perl(Error)
> I could not get rid off.

Thanks.

perl-error and expat-devel are both packaged outside git.
Aren't they listed in dependencies?  At least I think
expat-devel is on the build dependency.

Our Makefile tries to install our own copy of perl::Error if the
build platform does not have one, which we do not want to do
when building a binary package.  Perhaps perl-error needs to be
on the build dependency to deal with this issue?  I dunno, as I
am not an RPM person.
