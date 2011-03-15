From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: copy the index using --index-output instead of cp
 -p
Date: Tue, 15 Mar 2011 12:28:26 -0700
Message-ID: <7vk4g09o9x.fsf@alter.siamese.dyndns.org>
References: <4D7F3AA4.1080202@elegosoft.com> <4D7F466A.4090508@viscovery.net>
 <4D7F54C2.5060500@elegosoft.com> <4D7F5DA0.3030608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	casey@nrlssc.navy.mil, jon.seymour@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:29:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzZvO-0000xx-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 20:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758385Ab1COT2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 15:28:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab1COT2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 15:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A1DF444C;
	Tue, 15 Mar 2011 15:30:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rZmE4yBz4CFAtZkBUqVU3yZXrGw=; b=uHldWB
	ezZMTyh0OswvGJ36hrhpjhHO+4DkkWpBpeWfJ9LWeL0H7Epzt6xteSjUC1O/VBRr
	flAASfUq/10NaGezYyu6MvGlDSruIsl/EOtB1RcjaItQuI6/cu4+AgOlZbnpJKZC
	qZF7WYcVoeHI0roOIb/VTQ8ClK9ryVHzJNbhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bXF7wWZP+g0wQBJ1eW9j/TsrOqBV8A56
	Kz/DV3ahtPGMBAurVY+pk/eCdG0neh6BCxmhYLXfDBRZp0Om3JPzjk0E0CGnmho9
	7bPgvFPuDgl9wSNMo/+8DyItwX02RrZ8QyzQBW1qN0C0HhSv2MCfhM3/A0gwgdoJ
	9EmP1vxo90w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C2ED444B;
	Tue, 15 Mar 2011 15:30:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 800C0444A; Tue, 15 Mar 2011
 15:30:00 -0400 (EDT)
In-Reply-To: <4D7F5DA0.3030608@viscovery.net> (Johannes Sixt's message of
 "Tue, 15 Mar 2011 13:37:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A23B9256-4F3A-11E0-A03A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169086>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Luckily, the first operation in git-stash after copying the index is to
> call 'git read-tree'. Therefore, use --index-output instead of 'cp -p'
> to write the copy of the index.

Thanks, will apply.
