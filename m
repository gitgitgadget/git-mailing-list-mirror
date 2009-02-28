From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ensure proper setup of git_dir for git-hash-object
Date: Sat, 28 Feb 2009 12:59:50 -0800
Message-ID: <7v3adyffax.fsf@gitster.siamese.dyndns.org>
References: <1235851009-16739-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 28 22:01:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdWJX-0004l7-3S
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 22:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbZB1VAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 16:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbZB1VAK
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 16:00:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZB1VAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 16:00:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 376719E9D0;
	Sat, 28 Feb 2009 16:00:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 081DB9E9C7; Sat,
 28 Feb 2009 16:00:01 -0500 (EST)
In-Reply-To: <1235851009-16739-1-git-send-email-newren@gmail.com>
 (newren@gmail.com's message of "Sat, 28 Feb 2009 12:56:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C616133C-05DA-11DE-A7EA-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111790>

newren@gmail.com writes:

> Without this patch:
> $ mkdir tmp
> $ cd tmp/
> $ git init --bare
> Initialized empty Git repository in /home/newren/floss-development/git/tmp/
> $ echo hi | git hash-object -w --stdin
> error: unable to create temporary sha1 filename .git/objects/45: No such file or directory
>
> fatal: Unable to add stdin to database
> $ echo hi | git --git-dir=. hash-object -w --stdin
> 45b983be36b73c0788dc9cbcb76cbb80fc7bb057

Does the patched version work without -w option?  Should it?
