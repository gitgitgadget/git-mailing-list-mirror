From: Danny Lin <danny0838@gmail.com>
Subject: Re: [PATCH] branch: -r -d(D) should say "remote-tracking branch"
Date: Thu, 7 May 2015 03:01:55 +0800
Message-ID: <CAMbsUu4iAD0kGh_ZzbLBS4P69Hz-T4Mv0krLst+M7SVc=v=Dog@mail.gmail.com>
References: <CAMbsUu5pKiQ76WrCXvziQ8zER-Mc5oVt7tGnC7Q3RMVX2r8ZXQ@mail.gmail.com>
	<CAN0XMOJ8QJ14B15BoFrr7d7L-jE06yUbquo8pW3OCj4wmUk2Rw@mail.gmail.com>
	<xmqq4mnpvbgt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 21:02:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq4a1-0002hY-Hj
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbbEFTB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:01:56 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35333 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbEFTB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:01:56 -0400
Received: by qkhg7 with SMTP id g7so12721572qkh.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1FAx+quq49evNl4HANflOQv2C3Z2QONfCIHit/30qUA=;
        b=el3ddCx0D5KqYsW+SS0FBXOJNlg8shG6RU7nC4Vzdly9w+IY8Wb2r+dJLcstotHaFF
         ZMm+tVkDm2cDMkKjwWXduNn2oPHzL6eBMvhZVTwRqtQhTSQiZAOCamz972J5ZRXfGvzY
         6ONYvrV2rhl+PHw0ywlERotoscvnNySsGND8w0QFysr45kWf6jQgUMq663p4e+NNocE5
         y7tsVWPD5z23MtDsxSHeVjmokGv0Nfn+eFtoDI8i5qNfc5sA9fqCDXkHyTTuXHvahElb
         Vo9/mAn8BHjSC9+jtnR9vjrsJmlbBiQ3xyqRzWx/T8ALGlx3dzeaOMuYfDdHKc8S8qJE
         rVDA==
X-Received: by 10.55.21.31 with SMTP id f31mr313372qkh.95.1430938915499; Wed,
 06 May 2015 12:01:55 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Wed, 6 May 2015 12:01:55 -0700 (PDT)
In-Reply-To: <xmqq4mnpvbgt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268482>

git branch -r -d(D) currently says "delete remote branch",
which should be "remote-tracking branch".

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index dc6f0b2..3560c51 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -242,7 +242,7 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds,
                         sha1, &flags);
         if (!target) {
             error(remote_branch
-                  ? _("remote branch '%s' not found.")
+                  ? _("remote-tracking branch '%s' not found.")
                   : _("branch '%s' not found."), bname.buf);
             ret = 1;
             continue;
@@ -257,7 +257,7 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds,

         if (delete_ref(name, sha1, REF_NODEREF)) {
             error(remote_branch
-                  ? _("Error deleting remote branch '%s'")
+                  ? _("Error deleting remote-tracking branch '%s'")
                   : _("Error deleting branch '%s'"),
                   bname.buf);
             ret = 1;
@@ -265,7 +265,7 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds,
         }
         if (!quiet) {
             printf(remote_branch
-                   ? _("Deleted remote branch %s (was %s).\n")
+                   ? _("Deleted remote-tracking branch %s (was %s).\n")
                    : _("Deleted branch %s (was %s).\n"),
                    bname.buf,
                    (flags & REF_ISBROKEN) ? "broken"
-- 
2.3.7.windows.1



revised

2015-05-07 1:53 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Danny Lin <danny0838@gmail.com> wrote:
>>> git branch -r -d(D) currently says "delete remote branch",
>>> which should be "remote-tracking branch".
>>> ---
>>
>> No "Signed-off-by" line. (see Documentation/SubmittingPatches)
>>
>>>  builtin/branch.c | 6 +++---
>>>  po/bg.po         | 6 +++---
>>>  po/ca.po         | 6 +++---
>>>  po/de.po         | 6 +++---
>>>  po/fr.po         | 6 +++---
>>>  po/git.pot       | 6 +++---
>>>  po/it.po         | 6 +++---
>>>  po/pt_PT.po      | 6 +++---
>>>  po/sv.po         | 6 +++---
>>>  po/vi.po         | 6 +++---
>>>  po/zh_CN.po      | 6 +++---
>>>  11 files changed, 33 insertions(+), 33 deletions(-)
>>>
>>
>> You don't need to update messages within "po/*" as they're
>> updated by the l10n coordinator and translators.
>
> Thanks for pointing it out, but the language should be stronger; not
> "don't need to", but "you must not".
>
> Thanks.
>
>>> diff --git a/builtin/branch.c b/builtin/branch.c
>>> index dc6f0b2..3560c51 100644
>>> --- a/builtin/branch.c
>>> +++ b/builtin/branch.c
>>> @@ -242,7 +242,7 @@ static int delete_branches(int argc, const char
>>> **argv, int force, int kinds,
>>>                          sha1, &flags);
>>>          if (!target) {
>>>              error(remote_branch
>>> -                  ? _("remote branch '%s' not found.")
>>> +                  ? _("remote-tracking branch '%s' not found.")
>>>                    : _("branch '%s' not found."), bname.buf);
>>>              ret = 1;
>>>              continue;
>>> @@ -257,7 +257,7 @@ static int delete_branches(int argc, const char
>>> **argv, int force, int kinds,
>>>
>>>          if (delete_ref(name, sha1, REF_NODEREF)) {
>>>              error(remote_branch
>>> -                  ? _("Error deleting remote branch '%s'")
>>> +                  ? _("Error deleting remote-tracking branch '%s'")
>>>                    : _("Error deleting branch '%s'"),
>>>                    bname.buf);
>>>              ret = 1;
>>> @@ -265,7 +265,7 @@ static int delete_branches(int argc, const char
>>> **argv, int force, int kinds,
>>>          }
>>>          if (!quiet) {
>>>              printf(remote_branch
>>> -                   ? _("Deleted remote branch %s (was %s).\n")
>>> +                   ? _("Deleted remote-tracking branch %s (was %s).\n")
>>>                     : _("Deleted branch %s (was %s).\n"),
>>>                     bname.buf,
>>>                     (flags & REF_ISBROKEN) ? "broken"
>>
>> Looks good to me.
