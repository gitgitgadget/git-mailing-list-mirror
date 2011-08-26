From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Looking up objects that point to other objects
Date: Fri, 26 Aug 2011 21:01:22 +0200
Message-ID: <CACBZZX6sydEmuwj_C-KNocjra=6ynud5KFoezPd_Rr3bN4wh2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 21:01:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx1ei-0001kC-FG
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 21:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab1HZTBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 15:01:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59980 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab1HZTBX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 15:01:23 -0400
Received: by fxh19 with SMTP id 19so2787437fxh.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kPkA2Yk1nqOOHtMAB3sq5MzhvlnaYBOuxc9e0axfLi4=;
        b=thn91RR6iVCgzFj+hSUpUqTpDVZKYLPLAUuEW2PBvja84myYhbyw9gfcfps+02y7ub
         je+DB9popGxtEjP07P1Doya03x7NM8Zby6+l17vYQo5orahUYdr8ymI0sxDSZqcqPL/8
         xAZaClq1f8AkQK76+WTKXRxGC0sY1V9a7juWA=
Received: by 10.223.18.73 with SMTP id v9mr2116067faa.70.1314385282526; Fri,
 26 Aug 2011 12:01:22 -0700 (PDT)
Received: by 10.223.78.203 with HTTP; Fri, 26 Aug 2011 12:01:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180190>

Here's a couple of tasks that require brute-force with the Git object
format that I've wanted to do at some point.

 * Associate a blob with trees

   Given a blob sha1 find trees that reference it.

 * Associate trees with commits / other trees.

   Given a tree find which commit points to that tree, or a parent
   tree N levels up the stack that a commit points to.

Has anyone written tools to do this? They'd obviously be very CPU and
I/O intensive, but occasionally I encounter cases where I'd find this
useful, e.g. to find what commit contains this huge blob, or what
trees / commits are involved with a corrupted object.
