From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Documentation/git.txt: Mention unsupported use of
	--git-dir/GIT_DIR
Date: Tue, 25 Mar 2008 01:10:28 +0000
Message-ID: <20080325011408.5507.86924.julian@quantumfyre.co.uk>
References: <fs9f0o$jge$1@ger.gmane.org>
	<Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
	<7v1w5zslv5.fsf@gitster.siamese.dyndns.org>
	<7vve3br6ct.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0803250045120.30488@kaos.quantumfyre.co.uk>
Cc: Michael Gebetsroither <gebi@sbox.tugraz.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 02:17:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdxnB-0000dq-QC
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 02:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbYCYBQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 21:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbYCYBQx
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 21:16:53 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:55729 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753162AbYCYBQw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 21:16:52 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4366375C8D
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 01:16:51 +0000 (GMT)
Received: (qmail 13273 invoked by uid 103); 25 Mar 2008 01:16:40 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.025011 secs); 25 Mar 2008 01:16:40 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 25 Mar 2008 01:16:40 +0000
X-git-sha1: 7f91c194ba03e01331ccc7e8f0e56d94263b620d 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <Pine.LNX.4.64.0803250045120.30488@kaos.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78140>

We don't support using --git-dir/GIT_DIR to change the name of the
.git directory, so make this clear in the documentation.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
On Tue, 25 Mar 2008, Julian Phillips wrote:

> On Mon, 24 Mar 2008, Junio C Hamano wrote:
>
>>  Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > >  Well, git won't allow .git as a element anywhere in the path, when
we
>> > >  should only care about the _first_ one - and also, if you use
>> > >  --git-dir=banana then we still check for '.git' ... oops.
>> > 
>> >  That's not how git-dir is supposed to used, so there is no oops.
>> 
>>  The only purpose of git-dir is to have $GIT_DIR elsewhere _outside_ the
>>  work tree.
>
> That's fair enough.  It's not enforced, or discourgaed in the
> documentation though.  Would a patch to mention that using --git-dir/GIT_DIR
> to change the name _inside_ the work tree is not supported be accepted?

i.e. this ...

 Documentation/git.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3ed24d4..28cce7f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -134,7 +134,8 @@ help ...'.
 
 --git-dir=<path>::
 	Set the path to the repository. This can also be controlled by
-	setting the GIT_DIR environment variable.
+	setting the GIT_DIR environment variable. Setting this to use a name
+	other than `.git` _inside_ the working tree is not supported.
 
 --work-tree=<path>::
 	Set the path to the working tree.  The value will not be
@@ -391,7 +392,8 @@ git so take care if using Cogito etc.
 'GIT_DIR'::
 	If the 'GIT_DIR' environment variable is set then it
 	specifies a path to use instead of the default `.git`
-	for the base of the repository.
+	for the base of the repository. Setting this to use a name
+	other than `.git` _inside_ the working tree is not supported.
 
 'GIT_WORK_TREE'::
 	Set the path to the working tree.  The value will not be
-- 
1.5.4.4
