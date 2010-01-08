From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Support relative .git file in a submodule
Date: Fri, 08 Jan 2010 15:09:13 -0800
Message-ID: <7vocl4urc6.fsf@alter.siamese.dyndns.org>
References: <1262990208-15554-1-git-send-email-brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNxO-0004IA-SP
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab0AHXJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033Ab0AHXJW
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:09:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab0AHXJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 18:09:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5FA8FD03;
	Fri,  8 Jan 2010 18:09:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SYxZhT/iw2/803QfKm1xCgQySsY=; b=ixxA3m
	+VyNws7SAxyT/MFLE80HoX7sppF6+XoxwdBjhe8L9HPW8u7eVFfkkuPaMvaCOr4N
	SL3D+WPQSQ4rOqAAnae7zKSM4X4l2SThUaR5RqaSpmIjlR6ZFZCvorBLjIlYxtPB
	LI/JTzm+/3nHgFjLn34YCNFf5kNIDnyOhTayE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JzJDt2aKR8tlK8IbVy57S/Hu/ogojD/O
	y5ppO5O2LGevITeVOjCIyUh7qbkqafwAKJW1GtNNVWWXkBMXODqATehP031r7RcB
	pTiY59YnGWn9BL2ogmCGkwmlAkZ3EjzXG74rS9i9ozYzQG/oMrA3mfqGGJcpyf+o
	AU/kQ73Ken4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59C758FCFD;
	Fri,  8 Jan 2010 18:09:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9228B8FCF9; Fri,  8 Jan
 2010 18:09:14 -0500 (EST)
In-Reply-To: <1262990208-15554-1-git-send-email-brad.king@kitware.com> (Brad
 King's message of "Fri\,  8 Jan 2010 17\:36\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9057C72-FCAA-11DE-B1D8-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136490>

Brad King <brad.king@kitware.com> writes:

> ... if a submodule
> has a .git file "symlink" with a relative path to the real submodule
> repository then ...

... then I've always thought that is simply a misconfiguration (t0002
seems to use full path for this exact reason).  Is there a reason why
relative path should be used/usable here, other than "being able to is
better than not being able to"???

I don't like my process randomly chdir'ing around assuming they can chdir
back safely very much, and would prefer not to add such codepaths unless
absolutely necessary.
