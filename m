From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Mon, 4 May 2015 22:51:04 +0200
Message-ID: <20150504205104.GA28246@sandbox-ub1410>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
 <20150501175757.GA10569@book.hvoigt.net>
 <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
 <5547C961.7070909@web.de>
 <CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 22:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpNKe-0006E0-UY
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 22:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbbEDUvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 16:51:13 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:60644 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbbEDUvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 16:51:11 -0400
Received: from [80.135.96.43] (helo=sandbox-ub1410)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YpNKW-0007z7-J1; Mon, 04 May 2015 22:51:08 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268351>

Hi,

On Mon, May 04, 2015 at 03:21:31PM -0500, Robert Dailey wrote:
> Since I am not a linux user, I have implemented this feature against
> the Git for Windows fork of git. I am not able to verify changes if I
> make them directly against the Git repository. Is it OK if you guys
> end up getting this as an upstream patch later from that project? Also
> I am not familiar with the bash unit tests, I will need help with
> that.

I think there is nothing wrong with implementing it in the Windows
development environment and then sending the patch directly here. As
long as it is not Windows specific (which it should not be) that should
be fine and you save the Windows guys the work to get the patch
upstream (because here is upstream not there ;-)).

Have a look at some tests, they are quite simple. Basically they run git
commands in a && chain and the resulting return code tells the testsuite
whether that test succeeded or not. Maybe have a look at the test for
the existing --submodule option (t4041-diff-submodule-option.sh) as an
example. You can probably reuse the complete setup there and just add a
new test for the new option with the expected output. There is also a
README in the t/ folder. HTH.

Cheers Heiko
