From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Fri, 22 Jan 2010 19:34:02 +0100
Message-ID: <201001221934.03346.j6t@kdbg.org>
References: <718290.769818367-sendEmail@darysmbp> <7vd412ac8c.fsf@alter.siamese.dyndns.org> <7vr5pi8x6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "David Rydh" <dary@math.berkeley.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYOLp-0008Dm-W6
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 19:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab0AVSfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 13:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148Ab0AVSfK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 13:35:10 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:33258 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756084Ab0AVSfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 13:35:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B56D2CDF83;
	Fri, 22 Jan 2010 19:35:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9872519F6BA;
	Fri, 22 Jan 2010 19:34:03 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vr5pi8x6z.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137772>

On Freitag, 22. Januar 2010, Junio C Hamano wrote:
> Why does '/' matter in builtin-mv.c that needed b8f2626, but we can
> compare with '/' [in make_relative_path()]?

We should be using is_dir_sep() in make_relative_path() as well (see the fixup 
that I posted in response to your patch). The thing is that the incorrect 
result does not matter from a correctness-POV for the only caller of this 
routine.

-- Hannes
