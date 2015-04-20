From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-p4: Use -m when running p4 changes
Date: Mon, 20 Apr 2015 11:04:30 -0700
Message-ID: <xmqq383un0b5.fsf@gitster.dls.corp.google.com>
References: <CALM2SnY4GZDSYOjLmDqdq9SgGGywRO2A3XU3639E_0JAh-2P5A@mail.gmail.com>
	<1429542020-11121-1-git-send-email-lex@lexspoon.org>
	<CAE5ih79BLm1LbZersZeOxShq=W4X5xaPHE1cDwctA5cJOSLRJA@mail.gmail.com>
	<xmqq7ft6n0rn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lex Spoon <lex@lexspoon.org>, Git Users <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkG3h-0004yp-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbbDTSEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:04:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752521AbbDTSEc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:04:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24FE049F07;
	Mon, 20 Apr 2015 14:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/p4AH/rSyGISQ7iDNdrM/m0qEvs=; b=hSHTSC
	p7jf6QGkq5APzb73g+Tir5c9YeC8iiEI9TXmFyx2Uo0mXBRKkmn3hNZ91qfE38hC
	bNOvJTFpU7wLE9T0Iz2w3HDk2Uy9uVNXagZ+riA6HCqm1vEatqMGQ6s7nGVy73uu
	SwWX/DmsqAzRfvjtzGGoRovIUEHjbkSQ6KODE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ia7xJkAYW1hV+MGkrlJkDiPdn8OCPuyL
	Kl+UXs2PSk7IRIfhchdZ7vV6xadqtOqvJt+3cNMcqfyAEHYls+24NN6ltfh9Ykxe
	U4DKy8kMsAjDe05FGGYsXpEq/hjc7C2SXiE1+7TtAhk+sosf7JXv2WJ2nNVqiko0
	CNZ6QtJMN+8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D6AD49F06;
	Mon, 20 Apr 2015 14:04:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9360049F04;
	Mon, 20 Apr 2015 14:04:31 -0400 (EDT)
In-Reply-To: <xmqq7ft6n0rn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 20 Apr 2015 10:54:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1B7BE64-E787-11E4-9362-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267480>

Junio C Hamano <gitster@pobox.com> writes:

> Luke Diamand <luke@diamand.org> writes:
>
>> Sorry - could you resubmit your patch (PATCHv4 it will be) with this
>> change squashed in please? It will make life much easier, especially
>> for Junio!
>
> Thanks for caring, but this seems to be a full patch to replace v3.
>
> It was sent with your Reviewed-by already in, but I'd tentatively
> remove that line while queuing it to 'pu' and ask you to double
> check if the patch makes sense (and after your "yes, it does", I'd
> add the Reviewed-by back).
>
> Thanks.

Just to make it easier to see, the interdiff between v3 and v4 looks
like this:

 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1fba3aa..e28033f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2608,7 +2608,7 @@ class P4Sync(Command, P4UserMap):
 
         return ""
 
-    def importNewBranch(self, branch, maxChange, changes_block_size):
+    def importNewBranch(self, branch, maxChange):
         # make fast-import flush all changes to disk and update the refs using the checkpoint
         # command so that we can try to find the branch parent in the git history
         self.gitStream.write("checkpoint\n\n");
@@ -2616,7 +2616,7 @@ class P4Sync(Command, P4UserMap):
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
         #print "prefix" + branchPrefix
-        changes = p4ChangesForPaths([branchPrefix], range, changes_block_size)
+        changes = p4ChangesForPaths([branchPrefix], range, self.changes_block_size)
         if len(changes) <= 0:
             return False
         firstChange = changes[0]
