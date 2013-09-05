From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 05 Sep 2013 12:18:45 -0700
Message-ID: <xmqqd2onhyay.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<20130905080606.GE2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Sep 05 21:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHf54-0006By-U6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab3IETS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:18:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757072Ab3IETSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:18:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB2223F4DB;
	Thu,  5 Sep 2013 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cM6cKPD1g6G1YOF1kMXU7ldfuMI=; b=ZLivc0
	Y0B3uP4eDrBmksPK6OayeEhdkkEEOOF8VixjGr5uOhAKnMSd7EBYCwxBYLvJeZUe
	wxHAqJIIcuBQZzi4KCPc/bzXpb3TLQyRILp3CUJ3G8oy2F8gsBcsbRXuZiOK/HVX
	Hum16YPKapZ4fkihh4gpLyI9EOKHHkZ91kUqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4tcmFSW+eN17UAUbhzmEYVVPlo5JvX+
	XudtL5AxwF5iuQQ6bQ9pZMsYl5BuNW5fxtxsu+oCNGrNQuAHSIrFAFBp5lYiuyhl
	tJ9Rn1+ux7qt0tHzLojJttKCjP4whAbEaqfdfzAysNhRzYh6PbW12e5F9GWFQEzk
	YTWMK/KizFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34D753F4D7;
	Thu,  5 Sep 2013 19:18:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E36C3F4C6;
	Thu,  5 Sep 2013 19:18:48 +0000 (UTC)
In-Reply-To: <20130905080606.GE2582@serenity.lan> (John Keeping's message of
	"Thu, 5 Sep 2013 09:06:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE30D88E-165F-11E3-9B8F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233985>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Sep 04, 2013 at 03:59:18PM -0700, Junio C Hamano wrote:
>> Are there cases where you do not want to either rebase nor merge?
>> If so what do you want to do after "git pull" fetches from the other
>> side?  Nothing?
>
> One other thing that I can see being useful occasionally is:
>
>     git rebase @{u}@{1} --onto @{u}
>
> which allows local commits to be replayed onto a rewritten upstream
> branch.

Sure, that would make sense.

I somehow thought that rebase by default looked in the reflog to do
exactly that. Perhaps I am not remembering correctly.
