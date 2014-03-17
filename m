From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Mon, 17 Mar 2014 10:01:34 -0700
Message-ID: <xmqqha6wg3o1.fsf@gitster.dls.corp.google.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
	<53240C0F.2050204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 17 18:01:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPav3-0003k8-QA
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 18:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbaCQRBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 13:01:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771AbaCQRBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 13:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E298A73588;
	Mon, 17 Mar 2014 13:01:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hpNZF+SirxFZ
	zyjwkbq7yuC8wHQ=; b=ttEyqc5CRyVPhUBXo4l67xbRx1kLaazDkAfH6xQc9oxv
	SXATD3EcwZ7GKdGKtpZOzZB8zvTENI3UJhfhU3dGH4EoX+QvlbC5LVs/xsANWIrO
	PPzT+asacR58HURZDkT/c4C04Pcx+QLHI9nnMMik3d+Op0K/lPZgSQGVHSiczzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I5VI3i
	TaWNsRvhemI3nzkrOSbQ59m6Xy3XglWvKA4bFpNk/3iPZJvhHg0rzXL++kJ+06T3
	sObT+WSZZHUz/paM95XKgzVfVRIxUiQ5tSMn0pMgdJTCcsKePOlwFsqr9eYzfku7
	CghXckoiec0jkB9MOl2h8jp2GBX6Zc3pQkaRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFEBF7357E;
	Mon, 17 Mar 2014 13:01:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F7897357D;
	Mon, 17 Mar 2014 13:01:38 -0400 (EDT)
In-Reply-To: <53240C0F.2050204@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 15 Mar 2014 09:15:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CDBA8D84-ADF5-11E3-BE7A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244257>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-03-14 23.09, Junio C Hamano wrote:
>> * ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
>>  - remote-hg: do not fail on invalid bookmarks
>>=20
>>  Reported to break tests ($gmane/240005)
>>  Expecting a reroll.
> I wonder what should happen here.
> The change breaks all the tests in test-hg-hg-git.sh
> (And the breakage may prevent us from detecting other breakages)
>
> The ideal situation would be to have an extra test case for the probl=
em
> which we try to fix with this patch.
>
> Antoine, is there any way to make your problem reproducable ?
> And based on that, to make a patch which passes all test cases ?

After re-reading the thread briefly (there're just five messages)

  http://thread.gmane.org/gmane.comp.version-control.git/239797/focus=3D=
240069

I think the "breakage" the patch tries to fix seems to be of dubious
nature in the first place ("I don't know how I ended-up with such a
bookmark", Antoine says in $gmane/239800), and it has been in
"Expecting a reroll" state in response to "I will try to come-up
with an improved version" in $gmane/240069 but nothing has happened
for a few months.

At this point I think it would be OK for me to discard the topic
(without prejudice); if the root cause of the issue (if there is
one) and a proper fix is discovered in the future, the topic can
come back with a fresh patch, but it appears to me that keeping the
above patch in my tree would not help anybody.

Thanks.
