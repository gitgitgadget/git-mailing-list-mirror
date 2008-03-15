From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something strange has happened to my git HEADs.
Date: Sat, 15 Mar 2008 11:32:18 -0700
Message-ID: <7vwso3n8i5.fsf@gitster.siamese.dyndns.org>
References: <m38x0j51bw.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
X-From: git-owner@vger.kernel.org Sat Mar 15 19:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JabBt-0007xp-Es
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 19:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYCOSc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 14:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbYCOSc1
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 14:32:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYCOSc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 14:32:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4981B2E43;
	Sat, 15 Mar 2008 14:32:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2BB712E41; Sat, 15 Mar 2008 14:32:21 -0400 (EDT)
In-Reply-To: <m38x0j51bw.fsf@maximus.localdomain> (Krzysztof Halasa's message
 of "Sat, 15 Mar 2008 18:44:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77336>

Krzysztof Halasa <khc@pm.waw.pl> writes:

> 2. Working dirs using this repo are in /usr/src/linux* and
> /usr/src/linux-test is one of them, currently (.git dir):
> lrwx 1      30 2007-10-09 00:55 config -> ~/scm/linux-2.6/config
> lrwx 1      35 2007-08-24 18:33 description -> ~/scm/linux-2.6/description
> -rw- 1     126 2008-02-01 21:39 FETCH_HEAD
> lrwx 1      19 2008-03-15 17:52 HEAD -> refs/heads/eelogger
> -rw- 1 2220597 2008-03-15 17:56 index
> drwx 2    4096 2008-03-15 17:57 info
> -rw- 1   21482 2008-03-15 17:57 info/refs
> lrwx 1      28 2007-08-24 18:33 logs -> ~/scm/linux-2.6/logs
> lrwx 1      31 2007-08-24 18:33 objects -> ~/scm/linux-2.6/objects
> -rw- 1      41 2008-03-15 17:56 ORIG_HEAD
> -rw- 1   17909 2008-03-15 17:56 packed-refs
> lrwx 1      28 2007-08-24 18:33 refs -> ~/scm/linux-2.6/refs

This is wrong.  How did you set this up initially?

If you are putting a work tree by symlinking contents of its .git
directory, info and packed-refs are alsy symlinked.  See how
contrib/workdir/git-new-workdir does this.
