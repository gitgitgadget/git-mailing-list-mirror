From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Tue, 09 Sep 2008 20:53:08 -0700
Message-ID: <7vwshkzmfv.fsf@gitster.siamese.dyndns.org>
References: <1220889063-20387-1-git-send-email-marcus@griep.us>
 <1220892781-24343-1-git-send-email-marcus@griep.us>
 <20080909015338.GA15974@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 05:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdGmf-0005Gk-TG
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 05:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYIJDxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 23:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYIJDxT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 23:53:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbYIJDxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 23:53:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 267F87A95B;
	Tue,  9 Sep 2008 23:53:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C63697A958; Tue,  9 Sep 2008 23:53:10 -0400 (EDT)
In-Reply-To: <20080909015338.GA15974@yp-box.dyndns.org> (Eric Wong's message
 of "Mon, 8 Sep 2008 18:53:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 002F8420-7EEC-11DD-A524-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95477>

Eric Wong <normalperson@yhbt.net> writes:

> Marcus Griep <marcus@griep.us> wrote:
>> Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
>> interface introduced in 0.14, as pointed out by Tom G. Christensen.
>> 
>> This modifies Git.pm to use the more established tempfile() interface
>> and updates 'git svn' to match.
>> 
>> Signed-off-by: Marcus Griep <marcus@griep.us>
>> ---
>> 
>>  This patch v2 cleans up a few code items, corrects a misspelling,
>>  and ensures that the temp file gets unlinked when we exit, now
>>  that we are requesting the filename.  Otherwise, the previous
>>  comments stand:
>>  
>>  Per the earlier patch versions by Abhijit Menon-Sen and Tom G. Christensen.
>>  Both of you may want to run a test and add your 'Tested-by' to the thread
>>  if everything works out before Eric Wong adds his 'Acked-by'.
>
> Thanks Marcus, this works for me.
> (Perl 5.10.0, so no compatibility issues).
>
> <bikeshed>
> Can we rename temp_fname() to temp_path(), though?  "fname"
> just doesn't look right in the API to me...
> </bikeshed>

Ok, so will you take the patch with bikeshed fixes and feed the result to
me with a pull-request, or shall I do that myself?  I do not mind doing
this either way --- just trying to avoid duplicated work.

This is a 'maint' material, right?
