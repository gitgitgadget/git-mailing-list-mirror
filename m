From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Fix git rev-list --reverse --max-count=N
Date: Wed, 27 Jan 2010 23:09:25 +0100
Message-ID: <201001272309.26054.j6t@kdbg.org>
References: <1264622600-20981-1-git-send-email-spang@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Michael Spang <spang@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaG6f-0005SB-PV
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 23:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153Ab0A0WKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 17:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162Ab0A0WKk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 17:10:40 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:34480 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756116Ab0A0WKi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 17:10:38 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3A2B72C400D;
	Wed, 27 Jan 2010 23:10:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2AABA19F609;
	Wed, 27 Jan 2010 23:09:26 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1264622600-20981-1-git-send-email-spang@google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138199>

On Mittwoch, 27. Januar 2010, Michael Spang wrote:
> Using --max-count with --reverse currently outputs the last N commits
> in the final output rather than the first N commits. We want to
> truncate the reversed list after the first few commits, rather than
> truncating the initial list and reversing that.

So when you have this history (A is oldest, D is newest):

   A--B--C--D

and you say

   git log --max-count=2 --reverse D

then you want

   A
   B

but I want

   C
   D

Why is your interpretation correct, an mine wrong?

-- Hannes
