From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 09 Feb 2013 11:35:30 -0800
Message-ID: <7vliaxwa9p.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
 <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 20:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4GDN-0005Jp-Kr
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 20:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760824Ab3BITfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 14:35:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab3BITfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 14:35:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0A57C246;
	Sat,  9 Feb 2013 14:35:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7oM1PFBV61gQmOSEYifzuDLj0e0=; b=TqtZLA
	ySX5XEMqhYOEN/PhAfMJZ7Jn0D6VXBz91UnraD1DwpYLSPBy4vmvfh3NfAV13Nk9
	KXaP18RcFPpRCg7uZ8+1ov50zBl4P726bUxRCF0bMhJnPbWzYN7TcqrsJy78NeUz
	EUTFlqP8iIVZCzZCLI90FbLXwJlm3JD+xdB7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GX+1z2DZfmNgVPzj66KnWdHj/6ohtW7a
	7zWd11LZ2Eud1oV+Reun898sNiNsPvX4Qk5y8bEva7duzxOYmrCLm1SVuFpYTsHS
	7Phx5q5gAfrqXOb1vdsmhmiTlaBYtwCZbqolthgy3vqaO5qQ07v7gL4h6jMwUKTt
	ts0d7LHSDQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C3CC245;
	Sat,  9 Feb 2013 14:35:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68F86C244; Sat,  9 Feb 2013
 14:35:32 -0500 (EST)
In-Reply-To: <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 9 Feb 2013 17:35:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE270324-72EF-11E2-9D43-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215869>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This is much better than Junio's suggestion to study possible
> implementations on all platforms and designing a generic daemon/
> communication channel.  That's no weekend project.

It appears that you misunderstood what I wrote.  That was not "here
is a design; I want it in my system.  Go implemment it".

It was "If somebody wants to discuss it but does not know where to
begin, doing a small experiment like this and reporting how well it
worked here may be one way to do so.", nothing more.
