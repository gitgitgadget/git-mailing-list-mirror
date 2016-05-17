From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Tue, 17 May 2016 11:05:06 +0200
Message-ID: <vpqvb2drr5p.fsf@anie.imag.fr>
References: <20160517032247.25092-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 11:05:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2awH-0004mJ-7q
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 11:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbcEQJFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 05:05:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42428 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbcEQJFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 05:05:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4H9564q003420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 17 May 2016 11:05:06 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4H956lP029166;
	Tue, 17 May 2016 11:05:06 +0200
In-Reply-To: <20160517032247.25092-1-sbeller@google.com> (Stefan Beller's
	message of "Mon, 16 May 2016 20:22:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 17 May 2016 11:05:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4H9564q003420
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464080706.68699@3CBe8NL/1e3zRL0SFle2mg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294861>

Stefan Beller <sbeller@google.com> writes:

> The end goal of this (unfinished) series is to close all intentional memory
> leaks when enabling the -DFREE_ALL_MEMORY switch. This is just
> demonstrating how the beginning of such a series could look like.

One potential issue with this is: if all developers and the testsuite
use this -DFREE_ALL_MEMORY, the non-free-all-memory setup will not be
well tested, and still this is the one used by real people. For example,
if there's a really annoying memory leak hidden by FREE_ALL_MEMORY, we
may not notice it.

Perhaps it'd be better to activate FREE_ALL_MEMORY only when tools like
valgrind or so is used.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
