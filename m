From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 12:59:20 -0800
Message-ID: <7vzlv2c0k7.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
	<7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>
	<8c5c35580801180253x9022e62qf1ec515e101fb294@mail.gmail.com>
	<7vzlv3e6fy.fsf@gitster.siamese.dyndns.org>
	<8c5c35580801180354w74774fe2u1d96a8d12f513811@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFyJl-0003Qy-Mu
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 22:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759375AbYARU7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 15:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760176AbYARU7c
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 15:59:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758987AbYARU7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 15:59:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CD02B7FE0;
	Fri, 18 Jan 2008 15:59:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 451857FBF;
	Fri, 18 Jan 2008 15:59:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71064>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On Jan 18, 2008 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Lars Hjemli" <hjemli@gmail.com> writes:
>>
>> > Hmm, isn't a nonfunctional libgit considered breakage? Without
>> > something like this patch it is no longer possible to use
>> > write_tar_archive()/write_zip_archive() in libgit.a.
>>
>> Sorry, but libgit.a is not part of what we deliver.  We do not
>> support linking random stuff against libgit.a.  We never did.
>> It is not a "library".
>
> I kind of expected this reply, and I know libgit isn't supposed to be
> a stable API aginst git internals, but it still feels like a
> regression: cgit has been linking against libgit for over a year now
> (initial snapshot support added feb 8, 2007), and git-1.5.4 looks like
> the first git release which cgit cannot use.

If you expected it, you should have added the above four and
half lines in the initial message.  cgit is something even I
have heard of, and breakage of it because of what we have is
worth taking into consideration.  It would have been nicer if
this came before -rc0.

>> The code movement you did _should_ not hurt so it may be a fine
>> material for post 1.5.4, but I haven't carefully compared what
>> other change might have accidentally snuck in that patch, and I
>> would rather not have to during the rc cycle.
>
> Ok, I can't argue with that.

Instead of wasting more time in the exchange in this thread, I
spent a several uninterrupted minutes' attention to read over
your patch to make sure there is no accidental slippage (with
help from Dscho as well).  I'll make an exception and will
apply.

Thanks for the patch.
