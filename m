From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sun, 18 Oct 2009 15:50:35 -0700
Message-ID: <7vvdicmi4k.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7vaazpxha4.fsf_-_@alter.siamese.dyndns.org>
 <20091018193448.6117@nanako3.lavabit.com>
 <20091018120053.GA11391@atjola.homenet>
 <20091019052043.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: B.Steinbrink@gmx.de, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 00:50:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzeaV-0000OV-Kv
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 00:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbZJRWuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 18:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754259AbZJRWuq
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 18:50:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbZJRWup (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 18:50:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 479317C9E5;
	Sun, 18 Oct 2009 18:50:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=keCYIXQT5J3a3xlu/accpEKC8fI=; b=H6WdMY
	kbViZvBRBqjrzEo9bacPHRw78V7yGIdKV0l+dNxlkeisNmJc+DVCztv6l4vTwUPV
	o/oiv9225q1ep3kc9pEdIVKJJsEIRSssX1CN92dpXzvU7FQiDNnQuIhyo76YWeUz
	XZj+BesmShO+fgpiTwyTFzRar7dYjERtTn7Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ho16/kA1MBY0WP/+u8PpmzkaYm+5jCPR
	SDBAetvO0DvDq22TqoezzSzTymxAQJUre1BM6ePpL5UuPHXUgGuTPTUPov7qt+J/
	VS8mLDKjir+OcHYy/F2Y3CyK4JpBok5fvGAKJIqOsT51dsyW0bP4AH2mlLuNu4IW
	XHrQHjdcMMs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 027C97C9E4;
	Sun, 18 Oct 2009 18:50:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E02A7C9E1; Sun, 18 Oct 2009
 18:50:36 -0400 (EDT)
In-Reply-To: <20091019052043.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon\, 19 Oct 2009 05\:20\:43 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB87A94E-BC38-11DE-A6EA-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130619>

Nanako Shiraishi <nanako3@lavabit.com> writes:

>>> In the subject you used 'git checkout -b frotz origin/frotz'. Did you
>>> forget to say '-t'?
>>
>> Hm, the DWIMmery only triggers when opts.track is
>> BRANCH_TRACK_UNSPECIFIED, i.e. -t was not used. And it doesn't change
>> opts.track when it DWIMs, so it respects branch.autosetupmerge, which
>> would be overriden by -t. So it seems correct that -t is not in there.
>
> I see.
>
> A user who always wants tracking can set the config option and use 
> the new "git checkout frotz" shortcut, but a user who usually 
> doesn't want tracking doesn't have the config option and when he 
> wants tracking only for this new branch he can explicitly say "git 
> checkout -t origin/frotz", right?

Correct.
