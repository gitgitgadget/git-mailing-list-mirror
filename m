From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch -M" regression in 1.7.7?
Date: Mon, 28 Nov 2011 11:38:57 -0800
Message-ID: <7vk46kuje6.fsf@alter.siamese.dyndns.org>
References: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
 <20111126023002.GA17652@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?4piCSm9zaCBDaGlhICjosKLku7vkuK0p?= <joshchia@gmail.com>,
	git@vger.kernel.org, Soeren Sonnenburg <sonne@debian.org>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 20:39:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV72g-0006qi-Lx
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 20:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1K1TjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 14:39:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab1K1Ti7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 14:38:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28EEF6187;
	Mon, 28 Nov 2011 14:38:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fu7JjNIeFzZcu6F68680mI8bViU=; b=txdiGp
	rXIZfaqLByffoKtKGVqMGjE/R7ymVd7i3pbq/skloLl1JZCXVASwkAjjjq8njzMn
	7TWyHeSxoQMgQDojUFNv8qlTChlV4UiQ3SAXIfqV4r1TJu/St5/JNdT4+lmWNlry
	vflaUJzDlwdlhksdBbSoVYJtBg3Yb5iGrLLYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ryEY2EmzjuaglCCzHOQPWAdHTQZ1RHnk
	jE205osR4obX1rTHiDXQg5540leMh9N74n+UUT9twN6m2/q1x5esSYOML+ivleDk
	wB9cXAWjfQgA28A7Ddh4I8BbfBzfZmRL2sHCGzoJxHuNsUivV9nFP7PDCihQVsXh
	+2MDolmWub8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2062A6186;
	Mon, 28 Nov 2011 14:38:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9037F6185; Mon, 28 Nov 2011
 14:38:58 -0500 (EST)
In-Reply-To: <20111126023002.GA17652@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Fri, 25 Nov 2011 20:30:02 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DB0E0F4-19F8-11E1-B656-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186031>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 	git branch -M master
>
> This seems like a valuable exception to allow, because then "git
> branch -M foo" would _always_ be allowed --- either 'foo' is not the
> current branch, and it does the obvious thing, or 'foo' is the current
> branch, and nothing happens.
>
> Buildbot uses this idiom and was broken in 1.7.7 (it would emit the
> message "Cannot force update the current branch").

Although I am not sure the practice deserves to be called "idiom", I agree
that there is no reason to forbid renaming the current branch to the tip
commit of itself.

Will queue.
