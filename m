From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: add flag to skip "git reset --hard"
Date: Mon, 02 May 2016 12:58:26 -0700
Message-ID: <xmqqh9egs04d.fsf@gitster.mtv.corp.google.com>
References: <57267BBE.9010707@google.com>
	<xmqqeg9kti6x.fsf@gitster.mtv.corp.google.com>
	<5727A6DF.5020204@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tom Anderson <thomasanderson@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:58:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJzG-0003nJ-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbcEBT6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 15:58:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754649AbcEBT6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:58:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D6E117971;
	Mon,  2 May 2016 15:58:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHxO3NJvxh/3t6jGtR7tMVVPF38=; b=Jwm7wQ
	WfEr7AfUYcf7qQoKwNs1z6d/tqi2P+0p2eiIoHL+HXDlQbezDwZnNpF151rxPn0C
	vYyXTarP+mR53u3adwDXnTfCN5zICnispbvXc9EApK2X645l++KHDJ6W8i2CJfPc
	CxxyYOPtzXvGvI+a+lN3Zan99gFHwSrgvR2Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k66XNA92aEMCobP/+N/tBQPk6DQq7fNY
	IX72azzcFsZsgRjze6MD++ZNtbmxwCot+mk9sOONuUF5zeeIAJPQBy7B3Uy11xAU
	7OsqMmFe8eWZn9BI6jGOGJayoPE9Ze1YCa4WzNay4glrLE/TTk5EfID9eAranQsF
	iFol0J5Oy/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 05E7917970;
	Mon,  2 May 2016 15:58:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B2941796F;
	Mon,  2 May 2016 15:58:28 -0400 (EDT)
In-Reply-To: <5727A6DF.5020204@google.com> (Tom Anderson's message of "Mon, 2
	May 2016 12:13:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CEF7598-10A0-11E6-9E8C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293280>

Tom Anderson <thomasanderson@google.com> writes:

> Yes, but I like my stashes to be saved in the ref namespace.

Isn't that something you can do so yourself with store_stash?
