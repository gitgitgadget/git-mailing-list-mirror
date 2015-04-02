From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 02 Apr 2015 12:24:38 -0700
Message-ID: <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
	<20150402180914.GA19081@peff.net>
	<201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
	<20150402191452.GA20420@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: "Reid Woodbury Jr." <reidw@rawsound.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:24:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdkjN-0005PN-Pt
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbbDBTYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:24:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752057AbbDBTYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 15:24:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 221CB439C5;
	Thu,  2 Apr 2015 15:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sp+1pVCUjy+n6zzCv1HEpmlxMgY=; b=awtR+2
	Cn/q9hTF98tIRUQhUjSVtb+rVrVJ4PH9EZ+MXCg4yQ7k0uQmsb20aj9R4MO1oq6L
	O3P0SCbxEvO2zJVdus916G+0wScLANWW46vLWZydUdELOpx15IhgWSB8fvUFKuRw
	K+HMUQgqAJQYP2mztYOFTsb3/pf4b/VbQ00oA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PCAjr+/burDfFY3ZJ2Oug/AK2/IfOp7o
	BHOr6G+xwKPOreQG1/LJpswnxaO98k3/fzGmUjih23Yh824cTNynCKsEGDKckJrX
	0J2DukbelmjVL1mYrTT5qa03U/Vsl/NorhVVL8tf0xBYAypHoEqzmWBwAv0TvihA
	DvuWiCccUyg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AA9B439C4;
	Thu,  2 Apr 2015 15:24:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97522439C3;
	Thu,  2 Apr 2015 15:24:39 -0400 (EDT)
In-Reply-To: <20150402191452.GA20420@peff.net> (Jeff King's message of "Thu, 2
	Apr 2015 15:14:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E81581D0-D96D-11E4-858D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266660>

Jeff King <peff@peff.net> writes:

> but this does not:
>
>   $ git push ssh://does-not-exist:/repo.git
>   ssh: Could not resolve hostname does-not-exist:: No address associated with hostname
>
> (note the doubled colon). v2.3.3 did strip off that extra colon, but I
> am not sure the URL above (i.e., a colon with no hostname) is actually
> sane. IOW, it may have happened to work in older versions, but I'm not
> sure we would want to promise to keep it working.
>
> Can you show us what your URL looks like, obfuscating the names but
> keeping the syntax the same? Also, are you using the "insteadOf" config
> syntax at all (which could easily lead to funny splicing, I imagine).

Everything Jeff said ;-)

Depending on the nature of 'xxxx' in the original, Torsten's
response may be different.  'xxxx' could stand for [9999:9999::9999],
a.host.in.domain.xz, 127.0.0.1, or all the other things and it is a
bit too vague to help us tell which codepath will pick up what and
possibly screw it up.
