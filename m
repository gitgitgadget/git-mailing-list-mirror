From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 22:11:26 +0100
Message-ID: <878utqwpkx.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<87ha8ewqfv.fsf@fencepost.gnu.org>
	<xmqqzjm67fpu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:17:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnN6-0004gZ-MU
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934930AbaBDVR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:17:29 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:53288 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934924AbaBDVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:17:21 -0500
Received: from localhost ([127.0.0.1]:52328 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAnMu-0006gU-Dl; Tue, 04 Feb 2014 16:17:20 -0500
Received: by lola (Postfix, from userid 1000)
	id EA1BDE0778; Tue,  4 Feb 2014 22:11:26 +0100 (CET)
In-Reply-To: <xmqqzjm67fpu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Feb 2014 13:03:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241555>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Anybody know offhand what I should be including here?  It looks like Git
>> has some fallback definitions of its own, so it's probably not just
>> <string.h> I should include?
>
> In general, no *.c files outside the compatibility layer should
> include anything "#include <system-header.h>", as there seem to be
> finicky systems that care about order of inclusion and feature macro
> definitions, all of which are meant to be handled by including
> git-compat-util.h as the very first thing.

Ok, and that one's not yet in blame.c.  Will include, thanks.

-- 
David Kastrup
