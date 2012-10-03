From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 3 Oct 2012 14:16:04 +0530
Message-ID: <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com> <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJKbK-00030m-70
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab2JCIqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:46:30 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53771 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab2JCIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:46:24 -0400
Received: by qchd3 with SMTP id d3so5350805qch.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P7hG76ZgDfDAfzfgVCbrXMiaA/tIV8BCwBVn5CIJ1Rs=;
        b=Ucoq5QP/Kaf0guqJJoAUjeR+XmXXSjAtI/pMJA77FRO3ZcMNrSMpbrgcjmyOQt1gzg
         loeWCyH2sSnP/ftH8Jf4IcIxAEaxK78r+9M6kIG5I1qHUeYks+8KlUILGtIp1ynM3Web
         z+40iHmu1yt/5PVtlAoX3NaUJl1rWkIs6EJQ85IMO/uvSqw5LqO3+A1AfxGd2zYOt+zZ
         L0WfvGe/bxBdo9nYUKKwN3RgaC8AHZbEWdNNfAAZypeZeeVICt/Ba8D209lLQGfx7YkD
         xAczrEpuntT4NJST4DHv9Eruw4BTTwavYpJL+vfHD0uglHx1B08NiR0ZDKue2T/EcUbp
         tIDQ==
Received: by 10.224.173.84 with SMTP id o20mr6268298qaz.3.1349253984237; Wed,
 03 Oct 2012 01:46:24 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 3 Oct 2012 01:46:04 -0700 (PDT)
In-Reply-To: <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206874>

[+CC: Junio, for comments]

Nguyen Thai Ngoc Duy wrote:
> On Wed, Oct 3, 2012 at 3:17 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> Hi Duy,
>>
>> Nguyen Thai Ngoc Duy wrote:
>>> Your patch is fine. I'm just thinking whether it's a good idea to add
>>> a section in the end of each command's man page to list all relevant
>>> config keys to that command, somewhat similar to "see also" section.
>>> It may help finding useful config keys that otherwise hard to find.
>>
>> That sounds like a good idea.  Would you like to write the first patch
>> (for git-push)?
>
> I won't be able to do it in the next 4 hours. If you want a stab at
> it, go ahead.

On second thought, it might not be such a good idea.  There are *lots*
of variables that control the operation of each command, and it's hard
to decide which ones to list and which ones to omit.  I've listed all
the relevant variables for git-push, except the advice.* variables- I
don't know how useful such a long list might be.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- 8< --
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cb97cc1..0a1c8d2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -426,6 +426,30 @@ Commits A and B would no longer belong to a
branch with a symbolic name,
 and so would be unreachable.  As such, these commits would be removed by
 a `git gc` command on the origin repository.

+Configuration variables
+-----------------------
+
+These configuration variables affect the operation of git-push in
+various ways.  For more information see linkgit:git-config[1].
+
+branch.<name>.remote
+core.gitProxy
+http.proxy
+push.default
+receive.autogc
+receive.denyCurrentBranch
+receive.denyDeleteCurrent
+receive.denyDeletes
+receive.denyNonFastForwards
+receive.unpackLimit
+receive.updateserverinfo
+remote.<name>.mirror
+remote.<name>.proxy
+remote.<name>.push
+remote.<name>.pushurl
+remote.<name>.receivepack
+remote.<name>.url
+
 GIT
 ---
 Part of the linkgit:git[1] suite
