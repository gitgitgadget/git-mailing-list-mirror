From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG environment variable
Date: Fri, 01 Apr 2016 08:35:48 -0700
Message-ID: <xmqqtwjljq97.fsf@gitster.mtv.corp.google.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 17:36:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am175-0007eQ-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 17:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbcDAPfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 11:35:52 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751313AbcDAPfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 11:35:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 589F04FBF7;
	Fri,  1 Apr 2016 11:35:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tU4Q7YRmGk2ZC2kmy0PXIpimZE4=; b=ra4/jl
	F46Yin3E8CQz0nhnefYK08KRYDS3uy6d4F4uAC32Mk2VHRQRt208RO5E5TNb19ve
	JTd8M8v9K3iPNyILHZmzJulZyeNlSbzS5HhOQPajyErQot6sckpdIe4o3tToCPRo
	2Z9uhKp3KHB4xCNLTY8mEDJpa5VQtLqZpHsl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NhUK6FpByw56tlwvXfdgWBClNSZtClC1
	t0hC2LAXASh7UaF2N0kKHnNyC/88fBnn+hfrGqdtJ2ykPrXRKYlzj/OxGYfrsFGj
	/PfeyiKqpl7Gbjws/Ipg0sL/mcqBE/OmTmiQd1Kq6+sT0QVm2Qw+P4zu8GmEvSUH
	VZd8EUW2UA8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46DBA4FBF6;
	Fri,  1 Apr 2016 11:35:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B0AE74FBF5;
	Fri,  1 Apr 2016 11:35:49 -0400 (EDT)
In-Reply-To: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Fri, 1 Apr 2016 10:44:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69347A02-F81F-11E5-B61D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290546>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Implements the GIT_CURL_DEBUG environment variable to allow a greater
> degree of detail of GIT_CURL_VERBOSE, in particular the complete
> transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis.

My impression is that using GIT_TRACE_* is the more mainstream
trend, and it may be beneficial to work any new debugging aid like
this one to fit within that mechanism.

I am not saying new GIT_*_DEBUG is wrong.  I just wanted to make
sure you have considered doing this as a new trace in GIT_TRACE_*
family and rejected that apporach with a very good reason, in
which case that rationale deserves to be in the log message.
