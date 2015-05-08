From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 08 May 2015 11:53:34 -0700
Message-ID: <xmqqlhgylx3l.fsf@gitster.dls.corp.google.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<xmqqegmucqyh.fsf@gitster.dls.corp.google.com>
	<554CF9A4.4050103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:53:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnP3-0001ta-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbbEHSxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 14:53:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbbEHSxg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 14:53:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7AF64E150;
	Fri,  8 May 2015 14:53:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pspI4LVOpsrb
	NBFCKVKxpPVy1sE=; b=DhrEROjdq+QIW7SRx3JqplMB9s52cMBqSgMMcUdF0gq2
	IkzJQTgqm45XsuxKWD7E3ECWjeuHHZ48Nz7NBjxE2pLFWVwFb8J+7GX4UCmGEuRs
	8BLREDniad3oXk05vdkZawFPyPaHMrvvT++QbFQC3QPFy05ujsbbSnGq7vECuoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aZXFWP
	CqqB0M30cxRTNLBIBpkdZPTdz6zC4JSgsP7Z1FhAgCTS2tsgAbcqAg6H/E5nZ0Ki
	vDlceKBuHAHkzGjPf11uBK/20aVAUzrB0BVXQjKyNa8BflPVcdpNttxb3xlwbBQ3
	f5r21+4JuC1M4TBRYccyYyKkwK/GWd+5YV2ZU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C02304E14F;
	Fri,  8 May 2015 14:53:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EE5D4E14E;
	Fri,  8 May 2015 14:53:35 -0400 (EDT)
In-Reply-To: <554CF9A4.4050103@gmail.com> (=?utf-8?Q?=22S=C3=A9bastien?=
 Guimmara"'s message of
	"Fri, 08 May 2015 20:00:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 87B594C6-F5B3-11E4-AB4F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268644>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> A preliminary question to prepare the next round (v5) of this patch:
>
> All versions of these patches were based upon the tip of 'master' 2.4=
=2E0
> (3d4a3ff).
>
> Should I rebase subsequent patches on top of 'next' ?

I think doing it on 2.4.0 is fine.

In general, you shouldn't base anything on 'next', unless you are
using some new features that are still cooking in 'next' on their
own topic branches.  And even if that were the case, I would prefer
a series that introduces a new feature to wait for those other topic
branches it wants to use to graduate to 'master'.  Alternatively,
you can identify these still-in-flight topics that you absolutely
need to depend on, merge them to 'master' yourself, _and_ build your
patches on top, but please make it clear that you did that when
sending the patches in if you take this route.  Your patches would
become hostage of these other topics and cannot graduate to 'master'
before they do, so keep that in mind if you do so.

Whatever you do, you would still need to make sure that the result
of applying your patches merges cleanly to 'next' and works well.

Needless to say, a fix is preferrable to be based on 'maint' (or
even older maintenance tracks when it is feasible), but that does
not concern this "update help output" topic.

Thanks.
