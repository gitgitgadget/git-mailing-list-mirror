From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Repository specific git commands
Date: Mon, 7 Jan 2008 14:15:59 +0200
Message-ID: <8e04b5820801070415j5166c2eco53760cffe1ab1efb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13944_13728671.1199708159227"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 13:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBqu5-0007bc-Ue
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 13:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbYAGMQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 07:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755623AbYAGMQD
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 07:16:03 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:44533 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755499AbYAGMQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 07:16:00 -0500
Received: by hs-out-2122.google.com with SMTP id 54so5242118hsz.5
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 04:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=IN2yA0xWAETnzX8n57OTnhaJCJFP3J7nS/qzM/qam3o=;
        b=SA83zeVfzjDYVKfI/+T6RfiPYfzTWzOxrzc+9OE0pr7FlvutsvITRa+dLWdJRVpwJC43yp47WwmTxAR8fgR8ChDe3M0Di8oPBK4Ic36JakUngVMotxsRBwdOn/PuDdTSlJxUUK1439c/SbCmO6hJ9ZUcAOHKLITDiiqgAN2Szqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=kUcWfa4Z+dHOWYXv6cOK1a4fRNk4OEXOnLCJUmn6d9BoWT6avB6BycdaSs7SjVqeHepIJJFlIiIjFjPHvUtUYN3I+FGOpsaHrMU7HAeu3fP3RZSvVkluqhiMCwWy/p/pvmg99gZrwkbKzRd+GVpWEoLZjuSn6eQI/2/2lyyftRU=
Received: by 10.150.148.7 with SMTP id v7mr5368618ybd.95.1199708159264;
        Mon, 07 Jan 2008 04:15:59 -0800 (PST)
Received: by 10.150.11.9 with HTTP; Mon, 7 Jan 2008 04:15:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69785>

------=_Part_13944_13728671.1199708159227
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

    Hello all!

    I have a question / proposal: I see on the mailing list a lot of
situations when some commands (or group of commands) are very often
used and the users demand (or would like to have) a special "git xxx"
command for them. But adding such a command -- in almost all cases --
is not worth the effort or increases the number of available commands
(thus confusing even more the users).

    Thus the users are left with only two possibilities:
    -- either define an alias -- but usually it is very restrictive in
terms of what the alias can do;
    -- create a custom git command "git-xxx" and place it in the
executable path -- but this requires root access.
    (-- or write a custom script but this can not be invoked as "git xxx")
    => Thus neither option is very useful.

    So my proposal is to let the users create a special folder inside
the .git directory, for example ".git/bin" where they can place custom
built git files like "git-xxx", and when they issue "git xxx" this
folder is searched first, and if the command is found it will be
executed as any other "git-xxx".

    For this I attach a very simple patch that implements it. (It
modifies the execv_git_cmd function by adding a new path in the paths
array.)

    Comments? Opinions? Other solutions that I am not aware of?

    (Please note that I am a git user for only a couple of months, and
this is the first time I look over git source code...)

    Thanks,
    Ciprian Craciun.

------=_Part_13944_13728671.1199708159227
Content-Type: text/x-diff; name=patch.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fb4yteu8
Content-Disposition: attachment; filename=patch.diff

ZGlmZiAtLWdpdCBhL2V4ZWNfY21kLmMgYi9leGVjX2NtZC5jCmluZGV4IDliNzRlZDIuLjkwODI3
MTEgMTAwNjQ0Ci0tLSBhL2V4ZWNfY21kLmMKKysrIGIvZXhlY19jbWQuYwpAQCAtMzAsMTEgKzMw
LDMyIEBAIGNvbnN0IGNoYXIgKmdpdF9leGVjX3BhdGgodm9pZCkKIH0KIAogCitzdGF0aWMgY29u
c3QgY2hhciAqZ2l0X3JlcG9fZXhlY19wYXRoKHZvaWQpCit7CisJc3RhdGljIGNoYXIgcGF0aF9i
dWZmZXJbUEFUSF9NQVggKyAxXTsKKwlzdGF0aWMgY2hhciAqcGF0aCA9IE5VTEw7CisJCisJaWYg
KCFwYXRoKSB7CisJCXBhdGggPSBwYXRoX2J1ZmZlcjsKKwkJcGF0aFswXSA9ICdcMCc7CisJCWlm
IChnZXRfZ2l0X2RpcigpKSB7CisJCQlzdHJuY2F0KHBhdGgsIGdldF9naXRfZGlyKCksIFBBVEhf
TUFYKTsKKwkJCXN0cm5jYXQocGF0aCwgIi8iLCBQQVRIX01BWCk7CisJCQlzdHJuY2F0KHBhdGgs
ICJiaW4iLCBQQVRIX01BWCk7CisJCX0KKwl9CisJCisJcmV0dXJuIHBhdGg7Cit9CisKKwogaW50
IGV4ZWN2X2dpdF9jbWQoY29uc3QgY2hhciAqKmFyZ3YpCiB7CiAJY2hhciBnaXRfY29tbWFuZFtQ
QVRIX01BWCArIDFdOwogCWludCBpOwotCWNvbnN0IGNoYXIgKnBhdGhzW10gPSB7IGN1cnJlbnRf
ZXhlY19wYXRoLAorCWNvbnN0IGNoYXIgKnBhdGhzW10gPSB7CisJCQkJZ2l0X3JlcG9fZXhlY19w
YXRoKCksCisJCQkJY3VycmVudF9leGVjX3BhdGgsCiAJCQkJZ2V0ZW52KEVYRUNfUEFUSF9FTlZJ
Uk9OTUVOVCksCiAJCQkJYnVpbHRpbl9leGVjX3BhdGggfTsKIAo=
------=_Part_13944_13728671.1199708159227--
