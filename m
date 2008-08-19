From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add hints to revert documentation about other ways to
 undo changes
Date: Tue, 19 Aug 2008 11:56:58 -0700
Message-ID: <7vk5ec7s05.fsf@gitster.siamese.dyndns.org>
References: <1219165591-19969-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	=?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, Lea Wiemann <lewiemann@gmail.com>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWPG-00086P-FX
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbYHSS5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbYHSS5L
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:57:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbYHSS5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:57:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B3B251AB5;
	Tue, 19 Aug 2008 14:57:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6AC4E51AB4; Tue, 19 Aug 2008 14:57:01 -0400 (EDT)
In-Reply-To: <1219165591-19969-1-git-send-email-tarmigan+git@gmail.com>
 (Tarmigan Casebolt's message of "Tue, 19 Aug 2008 10:06:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9ED2DED8-6E20-11DD-B034-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92901>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> I put this in a Note: in the DESCRIPTION section.  If there is
> consensus about moving it somewhere else, I can send another patch.

I think a note in the description would be fine.

> +Note: Despite its name, 'git revert' may not undo changes in the way
> +that you expect.  If you want to throw away all uncommitted changes in
> +your working directory, you should see linkgit:git-reset[1],
> +particulary the '--hard' option.  If you want to extract specific
> +files as they were in another commit, you should see
> +linkgit:git-checkout[1], specifically the 'git checkout <commit> --
> +<filename>' syntax.  Take care with these alternatives as both will
> +discard uncommitted changes in your working directory.
> +

The last sentence makes the paragraph incoherent, doesn't it?

By starting this paragraph with "Despite its name", you are stating your
expectation that the people who find "git revert" nonintuitive are the
majority.  And you explain how to perform the operation that majority
would expect, which is to throw away uncommitted changes to go back to the
clean slate.  If that is what the target audience of this paragraph
expects to happen anyway, why do you need to caution against it in the
last sentence?

If the answer is "because it is not cut-and-dried which expectation is the
majority, and we try to be careful not to lose local modifications of
users", then the tone of the paragraph needs to become more neutral.

I'd suggest either dropping the first sentence altogether and starting the
paragraph with "If you want to throw away...", or replacing the first
sentence with "'git revert' is used to record a new commit to reverse the
effect of an earlier commit (often a faulty one)."
