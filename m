From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Mirror plain directory under git
Date: Tue, 21 Sep 2010 09:56:21 +0200
Message-ID: <20100921075621.GA27575@nibiru.local>
References: <AANLkTi=9nqfzR-Zo85LieBuhv97oudCVZCex8ZL3mM0t@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: suntong@cpan.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 14:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz73v-0001nF-B1
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 14:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab0IXMH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 08:07:29 -0400
Received: from caprica.metux.de ([82.165.128.25]:38054 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752237Ab0IXMH3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 08:07:29 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o8OBuZHp005578;
	Fri, 24 Sep 2010 14:08:05 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o8NKgxSa008244;
	Thu, 23 Sep 2010 22:42:59 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o8L7uL3d031552;
	Tue, 21 Sep 2010 09:56:21 +0200
Mail-Followup-To: git@vger.kernel.org, suntong@cpan.org
Content-Disposition: inline
In-Reply-To: <AANLkTi=9nqfzR-Zo85LieBuhv97oudCVZCex8ZL3mM0t@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156980>

* Tong Sun <suntong@cpan.org> wrote:

Hi,

> How feasible it is to mirror a plain directory and put it under git
> revision control (leaving the original intact)?

Probably you'll want to have the .git dir outside of /etc, so
--git-dir and --work-dir are your friend (man 1 git).

An cron-script could look something like that:

    #!/bin/bash

    cd /var/my-etc-archive.git && \
	git --work-dir=/etc add -A && \
	git --work-dir=/etc commit -m "autocommit" && \
	git push origin

(perhaps filter the output a bit, so you don't get unncessary
cron mails ;-))


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
