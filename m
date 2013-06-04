From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] add --authorship-order flag to git log / rev-list
Date: Tue, 04 Jun 2013 11:53:02 -0700
Message-ID: <7vmwr57lo1.fsf@alter.siamese.dyndns.org>
References: <1370369299-20744-1-git-send-email-me@ell.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: elliottcable <me@ell.io>
X-From: git-owner@vger.kernel.org Tue Jun 04 20:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjwM3-00024t-ED
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 20:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab3FDSxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 14:53:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab3FDSxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 14:53:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D511325164;
	Tue,  4 Jun 2013 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y1H9RwqdndIdIzZuSTevIv/Zb2Y=; b=Yd/cCK
	KihFc6M83wQsFfvKTwcAldyyflKI4pCc1Pn+p/JvRCXTAXSJYzKV6jiwhX7IvKSW
	inFtvx2/jG/wjWB1EvMLLLjkcBYwxhUh1G7ZC2P4KwS9aaBlqeePR9SFmjpqny2w
	DG4HvckKMgCd2G2xSFryF9A3zLW9gaE/2QVZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X84boF90l55h7f0GDsUsvOlo5vixG/n+
	AJTGn2xnRmDeSAnahKykCIM/H2aDT+b+SVkWP0YWizfhEcomk10DWyIi/6/Xy/Fj
	z9uuQeThHr1/qzpqoSdCximWyPWRUVHGnAI3T+QFRqPXcLB2BB6WPQ0jSASKt5zP
	zUKsL1vN3wQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9A7925162;
	Tue,  4 Jun 2013 18:53:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DFFE2515F;
	Tue,  4 Jun 2013 18:53:04 +0000 (UTC)
In-Reply-To: <1370369299-20744-1-git-send-email-me@ell.io> (elliottcable's
	message of "Tue, 4 Jun 2013 14:08:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCDD7B9C-CD47-11E2-B097-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226392>

elliottcable <me@ell.io> writes:

> This is my first time submitting a patch to this list, so please, let me know if
> I'm doing any of this the wrong way! I've striven to follow
> `Documentation/SubmittingPatches`. I hope I've succeeded. For that matter, it's
> my first time diving into git's sources, so I obviously would love some
> commentary on the patch itself, as well. ;)
>
> I've tried herein to add an `--authorship-order` flag to complement git-log's
> `--topo-order` and `--date-order` flags; it should operate the same as
> `--date-order`, but using the `AUTHOR_DATE` instead of the `COMMITTER_DATE`.

After reading the subject alone, my reaction was "is this sorting
commits by the name of the author"?

That is one of the expected natural reactions when people hear about
this option, which is not what you want.

Perhaps naming it --authordate-order (or enhance the command line
parsing to allow --date-order=author|committer) would give us a
better UI.

(the above comment is before reading any of the code in the patch).
