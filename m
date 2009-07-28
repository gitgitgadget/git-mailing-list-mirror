From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2009, #02; Sun, 26)
Date: Tue, 28 Jul 2009 01:01:35 -0700
Message-ID: <7v3a8h8cdc.fsf@alter.siamese.dyndns.org>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
 <4A6EA86A.5010705@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:02:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVhe5-0003wv-9g
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbZG1IBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbZG1IBl
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:01:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbZG1IBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:01:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F70E14280;
	Tue, 28 Jul 2009 04:01:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 18ED11427B; Tue, 28 Jul 2009
 04:01:36 -0400 (EDT)
In-Reply-To: <4A6EA86A.5010705@gnu.org> (Paolo Bonzini's message of "Tue\, 28
 Jul 2009 09\:27\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1A2EB9C-7B4C-11DE-821D-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124219>

Paolo Bonzini <bonzini@gnu.org> writes:

> Is your workflow to merge next to master after the release, or do you
> cherry-pick the merges?

Usually 'next' will never rewind, and topics graduate by merging into
'master', either as a whole or in steps.

But I've kept 'next' and 'pu' deliberately more inclusive during this -rc
period, knowing that people by now would be very well aware that after the
final release of 1.6.4, 'next' will be discarded and rebuilt with a few
selected topics.  That means what currently is in 'next' can be safely
kicked back to 'pu' or discarded if it turns out to be necessary.

If you have doubts or regrets in the series currently in 'next', you can
even send in replacements if you want to (which is not how 'next' works
normally). I can revert the merge of the original series to 'next' and
merge the replacements during -rc period.  After 1.6.4, I can discard the
original series and keep only the updated series.

On the other hand, if you want to keep going incremental, which is how
'next' is supposed to work, that is perfectly Ok, too.  After 1.6.4, we
can decide what to do.

> Do you plan to merge at least the first two patches of "git push
> --current" (i.e. without the config option)?

I am not quite sure if that is a good approach.  If the design is in flux,
perhaps we should cook the code in 'pu' a bit longer until we know what
end user interface want?  The last thing I want to do is to give end users
a set of new command line options in 'master' (or even 'next'), only to
revoke them before the next release.
