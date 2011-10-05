From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Bug report
Date: Wed, 05 Oct 2011 09:49:00 -0700
Message-ID: <7vlisz8jur.fsf@alter.siamese.dyndns.org>
References: <1317763443.17036.15.camel@skyplex>
 <20111005072235.GA12600@kolya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Federico Lucifredi <federico@canonical.com>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 18:49:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBUec-0000K3-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 18:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935046Ab1JEQtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 12:49:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934960Ab1JEQtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 12:49:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94B6C41BF;
	Wed,  5 Oct 2011 12:49:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q9xaDKQll1bcPzVhQht27Fkg9BA=; b=aUjMmE
	afC/yHI56pYqSPRuy9cFxsKeGz1+o7gCGG0j2lwEsW0q6kG/wVPM1jv0uGfAHcX5
	TLHGt0cTgnaQznSq38U9I/701U2YMiFDiSvxNO3WmmqgCzxDGXNzyFs9qhuiIYBG
	+YK878bqwzeNQu/JoO9SVAElVJJTr43J7sndI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iNk1jGxSlUrVtDFzFpYSxo3xeW0XaWf1
	4R6pvlVHkfPXHTCRg1NSgsW9kFzi3WaoKBDbBwk2yrYayrmwIgrsLzAyC8Bpo9/j
	t3QoIvBD7PBwESfHYvOOMO6KDsUCkY/Z+dsIw6EBYYVYnW/ecgS+fMvIHss9o9Co
	9w8ec9SUlWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7B441BE;
	Wed,  5 Oct 2011 12:49:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0747941BD; Wed,  5 Oct 2011
 12:49:01 -0400 (EDT)
In-Reply-To: <20111005072235.GA12600@kolya> (Fredrik Gustafsson's message of
 "Wed, 5 Oct 2011 09:22:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDC273AC-EF71-11E0-B52F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182861>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Tue, Oct 04, 2011 at 05:24:03PM -0400, Federico Lucifredi wrote:
>>  Found a minor bug in git today - the error message reported is not
>> correct when trying to access a repo that is not accessible
>> permission-wise:
>> 
>> > federico@skyplex:/etc$ git log
>> > fatal: Not a git repository (or any of the parent directories): .git
>> 
>> with correct access permissions, everything works as expected.
>
> So if:
> .git/ is a directory with not enought permissions.
> ../.git/ is a directory with enought permissions.
>
> git would today use ../.git. You suggest that git instead would die
> because a .git/ exists? (I'm not saying this is wrong or right).

For that matter, if you have .git/ that is a directory but is not a
repository, and ../.git/ that is, the same situation would arise. I do not
think we should die because .git/ is not a git repository. I do not know
if we should even warn about it.
