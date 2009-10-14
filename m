From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit feature request: pass editor command line options
Date: Wed, 14 Oct 2009 12:11:28 -0700
Message-ID: <7vvdihdc4f.fsf@alter.siamese.dyndns.org>
References: <25885354.post@talk.nabble.com>
 <20091014172337.GE6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Cline <matt@nightrealms.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 21:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My9H5-0006vz-4L
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 21:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbZJNTM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 15:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZJNTM2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 15:12:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZJNTMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 15:12:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63874770F1;
	Wed, 14 Oct 2009 15:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umc7Kix1Vv4c57WbohGHI7em4vM=; b=xsQ26W
	jzMLqZPfTsRUkoSMgLrEQu9qP7sfXIO7p6AdfyDa2AfKLZ57waPXV4/B0Az4k7V6
	ZrGxkxX5d7GOElutOJDzYzgJanXP8GjXgXRhBMy1+AZGcSa6vPL/PIIiec/qMUjm
	F8UBgvzvcMpoF9Jvznph40FF5I6VJvh6jKHa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UqcOx609DvfHGVxbUsl8GQb3XBhr+SR1
	255XjEKAVUu7cq8+aC3cY2ygXNsm4zHrLiH039lVJ0QNe2rjQKCzOFgFyr+h7ycN
	K1IfPfzqWZo/i8X5Umy4vxIpP5Zsuseg+2j9ikEo+nOqLuR82HBl+3SalqLYGSE/
	01+6MzfG9c0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B181770ED;
	Wed, 14 Oct 2009 15:11:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D52A9770E9; Wed, 14 Oct 2009
 15:11:29 -0400 (EDT)
In-Reply-To: <20091014172337.GE6115@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed\, 14 Oct 2009 19\:23\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6366157E-B8F5-11DE-B24E-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130324>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Oct 13, 2009 at 09:58:51PM -0700, Matthew Cline <matt@nightrealms.com> wrote:
>> 
>> I'd like to be able to have git-commit pass the commit-message editor command
>> line options which aren't passed to the editor for other usages.  Right now
>> I have "co" aliased to "!sh -c 'GIT_EDITOR=git-commit-editor git commit'",
>> where git-commit-editor is a wrapper around my editor-of-choice which passes
>> the editor the command line options I want, but it'd be simpler and cleaner
>> if I could just set "commit.editor_options=-BAR".  Or even let there be a
>> separate editor for commits, so I could do "core.editor=foo" and
>> "commit.editor=foo -BAR".
>
> Hmm, what is the use-case when using an option --foo is useful when
> creating a commit, but not useful when crating a tag?
>
> Apart from introducing inconsistency...

Not between commit and tag, but I can see you may want to auto-wrap for
log message but forbid auto-wrap when editing rebase insn sheet during
"rebase -i".
