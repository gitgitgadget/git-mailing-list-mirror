From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative submodule URLs vs. clone URL DWIMming
Date: Sat, 30 Aug 2008 15:27:01 -0700
Message-ID: <7vhc92f8ay.fsf@gitster.siamese.dyndns.org>
References: <200808271400.54302.johan@herland.net>
 <48B6BB49.3000703@gmail.com> <200808290101.20048.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 00:28:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZYvX-0006dV-U8
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 00:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbYH3W1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 18:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbYH3W1J
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 18:27:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYH3W1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 18:27:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A63759176;
	Sat, 30 Aug 2008 18:27:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8864759173; Sat, 30 Aug 2008 18:27:03 -0400 (EDT)
In-Reply-To: <200808290101.20048.johan@herland.net> (Johan Herland's message
 of "Fri, 29 Aug 2008 01:01:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C7829E66-76E2-11DD-8548-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94441>

Johan Herland <johan@herland.net> writes:

> ... But AFAICS, there's no way to get this information from the
> transport layer. I assume that the actual repo location is resolved on the
> remote side, and simply not communicated back to the local side.

Correct.

> If we simply resolve submodule URLs against the _repo_ (i.e. the real origin
> URL) and not the work tree (if any), we get results that are coupled to
> whether we use bare or non-bare repos: Take, for example, your use
> of "../<path>" to make submodules live outside the (bare) superproject. If I
> now create a non-bare clone of this, I must move the submodule repos _into_
> my work tree, so that the submodule repos are available, if someone tries to
> clone from me.

I personally feel that cases that involve cloning from non-bare
repositories (and in addition, DWIMmed repositories), with or without
nested submodules, are not worth supporting.
