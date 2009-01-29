From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git gc" removes ".git/refs/heads/master".
Date: Thu, 29 Jan 2009 12:07:05 -0800
Message-ID: <7vy6wtev12.fsf@gitster.siamese.dyndns.org>
References: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Bernd Lommerzheim <bernd@lommerzheim.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 21:08:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSdBo-0000YH-NJ
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 21:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbZA2UHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 15:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbZA2UHM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 15:07:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbZA2UHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 15:07:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CDA942A076;
	Thu, 29 Jan 2009 15:07:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0911A2A071; Thu,
 29 Jan 2009 15:07:06 -0500 (EST)
In-Reply-To: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net> (Bernd
 Lommerzheim's message of "Thu, 29 Jan 2009 20:31:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6905FEB6-EE40-11DD-B312-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107726>

Bernd Lommerzheim <bernd@lommerzheim.com> writes:

> Hi,
>
> maybe I found a bug in git. When I execute "git gc" in my local repository,
> git removes the file ".git/refs/heads/master". Is this an intended behavior
> (but why?) or is that a bug?
>
> Some commands to reproduce:
> ~ $ mkdir tmp; cd tmp
> ~/tmp $ git init
> Initialized empty Git repository in /home/myuser/tmp/.git/
> ~/tmp $ echo "content" > a
> ~/tmp $ git add .
> ~/tmp $ git commit -a -m "first commit"
> Created initial commit 0b67f33: first commit
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 a
> ~/tmp $ cat .git/refs/heads/master
> 0b67f33fff4152a912fdbe8819480b8fc1f2e990
> ~/tmp $ git gc
> Counting objects: 3, done.
> Writing objects: 100% (3/3), done.
> Total 3 (delta 0), reused 0 (delta 0)
> ~/tmp $ cat .git/refs/heads/master
> cat: .git/refs/heads/master: No such file or directory
> ~/tmp $ cat .git/HEAD
> ref: refs/heads/master
> ~/tmp $ 

$ grep master .git/packed-refs
