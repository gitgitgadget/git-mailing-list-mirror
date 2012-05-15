From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: clarify the referent of dcommit's optional
 argument
Date: Tue, 15 May 2012 08:22:49 -0700
Message-ID: <7vliktfoza.fsf@alter.siamese.dyndns.org>
References: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
 <CAH3Anroxjn6sCBYa71Y-H1AvitiFn=dRUapGxgQ1Nu6=Tf03Uw@mail.gmail.com>
 <7vr4umivr2.fsf@alter.siamese.dyndns.org>
 <CAH3Anrr11eLiHkasdLxAWD9--B6QNq5-kFfO+Xg1F5xTDS56zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net, trast@student.ethz.ch
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 17:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUJaX-0001SK-6y
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 17:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048Ab2EOPW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 11:22:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964963Ab2EOPWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 11:22:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1726F6CF0;
	Tue, 15 May 2012 11:22:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IH3JR5BmsQ85tny4jTyRqRh7Q7k=; b=MD3myM
	WxFqnQSmTUrUDm7RVJ473/fBOLC0H+AzjesLz96JRIRYX3+puq4VxDXEY4AYNdou
	e4pNoeIidglB7EtV7jvp2dS0MZXv8xGO7+78oQlT9+e8zMA7NpwQLXyZWCk7H6gt
	aFpSinwYnpJJZ272slKhod3uajdb02T3eNUkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZEQ0IHB8IIXK8hm5GyX0oC4b2vs/ClJP
	zbr+oUwsfQ6FnECEHdh6cNSk9FWdHt4s2V5/vz1fEI7o5eQ2e1GERbPqj/twfwE3
	+rfhtaGub/aIgc0/Vu8M+9q5VqT0n+zJx3PI4KtllXFwWpMMmPToxbXJiKSi/fsb
	wih8TTR2gmY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EB906CEE;
	Tue, 15 May 2012 11:22:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF4606CED; Tue, 15 May 2012
 11:22:50 -0400 (EDT)
In-Reply-To: <CAH3Anrr11eLiHkasdLxAWD9--B6QNq5-kFfO+Xg1F5xTDS56zg@mail.gmail.com> (Jon
 Seymour's message of "Tue, 15 May 2012 21:15:21 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5A72B34-9EA1-11E1-BE09-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197837>

Jon Seymour <jon.seymour@gmail.com> writes:

> On Tue, May 15, 2012 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The only reason why the original is not ordered that way, as far as I can
>> tell, is because "It is recommended that" was part of an existing paragraph
>> when dd31da2 (git-svn: allow dcommit to take an alternate head, 2006-12-12)
>> added "An optional ...", so it was tucked after existing paragraph without
>> reading the resulting whole to see if "at the very end" was the best place.
>
> Re-reading this, I don't think the advice:
>
>     "It is recommended that you run 'git svn' fetch and rebase (not
>     pull or merge) your commits against the latest changes in the =C2=A0SVN
>     repository."
>
> really belongs in the description of dcommit at all.

I tend to agree.  Opinions from git-svn experts?
