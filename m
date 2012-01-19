From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add: allow --ignore-missing always, not just in dry run
Date: Thu, 19 Jan 2012 12:03:17 +0100
Message-ID: <8762g87y4q.fsf@thomas.inf.ethz.ch>
References: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
	<7vobu0liwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 12:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnpm9-0003Al-9K
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 12:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab2ASLDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 06:03:21 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:58075 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410Ab2ASLDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 06:03:20 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 12:03:15 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 12:03:17 +0100
In-Reply-To: <7vobu0liwj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 18 Jan 2012 14:56:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188809>

[dropped Dieter as this really goes off on an internal tangent]

Junio C Hamano <gitster@pobox.com> writes:

> If somebody is writing a script using "git add" (which is not recommended
> to begin with)

Can we still stick to that stance?  Our tests are increasingly using
'git add' instead of 'git update-index --add':

  $ git grep 'git[ -]add' t/ | wc -l
  1540
  $ git grep 'git[ -]update-index --add' t/ | wc -l
  269
  $ git grep 'git[ -]update-index --add' v1.6.0 t/ | wc -l
  251
  $ git grep 'git[ -]add' v1.6.0 t/ | wc -l
  705

So while git(1) still says git-add is porcelain (and thus not to be used
for scripting), it has mostly superseded 'git update-index --add' in new
script usage even within git.git.  I suspect the same goes for things
like git-rm, git-commit, etc.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
