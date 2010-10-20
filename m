From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Highlighting whitespace on removal with git diff
Date: Tue, 19 Oct 2010 23:10:38 -0700
Message-ID: <7v4ochxuld.fsf@alter.siamese.dyndns.org>
References: <AANLkTik7a8OQz2+SVTm+HjZkCtbjm6O9d12biCJ8MyZz@mail.gmail.com>
 <D058D986-2A83-4979-A461-F7CB34EF9448@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stonky Fandango <stonkyfandango@gmail.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 20 08:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Rt0-00065V-BB
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 08:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab0JTGKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 02:10:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab0JTGKt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 02:10:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E737E0CC6;
	Wed, 20 Oct 2010 02:10:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oscxZVEc4UnZoFAmoln7z3jGuaU=; b=aTa7wE
	+vWelT8RoJyox0ua8NR2cf4Dj1nMCxKZS/8mJCHxjY2OgQqgZ+h3/HdOQ0Ywric1
	cJ2wgvK5aV8I7gUGlD6Kfz/97mCQTNgREQbSfEm2WWGoAWlTfO1cWPumCVfLt5wr
	DumGn6hjYNVMUtAqHDf1LiMmQBOdraB8Jb11U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5Z7W4XQ8bSqQGtzJ6yfNu2bwVclxFbd
	9fid5+HYi7vHZwFIHF393NNV+w/G4rf3eEIOVBhdimEnrEw6LDHQM61WVhP6oR+t
	XRD6KVNEEGlJlRIHq+XN8VFBKwleozpPlo1o2/2DiupyVUsGcjVMpkNFH/e3e7tQ
	Bwc5D6vu/kE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDB66E0CC4;
	Wed, 20 Oct 2010 02:10:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5895E0CC3; Wed, 20 Oct
 2010 02:10:39 -0400 (EDT)
In-Reply-To: <D058D986-2A83-4979-A461-F7CB34EF9448@sb.org> (Kevin Ballard's
 message of "Tue\, 19 Oct 2010 20\:15\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5B1AFA6-DC10-11DF-A3D3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159393>

Kevin Ballard <kevin@sb.org> writes:

> The highlight isn't telling you what changed on the line. It's telling
> you that this added line has trailing whitespace, and your
> core.whitespace config value is set such that this is considered an
> error.
>
> -Kevin Ballard

Which means that, in order to check for a whitespace error you removed in
your change, you can give "-R" (reverse) option to your "git diff".
