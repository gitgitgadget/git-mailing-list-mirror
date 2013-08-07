From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Remove old forgotten command: whatchanged
Date: Wed, 7 Aug 2013 21:30:35 +0530
Message-ID: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 07 18:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V76Aw-0003tp-5p
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 18:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab3HGQBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 12:01:22 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:43221 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab3HGQBV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 12:01:21 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so1645092oag.36
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=UPks/rZHbOjR0nJ4eiE6BWMMW+CRMCY0XK2d0Q+Hl4w=;
        b=YJAaoWVKkefOE37i2z4fnmoLFxC0hhQn6uo0KfaH8HGXSVGzAOZxzVZOXzjtnmIi6I
         0ThcsIZpkiUUhqKynqlUl+jY0Dvt5/ENW5Sfq78T5JlSZM9wI9P9HEH09Lk7wMJRbzbM
         QXX/oWY0yqYE7vr1ACEHmQHffOBBCD1q1IOszZU8+F1uEgp8S9//8WeKYmZqD0L5DfYB
         WhCVvitt7qQ/Z12aldubt3q+1OYLDI8JxXWp8vcYsIhFKCJMgEw76fuY6cOno5RMoPJD
         +/ntLsOTjWzjT482c7vL0lhAJ/qZDGTzXamaeg7rVH/abtljDJtVb/ACbSjAUXYVxcL8
         W5Eg==
X-Received: by 10.50.6.16 with SMTP id w16mr115266igw.29.1375891277440; Wed,
 07 Aug 2013 09:01:17 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 7 Aug 2013 09:00:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231834>

Hi,

This is the difference between whatchanged and log:

diff --git a/whatchanged b/log
index fa1b223..004d9aa 100644
--- a/tmp/whatchanged
+++ b/tmp/log
@@ -1,4 +1,4 @@
-int cmd_whatchanged(int argc, const char **argv, const char *prefix)
+int cmd_log(int argc, const char **argv, const char *prefix)
 {
        struct rev_info rev;
        struct setup_revision_opt opt;
@@ -7,13 +7,10 @@ int cmd_whatchanged(int argc, const char **argv,
const char *prefix)
        git_config(git_log_config, NULL);

        init_revisions(&rev, prefix);
-       rev.diff = 1;
-       rev.simplify_history = 0;
+       rev.always_show_header = 1;
        memset(&opt, 0, sizeof(opt));
        opt.def = "HEAD";
        opt.revarg_opt = REVARG_COMMITTISH;
        cmd_log_init(argc, argv, prefix, &rev, &opt);
-       if (!rev.diffopt.output_format)
-               rev.diffopt.output_format = DIFF_FORMAT_RAW;
        return cmd_log_walk(&rev);
 }

Should we remove it?

Ram
