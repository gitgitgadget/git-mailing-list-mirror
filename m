From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gti push interface inconsistency
Date: Mon, 26 Oct 2009 17:08:19 -0700
Message-ID: <7veiopd7gs.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910261523s51ac22b5y624ec3502e8fed67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Zc3-0002xx-Fb
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 01:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbZJ0AIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 20:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755164AbZJ0AIW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 20:08:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbZJ0AIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 20:08:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 077858652A;
	Mon, 26 Oct 2009 20:08:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vZysBfw/2KjwF9FRES40Qq99cBI=; b=WtWndQ
	lcNEDbe9Nwpujn7fu5asRO43w/+N1NTna5NjHA7+bgtXLaK76msHTs6KcQuKQ5rO
	UQyiu33NfBPl2IF9bCUQ3wLxr1Cigqp5OzAbQzv9nAG5PPMtYe/iwzicDMiONX+N
	ChNTgtkhQXdyV+t4I9zNnZlyTBDD/os0g9YkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rGaVopENTPiSNU6KA+QFT315B80LGTk/
	Ck0xmWYgCNI9c1FMM82gkqBDKLWPB/WUxINyUqKA7ZXSp79/aY1QtyddGX3z96RX
	gSNb2PdD+2iuM6L661j74CR6tqlhAAZ+Jknbx5OSo+Au0Xhz04xlboQhFZ25E3dR
	LPNmIjVaFGI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB67C86529;
	Mon, 26 Oct 2009 20:08:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EDE8186528; Mon, 26 Oct 2009
 20:08:20 -0400 (EDT)
In-Reply-To: <76c5b8580910261523s51ac22b5y624ec3502e8fed67@mail.gmail.com>
 (Eugene Sajine's message of "Mon\, 26 Oct 2009 18\:23\:44 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7BFC1CC-C28C-11DE-BB45-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131288>

Eugene Sajine <euguess@gmail.com> writes:

> I have a question:
>
> Why I can't do
>
> $ git push my_tag
>
> It will fail because the remote is not specified, even if there is
> only one origin remote

Probably because git is not smart enough to understand the human language
to notice 't' 'a' 'g' is a tag and cannot be a remote name spelled
incorrectly, or git cannot read your mind and find out that you spelled
a name of the remote correctly but forgot to add the remote first.
