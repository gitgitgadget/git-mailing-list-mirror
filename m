From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 13/16] t3700: Skip a test with backslashes in pathspec
Date: Sun, 22 Mar 2009 17:55:44 +0100
Message-ID: <200903221755.44642.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org> <6acd113f60d1b0e7926386f3aebe5d72ad362034.1237667830.git.j6t@kdbg.org> <7v3ad6cvub.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 18:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlR29-0005hL-Pb
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 18:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbZCVQ65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 12:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbZCVQ64
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 12:58:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:21345 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbZCVQ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 12:58:56 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E4A3B1012E;
	Sun, 22 Mar 2009 17:55:49 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B88243BED1;
	Sun, 22 Mar 2009 17:55:44 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v3ad6cvub.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114153>

On Sonntag, 22. M=E4rz 2009, Junio C Hamano wrote:
> I do not think the justification for this change is explained well en=
ough.
>
> The test prepares a file whose name consists of "ef, oh, bra, oh, you=
,
> ket, bee, ei and are" (no backslashes), and passes a filespec that qu=
otes
> bra and ket with backslash so glob won't misinterpret as if we are as=
king
> to add "ef oh followed by either oh or you followed by bee ei are".  =
There
> is no path that has a backslash in it involved.
>
> If this does not work on Windows, there is something else going on.  =
Is it
> that the shell eats one level of backslash too much or something?

I added these two paragraphs:

The test verifies that glob special characters can be escaped with
backslashes.  In particular, the string fo\[ou\]bar is given to git.

On Windows, this does not work because backslashes are first of all
directory separators, and first thing git does with a pathspec from the
command line is to convert backslashes to forward slashes.

-- Hannes
