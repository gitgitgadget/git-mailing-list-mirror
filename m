From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Thu, 12 Jul 2012 09:58:37 -0700
Message-ID: <7v394wdigy.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino> <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
 <20120710201105.GH8439@burratino> <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
 <20120710210901.GI8439@burratino> <7vehojgqgk.fsf@alter.siamese.dyndns.org>
 <20120710234717.GA21467@burratino> <7vzk77f602.fsf@alter.siamese.dyndns.org>
 <874npds75j.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:58:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpMj5-0008LP-JL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 18:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab2GLQ6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 12:58:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161360Ab2GLQ6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 12:58:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91F107915;
	Thu, 12 Jul 2012 12:58:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mp6ebYRa+WDCksiDSp0mtJDMTnc=; b=DT14I3
	AoX9BjqUG6A143eh7QDjBwX/RBoEPEDmkvOS9tTvfbFCZnsj74zpJGFVK9NXn/bY
	pKe31Du88M3nj7/enP0o05bvRZXHa37yx1GmQOPXrs1u6edPIAycGK3sXBWJiIMI
	MwLhpGMEhab5fISwv+hrSKhVvQpp/ONq+OCXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MuQMfpwJ9f9gkVTLCMy9DPmm/TnVqxwu
	PkPdkaTXZoORm3ax6ztBkR7dDVbhoh3vOMfgcJ+345hMk0e2TQcuohidoUIXZRBz
	g4DvYjPBuZb4Mu+rUZYHQ1+I1N+J5wNHEmHBbMuSftyybRyu+NwY9fqDum+nOhAa
	Se8q3syqBlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8813E7914;
	Thu, 12 Jul 2012 12:58:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB5847911; Thu, 12 Jul 2012
 12:58:38 -0400 (EDT)
In-Reply-To: <874npds75j.fsf@catnip.gol.com> (Miles Bader's message of "Thu,
 12 Jul 2012 17:41:44 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3B903DC-CC42-11E1-BF53-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201364>

Miles Bader <miles@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> is easier to understand, while I think
>>
>> 	git branch <branch> [<start>]
>>         git branch --set-upstream-to=<upstream> [<branch>]
>
> Isn't one problem with this that even if a "--set-upstream-to" option
> exists, inevitably some [and I'm guessing, many] people will not be
> aware of it (after all, nobody reads documentation more than they have
> to), and will attempt to use "--set-upstream" with an argument
> (that's the natural thing to do, after all) -- which may succeed with
> weird results ...?

In the part you quoted in the message you are responding to in the
subthread between Jonathan and, I was expressing doubts about his
"upon seeing a single argument for operations that need two pieces
of info, sometimes the first one is assumed to be missing and gets
the default, some other times the second one is assumed to be
missing and gets the default" design, which I felt would be
unnecessarily confusing.

The issue of possible confusion you raised is real, was discussed in
the main thread of discussion of the earlier round, and has been
addressed in this round of the patch series, I think, with warnings
and/or advises.
