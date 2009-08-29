From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git segfaults
Date: Fri, 28 Aug 2009 17:53:07 -0700
Message-ID: <7v8wh35tl8.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302>
 <20090817135651.GA4570@harikalardiyari>
 <20090826202053.6e6442a6.rctay89@gmail.com>
 <20090826131235.GF16486@harikalardiyari>
 <be6fef0d0908281707o59fdb0c9h9a5a78864b6ad063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ali Polatel <polatel@gmail.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 02:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhCFb-0000U5-Oa
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 02:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbZH2AxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 20:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbZH2AxS
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 20:53:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZH2AxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 20:53:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BC851C92B;
	Fri, 28 Aug 2009 20:53:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ijwZM4PJqgtYj21YuBB8S7dCfyA=; b=okz9Ag
	CwBT2lmB+KE952idi7xt1pZF0HnEHeqHac69mYHeHTNwXr73FwfBovyQJYVwTZyF
	rtNswfO5rmv6UHhOq1t/BC5IW1sTwcrkrdQyVaBlqPJUL1W2x/HdMs+SRxKzqSPj
	fSi1wwf4TIU1RuismCebMGkCtafDv7xlakMpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bpyb+q+MHYxw2UBRBNIAnahItJLyNTUg
	54BdCEjBm/MXJ0mihE0mpOcGAE/stBrY//kVmN/bO6pPrvn1CwTYcuIZoErxV1ke
	jcxdMmPSQyl6L36IOCqBTjQyXUenutZUq+7nCji+uH+xElkeWVInrZG2vK8cTud+
	zuZvNPdLp5I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0391B1C927;
	Fri, 28 Aug 2009 20:53:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06DB51C924; Fri, 28 Aug
 2009 20:53:08 -0400 (EDT)
In-Reply-To: <be6fef0d0908281707o59fdb0c9h9a5a78864b6ad063@mail.gmail.com>
 (Tay Ray Chuan's message of "Sat\, 29 Aug 2009 08\:07\:56 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54D18482-9436-11DE-AEF0-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127368>

Tay Ray Chuan <rctay89@gmail.com> writes:

> 2009/8/26 Ali Polatel <polatel@gmail.com>:
>> It works, I don't get any segfaults after applying this patch.
>
> Junio, I hope you don't mind me asking but why hasn't this patch been
> accepted? It addresses a pretty severe problem, and the sooner users
> have it the better.

The procedure ideally goes like this:

    (0) original bug report is sent; Ali did this with:

        Date: Mon, 17 Aug 2009 16:56:52 +0300
        Message-ID: <20090817135651.GA4570@harikalardiyari>

    (1) a helpful contributor (or somebody ashamed of having introduced
        the bug ;-)) sends a potential fix as an RFT to the reporter, with
        Cc: to list.  You did this with:

        Date: Wed, 26 Aug 2009 20:20:53 +0800
        Message-ID: <20090826202053.6e6442a6.rctay89@gmail.com>

	This message was clear that it was a request-for-test of a
	potential fix, not a "I know this is the correct fix to the
	problem; the maintainer, please apply".  It wasn't even Cc:'ed to
	me, and not CC'ing me is the right thing to do for this kind of
	request-for-test patches.

    (2) success/failure report is given.  Ali did this with:

        Date: Wed, 26 Aug 2009 16:12:35 +0300
        Message-ID: <20090826131235.GF16486@harikalardiyari>

	to report a success.

    (3) Upon seeing (2), the sender of (1) submits the final patch for
        inclusion, with To: me and CC: list.

        The sender makes sure that it is easy for me and others who sees
        (3) first without necessarily having followed the earlier
        discussions to find the previous messages (i.e. 0, 1, 2).  In this
        case, sending a follow-up to (2) is sufficient, just like you did
        in the message I am responding to, because these three steps were
        neatly threaded already.

        If you knew the flow I am describing here, you would have sent
        "the final patch for inclusion" instead of the message I am
        replying to.  The final patch for inclusion would have consisted
        of:

	* The usual "applicable patch": a proper subject, the log message,
          your Signed-off-by:, and Tested-by: to credit Ali;

        * Optionally, after the three-dash line before the diffstat, any
          out-of-band communication, e.g.

          "Junio, please apply to 'maint'; this is a fix for a grave bug,
          and the problem goes all the way down to version 1.6.1."

        * And the diffstat and the diff.

My request for this procedure is not red tape.

While an issue (such as this http one) is resolved that is in an area
(e.g. http) people other than me (i.e. you) are much more familiar with, I
do not have to keep track of the discussion while more capable hands are
on top of it.  Having (3) as the concluding step will

 - give me a way to easily verify, if I wanted to, the claim that this is
   the right solution, by referring to the previous dialog; and

 - give you a way to make sure that what is recorded is the correct final
   solution (this is especially important if steps 1 and 2 have to be
   repeated before reaching the final solution), and that the necessary
   background information (e.g. credits to the original reporter) are
   given in your own words, instead of having _me_ come up with one with
   less-than-perfect understanding of the issues I would gain after
   skimming the archive for the previous discussion.

Nobody can expect me to keep track of everything; the final "Here is the
good one" would help the process flow smoothly and reduce the chance of
mistakes.

Thanks.
