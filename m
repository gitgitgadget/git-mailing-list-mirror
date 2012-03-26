From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 10:12:48 -0700
Message-ID: <7v1uofqoa7.fsf@alter.siamese.dyndns.org>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org>
 <20120324165536.GA17932@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:12:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDTU-0006ch-IV
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933057Ab2CZRMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:12:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932667Ab2CZRMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:12:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D411E67C6;
	Mon, 26 Mar 2012 13:12:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ny3H7JkMWM9IaZCnkFLQ0DDfSHk=; b=Hxfu2NuopFeAO2QmKyUh
	lCpynjxc9qHCXZ3ZiEG3VrGc8GGbKN/gKxJ4bccand6kqHu5bJq6U0ln6XBKIPtp
	a3oDzxHDQSs6/hDldGWbSO8dZjNJTIxtrFuZfmEkb6a208Tgy/NqTSyS6uKIfGfE
	kLb+IvdQshS3K90GmlGrX1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=UaVipRebm5lo4EegjM8nXeXM+3BZzwK73fVF9jlRuhGJ9B
	SZrQcOFiK6DaPwRzrSbE7DdTpGApT0wNwACfhMT0uiYejOMISh9Y68BrcnDvEFUF
	AQ7mTGTC13zxiQVI5bRTxU2Z+43FzAU+mE8K/UAqTYb3lag9GR4YBOIG5/v+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C157A67C5;
	Mon, 26 Mar 2012 13:12:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56D8567C3; Mon, 26 Mar 2012
 13:12:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9F9DC4C-7766-11E1-9091-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193931>

Neil Horman <nhorman@tuxdriver.com> writes:

> Is there a way to differentiate a commit that is made empty as the result of a
> previous patch in the rebase, and a commit that is simply empty?

An empty commit has the same tree object as its parent commit.

> I agree, I think perhaps adding an --allow-empty option to the rebase logic, so
> that empty commits (or perhaps just initially empty, as opposed to commits made
> empty) would be very beneficial.

Yeah, that probably may make sense.
