From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #04; Thu, 20)
Date: Fri, 21 Mar 2014 14:33:32 -0700
Message-ID: <xmqqpplfs0cz.fsf@gitster.dls.corp.google.com>
References: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com>
	<532B659D.9010604@web.de>
	<xmqq38ibtgj1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Horn <max@quendi.de>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:33:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR74Q-0003vT-00
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbaCUVdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2014 17:33:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbaCUVdg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 17:33:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF747742B;
	Fri, 21 Mar 2014 17:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=87EsqTAHS/3l
	Jyoi1F+1sEMWSNI=; b=H65WPxDHgA2xZ/AYQJvAZp1RacOoxI/TaUNjIWVjRdt8
	7hdYsgS+ov5QtUI0Fu/wAL/1FcHXqdL5SabBh8EP0mokfJq0FEXi7buRPS7/dJQW
	IlquCqJ+lQvr1MJNNh1vDApFcXbvg9fDMDpr6+GXvzm2aYczgMobHb02/dZnL9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Let3uN
	5UyN5Xg8xZjEWunzJZkC7sEuvKvSy8+UgfunbpKOQp0ke/AA3xCABunRdoTVHONA
	U9nqGzdjXq3YA+1Nnkd8AK0RGuSCmO2FPnR5ohx+d3c6D/E951nJtWpIeEqLZY2b
	5ow9T0R+7UI4YGXd2MNrMblFp/Cp/mpGxTM28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99B357742A;
	Fri, 21 Mar 2014 17:33:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F126377429;
	Fri, 21 Mar 2014 17:33:34 -0400 (EDT)
In-Reply-To: <xmqq38ibtgj1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 21 Mar 2014 13:58:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74FCC65A-B140-11E3-BA4B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244754>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> On 03/20/2014 10:09 PM, Junio C Hamano wrote:
>>> * ap/remote-hg-skip-null-bookmarks (2014-03-19) 1 commit
>>>   - remote-hg: do not fail on invalid bookmarks
>>>
>>>   Will merge to 'next'.
>> Hmm, am I the only one who has 11 failures in test-hg-hg-git.sh,
>> like this:
>> (Tested under Debian 7, commit 04570b241ddb53ad2f355977bae541bd7ff32=
af5)
>>
>>
>>
>> master cde5672] clear executable bit
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>  mode change 100755 =3D> 100644 alpha
>> WARNING: Ignoring invalid bookmark 'master'
>> To hg::../hgrepo-git
>>  ! [remote rejected] master -> master
>> error: failed to push some refs to 'hg::../hgrepo-git'
>> not ok 1 - executable bit
>> []
>> # failed 11 among 11 test(s)
>> 1..11
>
> This has again been replaced; I'll queue it as d06f17f8 (remote-hg:
> do not fail on invalid bookmarks, 2014-03-21) on 'pu'.
>
> Please holler if this still breaks for you.
>
> Thanks.

Ah, you seem to have sent a good review on that patch while I was
looking at other topics ;-)  And they all make sense, I think.

Thanks.
