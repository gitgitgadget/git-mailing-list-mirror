From: Fabien <fabien.ubuntu@gmail.com>
Subject: Re: git-http-push (git v1.5) problems with DAVLockDB on reiserfs
 FS
Date: Thu, 18 Feb 2010 12:36:53 +0100
Message-ID: <hlj8oo$5bv$1@ger.gmane.org>
References: <hlj5ov$rca$1@ger.gmane.org> <be6fef0d1002180305i5f8d32b8p5b8dd30b5c8ff0a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 12:37:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni4hB-0006Pw-Ri
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 12:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595Ab0BRLhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 06:37:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:39445 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354Ab0BRLhV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 06:37:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ni4h4-0006MY-VX
	for git@vger.kernel.org; Thu, 18 Feb 2010 12:37:18 +0100
Received: from lamppc10.epfl.ch ([128.178.154.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 12:37:18 +0100
Received: from fabien.ubuntu by lamppc10.epfl.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 12:37:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lamppc10.epfl.ch
User-Agent: Thunderbird 1.5.0.14ubu (X11/20090319)
In-Reply-To: <be6fef0d1002180305i5f8d32b8p5b8dd30b5c8ff0a3@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140320>

Hi,

Tay Ray Chuan wrote:
> On Thu, Feb 18, 2010 at 6:45 PM, Fabien <fabien.ubuntu@gmail.com> wrote:
>> I encountered many problems when using a git repository served over
>> apache/dav on ubuntu 8.04LTS
>> * versions in use on server:
>> - kernel 2.6.24
>> - apache 2.2.8
>> - git version 1.5.4.3 or 1.6.6.2 (doesn't change anything on server side)
> 
> although nothing might have changed on the server-side, git does a lot
> of server-side operations via WebDAV, like locking, moving files, etc.

Yes, I forgot to say the problem is related to locking problems on the
server side :
Could not LOCK /git-tests/project1.git/info/refs due to a failed
precondition (e.g. other locks)

This is why I tested another file system, because I already had problems
in the past with reiserfs and locking :)

>> * versions in use on clients
>> git 1.5.4.3 => causes problem
>> git 1.6.6.2 => is ok.
> 
> why not just use git 1.6?
Yes, but I have to tell that to around 100 contributors ;-)
I plan to use a rule in apache to deny access to old versions of git...

--
Fabien
