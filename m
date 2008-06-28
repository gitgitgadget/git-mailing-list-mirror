From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Documentation: Don't assume git-sh-setup and
 git-parse-remote are in the PATH
Date: Sat, 28 Jun 2008 14:05:51 -0700
Message-ID: <7vvdztmfrk.fsf@gitster.siamese.dyndns.org>
References: <20080627151001.BIA19424@m4500-01.uchicago.edu>
 <20080628205817.GB3172@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 23:07:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KChdU-0005pA-V9
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 23:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbYF1VGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYF1VGD
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 17:06:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYF1VGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 17:06:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A359F13477;
	Sat, 28 Jun 2008 17:05:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E2EAA13474; Sat, 28 Jun 2008 17:05:53 -0400 (EDT)
In-Reply-To: <20080628205817.GB3172@steel.home> (Alex Riesen's message of
 "Sat, 28 Jun 2008 22:58:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 022617E6-4556-11DD-A189-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86744>

Alex Riesen <raa.lkml@gmail.com> writes:

> Jonathan Nieder, Fri, Jun 27, 2008 22:10:01 +0200:
>>  --------
>> +[verse]
>> +'PATH=$(git --exec-path):$PATH'
>>  '. git-parse-remote'
>
> You missed quoting. exec-path can contain whitespace.

Do you understand shell quoting rules?

	$ foo='c d'
	$ foo=$(echo a b):$foo
        $ echo "$foo"
        a b:c d
        $ exit

> What do you need exec-path in PATH for?

When git-parse-remote is not installed in $(bindir) anymore, the shell
script library won't be found on user's $PATH in general.
