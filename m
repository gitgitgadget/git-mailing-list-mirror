From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Tue, 04 Sep 2012 20:48:42 +0200
Message-ID: <50464D0A.9050502@kdbg.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org> <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de> <7vpq64f935.fsf@alter.siamese.dyndns.org> <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de> <7v1uijexor.fsf@alter.siamese.dyndns.org> <003601cd8a0f$6a792840$3f6b78c0$@schmitz-digital.de> <7vzk55bu8s.fsf@alter.siamese.dyndns.org> <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:49:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yBR-0004Mh-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 20:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab2IDSst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 14:48:49 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:39602 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757486Ab2IDSss (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 14:48:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 05FD8CDF8E;
	Tue,  4 Sep 2012 20:48:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7B99019F3FD;
	Tue,  4 Sep 2012 20:48:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204764>

Am 04.09.2012 19:23, schrieb Joachim Schmitz:
>> From: Junio C Hamano [mailto:gitster@pobox.com]
>> Only with the observation of "clone", I cannot tell if your timer is
>> working.  You can try repacking the test repository you created by
>> your earlier "git clone" with "git repack -a -d -f" and see what
>> happens.
> 
> It does update the counter too.

Last time I looked at the progress code, it updated the progress text
also every time the percent value changed. If you have a large count or
large objects such that it takes more than a second to increase the
percentage, than you don't get a smooth progress. Nor do you for phases
that do not have a percentage, like the "counting objects" phase of
pack-objects.

-- Hannes
