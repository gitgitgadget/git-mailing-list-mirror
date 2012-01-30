From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Mon, 30 Jan 2012 13:05:21 -0800
Message-ID: <7vty3caoku.fsf@alter.siamese.dyndns.org>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130200355.GA2584@server.brlink.eu>
 <7v39axaq0v.fsf@alter.siamese.dyndns.org>
 <201201302148.03909.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bernhard R. Link" <brl@mail.brlink.eu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:05:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RryPp-0005IH-Ke
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab2A3VFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:05:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab2A3VFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:05:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0985D7447;
	Mon, 30 Jan 2012 16:05:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yragpPVqzL6L6Tt6jyvIm3WGpWg=; b=SE6pIu
	xbfSjViNZqNIjt5XoEoI9S+alietVIhDuWXHmfhdbPqHw5PqNUh8M8WLn6wKoTg7
	V1qSvE4ivfEtfgEE2YfJN5CBkL8GQ4zyudmc1kBAMhy3DjMu8YI5NKA87h8T/xPJ
	U873K4ck/KN28skfC+Y5YOhx8wPcmqSuETjiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpN8xQMDbzHlvnOYBrqeidaZ5d0xAZH6
	wgYl4zggYkpHzQmP8JDoAHOgj5JL+1+osYmY4okNBbjTp45JkHwWCSx6FBpHHpkh
	AIr94/TlWBOl6LbTm+B86EfD1Zno4PbCY2+vlR0wLF4vZGZ95ilh2yZQYsjPjTf/
	rVoP7cTnVl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F33737446;
	Mon, 30 Jan 2012 16:05:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 707F57445; Mon, 30 Jan 2012
 16:05:23 -0500 (EST)
In-Reply-To: <201201302148.03909.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 30 Jan 2012 21:48:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 202357E2-4B86-11E1-A378-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189424>

Jakub Narebski <jnareb@gmail.com> writes:

>> -	my @list = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
>> +	my ($filter = $project) =~ s/\.git$//;
>
> This doesn't work: it is syntax error:
>
>   Can't declare scalar assignment in "my"
>   
> It has to be either
>
>  +	(my $filter = $project) =~ s/\.git$//;

Sorry, that is what I meant.
