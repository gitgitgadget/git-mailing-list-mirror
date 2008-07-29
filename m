From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Tue, 29 Jul 2008 02:17:51 +0200
Message-ID: <20080729001751.GH10151@machine.or.cz>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann> <alpine.DEB.1.00.0807281605330.8986@racer> <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:18:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcvZ-0005xI-MO
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 02:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbYG2ARz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 20:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYG2ARy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 20:17:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58760 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753707AbYG2ARx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 20:17:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7F317393A64B; Tue, 29 Jul 2008 02:17:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90535>

On Mon, Jul 28, 2008 at 12:19:19PM -0700, Junio C Hamano wrote:
> We need to refresh the entry to pick up potential ctime changes.
> 
>  read-cache.c       |    7 ++++++-
>  builtin-ls-files.c |   21 +++++++++++++++------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 1cae361..834096f 100644

Oops, silly me. Sorry for being slower than you at fixing this. ;-)

> diff --git a/builtin-ls-files.c b/builtin-ls-files.c
> index e8d568e..a6b30c8 100644

If you are going to apply this, you might be interested in squashing
this:

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index f43af41..2ead7af 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -53,7 +53,14 @@ OPTIONS
 
 -s::
 --stage::
-	Show stage files in the output
+	Show cached files in an extended format also listing the entry
+	mode, sha1 and stage number; see below for details.
+
+-S::
+--stat::
+	Show cached files in a special format listing stat information
+	stored in the index; this is useful probably only for Git
+	debugging purposes.
 
 --directory::
 	If a whole directory is classified as "other", show just its

(and even if you aren't, maybe the first part is useful, though it's
minor.)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
