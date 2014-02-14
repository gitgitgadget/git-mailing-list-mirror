From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2014, #04; Wed, 12)
Date: Fri, 14 Feb 2014 13:08:32 -0800
Message-ID: <xmqqr475h06n.fsf@gitster.dls.corp.google.com>
References: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
	<20140214194436.GB743@foghorn.codeweavers.com>
	<xmqq4n41ihgi.fsf@gitster.dls.corp.google.com>
	<20140214205038.GC743@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Eikum <aeikum@codeweavers.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 22:09:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQ0O-0008EW-VR
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaBNVIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:08:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbaBNVIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 16:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8018E6D0D0;
	Fri, 14 Feb 2014 16:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZbDOJ+DC92Wyi72uhmd2myVuQEA=; b=OEy6ig
	HzIVlg8p6jev0yJrFLvM0jvvh9ffPW+MjvbbW98v+6xxYy5H/elAdAXouCFmW1Nb
	1WGABFoRy2WNwQ0Mrvfn/A0wfDZJIXJaCtpvp17kq9GYO2mJUcYIUhy+GUqIc08R
	NJ0XC1cz4wSPE0uJA5paj/ZaPVkri3W2Z5Evk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dk4LkCMj9vQsUGpt0ppqyt1B2IZJWGaZ
	N94VG1IEPYgcGzvwYEP5DrdtR6C9BCfyXqr+sC3tuk3JJYPh5+oLjixmfSDRwWrH
	UYiPdJ6VaSNwngf85RxnQ8jUGqe6jVy4/Ae6ZtSVx3dA4MbU/kAMUl3FJ4FLcqhb
	Ka8VNwllvk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFA36D0CF;
	Fri, 14 Feb 2014 16:08:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A749C6D0CB;
	Fri, 14 Feb 2014 16:08:34 -0500 (EST)
In-Reply-To: <20140214205038.GC743@foghorn.codeweavers.com> (Andrew Eikum's
	message of "Fri, 14 Feb 2014 14:50:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2A470354-95BC-11E3-924C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242145>

Andrew Eikum <aeikum@codeweavers.com> writes:

> My worry is having "2." hang around for another decade or longer. I'd
> rather see X.0.0 denote a major feature release (currently represented
> as 1.X.0), with X.Y.0 for minor enhancements and X.Y.Z for bugfix.

We need three categories: (1) potentially incompatible, (2) feature,
(3) fixes-only.  We have been doing two levels of features by having
both second and third numbers and we are flattening by removing the
second one.

> It seems reasonable to expect fewer backwards incompatible changes in
> the future as Git has become more mature. This reduces the utility of
> reserving X.0.0 for major backwards incompatible changes, especially
> considering it's already been eight years for the first increment.

We are not done yet, far from it.  If we can stay at 2.X longer,
that is a very good thing.

If we followed your numbering scheme, you rob from the users a way
to learn about a rare event, a potentially backward-incompatible
change.  How would you tell your users when the version gap really
matters?  After hearing "You need to plan carefully when you update
to version 47" and then updating to version 47 (or the user may skip
that version), the user will learn about a new version 48 and does
not hear such a "you need to be careful".  What should he think?  No
news is a good news?  He should refrain from updating because the
last one was a big one?  What if the last time he updated was to
version 43, stayed at that version for a long time without paying
much attention (as Git grows more and more mature), and now we have
version 50 after having a large compatibility gap at version 47 he
did not pay much attention because he was skipping?

The rarer the important event is, the more necessary that the
importance is communicated clearly.
