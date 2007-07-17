From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Tue, 17 Jul 2007 16:27:15 +0200
Message-ID: <vpqbqebt8ak.fsf@bauges.imag.fr>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
	<dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com>
	<f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com>
	<f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com>
	<Pine.LNX.4.64.0707170834040.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bradford Smith <bradford.carl.smith@gmail.com>,
	Nikolai Weibull <now@bitwi.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 16:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAo1z-0003Qt-Dm
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 16:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbXGQO16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 10:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbXGQO16
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 10:27:58 -0400
Received: from imag.imag.fr ([129.88.30.1]:37578 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbXGQO15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 10:27:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6HERGjh028444
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2007 16:27:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IAo1E-0008BG-3r; Tue, 17 Jul 2007 16:27:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IAo1E-0004lu-1W; Tue, 17 Jul 2007 16:27:16 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Bradford Smith <bradford.carl.smith@gmail.com>, Nikolai Weibull <now@bitwi.se>,  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0707170834040.14781@racer.site> (Johannes Schindelin's message of "Tue\, 17 Jul 2007 14\:56\:37 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 17 Jul 2007 16:27:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52762>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 16 Jul 2007, Bradford Smith wrote:
>
>> So, I guess I need to add a GIT_CONFIG_HOME environment variable.  If I 
>> get that done, I'll send a patch to the list including doc updates.
>
> Alternatively, you could actually not ignore my hint at readlink(2) and 
> have a proper fix, instead of playing games with environment variables.

I second that.

Using an environment variable means having a configuration which is
about git in my shell's config file, and that's a source of a lot of
troubles. Murphy's law implies that one day, the environment variable
won't be set properly (because you changed your shell, because you
launch git from something which isn't a shell, because you logged-in
in a way that didn't read the config file in which the variable was
set, ...).

I can do with it, like many other software require an environment
variable, but I find the symlink trick much more robust.

-- 
Matthieu
