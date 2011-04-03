From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/51] i18n: Shell script translations
Date: Sun, 03 Apr 2011 12:05:35 -0700
Message-ID: <7vhbafcg00.fsf@alter.siamese.dyndns.org>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:05:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6ScP-0004nW-RA
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab1DCTFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 15:05:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab1DCTFo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 15:05:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AE0B417D;
	Sun,  3 Apr 2011 15:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=o7GW+L0qEJRuYV7Zyfssw8aqb
	6s=; b=Djuu+RvtTZhkFs1z3jv4uDr7r03vnXk+6WVoVUYikw1XnpxBC9/yPifyr
	uRb6A6gwFd7zV7zWq9pki4ZzzO64ezOhIneHi72kWw1ZbKgFbfHAA2sky1dzm6EF
	dKBtZqmGCmd4XZNYa4GZZKN+3+tOtIpne8nQIyNyS08VLOI4w8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=YT0EXiM1TQE22nRz84q
	ybMO65DhlNDR0hzcGuAEgUf5pkRh3hf3Ir5Do0nEkNSy/Xq4cKSK4UCgliZNOj4g
	BGkEGWllCBLnyFOYaigcKpoue0kC6C7UTpmqvElSH1JAOSLnH1DltVhScS3SXz6a
	VkiAcKWH5HKZO9XTfYFY33l8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F8B54176;
	Sun,  3 Apr 2011 15:07:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 342A54175; Sun,  3 Apr 2011
 15:07:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0728C0A-5E25-11E0-8CD2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170771>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Following the "i18n: Shell script translation infrastructure"
> series. These are the actual shell script translations. Together thes=
e
> series add up to everything from:
>
>     git://github.com/avar/git.git ab/i18n-sh-only

I am obviously not going to queue these patches right at this moment, b=
ut
people with topics in flight or in their head need to take a look at th=
e
parts of this series that may overlap with what they are touching, and
plan to rebase their work when the time comes.

What is more urgent at this moment in this cycle is to catch and adjust
the fallouts from the merges of topics that started before ab/i18n topi=
c.
You caught one in t2019 that didn't mark a test that examines the outpu=
t
for a translatable string with C_LOCALE_OUTPUT (as there was no such th=
ing
when the topic started).

There may be other similar adjustments that are needed in tests, and al=
so
I suspect there are messages that are not marked with the _() markers t=
hat
came from other topics.  Because we shouldn't see too many new messages=
 in
the code appearing from now on until 1.7.5 final, this is a perfect tim=
e
to catch and adjust these kinds of issues.

Thanks.
