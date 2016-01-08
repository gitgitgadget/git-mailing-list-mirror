From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "dir.c: don't exclude whole dir prematurely if neg pattern may match"
Date: Fri, 08 Jan 2016 11:52:57 -0800
Message-ID: <xmqqlh7z26hy.fsf@gitster.mtv.corp.google.com>
References: <1452254725-22314-1-git-send-email-pclouds@gmail.com>
	<CACsJy8Bg+xnKxkq8-Da4-GKUWAOjGB6xyya+zzydhMWBEPPT8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 20:53:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHd60-0002eO-B5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 20:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbcAHTxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2016 14:53:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933094AbcAHTxA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2016 14:53:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC2DE3ABE0;
	Fri,  8 Jan 2016 14:52:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l9hKm0YTI821
	4U35NwoqukfPjks=; b=RL+U6y64ssWWO2sC7hE0O+VXWZboL5hmTPooS3Qg+ypY
	/bjCuqWB2spqNt8Bt79D+tm3KkcarWPG1al8w84S7rOSE0JEc+UDnxAOqsQ3mQc9
	mSw1cfRcpIzI/yHy8nJpTsDheAfK72/fHBZiQtkUzLa0PSoZJ/uORfhZR3wXToY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=k5P8yU
	VxGJLl41FVKnmpnR7YKLVXmWV4NLCuk0C4EptBlwCI0lTPVDyfb3FKFjTVJZXcyt
	0YpPWBNuLzTIshYNhxkOZIyrvjVdh52D0O+xie/bl6eveqpw23ck1sQ7IZG5NyGk
	FYFCKfdP/ZPGzvNgWl9fFSe20dAdASwXiJVSs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A37F83ABDF;
	Fri,  8 Jan 2016 14:52:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 215863ABDE;
	Fri,  8 Jan 2016 14:52:59 -0500 (EST)
In-Reply-To: <CACsJy8Bg+xnKxkq8-Da4-GKUWAOjGB6xyya+zzydhMWBEPPT8g@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 8 Jan 2016 19:12:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B26814A-B641-11E5-A409-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283579>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jan 8, 2016 at 7:05 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> patterns are too loose. The untracked listing and sparse-checkout
>> selection can become incorrect as a result.
>
> These two lines should be this instead if you want to keep track of
> problem references. I amended the commit then forgot to format-patch
> again.
>
> patterns are too loose. The untracked listing [1] and sparse-checkout
> selection [2] can become incorrect as a result.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/283520
> [2] http://article.gmane.org/gmane.comp.version-control.git/283532

Thanks.  I guess we need a 2.7.1 relatively soon now.
