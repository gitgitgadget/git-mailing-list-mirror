From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: repo consistency under crashes and power failures?
Date: Tue, 16 Jul 2013 08:17:20 +0200
Message-ID: <51E4E570.1060403@viscovery.net>
References: <rmiy597iujc.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 08:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyyZk-0002LH-SP
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 08:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab3GPGRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 02:17:25 -0400
Received: from so.liwest.at ([212.33.55.13]:32036 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab3GPGRY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 02:17:24 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UyyZc-000687-HG; Tue, 16 Jul 2013 08:17:20 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4BB7D1660F;
	Tue, 16 Jul 2013 08:17:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <rmiy597iujc.fsf@fnord.ir.bbn.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230541>

Am 7/15/2013 19:48, schrieb Greg Troxel:
> Clearly there is the possibility of creating a corrupt repository when
> receiving objects and updating refs, if a crash or power failure causes
> data not to get written to disk but that data is pointed to.  Journaling
> mitigates this, but I'd argue that programs should function safely with
> only the guarantees from POSIX.

Even under POSIX, "guarantees" and "crash/power failure" do not mesh well.
This has been under dispute recently, for example:

http://thread.gmane.org/gmane.comp.standards.posix.austin.general/7456/focus=7487

The best we can achieve with POSIX alone is "to make bad consequences less
likely".

Jonathan already mentioned the knob that allows you to trade performance
for more safety.

-- Hannes
