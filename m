From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2012, #04; Thu, 11)
Date: Fri, 12 Oct 2012 08:43:33 -0700
Message-ID: <7vy5jb4rx6.fsf@alter.siamese.dyndns.org>
References: <7vtxu061tf.fsf@alter.siamese.dyndns.org>
 <CACBZZX6pzeWBshrA17oyTte0ZfOBQaK1SvP07TnTN4=v5imsjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 17:43:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMhOu-0003OM-O8
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 17:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933822Ab2JLPni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 11:43:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933028Ab2JLPnh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 11:43:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D209E3C;
	Fri, 12 Oct 2012 11:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+xKUmZBHv+iC
	TfArTNP2Ekd86qc=; b=ehZng7P02P/xwqzv9kDikJz5vO1UdYfEqAZcKxujGaeF
	LpuEwHoBkmUKoQbYqiKFjjOTp4/T83Qt+RB1c2Lvn0lnznrrMXr4oWMcq/4krHIo
	35/1WDJAFdukumxmHTeKe6bKBeJHUhIFy4u7f1myfxb5nXPCAru1+LcwYMc0ruU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hNd9AX
	bvqXIvcTwOuMthN28BoSFUFdxm8C6ZabUc5vftx+OpWi1Oju+L0gnZCv3Ydt4R03
	lNNpv7AiKm8eR+uuiyspeHm07nUdCiiDvNO0y2Ba9Yw6gWbioSnGMgzpjx4pjK9m
	4xdGjl7nMwAypdGJMmm4sL9Ll94QBlsT9Z/D8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C56229E3B;
	Fri, 12 Oct 2012 11:43:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 199FA9E38; Fri, 12 Oct 2012
 11:43:35 -0400 (EDT)
In-Reply-To: <CACBZZX6pzeWBshrA17oyTte0ZfOBQaK1SvP07TnTN4=v5imsjw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 12 Oct
 2012 09:43:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95CE2852-1483-11E2-A77E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207549>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Oct 12, 2012 at 1:12 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
>> * jk/peel-ref (2012-10-04) 4 commits
>>   (merged to 'next' on 2012-10-08 at 4adfa2f)
>>  + upload-pack: use peel_ref for ref advertisements
>>  + peel_ref: check object type before loading
>>  + peel_ref: do not return a null sha1
>>  + peel_ref: use faster deref_tag_noverify
>>
>>  Speeds up "git upload-pack" (what is invoked by "git fetch" on the
>>  other side of the connection) by reducing the cost to advertise the
>>  branches and tags that are available in the repository.
>
> FWIW I have this deployed at work for a userbase of a few hundred
> users, none of whom have had any issues with it, it does speed things
> up a lot though.

Thanks.
