From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7.3 1/4 (bugfix)] gitweb: Prepare for splitting gitweb
Date: Thu, 02 Dec 2010 11:21:28 -0800
Message-ID: <7vmxooq8uf.fsf@alter.siamese.dyndns.org>
References: <201010311021.55917.jnareb@gmail.com>
 <201012021117.16183.jnareb@gmail.com>
 <7vtyiwrs8e.fsf@alter.siamese.dyndns.org>
 <201012022001.31739.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:21:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POEj0-0001Uk-8A
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab0LBTVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:21:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab0LBTVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:21:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0516429A4;
	Thu,  2 Dec 2010 14:22:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uUhnNZNvWrbRAjotlKdo6BBE3z4=; b=KuRdn4
	/c3qwD7EMrR56VzYZMXlC2ke1hBYc89kkhBvLDIlWz4oebLcqYT8cQlGy63vZ/KF
	Ydl1WDtzjlJEHfh8TPfVAZW7mdPdRN4p5W8nNjKdRfYpKyxuv8LqSe4yRW25HWXg
	adofJO8zXDZnAwfAcU7x2x/VtXfRH9Etg4aJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hk2+iUBSDP/YM+Wi7RmuvR5IIndZHYqf
	SrnAQLsZhd7QWJzagkBYY3QXF7Z2PEZ45vX1G7eSo5KQqptzw5SrnNgw12rB/9iV
	kK5hWDCLuXOvhHPNmfxv/UlYHEMItnCrwfS1jiMLDAf8jdpyAOfBW1pe2jyvtNG5
	fXTU65ysF3E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64DAD29A3;
	Thu,  2 Dec 2010 14:21:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5FB7D299F; Thu,  2 Dec 2010
 14:21:50 -0500 (EST)
In-Reply-To: <201012022001.31739.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 2 Dec 2010 20\:01\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E75EC88-FE49-11DF-AFD6-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162737>

Jakub Narebski <jnareb@gmail.com> writes:

>> Ah, I don't run the install step for a revision that does not pass its
>> selftest, so I haven't run "make install" on 'pu' for some time.  That may
>> explain it.
>
> Hmmm... I thought that "make install" doesn't install gitweb, but it does
> with "$(MAKE) -C gitweb install"... though I am not sure if "make all"
> builds gitweb (runs "make gitweb").

I think it does, and it should if it doesn't.
