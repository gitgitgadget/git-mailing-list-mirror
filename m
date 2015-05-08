From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 08 May 2015 10:31:32 -0700
Message-ID: <xmqq7fsjm0wb.fsf@gitster.dls.corp.google.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOLhkTMWDr+eOsb5H8YiC1b7Nk0OKTSfi02ocr1unwFjfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:31:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqm7f-00083r-Q7
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbbEHRbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:31:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753309AbbEHRbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:31:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 003944E430;
	Fri,  8 May 2015 13:31:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bb+gnVN1IEekBmgaKafUNcXUGcE=; b=Lz/lfm
	4hSoKkYQTTxp9M6xFZ+HH5JTYWjlQnymXT6UuGYiQ1esHaO10JuZrVFHHlvRsZwC
	QuJW7ixdWxzZVOC5nZDSY42S6YATE6eXyknBmVuB9DQ+YCEMOau4GNItSLNis8gE
	/rxwYsHGFe93Na1QLze1XbRAGRHkJLmG6Owtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QU+LjazYkEgTggr27pWoBOJPm/vqKOMf
	+G3b4HdMbWjSzuHWgWJ2emvFhU81gJVhYrzWgZfctjq/6JKJCN5omxoPfMuCfxwC
	SM9SYNmfh0UKoo0DJym+lqEDLUyI0bmuvzl1Wk4UqD7rGYxgYx4PaVOhSOSUqNab
	HWKfc6EJmYw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBC074E42F;
	Fri,  8 May 2015 13:31:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 728CB4E42D;
	Fri,  8 May 2015 13:31:33 -0400 (EDT)
In-Reply-To: <CAN0XMOLhkTMWDr+eOsb5H8YiC1b7Nk0OKTSfi02ocr1unwFjfw@mail.gmail.com>
	(Ralf Thielow's message of "Fri, 8 May 2015 19:26:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 121841C4-F5A8-11E4-B3AE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268630>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>>         error(_("-m option was given for non-merge commit '%s'", ...);
>
> The %s can be placed to somewhere else in translations.

That is true for all the messages, and is something the l10n people
need to be aware of.

We've seen those who are careful to keep '%s' for longer strings
(e.g. end-user controlled ones strings) at the end for this exact
reason. I do not offhand recall if there were cases where we
committed one version that had %s in the middle and then fixed
later to change that message in a separate commit, but there were
cases where earlier messages with %s in the middle were fixed for
this exact reason in their rerolls.
