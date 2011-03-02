From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Wed, 02 Mar 2011 08:53:40 -0800
Message-ID: <7vhbblcvl7.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net> <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com> <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com> <4D6E4246.5080407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:54:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PupJK-0002zR-Hr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab1CBQx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 11:53:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1CBQx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 11:53:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADEB33E57;
	Wed,  2 Mar 2011 11:55:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kDrfFpcGA5KDWvCWytekFawtQA8=; b=aELBEy
	5mYEssait33xMxFhxjivKZUIGk/RYAIzWuRp188MN3kKfXh3Dy/TFqaRSu8H6Dan
	l9YsgrWx0PEf6tvUQmxtnCKxGmRYi+MVpUo3gFJhYcE3fmqrNKUz6V+DktWG/bDg
	SvE2zLKZpFHO4ePUGMgHl1A4p7EOqcPFnuDJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RIBVoqmXTnkjqq+rFl+y65FgC7pRLvFe
	LqP3dFTywr8fqQY5HOwTer4MW03+5vIaW7G1C9YaA25mjsNb1JVQlbb6wuxwntPm
	uLc7fuKOcIwOXI8qHVIgyh6do1n6p9gYbiio+95ZVtd1hEViCgOpg3dUbgsp3ulF
	FeEpzZTKSz0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CD383E54;
	Wed,  2 Mar 2011 11:55:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E3F663E4F; Wed,  2 Mar 2011
 11:55:03 -0500 (EST)
In-Reply-To: <4D6E4246.5080407@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 02 Mar 2011 14\:12\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5163944-44ED-11E0-9040-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168324>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> [*] I keep forgetting that some people may have files whose names begin
> with ":". They are ambiguous now already with "treeish pathspec"
> commands, but not with "pathspec" commands. The latter would change.

Just to make sure I understand that they have easy workarounds:

 - If you have a path foo/:bar, you can say

   git log master -- foo/:bar

   because ':' signals the magic and gets stripped only when it is at the
   beginning (i.e. not affecting foo/:bar); and

 - For :boz at the root level, you can say

   git log master -- '\:boz'

   because the backslash in '\:boz' makes the colon not at the beginning and
   the glob match sees '\:boz' and then matches '\:' with literal ':' at the
   beginning of the pathname ":boz".

In very old times, git used to work only from the top-level of the working
tree.

The way we give an illusion that a command is restricted within the
current working directory was by learning the "prefix" returned by
setup_git_directory() while it chdir(2)'s up to the root level of the
working tree, and then by limiting the operation to the pathspec given
from the command line (each of whose elements prefixed by "prefix" by
calling get_pathspec()).

Your ':'-prefix trick will naturally work very well with this arrangement.
Instead of prefixing the "prefix", you would just strip ':' from the front
for such a magic pathspec element, and that should be all that is necessary.

There is a small worry, though.  Some codepaths have tricks that take
advantage of the knowledge of the current behaviour that the resulting
pathspec elements all refer to subtree under the "prefix", and try to
optimize their tree traversal.  I think dir.c:fill_directory()'s use of
common_prefix() is safe (it recomputes what is common based on the result
of get_pathspec(), not blindly using the original "prefix"), but we need
to make sure there isn't a codepath that blindly believes that the
original "prefix" defines the extent of the operation.  Anything that
understands "../" to step outside the cwd should be already safe, so I
hopefully am being worried too much.

Earlier, the list consensus was that if we were to aim for uniformity, we
should make everything relative to the root of the working tree when there
is no pathspec by default, because you can always give a single '.' to
restrict the extent of the operation to the cwd, but you cannot extend the
extent of the operation without tediously counting "../".  Would this ':'
trick affect that argument?  If a command is relative to the cwd with no
pathspec, you can now give a single ':' to affect the whole tree.

As I wrote in my response to Jeff in

  http://thread.gmane.org/gmane.comp.version-control.git/133570/focus=133874

I always thought that it would be the best solution that makes the choice
of the default irrelevant, and this ":" trick certainly feels like this is
that solution (I also think having a good default matters).

And we can start thinking about deprecating --full-tree option, no?  I
like that, too ;-).
