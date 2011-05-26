From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t7508: demonstrate status's failure to use
 --porcelain format with -z
Date: Thu, 26 May 2011 16:31:36 -0700
Message-ID: <7vzkm9t4x3.fsf@alter.siamese.dyndns.org>
References: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil> <7v4o4hw2zm.fsf@alter.siamese.dyndns.org> <oxsohkXWsdC5MeWOTaXZMEPAVeHglxeXSUXEWJ6xA_rmLcm2iqjtpg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 27 01:33:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPk35-0005MU-NO
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 01:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab1EZXbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 19:31:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab1EZXbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 19:31:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3638456C;
	Thu, 26 May 2011 19:33:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l94TSVklUmmexOiNa6GaJLs6JpQ=; b=mEwzuy
	eBzolr86i5Z1khanq8DfU42TvWsIX/i9jgzC3xp0o8wU1lu75xnqrkPEWH6yYiln
	L/zC8YGNjV4vzAiuJRYKkrDwofK/J0iwnGbIjIOnElQ7YbR7/BRvArBgQ30Sii3E
	lmqYiRE2eKQjAZJitTEYbGPKp8naUD28aVMNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oVlN/NCg5UoommVTxdQ0OErzOEh3GQWW
	FsMnhsaRzRyZ46iLGjJ3G2CTFzO+tes/tPNJsVN6rLnMFaz6rvvmfqzkq5dR0/YE
	2ZDKtUCx9kApz0sEN9+xK7n0WLkhWVj5Sdp5DgqMa/Rd+wIOdNe1pMtpY8r9V0Pg
	WjHhCIKWbWw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6381A456B;
	Thu, 26 May 2011 19:33:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DB0514568; Thu, 26 May 2011
 19:33:44 -0400 (EDT)
In-Reply-To: <oxsohkXWsdC5MeWOTaXZMEPAVeHglxeXSUXEWJ6xA_rmLcm2iqjtpg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 26 May 2011 17:51:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C2DBBFC-87F0-11E0-BF07-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174592>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>> By the way, don't we however also want to make sure -z does not kick in
>> automatically when other options like "short" or "normal" is given?

Heh, the above obviously does not make sense. What I meant was "if you
have -z but also --short or something other than --porcelain, -z should
not cause the command to fall back to --porcelain".

> It seems it was intended to be able to do
>
>    git status -z --short

Yes, you are of course right; in this case we shouldn't do either normal
nor porcelain; we should do NUL-terminated short output.
