From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to selectively recreate merge state?
Date: Thu, 10 Dec 2009 17:11:38 -0800
Message-ID: <7vzl5q71rp.fsf@alter.siamese.dyndns.org>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
 <7v8wda8jg3.fsf@alter.siamese.dyndns.org>
 <m38wdae4k4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 02:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIu30-0005zF-QU
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 02:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762114AbZLKBLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 20:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762081AbZLKBLn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 20:11:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762050AbZLKBLm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 20:11:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FEDCA5DB6;
	Thu, 10 Dec 2009 20:11:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45RKWO6Y6tP7MaUwg3T+ptgcHsU=; b=pgqWPz
	+GUweE/DK1FEJ73LsJNB+ihDjziL0mCuny/jWI3gh3wNL+Vm+G0yrv66F0jRKp0w
	WZ6itDC7TzyE2z6MMx52szN5ReJ2ewDiqpgOOoCGCqe89b/BBkzEhOgNSNXZCkXb
	534CFCDJhPxI0emJP5zUgW7350AgEvTtkVk/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rvH60tnQ3Rfg2Kk7d/A+OUDuiBpugjXT
	t4lJLsS3433/hdvBT5T9/cskoPXFs4IM8Kqym0fu49hahcmh7mAW2+N4g4Jl+bD8
	U02qczrITIQmM6Apj6+CpS5yvNARyb/0FILXHXlOCuAXnnXqKCnndMvKslVTV8zZ
	gFI89VVMefQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 71242A5DB5;
	Thu, 10 Dec 2009 20:11:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F1608A5DB1; Thu, 10 Dec 2009
 20:11:39 -0500 (EST)
In-Reply-To: <m38wdae4k4.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 10 Dec 2009 16\:28\:50 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 263C0A44-E5F2-11DE-BB11-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135064>

Jakub Narebski <jnareb@gmail.com> writes:

>   --unresolve::
>         Restores the 'unmerged' or 'needs updating' state of a
>         file during a merge if it was cleared by accident.
>
> Unless "git add foo" not only adds current contents of foo at stage 0,
> but also removes higher stages from index...

By definition, adding anything at stage #0 is to remove higher stages.
