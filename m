From: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "reword"
Date: Tue, 06 Oct 2009 09:03:22 +0200
Message-ID: <4ACAEBBA.9000806@gmail.com>
References: <4ACA1BD1.6050905@gmail.com> <4ACAACAB.3020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 09:08:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv49Z-0008F3-HT
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 09:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbZJFHEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2009 03:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbZJFHEE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 03:04:04 -0400
Received: from mail-ew0-f217.google.com ([209.85.219.217]:54836 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbZJFHED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 03:04:03 -0400
Received: by ewy17 with SMTP id 17so3582746ewy.39
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=yC65IfJi4b7fCw7R5IOJcnZaiIlRresWBptk+HRRBEo=;
        b=W6sJu7ZbRJkJz28FmJnCMNpIIElrJ73dJR0H8ZN0FUW6ygAPuxosgSsSuQdnVn4poo
         Nl36h2TZxS4pAE+9+QxzRZ0fJkmT4qn1cHxdd6CTpnCLQPue2xzGD91WzO/yavyH9Kzx
         GzUg+Cpy2mqLTtIeIqjXrv3d0jv9dfJ0glT+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hUc2omOE0AB6RkZ6m+hOrbeS5yBJv9V442UjbTj/yiz6ZdhIi7i1dQB79eaY2CsF0x
         jB4a3HdukKPidTZlgN0m3VihPygzjJZ53KqsbU41zieMfTYHsx8YXqDUhnQLeO6zxAPz
         Z9KndVgrXqf7OMNtd+jO91H3j2KcnylxJs4CM=
Received: by 10.216.86.83 with SMTP id v61mr212158wee.80.1254812603788;
        Tue, 06 Oct 2009 00:03:23 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm1218457eyg.27.2009.10.06.00.03.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Oct 2009 00:03:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <4ACAACAB.3020707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129607>

Stephen Boyd wrote:
> Bj=F6rn Gustavsson wrote:
>> +If you just want to edit the commit message for a commit, you can r=
eplace
>> +the command "pick" with the command "reword".
>> +
> Maybe use the imperative here. So instead of "you can replace" just s=
ay
> "replace".

Yes, that's better.
=20
> Also, two paragraphs down we say "In both cases ..." but now there ar=
e
> three cases right? Maybe we should say

Well spotted. I didn't think about that.

But actually, I think that in "In both cases..." was wrong to begin
with, as there only is one case, namely if the command is "edit".

>> +#  r, reword =3D use commit, but allow editing of the commit messag=
e
> How about this?
>=20
> use commit, but stop to edit (or reword?) the commit message

No, I think that would be misleading, as "stop" means exit to the shell
so that you can run other git commands. (The documentation says:
"...the loop will stop to let you fix things, and you can continue
-the loop with `git rebase --continue`")


Here comes a patch that improves the documentation. It should be applie=
d
on top of my previous patch and then combined with it.

If you want me to send a new, combined patch, I will of course do that.

-- >8 --
Subject: [PATCH] Minor polishing of documentation

To be combined with my previous patch.
---
 Documentation/git-rebase.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 52af656..0ae8449 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,17 +368,17 @@ By replacing the command "pick" with the command =
"edit", you can tell
 the files and/or the commit message, amend the commit, and continue
 rebasing.
=20
-If you just want to edit the commit message for a commit, you can repl=
ace
-the command "pick" with the command "reword".
+If you just want to edit the commit message for a commit, replace the
+command "pick" with the command "reword".
=20
 If you want to fold two or more commits into one, replace the command
 "pick" with "squash" for the second and subsequent commit.  If the
 commits had different authors, it will attribute the squashed commit t=
o
 the author of the first commit.
=20
-In both cases, or when a "pick" does not succeed (because of merge
-errors), the loop will stop to let you fix things, and you can continu=
e
-the loop with `git rebase --continue`.
+When "pick" has been replaced with "edit" or when a "pick" does not
+succeed (because of merge errors), the loop will stop to let you fix
+things, and you can continue the loop with `git rebase --continue`.
=20
 For example, if you want to reorder the last 5 commits, such that what
 was HEAD~4 becomes the new HEAD. To achieve that, you would call
--=20
1.6.5.rc2.18.g020de
