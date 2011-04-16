From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git
 notes"
Date: Sat, 16 Apr 2011 09:33:42 -0700
Message-ID: <7vk4eub1g9.fsf@alter.siamese.dyndns.org>
References: <4DA7F73B.9050007@gmail.com>
 <7v7have8wo.fsf@alter.siamese.dyndns.org> <4DA8862F.5070102@gmail.com>
 <BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
 <BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 18:34:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB8Rc-0005Bm-9W
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 18:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab1DPQdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 12:33:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab1DPQdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 12:33:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE30D54AD;
	Sat, 16 Apr 2011 12:35:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QTLIsSgYdjWRemHxbF8jxZidQg8=; b=qyO3ZV
	kSL/xQjJnaQI+NZflRlaM4L1ahx4aJFopYkrJEVXaz7thdtkSECqpEtfPzQmnYv6
	5AXxXtQWakfVR7+XCr2y7wjBayWCZrRuElzngwmSAkNdQeGC/TMppf35SWZnEsDM
	cHehMybafQhcOqukpvlqaAg4Ehm5vAam5LSSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jyIs/zfxaBt8pc9ePvT5rWe+wfF4Dkj3
	4TJM0Go2VsFFxhmrA6MlXp59xQMewGy8xHxfqYyeyjvufLBnKmF04906quUM2Klm
	YwLdaFuZCnc4/JG3TAgqzK1zKrgIay/PLhZTzXjpmawksgOMxxJwIFEcTJMaK9VK
	danGyzWCIn8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 983BA54A4;
	Sat, 16 Apr 2011 12:35:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7C831549F; Sat, 16 Apr 2011
 12:35:44 -0400 (EDT)
In-Reply-To: <BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com> (Sebastian
 Schuberth's message of "Sat, 16 Apr 2011 09:19:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95BE9E80-6847-11E0-B2E6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171677>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> How can this be not true anymore? If you get a conflict while picking,
> you're asked to resolve the conflict and then commit via "git commit
> -c <picked_sha1>". Doing so will *not* give you the mentioned "(cherry
> picked from commit ...)" line.

I suspect Jay had the recent CHERRY_PICK_HEAD series that lets you omit
saying "-c <picked>" in mind.  We should not leave the cherry-picked from
in such a case, I think, but the new code may be buggy.
