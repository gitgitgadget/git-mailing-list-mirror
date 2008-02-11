From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [DOC BUG] branch.autosetupmerge defaults to true, not false
Date: Mon, 11 Feb 2008 01:13:47 -0800
Message-ID: <7vejbjam9g.fsf@gitster.siamese.dyndns.org>
References: <87bq6nc22l.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUk9-0003aE-NP
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbYBKJNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 04:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbYBKJNy
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:13:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYBKJNx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 04:13:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0984AD2;
	Mon, 11 Feb 2008 04:13:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B2BA4AD1;
	Mon, 11 Feb 2008 04:13:48 -0500 (EST)
In-Reply-To: <87bq6nc22l.fsf@Astalo.kon.iki.fi> (Kalle Olavi Niemitalo's
	message of "Mon, 11 Feb 2008 10:46:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73489>

Kalle Olavi Niemitalo <kon@iki.fi> writes:

> In Git v1.5.4.1, Documentation/config.txt describes:
>
>> branch.autosetupmerge::
>>         Tells `git-branch` and `git-checkout` to setup new branches
>>         so that linkgit:git-pull[1] will appropriately merge from that
>>         remote branch.  Note that even if this option is not set,
>>         this behavior can be chosen per-branch using the `--track`
>>         and `--no-track` options.  This option defaults to false.
>
> However, in builtin-branch.c:
>
>> static int branch_track = 1;
> ...
>>         if (!strcmp(var, "branch.autosetupmerge"))
>>                         branch_track = git_config_bool(var, value);
>
> So if the option is not listed in .git/config, then it actually
> defaults to true.  A demonstration with a bit older version:

Correct.  34a3e69 (git-branch: default to --track) did it
without updating the documentation.
