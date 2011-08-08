From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Tolerate zlib deflation with window size < 32Kb
Date: Mon, 08 Aug 2011 13:07:43 -0700
Message-ID: <7vk4anwttc.fsf@alter.siamese.dyndns.org>
References: <7vhb5x5cgo.fsf@alter.siamese.dyndns.org>
 <1312742773-26373-1-git-send-email-roberto.tyley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Roberto Tyley <roberto.tyley@guardian.co.uk>
To: roberto.tyley@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 08 22:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqW76-000885-Ej
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 22:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab1HHUHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 16:07:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab1HHUHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 16:07:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 728994477;
	Mon,  8 Aug 2011 16:07:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ION19bWyzOOwpfvvoAIceNTkpuM=; b=w/5POM
	A1XT83aBMGNnQi7F5iLNmzoQspzXUeuMNcTGh6a3aR8Uswju5wOpIK8XMMTxnjLY
	xKju+Y4cuV4SxBqjS5TFNaO26Zc8eEQaYSH7vaiLw2kcIrShqY3+H4+nA2hDwU1L
	A5+MB2MhTx2iLPxLR+Ni8aHu01ExLYunNIJ3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mp+knI7ahE3y5sNYMe3UxRJD89YB6El6
	ktAPtNlm+A19SaeOGmWuUMYhx/9LD+GbgZIiz+P/bZSweyof3g/YhwjomoGMsD00
	A6XiFVW+an1/hEKLCZsH0AM3hBKqwiYPhNxSbKjD7VTt2rdsKPbTAwxVbQdLnrXJ
	/9gsYP5D7uM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A8274476;
	Mon,  8 Aug 2011 16:07:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D38784473; Mon,  8 Aug 2011
 16:07:44 -0400 (EDT)
In-Reply-To: <1312742773-26373-1-git-send-email-roberto.tyley@gmail.com>
 (roberto tyley's message of "Sun, 7 Aug 2011 19:46:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 145D7C1E-C1FA-11E0-A59E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178978>

roberto.tyley@gmail.com writes:

> +test_expect_success setup '
> +	cp -R ../t1013/objects .git/
> +	git --version
> +'

This "my parent directory" reference ../t1013 does not work when you use a
separate test directory (e.g. to use ramdisks) with --root=/some/where/

I've squashed

	cp -R "$TEST_DIRECTORY/t1013/objects" .git/

as a fix while queuing.

Thanks.
