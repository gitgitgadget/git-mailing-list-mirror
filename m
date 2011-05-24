From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: honor advice.detachedHead when reattaching to
 a branch
Date: Tue, 24 May 2011 14:24:37 -0700
Message-ID: <7vipsz7pwq.fsf@alter.siamese.dyndns.org>
References: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
 <20110506223847.GC17848@sigill.intra.peff.net>
 <7vzkmc6n1s.fsf@alter.siamese.dyndns.org>
 <20110524202723.GG584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 23:24:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOz5u-0003bM-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab1EXVYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:24:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab1EXVYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:24:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FCC25EFB;
	Tue, 24 May 2011 17:26:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5e3r0C2Z+iwqewvI1drnNPa3xNI=; b=X+XvSU
	bY/j/kqA9a3/IgkvMCFWcNnwCdZ28Brx9r0/ACw1ZvT7sbNkzpa5EIJZM4Lno4YM
	+twDuNlNa/UgBIBXs3E10Ir1DkIAszU8ZCT3h3Gt8mjk3Q4Kfic9/5c4/9WCDP62
	ENLgcvZakU73QgdzBOm5CUE9BZMOEkWAw4rVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hkOiF9uJuk3WrFPof7Vt5nXrpJ3+a6Br
	t99dsZMC2cFn0I34YTN5Eb8l/+H3d0Uxw5K5dSg9ptb2wu+GGc2wAG0fXz4mCMK1
	TrwEQXrv/G1mU744z2w67B5+7SnDYO5Yq/ZiECWOT9B9BWdhPngZxxLJMSZzf8Da
	0bjmddOMTZg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFC8C5EF6;
	Tue, 24 May 2011 17:26:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 231345EF3; Tue, 24 May 2011
 17:26:46 -0400 (EDT)
In-Reply-To: <20110524202723.GG584@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 24 May 2011 16:27:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89386D76-864C-11E0-B813-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174345>

Jeff King <peff@peff.net> writes:

>> @@ -668,8 +671,6 @@ static void orphaned_commit_warning(struct commit *commit)
>>  		die("internal error in revision walk");
>>  	if (!(commit->object.flags & UNINTERESTING))
>>  		suggest_reattach(commit, &revs);
>> -	else
>> -		describe_detached_head("Previous HEAD position was", commit);
>>  }
>
> Wait, I thought we were keeping this, per your argument above?

Well, I do not have very strong preference either way. I didn't really
argue for or against. I just explained it might be useful.

Will resurrect.
