From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 10:24:22 +0200
Message-ID: <vpq4nauhubt.fsf@anie.imag.fr>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 10:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V99uU-0000cS-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 10:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab3HMIYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 04:24:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52283 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584Ab3HMIYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 04:24:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7D8OLB2010354
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Aug 2013 10:24:22 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V99tu-0007t7-OV; Tue, 13 Aug 2013 10:24:22 +0200
In-Reply-To: <20130809194214.GV14690@google.com> (Jonathan Nieder's message of
	"Fri, 9 Aug 2013 12:42:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 13 Aug 2013 10:24:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7D8OLB2010354
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376987065.57951@VUBC0rc5nhv3wrF2TkZz/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232216>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Thorsten,
>
> Thorsten Glaser wrote[1]:
>
>> git config user.email SHOULD NOT default to $(id -un)@$(hostname -f)
>> because just too many cow-orkers seem to be unable to follow basic
>> instructions
>
> Heh.
>
> Can you say a little more about your setup?  In a university
> environment with sysadmin-managed email and /etc/mailname set up
> correctly it is handy that people can start working without doing
> anything special to configure git's "[user] email" setting.

I also work with a university environment. The guessed user.email is
almost right (actually, it's not the official email address, but an
internal one we ask students not to use). Still, I'd love to see Git
error out by default, as most students use Git from several machines.
They usually learn and write their first ~/.gitconfig on the school's
machines, and then start working from their personal laptops, where the
guessed user.email is plain wrong.

We do teach them to set user.email in ~/.gitconfig as a very first step,
but many don't (because they don't read the tutorial, or because they do
something wrong like putting .gitconfig in the wrong directory). We do
tell them to set up ~/.gitconfig on every host they work from, but many
don't either. And unfortunately, the warning is not scary enough for
some of them :-\ ("Err, did I get a warning? where?").

An opt-in auto-detection would be cool for people who really work in a
controlled environment, so that the sysadmin could enable it from
/etc/gitconfig.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
