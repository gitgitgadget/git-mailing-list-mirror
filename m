From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git
 notes"
Date: Sat, 16 Apr 2011 10:42:36 -0700
Message-ID: <7vaafqay9f.fsf@alter.siamese.dyndns.org>
References: <4DA7F73B.9050007@gmail.com>
 <7v7have8wo.fsf@alter.siamese.dyndns.org> <4DA8862F.5070102@gmail.com>
 <BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
 <BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com>
 <7vk4eub1g9.fsf@alter.siamese.dyndns.org>
 <BANLkTim2=Jg4QcgKwO=J6343zWAoCkyXZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 19:42:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB9WH-0002RF-Tk
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 19:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab1DPRmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 13:42:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1DPRmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 13:42:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E563059F6;
	Sat, 16 Apr 2011 13:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yAMuDMm/jIJ5H3i15atgyfi1YFI=; b=KNk2x/
	LSGTi3LoqsqdpLF9MTD3HCNtmn8pO/K+iDC1Ohq2aARkmH0ttlkYbXPi3MvWDtNb
	T8Qq8j+xRUoYexKVbF0Ds6jsHacCP/7AUINAM3CRAF1bTZQqB1gT53LPlMqmR9QQ
	l8AsHRWe3sfRXBhWpPhNsxacppOkngMrs2axI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lY4/hwWaUYfa0tw+grUOD8MoenpBGGR8
	ANILZKrvLVM4MrI36VQJSxueQYNxmh1a4GXAvydBBHsMZUSp1TNSzzzQevA0YC97
	wFoZMzv+lriABq4RQZTn8ICu/3bs09SNZEAhEgAgdnmvyw+GYu1O7Or4N5KtcNTk
	aALgoqFQsCQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4E8859F2;
	Sat, 16 Apr 2011 13:44:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD21F59EE; Sat, 16 Apr 2011
 13:44:38 -0400 (EDT)
In-Reply-To: <BANLkTim2=Jg4QcgKwO=J6343zWAoCkyXZQ@mail.gmail.com> (Jay
 Soffian's message of "Sat, 16 Apr 2011 13:11:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35DFE05A-6851-11E0-AA81-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171687>

Jay Soffian <jaysoffian@gmail.com> writes:

> Disagree. Here was my thought process (it was a conscious decision):
> after conflict, when the user runs "git commit", the message is
> brought up in the editor, leaving it up to the user to decide whether
> it is appropriate to remove the "cherry-picked from" message. I
> personally think it is correct to keept it, along with the list of
> "Conflicts:".

I agree that the user can decide to remove that line in the editor when
the necessary conflict resolution was so extensive that the most part of
the original change became irrelevant.

It requires extra work that was unnecessary to the end user before the
series, and the series is a regression in that sense. But removing a
single extra line is much easier to do than adding the line from scratch,
so this particular potential regression is not really a big deal.
