From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Fri, 29 May 2015 07:35:36 +0200
Message-ID: <vpqbnh4hro7.fsf@anie.imag.fr>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Darling <darlingm@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 07:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyCxX-0001ND-ER
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 07:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbbE2Ffn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 01:35:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58242 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbbE2Ffj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 01:35:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4T5Za1B012437
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 May 2015 07:35:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4T5ZadH022028;
	Fri, 29 May 2015 07:35:36 +0200
In-Reply-To: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	(Michael Darling's message of "Thu, 28 May 2015 20:10:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 May 2015 07:35:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4T5Za1B012437
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433482536.77234@N9vltjVxxFw48W7ETqCCag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270207>

Michael Darling <darlingm@gmail.com> writes:

> $ git push --tags --set-upstream origin

[...]

> Note this time there is NO:
>
>  * [new branch]      master -> master
> Branch master set up to track remote branch master from origin.

man git-push says:

SYNOPSIS
       git push [...] [<repository> [<refspec>...]]
[...]
       --tags
           All refs under refs/tags are pushed, in addition to refspecs explicitly listed on the command
           line.

You did not provide any refspec (you provided <repository> but not
<refspec>), hence --tags pushes only tags. So, this is the expected
behavior.

That said, we may want to add an option like --tags-also that would push
tags _in addition_ to what would normally be pushed. --follow-tags does
more or less this, though, but only for annotated tags pointing at a ref
being pushed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
