From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Port `git submodule init` from shell to C
Date: Tue, 12 Apr 2016 18:41:27 -0700
Message-ID: <xmqqr3eal1yw.fsf@gitster.mtv.corp.google.com>
References: <1460506710-23994-1-git-send-email-sbeller@google.com>
	<xmqqh9f6mi9n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:41:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9oF-000136-7u
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747AbcDMBlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:41:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757523AbcDMBl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:41:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1CD9558C3;
	Tue, 12 Apr 2016 21:41:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+HndJVoYEA35OuVAxqBYLW8V4bo=; b=BMnxbI
	896oc7nzli0YzPwYDaLXuo8NEEv79w4yCpc696cnKSbRoisB8dP2v+Up9aHQeqd/
	1e4D4fMWcEZ58PXco/TurMGskhb3X/fxdta13a2qOZ0mOGpRDzlMsWSzt6gGbdGD
	2Vbf+XBLI71JhdGrOAeKplPImkR8W04zApzLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n017Q/xLnehTcJz5pOvmYTmkgJQeCHmg
	GOayQq1LcJ/KThHbVAjMXfVhmoJ1EVkWPkJneeogaSZz8oLaNlgG5/l7XylT4SQG
	r70+zlvRwBez3Zqr3l99S6rvYzyJGNOBlweoO3+19mBg5MzbIrmglm35nykgD989
	1ntNLX7wP2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E21F2558C2;
	Tue, 12 Apr 2016 21:41:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 55C1A558C1;
	Tue, 12 Apr 2016 21:41:28 -0400 (EDT)
In-Reply-To: <xmqqh9f6mi9n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Apr 2016 18:04:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D741E604-0118-11E6-AE39-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291363>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> This is a resend of origin/sb/submodule-init (and it still applies on 
>> top of submodule-parallel-update)
>
> Resend, or update?  There was some overlap with your recent series
> that fixes "prefix" thing, IIRC.

I've queued one possible resolution on 'pu' and pushed the result
out.  It sends $sm_path to the "helper init", but I think the
implementation of "helper init" now needs to do the equivalent of
"displaypath=$prefix$sm_path" that was done in your prefix fix
series, or something like that.
