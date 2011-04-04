From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Sun, 03 Apr 2011 22:20:18 -0700
Message-ID: <7vy63qa8z1.fsf@alter.siamese.dyndns.org>
References: <20110403172054.GA10220@kytes>
 <201104040643.35583.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stephen Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 07:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6cDj-0000mI-0b
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 07:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab1DDFUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 01:20:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab1DDFUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 01:20:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 71FFA5799;
	Mon,  4 Apr 2011 01:22:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UZRClR+xcu2ifi/qEtY/6SydlYc=; b=ZcnuX8
	TVYIq+6Qmng+IPCSaGa1ExKtfyjIJy1LlR47OMnjxww0zP7DR9UjCOhDxowXydFi
	azR87luDSgKCCOjW8hXIzTuexeQeuyBJ4dNQgPkGr89mo2tQF71xiVmXmjbgJq64
	Hheh4an0CMCxY7o4Mwiypn26qJBH66yn7HoXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aiVj+B7OYOXgFjVrVO9D57BdM/qpkwSK
	gSLXYVjbqN98bL4n6nCaoMqMf2zY/DYMiAeevkSVap2f/dTBrDRawMVJRUeN3nF5
	j8z0iV7lFv8IVATBxGzmfNl3kNijswQrhX3c5TXPYW3x2hGguqSQ4coMEY2pIQI+
	NWlSpdDfp50=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDBD95798;
	Mon,  4 Apr 2011 01:22:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE57B5795; Mon,  4 Apr 2011
 01:22:12 -0400 (EDT)
In-Reply-To: <201104040643.35583.chriscool@tuxfamily.org> (Christian Couder's
 message of "Mon, 4 Apr 2011 06:43:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 846EF72C-5E7B-11E0-A57D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170788>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yeah, the first step should be 'cherry-pick' with '--continue', '--abort', and 
> '--skip' merged.

I haven't looked at rebase-i machinery recently, but I wonder if it would
just be a matter of making a multi-commit cherry-pick just prepare a bunch
of "pick XXX" lines into .git/rebase-merge/rebase-todo file, make other
trivial setups (like detaching HEAD, writing head-name and head files) and
then execing "git rebase --continue"?
