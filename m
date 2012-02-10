From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Thu, 09 Feb 2012 21:48:44 -0800
Message-ID: <7v8vkbs0g3.fsf@alter.siamese.dyndns.org>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
 <7vsjijs9rq.fsf@alter.siamese.dyndns.org>
 <7vhayzs51s.fsf@alter.siamese.dyndns.org>
 <CACsJy8B_nsZnSarbRaBoxviK1xa_PVP0-DbnMiP9HkwzrztfJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tbushnell@google.com, tytso@google.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 06:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvjLs-00024k-IX
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 06:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab2BJFss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 00:48:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab2BJFsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 00:48:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E7B93ACB;
	Fri, 10 Feb 2012 00:48:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3QQIJAmDBkqJHXEgmPjUMviqT0E=; b=O6HXFJ
	BEXQH3Yf+IVfcar5xepCFndYTYB7f0ddA1N1CPVfekc7m1vqLjwc/PTYzoyxIMgj
	1X6KKze0flR8eF7+jgUbO5pjkH0G7Zv31rguf/dSJhGtsQ533ig7+wetyABImA3d
	A9O0YvkmC8b98YJyAMRk8JV8XmdDt1m1oOqxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1cjGYkxZyvQmO8TeDxT0d3IDsmNofin
	OuvXVJCDIElxi3ZfxO7wavUTVhSycrVNgaNC/0P3r9jCeslXjk1Z8wnItj4vbD1J
	1pL8qlP2ypecaQWhvC45c2ieo3tu+yALE1rpkH9+CMSzHjQ06s2/tKPH2CfBhKbv
	7W1QIcUjeNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 252C03ACA;
	Fri, 10 Feb 2012 00:48:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9EC13AC9; Fri, 10 Feb 2012
 00:48:45 -0500 (EST)
In-Reply-To: <CACsJy8B_nsZnSarbRaBoxviK1xa_PVP0-DbnMiP9HkwzrztfJg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 10 Feb 2012 11:43:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E575FB4A-53AA-11E1-82A3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190382>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> No objections. Does it fix a failed test? If not, should we add a test
> to record this side effect fix?

No, it was just "I tried this and it did not work" reported elsewhere, and
it is not v1.7.9 regression. Having seen a failure by a real user, having
a test would be a good idea to protect the fix from regressing.

I actually wish that the commit 9e58504 (clone: --branch=<branch> always
means refs/heads/<branch>, 2012-01-16) wasn't taken hostage to the earlier
changes that add new feature (addition of --single-branch and delaying of
the cloning before checking the remote HEAD); which would have been an
easier sell without violating the usual "no new features to maintenance
track".  And the thing is, I do not find this grave enough an issue that
deserves a separate implementation of a fix to be queued to maintenance
tracks.

> --mirror implies --bare in cmd_clone() if I read it correctly.

Yeah, what was I thinking... feeling stupid.

Thanks.
