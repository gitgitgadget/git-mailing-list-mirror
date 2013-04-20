From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Some observations on log -L
Date: Sat, 20 Apr 2013 15:26:09 +0530
Message-ID: <CALkWK0k+LYro8jpmfRPmX8Wsj6aEWzyq3DYa6waDMsh5B=X7Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 11:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTUZH-00059s-Gk
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 11:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237Ab3DTJ53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 05:57:29 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33773 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab3DTJ4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 05:56:50 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so5586623iea.10
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=XQpZZWCBnfar7Lrra7eH9n3Lypxftrbr0VpdAugvjEg=;
        b=y8+CpRNuLrG49yX/WLUMVUOl5gbCAicMXdqOgI6Y/Akb/XxDmvgZuXzcsVnl6K6PYJ
         hUOBBiB33pQBra8eZR+8e//ZqomE3BdA29O/rAK67NgnYyUo7MQ33V83IyWDWc481a0k
         HzGJur7QvbOdMh8FVN25bQPGLHi3UiS8U7i9wrPojtfz2VuZF3QtktFz0Aortvdma6j+
         KfqjCq1oXGCrAYUZtI8OcjCKRia6foX0RIsaE2xhVhx+4k658eX67CT2yZIgzPkSQ+Qr
         2xjVMUM0yPq2zcdSj5pqb2SBYX1FxEoknInlChsZUPxxFtRqYbUefR6CFDqbbcdUB4+P
         LI1w==
X-Received: by 10.50.50.71 with SMTP id a7mr17322588igo.14.1366451809955; Sat,
 20 Apr 2013 02:56:49 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sat, 20 Apr 2013 02:56:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221840>

Hi,

Ever since 'git log -L' made it to `pu`, I've been playing with it to
see how it can be useful.  Here are some of my observations:

1. Specifying line ranges by hand are too painful.  I would really
love it if it could parse the lines off a patch prepared by
format-patch or something.

2. Specifying regex ranges are really useful to see the history of a
function.  But I think it could really benefit from a tool that
actually understands the language (using Clang Tooling).  If we were
to build such a tool, git-core could benefit immensely from it: we'd
have smarter merges too, for instance.

3. Often, I want to know the people to contact for a segment of code.
Blame is useless here, because it only considers the most recent
commit, when I want to know the authors of all the commits that helped
shaped that segment of code.  So, I think shortlog could really
benefit from a -L.  Is this easily doable?

Thanks for listening.
