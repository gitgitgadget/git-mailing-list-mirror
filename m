From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding Beyond Compare as a merge tool, was: Re: What's cooking
 in git.git (Feb 2011, #05; Wed, 23)
Date: Sun, 27 Feb 2011 01:09:42 -0800
Message-ID: <7vhbbp6dyh.fsf@alter.siamese.dyndns.org>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <4D68D4FA.7090500@gmail.com> <4D69E355.7010104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	charles@hashpling.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 10:10:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptcdf-0003xZ-PG
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 10:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab1B0JKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 04:10:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab1B0JJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 04:09:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEF34265C;
	Sun, 27 Feb 2011 04:11:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/LGGWx2IWG9Ckm4hVdHS0vYQB4=; b=Cd/rPz
	OiprNiCRcDEZvR+n5yY5Rm09hJDC9hkHAF3DrmsbYzbRw3oILLlImGHLQ3cRNt4e
	A0I8RHbkFXQagfVNsD1f+Tvw1Vc4e2Ta/bQTuDmxOFYIco5BN/PnWUMf+Dtqyf6w
	MhQAh7Dcxlm6Aksrnq/02L/gcm4FCbjxg1r4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qkgLOesUbot9GUr677CPYpKqdKVDh/hV
	ibbGxHPAdDlh/007uMWUOo29Y5IGkZYWREFBfE1V0zNXwGMuRZjwD+Xg5A3RQO1B
	Kiy0ow4XQ8PUFeDWd1RpzwczmPsCzRNZa66kmvuO55y/XhUJHBYIkJuZHnEKJ4WD
	fLXKG975zvk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CC8E264A;
	Sun, 27 Feb 2011 04:11:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C9252649; Sun, 27 Feb 2011
 04:11:00 -0500 (EST)
In-Reply-To: <4D69E355.7010104@gmail.com> (Chris Packham's message of "Sun\,
 27 Feb 2011 18\:38\:29 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 822A6C1C-4251-11E0-82E2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168013>

Chris Packham <judge.packham@gmail.com> writes:

> In linux it's bcompare, although BCompare is the eventual executable
>
> chrisp@laptop:~> rpm -q --filesbypkg bcompare
> bcompare                  /usr/bin/bcompare
> bcompare                  /usr/lib/beyondcompare/BCompare
>
> Unfortunately /usr/bin/bcompare is a little more involved than a symlink
> so for linux we need to call bcompare.

The real question is which one the end-users like git-mergetool--lib are
expected to call, and it looks like the "bcompare" in /usr/bin spelled in
lowercase is the one.  So shouldn't we be calling that, Sebastian?

And if we invoke lowercase "bcompare" on Windows, the system would do the
right thing, no?
