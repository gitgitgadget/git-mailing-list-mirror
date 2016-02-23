From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git "thin" submodule clone to feed "describe"
Date: Tue, 23 Feb 2016 16:03:45 -0500
Message-ID: <CACPiFCLnXLdt5rLuX0a3pTS3OphKW=1oVKxyYpwvSLhY7ydb2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:04:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYK7v-0003CP-K1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbcBWVEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:04:07 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36370 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbcBWVEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:04:06 -0500
Received: by mail-ob0-f176.google.com with SMTP id gc3so206504293obb.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=uhgWyXC5e507EpWhqP4CXVq2tqAscQfjn12BqggAY18=;
        b=H0xKLK6pmEkD4tyLYPcV42kMJVvFEEAeIPukt4d7/AqmuhWLN7GBHhVWG2DnLg6o8n
         hwvpbeCR/Bx5isXwJr4n4Jhexf8zmFlQUkCx/4t2NLXDm/dzkyOpNzbQRgxJcU5eEEn+
         yB5vvjgIgR4C+IgJGG1yNeRFoxVuQ/h7xOCk5ziGJWue3lS/l7W8FyqdhYBilKhQZQPt
         SXS7F3nbkhbV0+VBKz80+77zpTMX085WP+NSnbOYL3CvqM/ZpRISIo+LkLq4ZElINnee
         JSuQgFnlaulu8xXW4ZLElinKHHzzyywv3Tori8FaVR1nr/l+iRLIMKzsyUWJKkHckkV+
         BSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=uhgWyXC5e507EpWhqP4CXVq2tqAscQfjn12BqggAY18=;
        b=g6hFckrGsSrMwPiMWjMhVFwjwV5HsjpTlCOE6skRtTECK2ZeK88tR2rf3hNzKjfOp+
         pFhInUh4Xe9l3RDHl+a1HI7J87RY9m58XPxnVcereOjObb8zoJxvX2nIks1r5RlkFRaq
         PilkTQXz25Hs3iNHJIIP07opFskYKrug1V960Hpldr/29QYENrp4bO2TLmw26d/IqEY7
         ryvjsW9bcbi6xE8yC1az0N02aRWJr84yGjR/rY6fmRIvM9OWX2lTmLqIOPIrVafvS3xb
         JKrcohDd8nsfX5873uCeoRpQPDl/DT8IzzHSh7AbJgBh6M9aOAde6JLs5TSyHWJA5Z0Z
         GwgQ==
X-Gm-Message-State: AG10YOSA1cMYpmZicro0ty5pzeA25eJWMtPlgVyTlfnhOLUaJ4+NyvhfReEFuXadEiqUrbXjLjfKo9v5Wo0xBg==
X-Received: by 10.60.96.74 with SMTP id dq10mr30654111oeb.78.1456261445149;
 Tue, 23 Feb 2016 13:04:05 -0800 (PST)
Received: by 10.182.19.225 with HTTP; Tue, 23 Feb 2016 13:03:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287120>

Hi git list! long time no see! :-) Been missing you lots.

Do we currently have any means to clone _history_ but not _blobs_ of a
repo, or some approximation thereof?

With a bit more context: If I have a top-level project using a couple
dozen submodules, where the submodules are huge, do I have a
git-native means of running git-describe on each submodule without
pulling the whole thing down?

In this context, most developers want to get full checkout of some
submodules, but not of all; and 'git describe' of the submodules is
needed to 'shim' the missing submodules appropriately.

If the answer is no, there's a bunch of ways I can carry that as extra
data in the top level project. It's possible, yet inelegant &
duplicative.

thanks,



martin
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
