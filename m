From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Mon, 01 Oct 2007 15:28:05 -0700
Message-ID: <7vir5qqxl6.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	<11912513203420-git-send-email-tom@u2i.com>
	<7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
	<550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: "Tom Clarke" <tom@u2i.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcTkU-0008Ko-CH
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbXJAW2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 18:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbXJAW2O
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 18:28:14 -0400
Received: from rune.pobox.com ([208.210.124.79]:60015 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbXJAW2N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 18:28:13 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8393713FB8C;
	Mon,  1 Oct 2007 18:28:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AB64913FCBB;
	Mon,  1 Oct 2007 18:28:28 -0400 (EDT)
In-Reply-To: <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com> (Tom
	Clarke's message of "Mon, 1 Oct 2007 23:41:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59640>

"Tom Clarke" <tom@u2i.com> writes:

> I'm happy to try to address the issues you raised, but I wonder if we
> would do better to look back at my original proposal which was to add
> a --rebase option to git-pull. git-pull is the main place there I see
> need for using a rebase instead of a merge, as anywhere where you
> might use git-merge directly, if what you really want is a rebase, you
> can just run git-rebase.

Yeah, we have taught "git-pull == git-fetch + git-merge" to our
users, and "-s strategy" has been a way to specify _how_ the
merge is done, and not about doing something that is not a
merge.

As you say, rebase is not doing a merge.  But neither is "squash".

"git-pull --rebase == git-fetch + git-rebase" might be simpler
for end users to understand.  I dunno.
