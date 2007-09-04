From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 10:25:16 -0700
Message-ID: <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	<9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISc9V-0008K7-7P
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbXIDRZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbXIDRZV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:25:21 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbXIDRZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:25:20 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A34D212E663;
	Tue,  4 Sep 2007 13:25:39 -0400 (EDT)
In-Reply-To: <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	(Jon Smirl's message of "Tue, 4 Sep 2007 12:28:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57621>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Another way of looking at the problem,
>
> Let's build a full-text index for git. You put a string into the index
> and it returns the SHAs of all the file nodes that contain the string.
> How do I recover the path names of these SHAs?

That question does not make much sense without specifying "which
commit's path you are talking about".

If you want to encode such "contextual information" in addition
to "contents", you could do so, but you essentially need to
record commit + pathname + mode bits + contents as "blob" and
hash that to come up with a name.
