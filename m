From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 02:50:04 +0200
Message-ID: <20101005005003.GA2768@nibiru.local>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 02:55:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2voL-00034b-9K
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 02:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0JEAzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 20:55:02 -0400
Received: from caprica.metux.de ([82.165.128.25]:43501 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751600Ab0JEAzB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 20:55:01 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o950u1dQ011954
	for <git@vger.kernel.org>; Tue, 5 Oct 2010 02:56:03 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o950tW4C011934
	for git@vger.kernel.org; Tue, 5 Oct 2010 02:55:32 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o950o4AF021477
	for git@vger.kernel.org; Tue, 5 Oct 2010 02:50:04 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158147>

* Shawn Pearce <spearce@spearce.org> wrote:

> The mmap() isn't the problem.  Its the allocation of a buffer that is
> larger than the file in order to hold the result of deflating the file
> before it gets written to disk.  
> When the file is bigger than physical memory, the kernel has to
> page in parts of the file as well as swap in and out parts of
> that allocated buffer to hold the deflated file.

What are the access pattern of these memory areas ?
Perhaps madvise() could help ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
