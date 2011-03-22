From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 10:25:58 -0700
Message-ID: <7vsjufkqxl.fsf@alter.siamese.dyndns.org>
References: <4D871972.7080008@elegosoft.com>
 <7vhbawno11.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1103212302000.1561@bonsai2>
 <7v4o6vmvzs.fsf@alter.siamese.dyndns.org> <20110322085027.GF14520@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:26:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q25Ln-00030H-C3
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 18:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab1CVR0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 13:26:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449Ab1CVR03 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 13:26:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD93B45B0;
	Tue, 22 Mar 2011 13:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U3Jz6Kba+r27
	qJOXwjVA2WzZVto=; b=IMA1/GgsR6aSnavh3VQr4NY3xTCsp9OOSnJjX+Elxrzg
	tHOquFNOD60pGtvnpzzbi8lIY9RKIznFLNDxVbD8oKaHcfRbdPRKh6V+D+ZrJHdf
	ZxPd6f7kH1npBckgX6+kWzOVXWqDiJeqDKqFt6I+s/d247SNpXGytDkvuNMnxh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h0G6Pa
	6QSqqz3jxypwhnGK72S4V8Bb8KPt6Ma5PyADGN8HG87DlfF9P1j4/Dkw9Jg0rBZ7
	TlfUhCR5nwhP3jXghOQvYOH/M/HNPdqRVyIgnBWv7JARhYX4thg4FbUQ9i0iyC/r
	fFi8dteyYML0OblI23eLNSkEN+7ZqYnnhLVWA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 324AD45AB;
	Tue, 22 Mar 2011 13:27:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6A16045A6; Tue, 22 Mar 2011
 13:27:39 -0400 (EDT)
In-Reply-To: <20110322085027.GF14520@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bo?=
 =?utf-8?Q?r=22's?= message of "Tue, 22 Mar 2011 09:50:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7D112C0-54A9-11E0-8D03-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169750>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I think this is not necessary.  We already run __git_aliases() every
> time after 'git <TAB>', and it was not an issue so far.

If we allow that line of reasoning, the cached $__git_all_commands that
can go stale needs to be removed, no?  I think folks running bash on
windows wanted it and it would be helping them.

One valid looking argument against caching aliases but still caching
commands is that the former could change on the end user's whim while t=
he
latter is more or less stable across releases, but people can throw the=
ir
own "git-frotz" in their path and run it as "git frotz", so that is not
entirely a valid argument, either.
