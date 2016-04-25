From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 09:56:40 -0700
Message-ID: <xmqqh9epmxtj.fsf@gitster.mtv.corp.google.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	<vpq37qeovu4.fsf@anie.imag.fr>
	<xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
	<EDD0757C-2BD3-476F-B703-147D35BB1FAC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:56:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujoW-0002NS-LE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbcDYQ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 12:56:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754393AbcDYQ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:56:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B939414850;
	Mon, 25 Apr 2016 12:56:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S6/M3hdAgphChXzFuEBqM7l/Xhk=; b=SKyZHn
	yGUOBljZU+H65FHr8SzrENBBlafKkD0G7B0bA+OcJNuopNAbrKqS9dSiUwU3YVP5
	jaF55pZbgEfoYrDJv1fAh3N0Y1yyqP5TbDM9AcfVF6E9nIU117ZKzFbQdwcjYFS2
	44UYlLboJc4mQkV4JviBNtQ72jldMYYpGEeWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iX0j1904isF/fvqu66aSq6NDsyFnURBi
	tVPADHvdO9CyYzpFG+9Z5EVk4tWwfNRyXMkVjihkQ/vJ/IUXwL8ssPiJG5oxciU6
	tLz7qYA8D1vlazUJSxvB0OnpWYxxaCVhsUuFQeT6XIMbs4r9CWwkgFocnpDHymT7
	EQSkyc35YB0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE7041484F;
	Mon, 25 Apr 2016 12:56:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 140C91484E;
	Mon, 25 Apr 2016 12:56:42 -0400 (EDT)
In-Reply-To: <EDD0757C-2BD3-476F-B703-147D35BB1FAC@gmail.com> (Lars
	Schneider's message of "Mon, 25 Apr 2016 10:33:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AF59C024-0B06-11E6-8CE1-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292523>

Lars Schneider <larsxschneider@gmail.com> writes:

>> There also are existing instances of "useless ;" that would want to
>> be cleaned up regardless of portability issues.
> Unfortunately it seems to be required. Travis CI generates a shell script
> out of the yml file and I think they don't respect newlines or something...

If they squash all the lines into a single long line before
executing, these semicolons do indeed become necessary (we have to
write a logical single line shell script in our Makefiles with ';',
and I'd imagine Travis's scriptlets are done similarly).

Thanks.
