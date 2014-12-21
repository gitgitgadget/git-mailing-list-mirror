From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH w/signoff] pre-push.sample: Remove unwanted `IFS=' '`.
Date: Sun, 21 Dec 2014 14:49:53 -0800
Message-ID: <xmqqlhm0botq.fsf@gitster.dls.corp.google.com>
References: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
	<1419186337-20348-1-git-send-email-gjthill@gmail.com>
	<xmqqtx0obzwm.fsf@gitster.dls.corp.google.com>
	<CAEE75_0Ff7NfQYUPrA414N9E0AE6LsS2zs0kL=BJ25bjPgom_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:50:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2pK4-0007at-Sf
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 23:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbaLUWt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 17:49:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752886AbaLUWt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 17:49:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 930A626104;
	Sun, 21 Dec 2014 17:49:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0tjO6Thdm7WeGUhGtmVlmoGcizk=; b=fnIJFM
	BXhv44rHhIu2++6KxKYnQpMc9m3ekFxz2ZwWEmJeJAm44F0JZAJ5kiGDQJsbowEj
	4/HJgjH1ikoyTMga/A/xJW/o7BDmHoRoCRZCyYA66lTaVwFoqlNrDBEo8lJG+EZr
	RMFZ4S8g2FDz8c976l7ZT/g9QBo+aVKY/xiCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fIPpbTBgSly+md8AgPOKjo3Ry6iK/GhQ
	NLXdCBAjyk4TA371h5dIMvxME5/8s3bboemzpS9Dfjuy5tiygEyDtZr9LSicBNNz
	SPy5ilFCA4TEmHwQCQEdWynSgJoL6AYh0+RwT1LLS1SAZs8nvLSi/ok8K7bLfZjl
	0In4q4zOa+c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89BB626103;
	Sun, 21 Dec 2014 17:49:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2629E26102;
	Sun, 21 Dec 2014 17:49:54 -0500 (EST)
In-Reply-To: <CAEE75_0Ff7NfQYUPrA414N9E0AE6LsS2zs0kL=BJ25bjPgom_w@mail.gmail.com>
	(Jim Hill's message of "Sun, 21 Dec 2014 11:12:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADFB3738-8963-11E4-8A57-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261634>

Jim Hill <gjthill@gmail.com> writes:

> I call it unwanted because the default works fine with the actual
> input and explicitly limiting whitespace this way breaks most command
> substitution.

OK.  I'd call that "unnecessary", not "unwanted", though.

It becomes unwanted only when somebody cuts and pastes and changes
what happens inside the body of the loop without thinking what IFS
assignment is doing.

Leaving it to the default is not wrong per-se, but I think it is
better to justify this change as protecting cut-and-paste people,
which is its primary benefit as far as I can see.

Thanks for noticing.
