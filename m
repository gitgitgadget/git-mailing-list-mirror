From: =?UTF-8?Q?Carl_F=C3=BCrstenberg?= <azatoth@gmail.com>
Subject: Git submodule update and the --merge flag when submodule is yet to be
 checked out
Date: Fri, 18 Mar 2011 19:25:39 +0100
Message-ID: <AANLkTikJo_pjSAmVV3wjWi04io4zWb-_P5p81TYj9tq6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6dd966bb4595b049ec5e79b
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 19:25:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0eMt-00066J-7O
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 19:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab1CRSZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 14:25:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36296 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab1CRSZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 14:25:41 -0400
Received: by wwa36 with SMTP id 36so5216193wwa.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=H4jLyg4AYHCu4BjUjQKcTPw9EcnbX9iwt8mNRUMOxDo=;
        b=cqv7jMLPWQLQWtn0ny9PQcJdDXh8BDZF9NrA2BHxLL/3vR48fe0rJEwiZH79Dz9akw
         NNtTqJXMfR9pKLuPz75HaWESwqi1cvjW4NbK5BfZ7biut8okuRMdMLKz6snw7gWZ2yck
         5ls9Eq5BbTXIh4l+jck0orshcHSWiWCRELh+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=V9GTDjP/R+RPdEri8kBInnHI6hUoZ2q00eYyY7EA3Jzdosr7ndYj7UpTOLD0rDv1Ua
         HDXbrovSJWgMW/iOgoU12FPx5LDJjmht4vZdXpIAQ161foygdz5oViGLjnx5KB5RxiH8
         AVUeQU/6osXqAmiIz+erUn6aDaVNDpxDbmCAE=
Received: by 10.216.82.18 with SMTP id n18mr86188wee.45.1300472739944; Fri, 18
 Mar 2011 11:25:39 -0700 (PDT)
Received: by 10.216.170.211 with HTTP; Fri, 18 Mar 2011 11:25:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169346>

--0016e6dd966bb4595b049ec5e79b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sorry for re-posting the question but I though I should explain the
issue better and to fix the subject line.
sub
When you are cloning repository containing submodules, and you are
using the --merge flag to "git submodule update" the first time, then
the submodule instance in question will assume you want to delete all
files present in the module.

Please look at attachment for a testcase and how the result might look like=
.
Unless this is not the intended behavior, then I would suggest
changing --merge (and possible --rebase) to not assume a non-existent
repository
to be a empty one.

The man pages says "Merge the commit recorded in the superproject into
the current branch of the submodule", but we have no current branch of
the
submodule.

I would be happy for any reply, and sorry again for the repost.

/Carl F=C3=BCrstenberg

--0016e6dd966bb4595b049ec5e79b
Content-Type: application/x-sh; name="submodule_merge_test.sh"
Content-Disposition: attachment; filename="submodule_merge_test.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_glffq2rt0

IyEvYmluL2Jhc2gKCnNldCAteApta2RpciAtcCB0ZXN0L2Jhc2UgdGVzdC9zdWJwcm9qCigKY2Qg
dGVzdC9zdWJwcm9qCmdpdCBpbml0CmVjaG8gYSA+IGZpbGUKZ2l0IGFkZCBmaWxlCmdpdCBjb21t
aXQgLW0gJ0FkZGVkIGZpbGUnCikKCigKY2QgdGVzdC9iYXNlCmdpdCBpbml0CmdpdCBzdWJtb2R1
bGUgYWRkIGZpbGU6Ly8kUFdELy4uL3N1YnByb2ogc3ViCmdpdCBjb21taXQgLW0gJ0FkZGVkIHN1
YnByb2onCikKCigKY2QgdGVzdApnaXQgY2xvbmUgYmFzZSBjbG9uZWQKY2QgY2xvbmVkCmdpdCBz
dWJtb2R1bGUgc3RhdHVzCmdpdCBzdWJtb2R1bGUgdXBkYXRlIC0taW5pdCAtLW1lcmdlCmdpdCBz
dWJtb2R1bGUgc3RhdHVzCmdpdCBzdGF0dXMKY2Qgc3ViCmdpdCBzdGF0dXMKKQoKcm0gLXJmIHRl
c3QvYmFzZSB0ZXN0L3N1YnByb2ogdGVzdC9jbG9uZWQKcm1kaXIgdGVzdAo=
--0016e6dd966bb4595b049ec5e79b
Content-Type: application/octet-stream; name=test_output
Content-Disposition: attachment; filename=test_output
Content-Transfer-Encoding: base64
X-Attachment-Id: f_glffrz5l1

KyBta2RpciAtcCB0ZXN0L2Jhc2UgdGVzdC9zdWJwcm9qCisgY2QgdGVzdC9zdWJwcm9qCisgZ2l0
IGluaXQKSW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL2hvbWUvYXphdG90aC90
bXAvc3VibWVyZ2UvdGVzdC9zdWJwcm9qLy5naXQvCisgZWNobyBhCisgZ2l0IGFkZCBmaWxlCisg
Z2l0IGNvbW1pdCAtbSAnQWRkZWQgZmlsZScKW21hc3RlciAocm9vdC1jb21taXQpIDlkODU3NmVd
IEFkZGVkIGZpbGUKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGZpbGUKKyBjZCB0ZXN0L2Jhc2UKKyBnaXQgaW5pdApJ
bml0aWFsaXplZCBlbXB0eSBHaXQgcmVwb3NpdG9yeSBpbiAvaG9tZS9hemF0b3RoL3RtcC9zdWJt
ZXJnZS90ZXN0L2Jhc2UvLmdpdC8KKyBnaXQgc3VibW9kdWxlIGFkZCBmaWxlOi8vL2hvbWUvYXph
dG90aC90bXAvc3VibWVyZ2UvdGVzdC9iYXNlLy4uL3N1YnByb2ogc3ViCkNsb25pbmcgaW50byBz
dWIuLi4KKyBnaXQgY29tbWl0IC1tICdBZGRlZCBzdWJwcm9qJwpbbWFzdGVyIChyb290LWNvbW1p
dCkgYWNhYjRiZF0gQWRkZWQgc3VicHJvagogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgLmdpdG1vZHVsZXMKIGNyZWF0
ZSBtb2RlIDE2MDAwMCBzdWIKKyBjZCB0ZXN0CisgZ2l0IGNsb25lIGJhc2UgY2xvbmVkCkNsb25p
bmcgaW50byBjbG9uZWQuLi4KZG9uZS4KKyBjZCBjbG9uZWQKKyBnaXQgc3VibW9kdWxlIHN0YXR1
cwotOWQ4NTc2ZWRhMThkZDBhMjczNjgyMWQ5ZjYwYmQzNDkxNWZkZDYxYyBzdWIKKyBnaXQgc3Vi
bW9kdWxlIHVwZGF0ZSAtLWluaXQgLS1tZXJnZQpTdWJtb2R1bGUgJ3N1YicgKGZpbGU6Ly8vaG9t
ZS9hemF0b3RoL3RtcC9zdWJtZXJnZS90ZXN0L2Jhc2UvLi4vc3VicHJvaikgcmVnaXN0ZXJlZCBm
b3IgcGF0aCAnc3ViJwpDbG9uaW5nIGludG8gc3ViLi4uCkFscmVhZHkgdXAtdG8tZGF0ZS4KU3Vi
bW9kdWxlIHBhdGggJ3N1Yic6IG1lcmdlZCBpbiAnOWQ4NTc2ZWRhMThkZDBhMjczNjgyMWQ5ZjYw
YmQzNDkxNWZkZDYxYycKKyBnaXQgc3VibW9kdWxlIHN0YXR1cwogOWQ4NTc2ZWRhMThkZDBhMjcz
NjgyMWQ5ZjYwYmQzNDkxNWZkZDYxYyBzdWIgKGhlYWRzL21hc3RlcikKKyBnaXQgc3RhdHVzCiMg
T24gYnJhbmNoIG1hc3RlcgojIENoYW5nZXMgbm90IHN0YWdlZCBmb3IgY29tbWl0OgojICAgKHVz
ZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIHVwZGF0ZSB3aGF0IHdpbGwgYmUgY29tbWl0dGVkKQoj
ICAgKHVzZSAiZ2l0IGNoZWNrb3V0IC0tIDxmaWxlPi4uLiIgdG8gZGlzY2FyZCBjaGFuZ2VzIGlu
IHdvcmtpbmcgZGlyZWN0b3J5KQojICAgKGNvbW1pdCBvciBkaXNjYXJkIHRoZSB1bnRyYWNrZWQg
b3IgbW9kaWZpZWQgY29udGVudCBpbiBzdWJtb2R1bGVzKQojCiMJbW9kaWZpZWQ6ICAgc3ViICht
b2RpZmllZCBjb250ZW50KQojCm5vIGNoYW5nZXMgYWRkZWQgdG8gY29tbWl0ICh1c2UgImdpdCBh
ZGQiIGFuZC9vciAiZ2l0IGNvbW1pdCAtYSIpCisgY2Qgc3ViCisgZ2l0IHN0YXR1cwojIE9uIGJy
YW5jaCBtYXN0ZXIKIyBDaGFuZ2VzIHRvIGJlIGNvbW1pdHRlZDoKIyAgICh1c2UgImdpdCByZXNl
dCBIRUFEIDxmaWxlPi4uLiIgdG8gdW5zdGFnZSkKIwojCWRlbGV0ZWQ6ICAgIGZpbGUKIworIHJt
IC1yZiB0ZXN0L2Jhc2UgdGVzdC9zdWJwcm9qIHRlc3QvY2xvbmVkCisgcm1kaXIgdGVzdAo=
--0016e6dd966bb4595b049ec5e79b--
