From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add post-fetch hook
Date: Mon, 26 Dec 2011 22:37:10 -0800
Message-ID: <7v8vly8qqx.fsf@alter.siamese.dyndns.org>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <20111226023154.GA3243@gnu.kitenet.net>
 <7vlipz930t.fsf@alter.siamese.dyndns.org>
 <20111226155152.GA29582@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Dec 27 07:37:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfQf2-0004KG-1J
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 07:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab1L0GhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 01:37:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab1L0GhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 01:37:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C5DA7622;
	Tue, 27 Dec 2011 01:37:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rdyNckwuNBXs23mn6SnGp3W0744=; b=OzhzfD
	wW8+exCuHS2XCK48s9ISsm6AkxzuXp53llAtwqBCfVePGkAKANA2ZhfH1IT/s5Rm
	kBhc2g7P4zwZTc1LSnCyyBuuyF5SS6QmO4OocylOTUt/EVKTywBnhoG4t6cMnOPx
	w1XiUpCZXt4KglfCbFVg8MDJlyZcAwWNCSVzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ld3pOYcxsC7oE324o1uGrscaHfgF9CM2
	ndCS9aE8NqX6Zl9jOWJnxoyZZUToH28fbcVH5TPugTEdtkgrtYcbIHobQ9TIzdFv
	2yRrUhX10pntQeW/RigPvIQBcqw4lT8GE2dBHCW9NNdZr20HF3W/1Wk7Iq17S90p
	Zk0xjuomOdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13E097621;
	Tue, 27 Dec 2011 01:37:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 963BB7620; Tue, 27 Dec 2011
 01:37:12 -0500 (EST)
In-Reply-To: <20111226155152.GA29582@gnu.kitenet.net> (Joey Hess's message of
 "Mon, 26 Dec 2011 11:51:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35878DC0-3055-11E1-9C01-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187709>

Joey Hess <joey@kitenet.net> writes:

> .... And other code in git uses an async feeder similarly,
> see for example convert.c's apply_filter(). So I think this is ok..?

Yeah, I didn't look at your patch (sorry) but if it uses async like the
filtering codepath does, it should be perfectly fine (please forget about
the select(2) based kludge I alluded to; the async interface is the right
thing to use here).

Thanks.
