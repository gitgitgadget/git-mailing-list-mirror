From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] glossary: extend "detached HEAD" description
Date: Wed, 10 Apr 2013 07:45:14 -0700
Message-ID: <7vfvyyo35x.fsf@alter.siamese.dyndns.org>
References: <7vwqshc8ec.fsf@alter.siamese.dyndns.org>
 <5165623C.703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 16:45:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPwH7-0000iL-2N
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 16:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936574Ab3DJOpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 10:45:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936388Ab3DJOpT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 10:45:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A387F12D89;
	Wed, 10 Apr 2013 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C90j0ROjpES3
	WpbQmcVfkbl7n4Y=; b=LkXgM0Ss2j4ghDVk+/DMaVe5SwGfRrXaJRgd6rz+yblS
	KqF5G+/P1nX8XaXyG93ySkI0t26AFlCjGoz9Mw1Q2tL7U4U5ueONCKNwkCtB0pAf
	NwH44jZroloKqy+gK1rL1zNAPAcPa5EXWAzfwwGAc14uFTmitc5xs0eXiuj4L2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=atv1iM
	ICqZnF4116yuYuJ4M2bbMyGi/RzO8qr2KyXRXLT6judm4wyTre1XjzHlE+ANwNHT
	5ndp+2INieZ54bntkOmZpt+EfxbZgD3axkZUK/lEwlNlaBp8hpsifwQy7GDbNi50
	d3MNz0aNkbmLlVcXiQGjqdNTTrA9t66GYnvdg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9872D12D88;
	Wed, 10 Apr 2013 14:45:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5E3E12D87; Wed, 10 Apr
 2013 14:45:16 +0000 (UTC)
In-Reply-To: <5165623C.703@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski=22's?=
 message of "Wed, 10 Apr 2013 14:59:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42757000-A1ED-11E2-B63A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220693>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glos=
sary-content.txt
>> index f928b57..69c90d1 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -100,9 +100,22 @@ to point at the new commit.
>> =20
>>  [[def_detached_HEAD]]detached HEAD::
>>  	Normally the <<def_HEAD,HEAD>> stores the name of a
>> -	<<def_branch,branch>>.  However, git also allows you to <<def_chec=
kout,check out>>
>> -	an arbitrary <<def_commit,commit>> that isn't necessarily the tip =
of any
>> -	particular branch.  In this case HEAD is said to be "detached".
>> +	<<def_branch,branch>>, and commands that operate on the
>> +	history HEAD represents operate on the history leading to the
>> +	tip of the branch the HEAD points at.  However, Git also
>> +	allows you to <<def_checkout,check out>> an arbitrary
>> +	<<def_commit,commit>> that isn't necessarily the tip of any
>> +	particular branch.  The HEAD in such a state is called
>> +	"detached".
>
> Should we also add that "git branch" output shows this situation
> as "(no branch)"?
>
> Nb. this is not documented in git-branch(1) manpage either...

Sounds good. Please make it so, perhaps for both.

Thanks.
