From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: untracked symlinks are less precious than untracked files?
Date: Wed, 2 Feb 2011 23:24:22 +0100
Message-ID: <201102022324.22123.j6t@kdbg.org>
References: <201102022025.06140.j6t@kdbg.org> <7v7hdixkys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 23:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkl7n-0000Ga-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 23:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851Ab1BBWYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 17:24:25 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:25644 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754475Ab1BBWYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 17:24:24 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 333701001D;
	Wed,  2 Feb 2011 23:24:22 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3D14419F6C2;
	Wed,  2 Feb 2011 23:24:22 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v7hdixkys.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165937>

On Mittwoch, 2. Februar 2011, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > Is it by design that symlinks are less precious than files, or is it an
> > oversight?
>
> I don't recall making conscious distinction between symmlinks and regular
> files, so it is likely to be just a bug. Perhaps using stat() where
> lstat() should be used and mistaking an error return as missing, or
> something silly like that?

Hm, I don't think so. It seems to interact with the lstat_cache. When lstat 
reports a symlink, this result is cached; but if it is a regular file, it is 
not cached. I don't know, what the consequences are, though... I have to stop 
my investigations for tonight.

-- Hannes
