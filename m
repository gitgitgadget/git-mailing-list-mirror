From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Mon, 22 Nov 2010 21:21:01 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011222103290.17721@debian>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com> <vpqoc9hsemy.fsf@bauges.imag.fr> <201011221414.15982.trast@student.ethz.ch> <vpq8w0lqyf7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 23 03:21:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKiVB-0002Zv-QP
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 03:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144Ab0KWCU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 21:20:57 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36431 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab0KWCU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 21:20:56 -0500
Received: by qyk12 with SMTP id 12so1122829qyk.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 18:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=LL61yQvyiFArFlNlJXkJGSLS4EQmf1f5zNa5JUXhXr8=;
        b=XorrwYd4imIUGKeBsvZcNGlTS5vGuX8asEpC5NRgY2O2PBKaZwoeTxYVDwA5q6vWa2
         MgTq+t3SVPoBTF4vCgnlkImTZqB9xVwjfHzqAOmoN54c6Rof4g6RvWJVCjN6gtGPGIXz
         m7CfAdc0UhPwoorurv82NSa1nCVNgiE8rn510=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=vhY/nkpjXfkgZEUQX71wUTPafF74Rliq5wy01dKu23J1iC5korqk7w2FpSvQ9sUVij
         HEuGE4smmW8Nbhg8VmExYKVfj5RfdULttPklG2uEEgdGSzfWmhCq27zMW3Fx8YwHEXyn
         ky4v0wUise87l9ZlU5j3ENX20kPAeZ10RsAvc=
Received: by 10.229.183.197 with SMTP id ch5mr5688996qcb.160.1290478855662;
        Mon, 22 Nov 2010 18:20:55 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u2sm3295411qcq.19.2010.11.22.18.20.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 18:20:54 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <vpq8w0lqyf7.fsf@bauges.imag.fr>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161924>



On Mon, 22 Nov 2010, Matthieu Moy wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Matthieu Moy wrote:
>>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>>>
>>>> Remove the undocumented and unused '--verify' flag from interactive
>>>> rebase.
>>>
>>> I don't think this change is good. If a command has a --no-whatever
>>> flag, one expects the --whatever flag to exist too, even if it's a
>>> no-op.
>> [...]
>>> I think a better change would be to add a comment like
>>>
>>> --verify)
>>> 	# no-op, exists because --no-verify exists too.
>>
>> Shouldn't that be
>>
>>   OK_TO_SKIP_PRE_REBASE=
>>
>> instead, so that it undoes the effect of an earlier --no-verify?
>
> Yes, right. Useful when an alias contains --no-whatever in particular.


Alright, how about something like this instead?

(I hope this is the correct way of including a patch. I have only used
'git send-email before'. I noticed that Jeff seems to remove the first
three lines and put a '-- 8> --' before, but others do not. What does
the mysterious header mean?)


----
From 90c14fe48ab921ae60000e4f9de02f97f867e273 Mon Sep 17 00:00:00 2001
From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Date: Mon, 22 Nov 2010 20:42:50 +0100
Subject: [PATCH] rebase: support --verify

Interactive rebase allows the '--verify' option to be passed, but it will
be ignored. Implement proper support for the option for both interactive
and non-interactive rebase by making it override any previous
'--no-verify'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
  Documentation/git-rebase.txt |    4 ++++
  git-rebase--interactive.sh   |    2 ++
  git-rebase.sh                |    3 +++
  3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f3753a8..1f5ce74 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -279,6 +279,10 @@ which makes little sense.
  --no-verify::
  	This option bypasses the pre-rebase hook.  See also linkgit:githooks[5].

+--verify::
+	Allows the pre-rebase hook to run, which is the default.  This option can
+	be used to override --no-verify.  See also linkgit:githooks[5].
+
  -C<n>::
  	Ensure at least <n> lines of surrounding context match before
  	and after each change.  When fewer lines of surrounding
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a27952d..4eabe54 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -28,6 +28,7 @@ continue           continue rebasing process
  abort              abort rebasing process and restore original branch
  skip               skip current patch and continue rebasing process
  no-verify          override pre-rebase hook from stopping the operation
+verify             allow pre-rebase hook to run
  root               rebase all reachable commmits up to the root(s)
  autosquash         move commits that begin with squash!/fixup! under -i
  "
@@ -727,6 +728,7 @@ do
  		OK_TO_SKIP_PRE_REBASE=yes
  		;;
  	--verify)
+		OK_TO_SKIP_PRE_REBASE=
  		;;
  	--continue)
  		is_standalone "$@" || usage
diff --git a/git-rebase.sh b/git-rebase.sh
index 3d194b1..595fca2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -206,6 +206,9 @@ do
  	--no-verify)
  		OK_TO_SKIP_PRE_REBASE=yes
  		;;
+	--verify)
+		OK_TO_SKIP_PRE_REBASE=
+		;;
  	--continue)
  		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
  			die "No rebase in progress?"
-- 
1.7.3.2.190.gfb4ae
