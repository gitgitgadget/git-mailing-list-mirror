From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 06 Feb 2009 23:48:08 -0800
Message-ID: <7vd4duzo07.fsf@gitster.siamese.dyndns.org>
References: <200902022204.46651.toralf.foerster@gmx.de>
 <200902061126.18418.jnareb@gmail.com>
 <b77c1dce0902060231u358587d5o940eb322fde52a68@mail.gmail.com>
 <200902061149.16210.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?utf-8?Q?F?= =?utf-8?Q?=C3=B6rster?= 
	<toralf.foerster@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhwh-00070r-Cl
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZBGHsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZBGHsU
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:48:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZBGHsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:48:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE60997246;
	Sat,  7 Feb 2009 02:48:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D985997245; Sat,
  7 Feb 2009 02:48:11 -0500 (EST)
In-Reply-To: <200902061149.16210.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 6 Feb 2009 11:49:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF66A1B0-F4EB-11DD-9AFB-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108824>

Jakub Narebski <jnareb@gmail.com> writes:

> Make SHA-1 regexp to be turned into hyperlink (SHA-1 committag)
> to match word boundary at beginning and end.  This way we limit
> false matches, for example 0x74a5cd01 which is hex decimal (for
> example memory address) but not SHA-1.
>
> Also make sure that it is not Message-ID, which fragment just
> looks like SHA-1 (e.g. "Message-ID: <46A0F335@example.com>"),
> by using zero-width negative look-ahead assertion to _not_
> match '@' after.

Your message I am responding to is:

    Message-ID: <200902061149.16210.jnareb@gmail.com>

Does your description mean that "200902061149" would match, because the
LAA will say "Ah, dot is not an at-sign"?
