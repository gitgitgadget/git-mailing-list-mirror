From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 15:31:24 +0100
Message-ID: <87lk7yr7ib.fsf@lysator.liu.se>
References: <20071213133653.13925.89254.stgit@krank>
	<b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 15:32:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2p6f-0002L4-Eh
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 15:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbXLMObL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 09:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbXLMObK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 09:31:10 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:44131 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbXLMObJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 09:31:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id AF0D7200A215;
	Thu, 13 Dec 2007 15:31:07 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28656-01-12; Thu, 13 Dec 2007 15:31:07 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 210D3200A1FA;
	Thu, 13 Dec 2007 15:31:07 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id E9B9D7B4077; Thu, 13 Dec 2007 15:31:24 +0100 (CET)
In-Reply-To: <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com> (Catalin Marinas's message of "Thu\, 13 Dec 2007 14\:04\:26 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68160>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 13/12/2007, David K=C3=A5gedal <davidk@lysator.liu.se> wrote:
>> I have a fair amount of branches, and I noticed that "stg branch -l"
>> takes ridiculously long to finish.
>
> I have the same problem.
>
>> Maybe someone can help me find a quicker replacement for the
>> get_protected call?

Hey, why not put the "protected" flag in the config? Then we can get
it the same way as the other stuff.

Protecting a branch is a configuration action, so it makes sense to
put it in the config.

--=20
David K=C3=A5gedal
