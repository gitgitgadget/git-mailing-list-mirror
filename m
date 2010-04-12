From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: simplest git deamon?
Date: Mon, 12 Apr 2010 16:24:46 +0200
Message-ID: <vpqmxx8g34h.fsf@bauges.imag.fr>
References: <20100412164740.740050cb@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:29:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Kdp-0002oC-QC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab0DLO3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 10:29:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:53366 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab0DLO3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 10:29:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o3CEOkRa009663
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Apr 2010 16:24:47 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O1KZC-0002W4-Ql; Mon, 12 Apr 2010 16:24:46 +0200
In-Reply-To: <20100412164740.740050cb@pbmiha.malagasy.com> (Mihamina Rakotomandimby's message of "Mon\, 12 Apr 2010 16\:47\:40 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 12 Apr 2010 16:24:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144734>

Mihamina Rakotomandimby <mihamina@gulfsat.mg> writes:

> Manao ahoana, Hello, Bonjour,
>
> I would like to setup a git repository, on a Debian machine.
> I would like to access it only with git:// (no http://, no ssh://,...)
>
> How to implement read/write restriction when just wanting to use
> "git://" without dealing with SSH?

You do want SSH: Git itself doesn't do encryption, so implementing
access control over plain git:// would be insecure. And Git prefered
to delegate access control to well established solution such as SSH.

I'd recommand having a second look at gitosis, or its variant
gitolite, which provide a configuration file mostly like what you
expect :

>   [users]
>   alice: al_pass
>   bob  : b_pass
>   
>   [groups]
>   senior:alice,bob
>   
>   [permissions]
>   @senior:all
>   @anonymous:clone

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
