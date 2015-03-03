From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] commit/status: show the index-worktree diff with -v -v
Date: Tue, 03 Mar 2015 13:26:57 -0800
Message-ID: <xmqqmw3tai1q.fsf@gitster.dls.corp.google.com>
References: <54B8C82E.8000707@drmicha.warpmail.net>
	<33591b47a7ea8cfa23a3bee05fbf8c0ce4a00b3d.1425390756.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:27:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSuLV-0001dL-LL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 22:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbbCCV1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 16:27:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754821AbbCCV1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 16:27:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B81C83DE3E;
	Tue,  3 Mar 2015 16:27:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r8QeHL8ZezraUzvZmGlSSpAT9+c=; b=XHXyTU
	S+Bg4D6McbzU0KgemmzQvTcxNwfzs1SUBfq4FU91e/0DjUWBWgYSllBhInMpqREP
	ukHFEXdKGNOppM8egZh/GXqUnVE++o+f5D2Tc2i1wAl1kOppLs5ynBLAbw19eyr1
	97o4xRMJMfrCGJLJpxck+gMPBM9N9YnnDBIuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WrZm4VzVuc9FWKp3qkDqL/nb6GPlwMSK
	4f8fYYuyR122yKIeBVbtdFFFymRaQrilQ1eS14f5cOFxODVKzTNHtl3fmxez4TEK
	2EHQepc246DVAVTa6EwlM2uTNAD3B0lvYkdg+Fj5RZONcB46HONn5Xo9NSE2hFW6
	hJ08UwQdKK4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADB193DE3D;
	Tue,  3 Mar 2015 16:27:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02A543DE39;
	Tue,  3 Mar 2015 16:26:59 -0500 (EST)
In-Reply-To: <33591b47a7ea8cfa23a3bee05fbf8c0ce4a00b3d.1425390756.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 3 Mar 2015 15:16:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 06E87ADE-C1EC-11E4-8CCC-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264692>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> +diff --git INDEX=staged-for-commit/dir1/modified WORKTREE=not-staged-for-commit/dir1/modified
> +index e69de29..d00491f 100644
> +--- INDEX=staged-for-commit/dir1/modified
> ++++ WORKTREE=not-staged-for-commit/dir1/modified

This might be OK for a project like Git itself, but I suspect people
with long pathnames (like, eh, those in Java land) would not
appreciate it.

Wouldn't mnemonic prefix, which the users are already familiar with,
be the most suitable tool for this disambiguation?  After all that
was what it was invented for 8 years ago.
