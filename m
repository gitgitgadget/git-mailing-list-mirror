From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 00:01:07 -0700
Message-ID: <xmqqfuvt8rws.fsf@gitster.mtv.corp.google.com>
References: <56E3BE3E.9070105@gmail.com>
	<1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
	<56E5B27D.7010808@gmail.com> <20160313211910.GA22052@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sidhant Sharma <tigerkid001@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Mon Mar 14 08:01:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afMV8-0001T4-G0
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 08:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933492AbcCNHBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 03:01:11 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933122AbcCNHBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 03:01:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1089D469E0;
	Mon, 14 Mar 2016 03:01:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nkJ7Fo/eX7heMge+v1F2kiM0B78=; b=QGVWdC
	NMVaWDyfFWbssUm8iQ2ABv//Gt6SR33pkTGw1BPEDjrR6eX2+p+o7Kk+PKAoOLTl
	q5cB7w/zCqk4sE2khGQ8jHIDDY4Fv4RkNfHQPYHWc+Jd2U6/lo0mc91w2BsF6329
	YbUiPqHnFbLQRTUlekp8lmgp9WggyPKsDIgsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gn6IWEauJecC/KKbtsZjNOdLVRU6s9Y7
	wzgYkL3oYfE8zqmZX3iiHVgzGONk6sjBhdNMh2Vb1YnY/cBkUP8wZxybDHDiT13d
	eVyzfeC8RPxp02jhkBNFdDwbbmvHVPlb4f1m8KJLrjuJ5lUoZBb3AruOqHHFQmZq
	ysLv9ljElgo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F15EC469DF;
	Mon, 14 Mar 2016 03:01:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6F6F5469DE;
	Mon, 14 Mar 2016 03:01:08 -0400 (EDT)
In-Reply-To: <20160313211910.GA22052@ikke.info> (Kevin Daudt's message of
	"Sun, 13 Mar 2016 22:19:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 87195CF2-E9B2-11E5-92EC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288771>

Kevin Daudt <me@ikke.info> writes:

> On Mon, Mar 14, 2016 at 12:03:33AM +0530, Sidhant Sharma wrote:
>> 
>> 
>> 
>> Other than this, I also tried to expand the list of potentially destructive
>> commands and updated the list as follows (additions in brackets):
>> 
>> * git rebase [ git pull --rebase ]
>> * git reset --hard
>> * git clean -f
>> * git gc --prune=now --aggressive
>> * git push -f [ git push <remote> :<branch>, git push <remote> +<branch> ]
>> * [ git branch -D ]
>> 
>> Are these additions appropriate? What other commands should be included?
>
> git checkout [ref] <file> is destructive too if it would overwrite an
> uncomitted change.

Obviously.  As that was designed to be the way to get rid of
unsuccessful/unwanted edit in the working tree.

"git add <file>" is destructive if it overwrites the index entry
that holds contents you have not committed.

"git rm [--cached] <file>" is destructive, too.

I think "git checkout [<ref>] <file>" falls into the same category.
