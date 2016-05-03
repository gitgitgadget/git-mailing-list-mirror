From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] preparatory patches for the submodule groups
Date: Tue, 03 May 2016 15:24:41 -0700
Message-ID: <xmqq7ffalqza.fsf@gitster.mtv.corp.google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kakayOhPkCK4hbRkj-h2Bt+PqD69EgHk-chbu4xCA8_pA@mail.gmail.com>
	<xmqqoa8mlutg.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbm5y+LeyA_dwQWKFNaa42280cOvwQYZTP=-aRnySsB1A@mail.gmail.com>
	<xmqqfutylte1.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZK_EtwBps3hcYVkRat2XbpXXXdXkQDrB281rxkedjaGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:25:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axikc-0004bd-E1
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbcECWZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:25:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756788AbcECWYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:24:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F173B18D3E;
	Tue,  3 May 2016 18:24:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XPdC+CQPWlkAAG2F5gWoswRsc8o=; b=CFKS9w
	jNc2LaWD43AP26JPJ+Ysf6nvgMp/6I4Xn7X0jKycTwJO8r9ulG27gsE7z6QnrrYP
	ukPHxjC3s77Khwqz04gLODkf2A1ARuOpeQYvbnq3Tv/ppbUMTMjsd0g6hl4ft0g6
	MvaE4IJwNbDWJur3eQ35KHX+A1fS/eMO2yDOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YLXXbN2tKwG4qWNkHKCQG6hdY+TsMsMj
	8k6PKA8jwED64VFXgYh6WjoRqxCURcX1Uv1/I2xH9zuMzPKAvc/gZ9OoR0eB5XNa
	+N4YLkIjfUx96CoSkFrvNIxhHvUvDz2TtmZxJZuP7Z+4qW8rnXGa5ua8VySN3TBL
	I2WitloenOQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E98F218D3D;
	Tue,  3 May 2016 18:24:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33BD018D3C;
	Tue,  3 May 2016 18:24:43 -0400 (EDT)
In-Reply-To: <CAGZ79kZK_EtwBps3hcYVkRat2XbpXXXdXkQDrB281rxkedjaGA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 3 May 2016 14:57:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D585AAF6-117D-11E6-8888-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293467>

Stefan Beller <sbeller@google.com> writes:

>> I wouldn't be surprised if many people wished that "git branch" did
>> not list (and required "git branch -l" to list) to scroll everything
>> they are looking away but instead showed what the current branch is.
>
> Isn't that yet another more specialized mode of operation?

Yes.  It all boils down to "what is the most common thing people
would want" and "which one of these operation modes deserve the
short-hand".

Most often, the first one that gets invented ends up squatting on
the short-and-sweet "by default without parameter, we do this" slot,
and we have to let it squat forever due to backward compatibility.

I think "git branch" that shows all 300 branches is a good example
of that--if we didn't have command line prompt support, I am
reasonably sure that "git branch --current-branch" would have been
added by popular request long time ago, and that would be a more
common thing people would want than "git branch -l".  I would not be
surprised if in an alternative universe in which both "list" and
"tell me current" were available back when the "no option default"
had not been defined yet, we gave the shortest-and-sweetest to "git
branch ---current-branch".
