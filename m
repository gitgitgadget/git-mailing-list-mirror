From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: not all tests pass when on an NFS partition
Date: Thu, 12 Feb 2009 18:54:30 -0600
Message-ID: <Aq-rucZsypJQU8SHtTE8X62cEZZn-xSpOOIfA-I5czdtCkm2IyMjDw@cipher.nrlssc.navy.mil>
References: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com> <7vk57vjqsd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: E R <pc88mxer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 01:56:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXmLa-0004YF-QT
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 01:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284AbZBMAyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 19:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758225AbZBMAye
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 19:54:34 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46899 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZBMAye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 19:54:34 -0500
Received: by mail.nrlssc.navy.mil id n1D0sUUU029097; Thu, 12 Feb 2009 18:54:30 -0600
In-Reply-To: <7vk57vjqsd.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 13 Feb 2009 00:54:30.0684 (UTC) FILETIME=[A0E545C0:01C98D75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109698>

Junio C Hamano wrote:
> E R <pc88mxer@gmail.com> writes:
> 
>> When I run 'make test' for git-1.6.1.3 it will fail on this test when
>> running on an NFS partition.
> 
> ... when the filesystem clock and the machine clock are out of sync.

I previously modified t5304 to make test-chmtime modify the mtime of
the file based on the system time rather than the file mtime precisely to
avoid this problem.  i.e. the argument to test-chmtime is now prefixed with '='

So I don't think it is related to out of sync clock on NFS server and client.
There may be a bug in the NFS client though.

>> Is this a known problem? Is this a real problem?

Known by me, but I haven't mentioned it since I haven't had a moment to
diagnose it.

>> My uname -a: Linux XXX 2.6.18-92.1.17.el5 #1 SMP Tue Nov 4 13:45:01
>> EST 2008 i686 athlon i386 GNU/Linux

RHEL 5.2? me too.

RHEL 4.7 works fine, same NFS server (running 5.2).

-brandon
