From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8 v6] gitweb: Add an option to force version match
Date: Mon, 01 Feb 2010 19:19:05 -0800
Message-ID: <7vfx5kiaty.fsf@alter.siamese.dyndns.org>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
 <1264890645-28310-9-git-send-email-jnareb@gmail.com>
 <4B677971.2080100@eaglescrag.net> <201002020235.19943.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog9@eaglescrag.net>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 04:20:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc9J9-0003Hw-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 04:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab0BBDT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 22:19:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0BBDTz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 22:19:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1956941D9;
	Mon,  1 Feb 2010 22:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nlVfIkEx0QRxUHigwyq2l3jT5BM=; b=DcNRBO
	esj0psbB4Zkd1DhR1NxpC5N7YOSfTM0kDWx3mV4paYdAEFlRZMn/+NH42urBTZdx
	LeHmlT25YEiv0R29eePeCR7TjPg089rcjCVRyj26Y8P3j66E8hg43eDRKd+p+DWO
	2F89efsdFIU0P1HakzzQERY0Yf4H4UjvRp1mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2t3vFtcnoqDM7A/oYxRg2Z10XW06vKZ
	cxazacRK9bGXOh0qYII5iuTsh173BsRCJgIsF1DV/EUJI5A21/8wZJjgL0FDBoTq
	gZdowq1zDQofiKI755zfXdmknZh4LW/QKiCIvCmo1YH+vvlpr3GKEKKweCgn/yIs
	syv94TxLyI8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BDBD941D4;
	Mon,  1 Feb 2010 22:19:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77CB6941D3; Mon,  1 Feb
 2010 22:19:41 -0500 (EST)
In-Reply-To: <201002020235.19943.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue\, 2 Feb 2010 02\:35\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D17B4EE8-0FA9-11DF-BFCF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138673>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 1 Feb 2010, at 17:01:37 -0800, J.H. wrote:
>
>> Starting to pop off the stack, and this came up first.  A quick reading
>> of this, I'd sign-off and agree to patches 1-7 completely.
>> 
>> I'm still going to take issue that this being off by default is the
>> wrong behavior and leaving this off by default more or less means that
>> it will never get run and it becomes useless code.  If this isn't on by
>> default, it shouldn't be committed, as I can't think of a legitimate use
>> case where an admin is going to turn this on.
>
> Well, I don't think that mismatched git and gitweb version should be
> serious problem in practice, unless they are seriously out of sync.  
> And in such situation (where either git is stale and gitweb updated,
> or git updated and gitweb kept stale e.g. because it is heavily 
> customized with not ported changes) gitweb admin should turn this
> feature on.

I am not quite sure why the "boolean" default matters that much to deserve
this much of bandwidth.

If it is assumed that most everybody uses matching git and gitweb given by
their distro, then the default does not matter to them.  So let's think
about others.

If it is by default on, then here are what the site administrators would
do:

 - Some may want to _always_ make sure they run matching versions and
   consider having different versions of git and gitweb as _a mistake_; .
   they leave the check on by default, and they don't have to do anything.

 - Some may _not_ even care.  They flip it off, and keep it that way.
   They do that _only_ once.

Between these two classes of people, if you make the default off, you are
making more careful ones pay a bit more "one time" price, while allowing
lazy ones potentially shoot themselves in the foot more easily.  As the
maintainer, I am sympathetic John's insistence of having this check on by
default, and would even suggest that the configuration variable has to be
set to the exact string "I accept the risk of running non-matching
versions of git and gitweb" to turn the warning off ;-), but either way,
it doesn't seem to make too much of a difference.

Admittedly, unlike John or Pasky, I do not run a public gitweb instanace
nor have to deal with error reports from the end users, and that might be
contributing to my bias.

But I think we need to try helping the third category of people:

 - Some may need to _keep_ unmatched versions of git and gitweb for the
   users on their box.  Perhaps interactive users need a certain version
   of git, but they want to show spiffier looking gitweb to the general
   public by installing newer one.  They check if the combination of the
   particular (older) git and (newer) gitweb work well together, and then
   they say "don't warn, I know it is Ok _now_".

Unless the configuration can express "this combination has been checked,
so do not warn, but do warn when any other untested combination is being
used", this class of people won't be helped by having a configuration.

They instead have to _remember_ that they need to flip the warning bit on
before updating their git and/or gitweb, only to get reminded that they
need to make sure the combination works well.

That's a funny chicken-and-egg problem, isn't it?
