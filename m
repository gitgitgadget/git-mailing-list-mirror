From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] shell helpers usage: always send help to stderr
Date: Mon, 02 May 2016 17:45:50 -0700
Message-ID: <xmqqlh3sotoh.fsf@gitster.mtv.corp.google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-5-git-send-email-sbeller@google.com>
	<xmqqtwigox9x.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka7uPxLKVU7Dn-4yHyN1BMgeG33_7LJDShF3UVjrT2fgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 02:46:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axOTQ-0002E2-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 02:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933429AbcECAp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 20:45:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932994AbcECApz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 20:45:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B29C18A7E;
	Mon,  2 May 2016 20:45:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8zC9E0jpeBdiaxBP1ZFUajm8Qh4=; b=b3nFvd
	R42B2weEFDKwqL4/X80Gk5nJf5zVWziIyJOFiMMy4ALIalqw+UqUi/rnbjjqxoX1
	lF/I8xYEeZOQDmCOFGAOsSCyUriarAmLwd/MBWFU4RedAWo8vaLKsZp3fWdE3Wlu
	d2oOGBSd4gLIri31Mvutpyv1yLTA81vAGHiPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b82vq/VGJIhDWRSty98V29Zd8255VIW7
	ccpTDcTymHqtvI/CeS1KhGmiaAtsztX86S9lMVMl12hdML8L07jSx4TWflKT7qGE
	wy9RDAu+P/s4+7aUKlCguJ5aL8bn9ECYpxfqHXYCP3QkejYnYOto3enfVx20Ph3D
	2zHZWu4yjhE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3284418A7D;
	Mon,  2 May 2016 20:45:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93DCB18A7C;
	Mon,  2 May 2016 20:45:52 -0400 (EDT)
In-Reply-To: <CAGZ79ka7uPxLKVU7Dn-4yHyN1BMgeG33_7LJDShF3UVjrT2fgQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 2 May 2016 16:44:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6342D87A-10C8-11E6-A6B9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293314>

Stefan Beller <sbeller@google.com> writes:

>     git --help |grep pull
>
> instead of
>
>     git --help 2>&1 |grep pull

Not just that.  It makes me sad that it is unpredictable which
stream a project happens to have chosen to send its help text and I
end up almost always doing

    random-command --help 2>&1 | less
