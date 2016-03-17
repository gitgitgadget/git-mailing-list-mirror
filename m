From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for the "Leftover Bits": rebase -x to imply -i
Date: Thu, 17 Mar 2016 00:31:34 -0700
Message-ID: <xmqqbn6d36i1.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
	<xmqqy49i2hhe.fsf@gitster.mtv.corp.google.com>
	<xmqqlh5i2g0y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZC0AAz=cm59ys1L_Axj1_HLvcTqrMrfNrOHoA3Ef7a5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:31:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agSPG-0000cc-Te
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 08:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbcCQHbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 03:31:39 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752954AbcCQHbi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 03:31:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D003C4414C;
	Thu, 17 Mar 2016 03:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rPGTePq4YlU4sMdWGr2hzLXn2rc=; b=MG25Q2
	oMG+Yqpo2Cvx9pbtkykzQ6U9YnDo8L0Fhnp4xyZ+xPnupgbjyOolxm0Oz75YrJ0a
	5XdDpjGwRrHv4lhqmVv2UlHICaEikobW+PkmySMYc2dWgO7smsArLaXa1sz/CpDL
	MW7PR/WBgOFBHtIBIla6vXjcEXy9oJ/EsiZro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m/anyQOPSPBG4nuRAOZDUfBDrMwhVdUR
	MyHpPnG+mO9sJwOkLIJ2HWd5y08ck1PPcry4/T8K1QuE+/9RNZsP9ciTbp6Q3WsE
	XBGJqTArqgIPFT1JEVS65MG3zRTuyfjD8lEYkXLHzxc1XT+wUmdyCeqzeSa7nrIj
	lEQugszZ6kY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C79B04414A;
	Thu, 17 Mar 2016 03:31:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E7FE44146;
	Thu, 17 Mar 2016 03:31:36 -0400 (EDT)
In-Reply-To: <CAGZ79kZC0AAz=cm59ys1L_Axj1_HLvcTqrMrfNrOHoA3Ef7a5A@mail.gmail.com>
	(Stefan Beller's message of "Wed, 16 Mar 2016 16:18:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47D49F9A-EC12-11E5-B5E4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289082>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Mar 16, 2016 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> A few "characteristics" of that list, that cannot be updated by
>> anybody but me (because it is just my personal collection after all)
>> are:
>>
>>  * I do not have to worry about useless new entries that do not
>>    align the overall system design getting added by clueless people.
>
> As it is your personall collection and you're the maintainer, I thought
> of this as a collection with maintainers blessing, i.e. if the code&tests
> are not too shoddy a patch will get accepted (read as: On that list there
> are no bullet points with fundamental design issues). Why would you
> add things to that list if you'd not agree with them?

If it was not clear, I didn't mean these three are all bad things.
In fact, this first of the three "characteristics" is a good thing.
Random people are not allowed to throw random things into it.

>>  * Adding new entry after scanning past list traffic and finding a
>>    still unresolved topic that "died down" is relatively easy.
>
> As the notes in Documentation/howto/maintain-git.txt indicate, you're
> scanning the list anyway, so offering help in this point may be moot.

The scanning of the list for new topics (to further discuss and pick
patches to queue) and the scanning of the list for "died down"
threads are two completely separate activities.  If somebody with
good taste can do the latter when I am too busy elsewhere by
pointing out "what happened to this thread?  It seems that nobody is
interested enough to pursue it right now, so perhaps it is a good
time to add it to 'leftover bits' list?", that would be helpful.

And as you agreed, pointing out "done" items to remove would also be
helpful.

Thanks.
