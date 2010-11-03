From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] pull: Remove --tags option from manpage
Date: Wed, 03 Nov 2010 21:55:48 +0100
Message-ID: <4CD1CC54.1060905@web.de>
References: <20101022053747.a5427cad.coolzone@it.dk> <4CC153A0.7080605@debugon.org> <7vhbgdlxof.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Rico Secada <coolzone@it.dk>,
	Mathias Lafeldt <misfire@debugon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 21:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDkNI-0004qS-9o
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 21:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab0KCUz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 16:55:58 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46183 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab0KCUz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 16:55:57 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id A2E4D17DCCE60;
	Wed,  3 Nov 2010 21:55:48 +0100 (CET)
Received: from [93.240.112.6] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PDkN2-0003NM-00; Wed, 03 Nov 2010 21:55:48 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vhbgdlxof.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19/gAm0Wo1oTjYq/59Cpqf74jHdcFknAhAeEpOp
	H3u1AERLYk9swgS4FLe2jCc2ktXCH7KfrfaNWApnnN7teUTPBn
	zbDfmguXOAdrZ3SuV5kw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160639>

"Fetch all tags and merge them" does not make any sense as a request at
the logical level, even though it might be more convenient to type.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 22.10.2010 23:33, schrieb Junio C Hamano:
> Mathias Lafeldt <misfire@debugon.org> writes:
>> From git-pull's manpage:
>>
>> -t
>> --tags
>>         Most of the tags are fetched automatically as branch
>>         heads are downloaded, but tags that do not point at
>>         objects reachable from the branch heads that are being
>>         tracked will not be fetched by this mechanism.  This
>>         flag lets all tags and their associated objects be
>>         downloaded. [...]
> 
> Can somebody submit a patch to stop this part of "fetch-options.txt" from
> getting included in "git pull" manpage please, by the way?

Maybe something like this?


 Documentation/fetch-options.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 470ac31..5ce1e72 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -53,6 +53,7 @@ endif::git-pull[]
 	behavior for a remote may be specified with the remote.<name>.tagopt
 	setting. See linkgit:git-config[1].

+ifndef::git-pull[]
 -t::
 --tags::
 	Most of the tags are fetched automatically as branch
@@ -63,6 +64,7 @@ endif::git-pull[]
 	downloaded. The default behavior for a remote may be
 	specified with the remote.<name>.tagopt setting. See
 	linkgit:git-config[1].
+endif::git-pull[]

 -u::
 --update-head-ok::
-- 
1.7.3.2.213.g5fe186
