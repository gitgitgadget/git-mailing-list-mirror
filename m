From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] help: Add '--follow-alias' option
Date: Wed, 14 Mar 2012 23:00:26 -0700
Message-ID: <7vehsummit.fsf@alter.siamese.dyndns.org>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
 <1331779969-8641-2-git-send-email-namhyung.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:00:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S83jp-0007eO-GE
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab2COGAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 02:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab2COGAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 02:00:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E84903DAB;
	Thu, 15 Mar 2012 02:00:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O9PX3XtL5067FOAuHvWCbsJIpbA=; b=lIbu8k
	AnmdyO2fXdjsxRMaBRJ08JA7TGhZlSt0p0POHh3Fr+aNt+a1H3wFhsljCaIlh5/P
	4IaNExkihp0K1SLg/Nri7V/JqOh07VisWpJapBCKe+sY0cljr8quzUVq2Jdz3z9o
	8y1n6ywdsk8LKI/BIe2K13OOto69sndmQuxH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hpr360fBHSw54BEhnKDE2+1ibn4ZzVmJ
	rmypZrDjOjVVqCsK0vwCY2wE2eKR3f4LM0d9LN7igzb6aTfHPOb09GuKNCHz7SIy
	+lmeiA8vNqV/sudwogpZkN5o2WNaXO9RoUABakXT39dMiTmv0KYSK3b8+Ylfgyxt
	oXsvf74yvoQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB4C73DAA;
	Thu, 15 Mar 2012 02:00:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 609133DA6; Thu, 15 Mar 2012
 02:00:28 -0400 (EDT)
In-Reply-To: <1331779969-8641-2-git-send-email-namhyung.kim@lge.com>
 (Namhyung Kim's message of "Thu, 15 Mar 2012 11:52:48 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A58AEE6-6E64-11E1-98ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193181>

Namhyung Kim <namhyung.kim@lge.com> writes:

> The --follow-alias option will look up the alias definitions and
> use the first word as a command. For example, if I set my aliases
> as follows:
>
>  $ git help br
>  `git br' is aliased to `git branch'
>  $ git help ru
>  `git ru' is aliased to `git remote update'
>
> adding --follow-alias (or -f) option will show man pages of
> git-branch and git-remote, respectively.

What would happen when somebody has this?

	[alias]
        	br = branch --list

	$ git help --follow-alias br
	... man page for git-branch is shown ...

NAK.

> +-f::
> +--follow-alias::
> +	Read alias definitions and use its first word as a command name
> +	(if any).

Also, please do not let a potentially ill-conceived option to squat on a
short and sweet single letter option name, until it proves to be useful.
