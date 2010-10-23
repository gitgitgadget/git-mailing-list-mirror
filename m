From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Sat, 23 Oct 2010 21:34:03 +0200
Message-ID: <vpqwrp8k8k4.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
	<20101023190817.GL21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:35:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jsY-0003L4-G2
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab0JWTeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:34:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59877 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451Ab0JWTeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:34:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9NJJXvJ008924
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 21:19:34 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P9jqu-00080g-9M; Sat, 23 Oct 2010 21:34:04 +0200
In-Reply-To: <20101023190817.GL21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 14\:08\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 23 Oct 2010 21:19:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9NJJXvJ008924
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288466377.11019@37flvh/GDZhA2/kIyzDlEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159823>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -1716,6 +1721,10 @@ one step:
>>  $ git pull origin master
>>  -------------------------------------------------
>>
>> +This command will fetch the changes from the remote branch to your
>> +remote-tracking branch `origin/master`, and merge the result in the
>> +current branch.
>> +
>
> I wish. :)  Actually this fetched to FETCH_HEAD and left origin/master
> alone the last time I checked.

Woops, right. I actually learnt and experimented that behavior today
when reading the doc, so I've got no excuse ;-).

We can drop this hunk, but I think it's important for users to
understand the two steps of "git pull". What about this:

@@ -1716,14 +1721,19 @@ one step:
 $ git pull origin master
 -------------------------------------------------

-In fact, if you have "master" checked out, then by default "git pull"
-merges from the HEAD branch of the origin repository.  So often you
-can
+In fact, if you have "master" checked out, then this branch has been
+configured by "git clone" to get changes from the HEAD branch of the
+origin repository.  So often you can
 accomplish the above with just a simple

 -------------------------------------------------
 $ git pull
 -------------------------------------------------

+This command will fetch the changes from the remote branches to your
+remote-tracking branches `origin/*`, and merge default branch in the
+current branch.
+
 More generally, a branch that is created from a remote-tracking
 branch
 will pull
 by default from that branch.  See the descriptions of the


The difficulty is to be technically sound and still helpfull. I've
written "merge default branch" to avoid entering the details of the
--set-upstream stuff, and avoid saying "merge one of the branch"
too ;-).

(the first part of the patch is just to make it technically accurate)

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
