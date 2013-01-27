From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 12:38:40 -0800
Message-ID: <7va9ruuzsf.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan> <20130127145056.GP7498@serenity.lan>
 <7vzjzuv224.fsf@alter.siamese.dyndns.org>
 <20130127200401.GT7498@serenity.lan>
 <7vr4l6v11z.fsf@alter.siamese.dyndns.org>
 <20130127202106.GU7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:39:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZ0O-0006Ti-92
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab3A0Uio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:38:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab3A0Uin (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:38:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A90B819;
	Sun, 27 Jan 2013 15:38:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=34MFd92inN045TMfxe7L5uFSDZQ=; b=bT8Wnn
	GO+g3xb9ZbtDY4FmMozF5L0ViL5FtXRb49d6LWIYJbSjLzeQFQ4Phe6A0LolPdO3
	jdBsxAgqS1XKr+prMY+vcmBQBsYInS/Mr1L5md0CcWVgWMQUniiYzx88SI0Fs/rm
	obBGb39mco57ov7fDUTGKQkRCj8fnB/9iOYbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tFrEQ3eXh/tt/eomTw/B8w72sSsoSSMy
	gGS9VZyGGDLNapu3+o5dejCsX0bznoyw7voBfykcXPg+S7b1nyj4uF/1djkrFUuU
	pa2PA4LEDFO7v1web0QsUuLgNAW+fGJAFlpzCt1BBRl2OfCBAXWyL9BPRLaHNJaM
	RNLDDnASa7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCFD1B817;
	Sun, 27 Jan 2013 15:38:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 476F1B816; Sun, 27 Jan 2013
 15:38:42 -0500 (EST)
In-Reply-To: <20130127202106.GU7498@serenity.lan> (John Keeping's message of
 "Sun, 27 Jan 2013 20:21:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89B74FE8-68C1-11E2-8495-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214730>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Jan 27, 2013 at 12:11:20PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> >> Thanks; will queue and wait for an Ack from Michael.
>> >> 
>> >> Does the helper function need to be named with leading underscore,
>> >> though?
>> >
>> > ...  Since this is a script
>> > not a library module I don't feel strongly about it in this case.
>> 
>> That is exactly why I asked.
>
> So I think the answer is "habit, but I probably shouldn't have put it
> in in this case".

OK, then I'll queue with a local amend to drop the leading
underscore.

Thanks.
