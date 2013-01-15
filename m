From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix handling of file perms when pushing
Date: Tue, 15 Jan 2013 15:51:53 -0800
Message-ID: <7vfw220zty.fsf@alter.siamese.dyndns.org>
References: <1358254959-50435-1-git-send-email-max@quendi.de>
 <1E49829A-0675-40D2-97C6-FD62982A0923@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvGIw-0002dM-W6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589Ab3AOXv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:51:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807Ab3AOXv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:51:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 932A7A411;
	Tue, 15 Jan 2013 18:51:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJjI1efkCe5wnO7FMEtpGwToiNU=; b=luoO7f
	TfNnlsJkug+TkrvNPVX96UOEonTwz7ndmrytmP9nQcY5TWwvtDXScsJYOdw20gLk
	MCx+W7l0FL07q8sN+NhjlW/D+/ohK7xAno1uE3QSoWNUxrH+ggQvFIK6f1na/v6b
	JUI4odlCkruhoMnd3ow9xecRFUF+H4uKufvHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZVJBAzll+wpPMPkzlc7n/VYq6nFSC/cP
	nLmN93JS1MUSCnFiqIypsknpUCqBPQ3fP4VMJ0ux9WYU1+wQ98fV4yxLZuaprRmL
	0/Fss7zCYtVk1EMEO3/Vw7q6gtWMT23OiWPqMy6Rqs/fP+88cvZscYy/7g9ZkajO
	qwnO16Sxj6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88140A410;
	Tue, 15 Jan 2013 18:51:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 063D3A40D; Tue, 15 Jan 2013
 18:51:54 -0500 (EST)
In-Reply-To: <1E49829A-0675-40D2-97C6-FD62982A0923@quendi.de> (Max Horn's
 message of "Tue, 15 Jan 2013 14:06:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A911F2C-5F6E-11E2-BC7F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213693>

Max Horn <max@quendi.de> writes:

> On 15.01.2013, at 14:02, Max Horn wrote:
>
>> Previously, when changing and committing an executable file, the file
>> would loose its executable bit on the hg side. Likewise, symlinks ended
>> up as "normal" files". This was not immediately apparent on the git side
>> unless one did a fresh clone.
>
> Sorry, forgot to sign off, please add:
>
> Signed-off-by: Max Horn <max@quendi.de>
>
> Max

Thanks; merged together with the other patch from Felipe to 'next'.

Unfortunately I noticed the "loose" typo (I think you meant "lose")
after I pushed out the results X-<.
