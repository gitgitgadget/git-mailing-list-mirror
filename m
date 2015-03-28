From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 0/2] git-p4: Small updates to test cases
Date: Sat, 28 Mar 2015 09:07:32 -0700
Message-ID: <xmqqa8yxyukb.fsf@gitster.dls.corp.google.com>
References: <1427500983-8802-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 17:07:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbtGu-0006ed-V6
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 17:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbbC1QHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 12:07:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752172AbbC1QHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 12:07:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46AAF41BC2;
	Sat, 28 Mar 2015 12:07:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uHWRBZxUQY5Blwpc2G46zJM1Op0=; b=jU36Zr
	Z+MqajkbSVwueXCiXNlGK+rEqe3QgMzVh344s9RdG0m/6+S5TZlOTe1VDef5bb0x
	woeXpcEBethTSUNt0/4356pB4m1gWqOOeGCgARV3wM523cGS63wfKXNsJpHN8aXi
	XPEhUudH4Lonq/mmb43tLLloVt2mq7i7gXZvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TBNuUEseh9P8M0apu7GR/1/X3f7/9maj
	X57g1zMFuSz/xz7ZYEBwIwQpJu/KraZP9UvSNv1NcfDe2bowU56qiWLyQtOZGwH1
	Who/Z85laSlKstq3Yigc0dFYVCDWlxvbLW1wG7qwwU/HCcpSffJtg0+dFJzROQmv
	tlFIPV8eH5E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B6BF41BC1;
	Sat, 28 Mar 2015 12:07:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A29741BC0;
	Sat, 28 Mar 2015 12:07:33 -0400 (EDT)
In-Reply-To: <1427500983-8802-1-git-send-email-vitor.hda@gmail.com> (Vitor
	Antunes's message of "Sat, 28 Mar 2015 00:03:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B2E254C-D564-11E4-BFA3-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266418>

Will apply both.

It seems that I am to blame for 1/2 for botching the shell syntax
X-<.  Thanks for fixing.

I was not entirely happy with the "we could find either file10 or
file11 because they are the same, so let's declare both are success"
in the original, f69b3a93 (git p4 test: copy source indeterminate,
2012-06-27) in the first place, which survived the 9b6513ac (git p4
test: split up big t9800 test, 2012-06-27) and e832f737 (t9814: fix
misconversion from test $a -o $b to test $a || test $b, 2014-07-25).
I think a better fix would have been not to have multiple identical
copies in the tested tree to begin with.

But 2/2 is an acceptable interim fix that uses the same approach as
we have been using since f69b3a93, so it should do at least for now.

Thanks.
