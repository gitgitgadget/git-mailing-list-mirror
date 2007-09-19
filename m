From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 01:31:34 -0700
Message-ID: <7vwsunoy3d.fsf@gitster.siamese.dyndns.org>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224122.2B55D344AB3@madism.org> <46F0C3AB.8010801@op5.se>
	<20070919080030.GA28205@artemis.corp> <46F0D8E2.5090706@op5.se>
	<20070919082111.GB28205@artemis.corp>
	<86r6kv2h64.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuyR-0004Bf-Qf
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbXISIbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbXISIbk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:31:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbXISIbj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:31:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 46FF4135E2D;
	Wed, 19 Sep 2007 04:31:58 -0400 (EDT)
In-Reply-To: <86r6kv2h64.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Wed, 19 Sep 2007 10:28:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58697>

David Kastrup <dak@gnu.org> writes:

> Pierre Habouzit <madcoder@debian.org> writes:
>
>> On Wed, Sep 19, 2007 at 08:08:02AM +0000, Andreas Ericsson wrote:
>>> Then perhaps a separate patch for this would have been prudent? I'm not
>>> against the change per se and I understand the reasoning behind it, but
>>> it seems to go against Documentation/SubmittingPatches (submit one change
>>> at a time).
>>
>>   Yes, the thing is, I wrote it in one piece, and had a _very_ hard time
>> splitting it. The aggregated patches had almost no chunks, and editing
>> diffs by hand isn't what I like to do :)
>
> Use Emacs for it.  After loading the patch in a file, type
>
> Esc x diff-mode RET
>
> If you now move to a place in the middle of a hunk and type C-c C-s,
> the hunk is split at that point into two hunks.  C-c C-k kills the
> current hunk.  C-x C-s saves the file, C-x C-c exits Emacs.
>
> In that manner throwing selected material out of a patch is rather
> straightforward, even when it is in the middle of a hunk.

Be careful when you edit format-patch output.  It seems that
diff-mode tends to mistake the trailing "signature separator" at
the end as if it is a removal of a line from the preimage, and
editing the last hunk ends up miscalculating the number of lines
in it.  It might have been fixed in the latest version but I was
burned by it number of times.
