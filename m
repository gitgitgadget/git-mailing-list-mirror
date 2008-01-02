From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplication in t9119-git-svn-info.sh
Date: Tue, 01 Jan 2008 21:57:09 -0800
Message-ID: <7vabno3h3e.fsf@gitster.siamese.dyndns.org>
References: <7vodc65whw.fsf@gitster.siamese.dyndns.org>
	<1199143999-6859-1-git-send-email-ddkilzer@kilzer.net>
	<20080102034317.GB11711@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 06:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9wbs-0004eB-3B
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 06:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbYABF5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 00:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbYABF5U
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 00:57:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbYABF5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 00:57:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 72B4DA374;
	Wed,  2 Jan 2008 00:57:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E5F04A216;
	Wed,  2 Jan 2008 00:57:11 -0500 (EST)
In-Reply-To: <20080102034317.GB11711@untitled> (Eric Wong's message of "Tue, 1
	Jan 2008 19:43:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69457>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "David D. Kilzer" <ddkilzer@kilzer.net> writes:
>> 
>> > @@ -350,8 +355,8 @@ test_expect_success 'info unknown-symlink-directory' "
>> >  	cd svnwc &&
>> >  		ln -s unknown-directory unknown-symlink-directory &&
>> >  	cd .. &&
>> > -	ptouch gitwc/unknown-symlink-directory \
>> > -	       svnwc/unknown-symlink-directory &&
>> > +	ptouch svnwc/unknown-symlink-directory \
>> > +	       gitwc/unknown-symlink-directory &&
>> 
>> Hmph.  Am I the only one who finds this repetition somewhat
>> disturbing?
>
> "David D. Kilzer" <ddkilzer@kilzer.net> wrote:
>> Simplify arguments to ptouch bash function.
>
> Not reading Junio's mind, I think he meant that you were swapping the
> "gitwc/" and "svnwc/" args everywhere in your changeset.

Yeah, that was what I meant.  ptouch routine's implementation
could have swapped the order of arguments internally.

The follow-up patch by David makes ptouch routine unusable if
the test suite becomes more elaborate and starts using more than
one git and svn work trees, but I do not think that is something
we have to worry about too much.
