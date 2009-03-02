From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Mon, 02 Mar 2009 01:01:03 -0800
Message-ID: <7v7i385meo.fsf@gitster.siamese.dyndns.org>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
 <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
 <76718490903010949h7b64eb97ob567101fbc7e4cd1@mail.gmail.com>
 <20090302172401.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:02:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le42t-0000ep-9O
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 10:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbZCBJBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 04:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbZCBJBQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 04:01:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756342AbZCBJBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 04:01:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 448A29E522;
	Mon,  2 Mar 2009 04:01:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 98B2F9E51A; Mon,
  2 Mar 2009 04:01:05 -0500 (EST)
In-Reply-To: <20090302172401.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon, 02 Mar 2009 17:24:01 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ADABF35A-0708-11DE-B555-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111920>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> The escape hatch was there from the beginning, is still there, and it
> will remain there. I should also add that it was Junio's veto of
> Linus'es proposal to stop installing git-foo commands for builtins
> that enabled this escape hatch.

I think veto is too strong a word to describe what really happened, but in
retrospect, if we went ahead and removed built-ins from the filesystem as
Linus and other people advocated, the escape hatch wouldn't have worked at
all, so in that sense you are correct.  But I do not think I deserve the
credit for that---I do not see myself making an argument based on that
"possible escape-hatch" value in that old thread.

By the way, how are you researching these old discussions?  Do you have
a huge list of bookmarks?

> By the way, I don't think the lesson you should take home is the need
> for an escape hatch. Read the message by Junio on August 24th,
> 2008. Being nice and not too loud during the deprecation period kept
> users complacent about upcoming changes and upset them when the change
> finally came. Being un-nice and too loud during the deprecation period
> would have upset them early instead. You cannot avoid upsetting users
> either way whenever you change the behavior.

Yup.

And the most scary part of all is that you cannot try both.  We now know
that for 1.6.0 transition people _claimed_ that they would have liked
louder deprecation period than the way 1.6.0 transition was handled, but
that is not (and cannot be) backed by real world experience. Nobody tried
versions of git that warned loudly about the upcoming change every time he
typed "git-commit" to see if the louder deprecation period was really
preferrable.

We are taking that route for 1.7.0 to warn very loudly about pushing into
the currently checked-out branch in 1.6.2 and onwards.  We may now find
out that people hate a loud deprecation period.  Then what?
