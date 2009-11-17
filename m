From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 15:40:47 -0800
Message-ID: <7v6398btz4.fsf@alter.siamese.dyndns.org>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
 <7vhbssewm7.fsf@alter.siamese.dyndns.org>
 <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
 <7vd43gerak.fsf@alter.siamese.dyndns.org>
 <7fce93be0911171454i61e995a1ob0bf80013bcb0727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:41:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAXfb-0000S1-Aj
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 00:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288AbZKQXky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 18:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756217AbZKQXky
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 18:40:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbZKQXkx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 18:40:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17B9E9F122;
	Tue, 17 Nov 2009 18:40:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=B59xoSQdMDzf
	twOmGFRiXJ9FUy8=; b=ryQQ9chBAmxRGnRh3/XAzHRR+s66NzEcwRVFYI4EIf3u
	aAuya5grmS3p+v8FC92TP02VPq8H3Bx/BGcbBkWsWiouFHfYjzrY3D/+K5xuUxzz
	S6hlGapaRAZi6wi2cSLmYlgYUg4AaPdTwnzm6B14Kw6oyLmABCqBc/og6QMuZog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CPmkAX
	+v2B+lxrbC9JTePQ8EsknPjt3ZCe23eo+bR+Jbu0rb5iLUxKY26Lb6J8sYFSolYf
	/3AzzeqJBX2av6oJk44/Ez4/dXysOxLeZLcNvOXY3M38Zf+0+cTlmYIcrzQzb9v3
	wO+JIUo+IF18RYkep4aTWVotbPeGFufPEgTWc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEBD39F121;
	Tue, 17 Nov 2009 18:40:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 259E39F120; Tue, 17 Nov 2009
 18:40:48 -0500 (EST)
In-Reply-To: <7fce93be0911171454i61e995a1ob0bf80013bcb0727@mail.gmail.com>
 (Sylvain Rabot's message of "Tue\, 17 Nov 2009 23\:54\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5EC09D8-D3D2-11DE-A479-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133111>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> On Tue, Nov 17, 2009 at 23:10, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Sylvain Rabot <sylvain@abstraction.fr> writes:
>>
>>>> Wouldn't it be a good idea to somehow make this work well together=
 with
>>>> the --user-path feature of git-daemon?
>>>>
>>>> Perhaps the recommended name given in the example shouldn't be ~/g=
itweb,
>>>> but more like ~/public_git, as this is like ~/public_html but for =
git
>>>> repositories. =C2=A0Then the end users will browse
>>>
>>> As I said, it's configuration :)
>>
>> Wrong answer.
>
> Am I passing a test ?

Sorry, but that wasn't what I meant.

>> Exactly because it is configurable, the document that outlines the
>> recommended practice should suggest the best convention. =C2=A0My po=
int was
>> that it is likely to be tied to "git"-ness of the specified director=
y
>> under $HOME/, not limited to "gitweb"-ness, and it is wrong to recom=
mend a
>> name tied to "gitweb"-ness in this document.
>
> Again, git is a brand new world for me and I don't know any of his
> conventions yet.

I do not see this as git-specific conventions.

But suggesting ~/gitweb is perfectly excusable, especially if you did n=
ot
know that git-daemon can respond to "git://host/~user/".

John warthog19 (hmm, I thought he used to be warthog9) explained the ab=
ove
much better than I did.  People tend to cut and paste without thinking,=
 so
we should describe a good default layout in our documentation.

> I am not trying to impose my own conventions, I am just proposing an =
idea.

Yeah, I know.  We are all in this to improve things for people who foll=
ow
us.
