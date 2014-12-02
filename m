From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked out elsewhere
Date: Tue, 02 Dec 2014 09:30:22 -0800
Message-ID: <xmqq4mtem029.fsf@gitster.dls.corp.google.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
	<1417335899-27307-25-git-send-email-pclouds@gmail.com>
	<547B5170.6050206@gmail.com> <20141201103818.GA20429@lanh>
	<xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
	<547D487B.4040502@gmail.com>
	<CACsJy8DjbgNpbf9Z-OVCpv+YNmvsuHfcPW_Jfm3_gbq2VgYgkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrHT-0000oy-Vs
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbaLBRa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:30:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932236AbaLBRaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:30:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E6672373C;
	Tue,  2 Dec 2014 12:30:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jbF0EckPks40pMs6XMlXmQgxbQU=; b=ThW2XL
	doShyq13Maj/aA3P3YZtmV5Bwub/q/Fuby2ejA54MGlp3Ek5udd9v+B50R1XlxJ/
	DpuoAwWB/1wXyWUAgotD8+39o9zfIUOO9+mN3h48fXqzS+rcLK1qvOchO8OCmKQw
	f11GM14X9DnWYKikMvUqYniaVbnWhtznxaHpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oqu6ilmBdPPPGqidjKOJF4vux407vJVP
	QRhKZ1lARVBbxlr5v5IMJiVuJMZrMLTJRN/zwEwVm8HEGm+wTiQHYZ5Ef9uu4bHd
	CNZTkPgA5K2woZyEagi+17cwi8gOvTSIN8iizcc7XeTfnhi1n1eo/URVQflVnwbP
	fHmRviGxCIU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 332152373B;
	Tue,  2 Dec 2014 12:30:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A72BD23739;
	Tue,  2 Dec 2014 12:30:23 -0500 (EST)
In-Reply-To: <CACsJy8DjbgNpbf9Z-OVCpv+YNmvsuHfcPW_Jfm3_gbq2VgYgkQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 2 Dec 2014 19:01:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5A47908-7A48-11E4-852C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260583>

Duy Nguyen <pclouds@gmail.com> writes:

> FWIW git-branch usually can show the original branch of detached head
> (must not always). I don't think we have a plumbing equivalent for it
> though. People can "tail -1 $GIT_DIR/logs/HEAD| sed .." but that seems
> hacky.

@{-1}, i.e. "the last branch I checked out"?

> I do like "read-only" ref concept where we can keep ref name
> (especially tags) in HEAD until the next commit. But it didn't go
> anywhere

Remind me.  That sounds somewhat interesting.
