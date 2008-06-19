From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 00:30:43 -0700
Message-ID: <7v7iclx4nw.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu>
 <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain>
 <20080618223821.GJ29404@genesis.frugalware.org>
 <20080619072308.GA12727@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 09:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ecf-0002wX-L4
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 09:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYFSHbD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 03:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbYFSHbB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 03:31:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYFSHbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 03:31:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 57A831869F;
	Thu, 19 Jun 2008 03:30:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 091CA1869E; Thu, 19 Jun 2008 03:30:51 -0400 (EDT)
In-Reply-To: <20080619072308.GA12727@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Thu, 19 Jun 2008 09:23:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A993B04C-3DD1-11DD-9A98-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85454>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> So how many parents can a commit have, exactly? Is there a hard limit
> somewhere, or just a point beyond which some git tools will start
> behaving strangely?

There is no hard limit at the data structure level.

git-commit-tree has a hard limit of accepting 16 parents.  git-blame ha=
s
the same 16-parent limit while following the history (but the one in
'next' has lifted the latter limitation).

But that is purely academic.  Anybody who does an octopus with more tha=
n 8
legs should get his head examined ;-).
