From: Junio C Hamano <gitster@pobox.com>
Subject: Re: only accessing some git repos: Am I configuring daemon wrong?
Date: Sun, 18 Nov 2007 10:48:29 -0800
Message-ID: <7vr6inv18i.fsf@gitster.siamese.dyndns.org>
References: <9732aadb0711180518n26c2681aqe7f0a823012c6fe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Henrik Vendelbo" <hvendelbo.dev@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 19:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItpCP-0003S9-9h
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbXKRSsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbXKRSsf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:48:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40476 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbXKRSse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:48:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 76050325;
	Sun, 18 Nov 2007 13:48:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 051419720D;
	Sun, 18 Nov 2007 13:48:52 -0500 (EST)
In-Reply-To: <9732aadb0711180518n26c2681aqe7f0a823012c6fe3@mail.gmail.com>
	(Henrik Vendelbo's message of "Sun, 18 Nov 2007 13:18:04 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65384>

"Henrik Vendelbo" <hvendelbo.dev@googlemail.com> writes:

> I run the daemon against a base directory with all my repos.
>
> /repositories
>   + /blingon
>      + /config
>   + /thepia
>      + /config
>
> The config directories are git repositories, and the repos are made
> available with the following command:
>
> henrik-computer:~ x$ git daemon --export-all --verbose --base-path=/repositories
> [337] Connection from 192.168.9.130:56583
> [337] Extended attributes (20 bytes) exist <host=192.168.9.165>
> [337] Request upload-pack for '/blingon/all'
> [337] Disconnected
>
> For some reason when I try to pull over the git protocol to a
> different machine using clone, I get a failure telling me that there
> is 'no matching remote head'
>
> I tried specifying the actual repo directories, but that made no difference.
>
> Any ideas?

Lack of any whitelist on the command line and --export-all?

Do you see "not in whitelist" in your error log?
