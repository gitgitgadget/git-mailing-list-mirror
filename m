From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Tue, 02 Aug 2011 10:53:53 -0700
Message-ID: <7vvcufem32.fsf@alter.siamese.dyndns.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
 <201107301548.09815.chriscool@tuxfamily.org>
 <CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
 <201107301619.51438.chriscool@tuxfamily.org>
 <7v39hmkkth.fsf@alter.siamese.dyndns.org>
 <CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
 <7vvcuhhw96.fsf@alter.siamese.dyndns.org>
 <CAH3Anrqp3BVMpTz7DhYBL=9nt1F30_20t=FmcmdZHqMHLEqXqA@mail.gmail.com>
 <7vaabshfmb.fsf@alter.siamese.dyndns.org>
 <CAH3AnrrrvX64s3p_=5mrVcwx5FeO0iT8uX47remyCuCwPpOo=A@mail.gmail.com>
 <CAH3Anro-ve2ZoTnbEvWyNH7kEMBCQOoCDfqZbPPxymn12pzAbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 19:54:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoJAH-0006ci-9C
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab1HBRx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 13:53:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639Ab1HBRx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 13:53:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3A973927;
	Tue,  2 Aug 2011 13:53:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bVe8Jw4NeWYDotSaOxI+cxSOlYU=; b=Qz6DWx
	TP/OQjxcRQ16DfUEapCi3h8egTBs8F/HDfCnYwaQIdhnzxSDsFLlzvu2+0gk/qix
	0VNWqQhmDaDsG2w2uJhfm6bHetfFiCe3wZkP9i8tG6hkqPKC6u3G+v4CEsCdLHA3
	Ok4d1newIU0l8gi48NYzo8GON6ABbeiHNi8g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhLz8kMGKpJHYFDc4j43g9XVi4YAv5kY
	7kBedjB8iGG+fPGCYderivSgLLLwA2BWCqa1pac2lhiXQuuZSMBZXNQZTjB8BedQ
	EnVE1TOdFcM3rNq2HlG1evpRRZWwFl5fMdhpCpSMyv39goh58qPF7oannW6zOMWc
	JlBQj5IzimU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAEC23926;
	Tue,  2 Aug 2011 13:53:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 400183925; Tue,  2 Aug 2011
 13:53:55 -0400 (EDT)
In-Reply-To: <CAH3Anro-ve2ZoTnbEvWyNH7kEMBCQOoCDfqZbPPxymn12pzAbQ@mail.gmail.com> (Jon
 Seymour's message of "Tue, 2 Aug 2011 11:41:06 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63DEAE80-BD30-11E0-A647-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178490>

Jon Seymour <jon.seymour@gmail.com> writes:

>> Then, the next series can add a --bisect-head option (instead of
>> --update-ref) to allow the head to be varied (defaulting to
>> BISECT_HEAD) if not specified.
>
> To clarify: --bisect-head would default to HEAD if mode is checkout,
> to BISECT_HEAD if the mode is update-ref.

I am not sure if we ever want to allow updating anything but HEAD under
checkout mode, so I would rather think --bisect-head is _always_ invalid
under that mode. IOW, as I said in the previous message, these two are not
independent options.
