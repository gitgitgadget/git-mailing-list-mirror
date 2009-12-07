From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 1/2] Documentation: 'git add -A' can remove files
Date: Mon, 7 Dec 2009 01:57:32 +0100
Message-ID: <20091207005732.GA20909@atjola.homenet>
References: <4B1C384A.8000106@gmail.com>
 <7vr5r7el2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:57:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRv5-0006cB-If
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229AbZLGA5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 19:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758227AbZLGA5b
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:57:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:36751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758184AbZLGA5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 19:57:30 -0500
Received: (qmail invoked by alias); 07 Dec 2009 00:57:36 -0000
Received: from i59F572C7.versanet.de (EHLO atjola.homenet) [89.245.114.199]
  by mail.gmx.net (mp035) with SMTP; 07 Dec 2009 01:57:36 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/+oZll39b+FST+LEpKC+yx5Z+NqL+EW6yom4zSqH
	vnxTePfA0YVAxu
Content-Disposition: inline
In-Reply-To: <7vr5r7el2q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134704>

On 2009.12.06 15:31:25 -0800, Junio C Hamano wrote:
> I wonder if we can restructure the description of "-u" to make it eas=
ier
> to read, to simplify the description of "-A".

What I usually say on #git is something like:

	"git add <path>" looks at the working tree to find files
	matching <path>.  "git add -u <path>" looks at the index, and
	"git add -A <path>" looks at both. Therefore "add" and "add -A"
	can add new files to the index, and "add -u" and "add -A" can
	remove files from it.

	And for convenience, -u and -A default to "." as the path argument.

So maybe something like this?

-u, --update
    Instead of matching <filepattern> against files in the working tree=
,
    it is matched against the already tracked files in the index. This
    means that it won't find any new files, but can find files already
    deleted from the working tree and remove them from the index. Also,
    if no <filepattern> is given, this option will make it default to
    ".", updating all tracked files in the current directory and its
    subdirectories.

-A, --all
    Like -u, but matches <filepattern> against files in the index in
    addition to the files in working tree. This means that it can find
    new files as well.


Bj=F6rn
