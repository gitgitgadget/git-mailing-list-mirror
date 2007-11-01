From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-mailinfo strip whitespace from the start of the mail file.
Date: Thu, 01 Nov 2007 15:26:34 -0700
Message-ID: <7vr6j98uw5.fsf@gitster.siamese.dyndns.org>
References: <1193951139-2312-1-git-send-email-Simon.Sasburg@gmail.com>
	<7vd4utabx0.fsf@gitster.siamese.dyndns.org>
	<981e6de60711011441n5bef772cuda381c539c0a2603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Simon Sasburg" <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IniV9-0000EL-C4
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760046AbXKAW0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760027AbXKAW0m
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:26:42 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47887 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760055AbXKAW0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:26:41 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 090132F0;
	Thu,  1 Nov 2007 18:27:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A32F912D7;
	Thu,  1 Nov 2007 18:26:58 -0400 (EDT)
In-Reply-To: <981e6de60711011441n5bef772cuda381c539c0a2603@mail.gmail.com>
	(Simon Sasburg's message of "Thu, 1 Nov 2007 22:41:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63023>

"Simon Sasburg" <simon.sasburg@gmail.com> writes:

>> Just to help me understand why this change is needed...
>>
>> Are you using mailinfo directly without splitting with mailsplit
>> first?
>
> Well, when using gmail's web interface, when reading a mail, there is
> this option to show the raw mail text (headers+body) with the 'show
> original' option.
>
> If you do 'save as..' in your browser to save what you get with that,
> and try to do git-am on that file, it fails because it starts with
> some whitespace.
>
> With this patch git-am works on these files.
>
> So, i'm not using mailsplit or any other mail tools at all, just my
> browser and git.

Ah, I meant "git-mailsplit", which is the command internally run
by "git-am" to preprocess the file and to split it into
individual mail pieces to be fed to "git-mailinfo".

That may suggest the change is better done in git-mailsplit not
git-mailinfo.

Or perhaps both.
