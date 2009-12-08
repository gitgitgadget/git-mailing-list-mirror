From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add commit.status, --status, and --no-status
Date: Mon, 07 Dec 2009 23:13:00 -0800
Message-ID: <7vr5r6ndkz.fsf@alter.siamese.dyndns.org>
References: <20091206131217.GA12851@sigill.intra.peff.net>
 <1260225927-33612-1-git-send-email-jh@jameshoward.us>
 <20091208060415.GC9951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "James P. Howard\, II" <jh@jameshoward.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:13:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHuG4-0002x7-LL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbZLHHNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZLHHNE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:13:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbZLHHNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:13:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 474CDA4C19;
	Tue,  8 Dec 2009 02:13:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4c7p/rAuUi1PWCqZ8DD/m4FunlY=; b=S8Jfof
	F0sJst+jU/50yB0M1nW88VBdPckUme9Ex6nl3Ho+eVAnFMB5pJTr4foH/8akzzT1
	JkK4+n23dQjWjMjNPaynNfOsiAkIIAINhSmkQ4vspuVreB26rTwwrPpD0XGB1F7n
	ALThSvabRWa0Vk0vFzi8wm6x4p8da6PbF6vSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i6yjIW8Z9GeFVBDBLE8uydNxUqrNY2k3
	fEHVYkzCf+80ovOZsAiR+Pra8pskg/M/pqZ7TPWqLgdQWmJdIf58LJk3lDzjISKG
	r46ljX0gLEigQR66iknv+5tNqkVIZkF0Nk5bdxRLgNwc+QERG6R1oukhOMYuwn4C
	gzbulXgbx9U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1891CA4C16;
	Tue,  8 Dec 2009 02:13:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D136CA4C14; Tue,  8 Dec 2009
 02:13:01 -0500 (EST)
In-Reply-To: <20091208060415.GC9951@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 8 Dec 2009 01\:04\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21A95F0C-E3C9-11DE-8306-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134827>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 07, 2009 at 05:45:27PM -0500, James P. Howard, II wrote:
>
>> This commit provides support for commit.status, --status, and
>> --no-status, which control whether or not the git status information
>> is included in the commit message template when using an editor to
>> prepare the commit message.  It does not affect the effects of a
>> user's commit.template settings.
>
> Thanks, this looks very cleanly done. The only complaint I would make is
> that it should probably include a simple test case.

Yes.  Also I am a _bit_ worried about the name "status", as the longer
term direction is to make "status" not "a preview of commit", may confuse
people who do read Release Notes.
