From: ryenus <ryenus@gmail.com>
Subject: git merge/rebase ref -P ref
Date: Sun, 28 Apr 2013 23:35:50 +0800
Message-ID: <CAKkAvawit0L4JKKNs7Di46B=Y0VjPohKNbjnS=r07VhafXu4kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 28 17:36:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWTeD-00051b-7f
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 17:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab3D1PgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 11:36:13 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:54438 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab3D1PgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 11:36:12 -0400
Received: by mail-we0-f172.google.com with SMTP id r6so729571wey.31
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=gj+qXPWsXylLOYXJYsm5Sm4h7CzVvzqATQ2W0p1lBrg=;
        b=gkd6KzY6666Yecof2uDgSCEyscOHM97oWUz/PvYyxRxTbNiHZ+Ul4mltRfPtMenkn1
         hdnKVsNp91Dkl7F1spWwt7HY9cdy59Bhj24AMAwn3/y32U7ceMIjzkSYkQXFasP1vzA7
         glD34s5etuFBnk0yo+hqeDIwogazZdRmgQjTQSCtOA0MfaTMi6K1WRsE8CfX4MgLJ/LD
         a/o55zJP9j++owmrUrIIT+QTxgxvMjEv/7n1H5RcGs5Iu8UFcgFRhmqbIlJu5GNj8h9W
         u4YZVRM8Na11IySnpbrdrCFU2sOhDhuMmXTeaGkX7Z8maDWGOqI6ToMkaWarTB9EUSty
         muHw==
X-Received: by 10.194.62.233 with SMTP id b9mr31585453wjs.37.1367163371008;
 Sun, 28 Apr 2013 08:36:11 -0700 (PDT)
Received: by 10.194.92.48 with HTTP; Sun, 28 Apr 2013 08:35:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222736>

The inverted meaning of {ours,theirs} for rebase could be very
confusing to some, especially to new uses, for me every time I
merge/rebase I need to think about it to make sure I've made it right.

What about making it more intuitive?

We can and a new option (like '-P') for people to specify the
preferred branch/ref by it's name.

E.g. assume I have two branches, namely 'dev' and 'exp', and I prefer
the changeset on the 'dev' branch when I merge or rebase, so that I
can do it with

# using merge
git checkout dev
git merge exp -P dev

OR

# using rebase
git checkout exp
git rebase dev -P dev
