From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: [PATCH v2] Fix buffer overflow in config parser
Date: Tue, 14 Apr 2009 23:47:44 +0200
Message-ID: <49E50480.5060005@intra2net.com>
References: <49E50003.2040907@intra2net.com> <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 23:49:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtqVN-0003l9-Rn
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbZDNVrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbZDNVrs
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:47:48 -0400
Received: from rs02.intra2net.com ([81.169.173.116]:38159 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbZDNVrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:47:47 -0400
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id DD3874FCF;
	Tue, 14 Apr 2009 23:47:45 +0200 (CEST)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 7F6722AC4B;
	Tue, 14 Apr 2009 23:47:45 +0200 (CEST)
Received: from pikkukde.a.i2n (pikkukde.m.i2n [192.168.12.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 1653E2AC4A;
	Tue, 14 Apr 2009 23:47:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de>
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure AntiVirus (fsavdb 2009-04-14_08)
X-Spam-Status: hits=-2.9 tests=[ALL_TRUSTED=-1.8,BAYES_05=-1.11]
X-Spam-Level: 971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116580>

Johannes Schindelin wrote:
>> +LONG_VALUE=`perl -e 'print "x" x 1023," a"'`
> 
> But should it not be guarded against NO_PERL?

Hmm, lots of other tests like "t4200-rerere.sh" use perl
and it don't see any special guard around the perl usage.

If it's needed, just add it while applying :-)

Thomas
