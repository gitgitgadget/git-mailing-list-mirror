From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 09 Sep 2008 18:59:00 -0700
Message-ID: <7vej3s223f.fsf@gitster.siamese.dyndns.org>
References: <20080909132212.GA25476@cuci.nl>
 <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl>
 <20080909195930.GA2785@coredump.intra.peff.net>
 <7vljy159v7.fsf@gitster.siamese.dyndns.org> <20080910001316.GF7459@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 04:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdF0F-0001Kf-Jh
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 04:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYIJB7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 21:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbYIJB7K
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 21:59:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYIJB7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 21:59:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D90975A379;
	Tue,  9 Sep 2008 21:59:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1510B5A376; Tue,  9 Sep 2008 21:59:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0DAE2512-7EDC-11DD-B85E-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95474>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Junio C Hamano wrote:
>>As for "by the way ... was used to make this commit": this is git.  So how
>>you arrived at the tree state you record in a commit *does not matter*.
>
> The typical use case for the origin links is in a project with several
> long-lived branches which use cherry-picks to backport amongst them.
> There is no real other way to solve this case, except for some rather
> kludgy stuff in the free-form commit message which doesn't mesh well
> with rebase/filter-branch/stgit etc.
>
> As to "does not matter": then why does git store parent links?

The parent links describe *where* you came from, not *how*.

And if you think the difference is just "semantics", then you haven't
grokked the first lesson I gave in this thread.  "parents" record the
reference points against which you make "this resulting commit suits the
purpose of my branch better than any histories leading to these commits".
