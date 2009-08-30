From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Sun, 30 Aug 2009 13:11:22 -0700
Message-ID: <7vljl1dpud.fsf@alter.siamese.dyndns.org>
References: <87k549dyne.fsf@meyering.net>
 <7vvdnt869j.fsf@alter.siamese.dyndns.org> <87eiuhdnw9.fsf@meyering.net>
 <7v7i087twu.fsf@alter.siamese.dyndns.org> <87skf9uv3r.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhqkT-0005Ki-Uy
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbZH3UL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbZH3UL2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:11:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbZH3UL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 16:11:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EDCE1F13D;
	Sun, 30 Aug 2009 16:11:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UWW6DcaU7K1IzIN7r3vIymCaegs=; b=rj+Qilo1WfBMzVQsGYKzPFe
	9EwcuD42RE8J8bmhxOwB7/v4OtFtH3Obyeyl7FKReSS5IHjIOBphDjyc1s4W+Hxn
	kXoj/930r1v6Krqfc0p+JYNKYQXRVGPTbemhBuHj7D5k7+Ihx63uOK7yydm/0eJi
	kG3qawDF0rn0DEhr6RCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kxTqwHfi1ZEGPclnFqYHQLR+8xsWTfou+mp1kv9M7pv+VldSy
	jjW0pkyTonTBL6RWDBBsU/heNHeYdgyj83DZBNQXfx1dSLseqO4wnm/ZuXlHq934
	Zh9tj1hyM8sOSH+5e5ZLK8YaDEiiIzdS/cgE+7kTQBXFUknFHIGW2MO7CA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F0791F13C;
	Sun, 30 Aug 2009 16:11:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67F581F13B; Sun, 30 Aug
 2009 16:11:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C50F57E-95A1-11DE-BB5C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127425>

Jim Meyering <jim@meyering.net> writes:

> Junio C Hamano wrote:
> ...
>> Subject: [PATCH] diff --quiet: special case "ignore whitespace" options
>> ...
>> Change the semantics of --ignore-whitespace* options to mean more than
>> "omit showing the difference in text".  When these options are used, the
>> internal "quick" optimization is turned off, and the status reported with
>> the --exit-code option will now match if any the textual diff output is
>> actually produced.
>>
>> Also rename the internal option "QUIET" to "QUICK" to better reflect what
>> its true purpose is.
>
> Thanks again.
> If there's anything I can to do help (add a test?), let me know.

The change has been cooking in 'next' and hopefully be in 1.7.0.  I think
the updated series adds its own test script, too.

Using it in every day scenario, and reporting any breakage you notice
before 1.7.0 happens, would be greatly appreciated.

Thanks.
