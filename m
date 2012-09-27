From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash completion with colour hints
Date: Wed, 26 Sep 2012 23:53:31 -0700
Message-ID: <7vfw64rm6s.fsf@alter.siamese.dyndns.org>
References: <50631885.8090604@nieuwland.nl>
 <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com>
 <506356AA.3050005@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:53:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7yh-0002Ec-JM
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab2I0Gxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:53:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611Ab2I0Gxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:53:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 958B47387;
	Thu, 27 Sep 2012 02:53:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NAvo+bLDLnhbuTBB4L6S23bcuqY=; b=lj6+Cc
	h0yUh1HiFD/wJ3y84AraNZnjMYhCZ5zCSgyboS5aR7vP8rZPHpA7XGpRS1qrUUmF
	dAWgedFR6s7/FU6h2F9Y07WNRRiDQ5HNPDv+ch3RWfrSKQ9qncQQmSDrVdorhl/n
	lkp/B0zZL7ADKL/+5rr7BqEYoKKZXwHqn+thg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A/3zSfcrejoNAaYdyuxxYABhjBGbENvL
	dXs6cPGBY3yUfEiQKx96WgJzjlcCnd0wBOA6H++1JRVbm4l/BINejZuXe9r883Qn
	d8AEpauWOQdSUKcCnrhUb769ByXzXY1MHnvxOt3jt4aoeO4LRTmO59H9NJ4Ji2px
	zyNPAzjBgRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83046737D;
	Thu, 27 Sep 2012 02:53:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBDED737C; Thu, 27 Sep 2012
 02:53:32 -0400 (EDT)
In-Reply-To: <506356AA.3050005@nieuwland.nl> (Simon Oosthoek's message of
 "Wed, 26 Sep 2012 21:25:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D6C386A-0870-11E2-AC72-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206469>

Simon Oosthoek <soosthoek@nieuwland.nl> writes:

> I read the guide and now I have some questions:
>
> - It suggests to use the oldest commit that contains the "bug" and can
> support the fix. This would be the very first mention of __git_ps1
> function I think commit d3d717a4ad0c8d7329e79f7d0313baec57c6b585

You could claim that the lack of coloring is a bug, but nobody
complained about it so far (and I personally hate coloring in
prompts as they are distracting noise, and would reject a patch if
it weren't made conditional), so I would think this is more about
"adding a feature the users can choose to use but they do not have
to".

We do not usually add new features to maintenance tracks, so the
result of applying the patch does not have to be merge-able to maint
or amything older.  I would base the patch on v1.7.12 (the latest
stable release) if I were you.

> - I read that git-prompt.sh is meant to support bash and zsh, I have
> only tested it on bash. Should I attempt to test it on zsh or is there a
> kind person with zsh as his/her shell to test it for me?

That is something you should ask on list, like you did here, but the
most effective way to do so is do so when you send a patch you
worked on and tested with bash.  Say "I've tested it only with bash;
can you please take a look?" and Cc the folks you find in the output
of "git log contrib/completion/" who worked on making it workable
with zsh.
