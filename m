From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Massive repository corruptions
Date: Tue, 13 Jul 2010 07:03:51 +0200
Message-ID: <20100713050350.GB29392@nibiru.local>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 07:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYXk9-0000U8-1l
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 07:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab0GMFJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 01:09:16 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:42086 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751032Ab0GMFJP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 01:09:15 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6D59C9G017767
	for git@vger.kernel.org; Tue, 13 Jul 2010 07:09:12 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6D53pTZ020608
	for git@vger.kernel.org; Tue, 13 Jul 2010 07:03:51 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150873>

* Avery Pennarun <apenwarr@gmail.com> wrote:

> Multiple simultaneous gc's shouldn't be a problem - git locks things
> as it needs them.  Plus, git only removes objects after it has safely
> created a new packfile that contains them.  Maybe a filesystem filling
> up could cause a problem, but git should be detecting that if it
> happens (maybe there's a bug that causes it to not notice, though).

Okay.

> You could experience corruption if your computer crashed before
> everything was synced to disk.

No machine crash, and no sign of filesystem or disk problems
(according to kernel log).

> Do you know which packfiles are corrupted?  Does 'git index-pack' on
> the files reveal anything?

git@blackwidow ~/metux/work.git/pack $ git index-pack pack-3b6cbd5dc5f54cf390cfaa479cac6a99d7401375.pack
error: inflate: data stream error (incorrect data check)
fatal: pack has bad object at offset 37075832: inflate returned -3

(that's essentially the same git-gc says)


git@blackwidow ~/metux/work.git/pack $ git unpack-objects -r < pack-3b6cbd5dc5f54cf390cfaa479cac6a99d7401375.pack 
error: inflate: data stream error (incorrect data check)
error: inflate returned -3

error: inflate: data stream error (incorrect data check)
error: inflate returned -3

Unpacking objects: 100% (1223/1223), done.
fatal: final sha1 did not match



cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
