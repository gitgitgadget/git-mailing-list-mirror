From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: allow disabling expensive broken symlink checks
Date: Mon, 02 Feb 2009 22:52:22 -0800
Message-ID: <7v4ozcdnbt.fsf@gitster.siamese.dyndns.org>
References: <200901311414.58205.markus.heidelberg@web.de>
 <20090201021844.GB18855@dcvr.yhbt.net>
 <7vbptlo7zg.fsf@gitster.siamese.dyndns.org>
 <20090203044549.GA2483@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 07:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUFAR-0007Wr-T8
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 07:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZBCGwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 01:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZBCGw3
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 01:52:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbZBCGw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 01:52:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 837492A533;
	Tue,  3 Feb 2009 01:52:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AAFB72A543; Tue, 
 3 Feb 2009 01:52:24 -0500 (EST)
In-Reply-To: <20090203044549.GA2483@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 2 Feb 2009 20:45:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38D0AB06-F1BF-11DD-BDCD-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108156>

Eric Wong <normalperson@yhbt.net> writes:

>> How common is this breakage in people's subversion repositories that
>> dbc6c74d (git-svn: handle empty files marked as symlinks in SVN,
>> 2009-01-11) works around?
>
> It's not common at all.  Some broken Windows clients were able to
> create it.
>
>> What's the way to recover from a broken import, when the subversion
>> repository does have such a breakage, and the user used git-svn that
>> predates dbc6c74?  Is it very involved, and it is much better to have the
>> safety by default than to force everybody else who interacts with
>> non-broken subversion repository suffer from this performance penalty?
>
> Previously, git-svn would just stop importing and refuse to continue.
> So allowing the user to enable it would be a problem; too.  I don't
> recall the error being easy to distinguish from other errors.
>
>> Because the fix (that is broken from the performance angle) is relatively
>> recent, I am wondering if it makes more sense to turn it off by default,
>> and allow people with such a broken history to optionally turn it on.
>
> I'm considering disabling it by default, too.

I leave it entirely up to you to choose whichever default you find
sensible (I do not think I have to say this).  I wasn't complaining your
original choice to stay on the safer side, with an option to trigger a
faster but potentially riskier behaviour.

I was curious how black-and-white the deciding factor for a sensible
default would be for this particular case.
