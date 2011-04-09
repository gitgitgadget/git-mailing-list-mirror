From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Sat, 09 Apr 2011 14:38:50 -0700
Message-ID: <7vk4f3yuj9.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org>
 <7vaag01gdl.fsf@alter.siamese.dyndns.org>
 <BANLkTimCbr+hnJNGWDBVbjZKEBDW1KR4=g@mail.gmail.com>
 <BANLkTik32jvmJOtFRB9+vCnd_NWC2ft1fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 23:39:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8fs7-00077A-9e
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 23:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab1DIVjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 17:39:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab1DIVjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 17:39:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA3F45093;
	Sat,  9 Apr 2011 17:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qTi8R1wGZ0Mp
	/Bep4OAVtwDYy/k=; b=ooLkfNtp3TK3OsYrmwk+x0ngQPiD8r6spNmoSajGOkqp
	YD146aD1uX0jMx68olnu0y63HnKt1hN11HtMgi72hJ5larhJVqeQI8kzc2kAItN9
	o1eUFFwj+yi6WASHNVDfZKiXwYSWnsF/rzEFHcUw3DZMLUcCpjNsfOUI9Jp5H6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w4Uvgj
	3KFt97v+dtmLkXo05GIGO6reZfZku9DIqh25zBuyGRrFa9lzk4x7wHqrztG5J7qK
	W353UlMPBPRhQq16JOpIzd03c0gI37/EN+ELXSnxYZHBW1b0uhde7nRxxLcCn3++
	M5hRme+5FRD3yLGULLL5QueFCfIseKINHWrAM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A53455092;
	Sat,  9 Apr 2011 17:40:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 55BB5508E; Sat,  9 Apr 2011
 17:40:49 -0400 (EDT)
In-Reply-To: <BANLkTik32jvmJOtFRB9+vCnd_NWC2ft1fA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 9 Apr 2011 18:24:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C1C71D4-62F2-11E0-84FE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171208>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Apr 9, 2011 at 11:58 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> On Sat, Apr 9, 2011 at 6:18 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Also make ':' without anything else to mean "there is no pathspec".=
 =C2=A0This
>>> would allow differences between "git log" and "git log ." run from =
the top
>>> level of the working tree (the latter simplifies no-op commits away=
 from
>>> the history) to be expressed from a subdirectory by saying "git log=
 :".
>>
>> The intention is good, but reality may need more work.
>
> Wait, what if I say "git grep -- : foo : bar"? I take it we should
> reject on this case?

The patch probably would stuff NULL, "foo", NULL, "bar" in the array, a=
nd
the first NULL would make the caller turn the array itself into NULL; i=
t
is a user error I didn't have to bother while the topic is still in a P=
oC
stage.
