From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Merging (only) subdirectories
Date: Fri, 3 Dec 2010 11:59:58 +0100
Message-ID: <20101203105957.GA14783@nibiru.local>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com> <AANLkTik-d8oys9h=wFRnyt8sukTsSymaw5LGM39BU2K=@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 12:04:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POTQr-00029e-Ko
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 12:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771Ab0LCLD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 06:03:59 -0500
Received: from caprica.metux.de ([82.165.128.25]:37655 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752689Ab0LCLD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 06:03:58 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oB3B6RmZ030857
	for <git@vger.kernel.org>; Fri, 3 Dec 2010 12:06:33 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oB3B61GM030822
	for git@vger.kernel.org; Fri, 3 Dec 2010 12:06:01 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oB3AxwZS027269
	for git@vger.kernel.org; Fri, 3 Dec 2010 11:59:58 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTik-d8oys9h=wFRnyt8sukTsSymaw5LGM39BU2K=@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162788>

* Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> Also, please consider submodules if theme dir is totally independent.
> I don't see how it makes it problematic for testing. git-subtree [1]
> might be of your interest too.
> 
> [1] https://github.com/apenwarr/git-subtree

Another option could be completely splitting off the themes to
their own branches (eg. using git-filter-branch), check them
out in an separate workdir and use unionfs to get a combined/merged
view of the working trees.

So, you'd actually have to fully separate branches, checked out
in their own worktrees/repos:

a) mainapp (the main application)
b) theme (the current theme you're working on)

For testing/runtime, the webserver gets a union'ed tree,
which just merges both namespaces (from host filesystems's, not
git's view) together. Your actual development happens in the theme
repo only.


On actual deployment (if you're using git here, too), you can simply
merge both branches together (will be just an passive - aka: 
merge-down-only - branch).


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
