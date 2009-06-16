From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Tue, 16 Jun 2009 13:30:21 -0700
Message-ID: <4A3800DD.10809@zytor.com>
References: <200906142238.51725.j6t@kdbg.org> <200906152339.43607.j6t@kdbg.org> <4A36C086.5010306@zytor.com> <200906162227.00377.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 22:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGfIi-000162-Gj
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 22:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZFPUa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 16:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZFPUa0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 16:30:26 -0400
Received: from terminus.zytor.com ([198.137.202.10]:53948 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZFPUa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 16:30:26 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5GKULbG016700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Jun 2009 13:30:21 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200906162227.00377.j6t@kdbg.org>
X-Virus-Scanned: ClamAV 0.94.2/9472/Tue Jun 16 10:24:06 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121713>

Johannes Sixt wrote:
> On Montag, 15. Juni 2009, H. Peter Anvin wrote:
>> Johannes Sixt wrote:
>>> The progress indicator can be helped . But there is now another anoyance:
>>> If the client terminates the connection early, this is now logged as:
>>>
>>> fatal: unable to run 'git-upload-pack'
>> We probably do want to log that the client has disconnected.
> 
> Any client, or only clients that disconnect early? Is this useful besides 
> debugging?
> 

Clients that disconnect without completing the transaction.  This is
highly valuable to administrators when tracking down a problem (since it
generally implies a client or network problem, as opposed to a server
problem.)

	-hpa
