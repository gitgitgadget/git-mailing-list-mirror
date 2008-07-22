From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for master] Rename path_list to string_list
Date: Tue, 22 Jul 2008 13:09:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807221308050.3391@eeepc-johanness>
References: <alpine.DEB.1.00.0807211858330.8986@racer> <alpine.DEB.1.00.0807211904090.8986@racer> <7v3am2sldy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLFkn-0007dB-IA
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 13:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbYGVLJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 07:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbYGVLI7
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 07:08:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:49051 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755446AbYGVLI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 07:08:58 -0400
Received: (qmail invoked by alias); 22 Jul 2008 11:08:57 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp052) with SMTP; 22 Jul 2008 13:08:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RI419/FyRS7tdxMnV9R4DnClMigjGXgGv4heVkJ
	zZ2ceYpP8dctgO
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v3am2sldy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89484>

Hi,

On Mon, 21 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -64,9 +65,10 @@ Functions
> >  
> >  `string_list_clear`::
> >  
> > -	Free a string_list. The `path` pointer of the items will be freed in case
> > -	the `strdup_strings` member of the string_list is set. The second parameter
> > -	controls if the `util` pointer of the items should be freed or not.
> > +	Free a string_list. The `path` pointer of the items will be freed in
> > +	case the `strdup_strings` member of the string_list is set. The second
> > +	parameter controls if the `util` pointer of the items should be freed
> > +	or not.
> 
> Missed 's/path/string/' here?

Good catch.  I clearly forgot to grep for "path" in all the files that I 
touched.  I did that now, but only looked at comments (in the hope that 
the compiler would have caught the other ones).

-- snipsnap --
[PATCH] Fix two leftovers from path_list->string_list

In the documentation, where you cannot get compile errors for using the
wrong member name, there were two mentions of 'path' left.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-string-list.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 92b3ecd..293bb15 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -41,7 +41,7 @@ memset(&list, 0, sizeof(struct string_list));
 string_list_append("foo", &list);
 string_list_append("bar", &list);
 for (i = 0; i < list.nr; i++)
-	printf("%s\n", list.items[i].path)
+	printf("%s\n", list.items[i].string)
 ----
 
 NOTE: It is more efficient to build an unsorted list and sort it
@@ -113,7 +113,7 @@ Data structures
 
 * `struct string_list_item`
 
-Represents an item of the list. The `path` member is a pointer to the
+Represents an item of the list. The `string` member is a pointer to the
 string, and you may use the `util` member for any purpose, if you want.
 
 * `struct string_list`
-- 
1.5.6.2.516.g22071
