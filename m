From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/13] Improve section "Manipulating branches"
Date: Sat, 24 Aug 2013 20:25:51 -0700
Message-ID: <xmqqioyumoxr.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<1973484790.1091060.1377329493472.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQxi-0001Sd-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab3HYDZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:25:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3HYDZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:25:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F4B2AF05;
	Sun, 25 Aug 2013 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0yWc6PNZxa2IYSh+uZiSj6damEU=; b=G1l6P1
	6eFEGIND2JKOJKq/uqU3mrlwVklHTQWi5fsS75Tucr9urG3Tbz4aSe8eoA6RE6Ho
	iH6gLkTB7ZSmOunhaZWXlO1ktbZLXeOg5X8FuHfBK0StUku1c4a0lSRDc4KJmfIY
	tuq/niOo8kRnLw/bDFvueOKBnX3UcjTRg4tFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tPioFYRq5WI6s+R34X4bWxmpDGPKh80X
	OEUm5A+WOM/dsld8QJ0GZbXXf17pmrFIXhF354rzdDa0EKEIj9E58TRtU4e/d0ZU
	M8ohXTgYfezn15O2WWEJ3sPTo6HgOJKwkD3lPcRDA3DzXSIw6k6ZQODuTSJEmqg2
	8ai90sui8HM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306772AF04;
	Sun, 25 Aug 2013 03:25:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B4D22AF03;
	Sun, 25 Aug 2013 03:25:53 +0000 (UTC)
In-Reply-To: <1973484790.1091060.1377329493472.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:31:33 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0C44A064-0D36-11E3-A1FB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232901>

Thomas Ackermann <th.acker@arcor.de> writes:

> Add some missing punctuation.
> Simplify description of "git branch -d/-D".
> ...
>  `git branch -d <branch>`::
> -	delete the branch `<branch>`; if the branch you are deleting
> -	points to a commit which is not reachable from the current
> -	branch, this command will fail with a warning.
> +	delete the branch `<branch>`; if the branch is not fully
> +	merged in its upstream branch, this command will fail with a warning.

But is this correct?  I somehow thought that we check with the
current or the upstream.

>  `git branch -D <branch>`::
> -	even if the branch points to a commit not reachable
> -	from the current branch, you may know that that commit
> -	is still reachable from some other branch or tag.  In that
> -	case it is safe to use this command to force Git to delete
> -	the branch.
> +	delete the branch `<branch>` irrespective of its merged status.

This is an OK change.
