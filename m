From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Make help behaviour more consistent
Date: Mon, 11 Mar 2013 14:50:31 -0700
Message-ID: <7vhakh8v2w.fsf@alter.siamese.dyndns.org>
References: <1362937729-9050-1-git-send-email-kevin@bracey.fi>
 <vpq620yfj6g.fsf@grenoble-inp.fr> <7vppz592v5.fsf@alter.siamese.dyndns.org>
 <CD3017A6746B45FE8A5F242E4C597B51@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Kevin Bracey" <kevin@bracey.fi>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 22:51:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFAcX-0007AH-MT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484Ab3CKVuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 17:50:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234Ab3CKVue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 17:50:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03AB4B4DE;
	Mon, 11 Mar 2013 17:50:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PuSO8mF7iAk8MblKDIyYDOkxd/Y=; b=Y8EiZT
	pYIGUsO2zasujo+rqFWYWjrZ4tjEkfgYqBBPInGGrW2Kw3mGav4cUz3NWLCc1/c9
	5PKLpCluN6s18Yx0DNttal0WBD7EmNqlp3qqWl6/Qre/H8VSyYoKUOLRR7yAH2/6
	XSv+t4brUgCjxx4ugORAppLvONqcxUgzc1VVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j/BWLeLMZaaMEWZOpliU4QDfl74rR24M
	34BX7ERLjMVgJgGFWbNF+AtF4oPo6fkmf84dGxLe0iFcWGgnL4DZjM+nAUDsVdGD
	4i3d1cW2ipAIypXMGwy4QSTFGitDbiSAi0tKl5F9ba8R0Cc9HzS+Qp34piAxyZ/q
	08cmkIvsqqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9FA7B4DD;
	Mon, 11 Mar 2013 17:50:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57864B4DA; Mon, 11 Mar 2013
 17:50:33 -0400 (EDT)
In-Reply-To: <CD3017A6746B45FE8A5F242E4C597B51@PhilipOakley> (Philip Oakley's
 message of "Mon, 11 Mar 2013 21:06:33 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3130D64-8A95-11E2-A4B7-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217916>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>>   See 'git help git' for general help about Git.
>>>
>>> to the output of "git help"?
>> ...
>> That sounds like a good direction to go in.
>
> My earlier attempt, and Junio's reply
> http://thread.gmane.org/gmane.comp.version-control.git/217352

Yeah, I threw "git help git" in the general category of "git help
<cmd>" in that message, and now I realize that it may arguably be
confusing to some people.

Perhaps spend one more line to do something like this?

    'git help -a' and 'git help -g' lists available subcommands and
    concept guides. See 'git help <command>' or 'git help <concept>'
    to read about a specific subcommand or concept.
    For an overview, see 'git help git'.

I am neutral between the above and this:

    For an overview, see 'git help git'.
    'git help -a' and 'git help -g' lists available subcommands and
    concept guides. See 'git help <command>' or 'git help <concept>'
    to read about a specific subcommand or concept.

Hrm?
