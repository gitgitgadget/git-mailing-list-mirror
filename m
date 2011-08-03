From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 10:11:23 -0700
Message-ID: <7v8vractdw.fsf@alter.siamese.dyndns.org>
References: <4E0A08AE.8090407@web.de>
 <1311792580.2413.82.camel@Naugrim.eriador.com>
 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
 <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>
 <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>
 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
 <20110803062536.GB33203@book.hvoigt.net>
 <1312374382.3261.913.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 19:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoeyj-0002gT-1a
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 19:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab1HCRL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 13:11:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab1HCRL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 13:11:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 157DF51D7;
	Wed,  3 Aug 2011 13:11:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0VnOYFjKVNFKT+6PahTTLOJotXA=; b=mOVNT4
	owGFK2dQWVk+HYb8z8V3oj6bPKiG39Boos+lOdC7KTgOJVFR8UNoUOZFHOEcH1+9
	H25tvWKs+52SPH1YsuF79haejUUVmSFmTH0h9GjQCPC4irxWtIRQYV+tdhRwuL4Y
	eY3e2C+i3cOBkynIH6pmTp1y/en+886xu+SiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tRNXN37vd535OluG6m04rlstHGbohSIb
	4Y133IHSz0QRmQ1zLQCjzLYNtq9kLcDwTnjOAN/RKMhkbbfd9Q6WHiQrbGR2VVTk
	jdyxhw5YNgJQJnCo9dSxAZ6h3tGVCoTmxIv0vpCGf8OM47QQJw7Dj3H/UBb63LfN
	FWVkJuTnJgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC7E51D6;
	Wed,  3 Aug 2011 13:11:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AE3B51D5; Wed,  3 Aug 2011
 13:11:25 -0400 (EDT)
In-Reply-To: <1312374382.3261.913.camel@Naugrim.eriador.com> (henri GEIST's
 message of "Wed, 03 Aug 2011 14:26:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E6E4A10-BDF3-11E0-B74D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178597>

henri GEIST <henri.geist@flying-robots.com> writes:

> I plan to use a config file containing lines like
>
> "path_to_poited_repo   SHA1_of_intended_commit   URL_of_origin"
>
> the URL part will not be required.
>
> this file will be a list of pointer to other project.

I wasn't paying attention to this thread, but I have to ask "why" here.

The first two are what gitlink was designed to do in the superproject that
ties multiple submodules together, and the last one is also supplied by
the .gitmodules in that superproject. This seems to be adding the same
information in a redundant way by saying "this version A0 of submodule A
wants version B0 of submodule B and version C0 of submodule C" when the
supermodule can say "the consistent view I record is to have version A0,
B0 and C0 of submodules A, B and C, respectively".

I also suspect that allowing each submodule to know and demand specific
versions of other submodules will lead to inconsistencies. Which version
of submodule C would you demand to have when submodule A wants version C0
and submodule B wants version C1 of it?
