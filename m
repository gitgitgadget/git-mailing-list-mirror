From: Uri Moszkowicz <uri@4refs.com>
Subject: tag storage format
Date: Mon, 22 Oct 2012 17:23:33 -0500
Message-ID: <CAMJd5ATiAx09eAEo1=6+=hPv=5c6qtOiLRG5jrQn5dfCKUrvMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 00:24:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQQPn-0001E1-LY
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 00:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab2JVWX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 18:23:57 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:34082 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932171Ab2JVWX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 18:23:56 -0400
Received: (qmail 6623 invoked by uid 399); 22 Oct 2012 18:23:54 -0400
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 22 Oct 2012 18:23:54 -0400
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so4434754iea.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 15:23:53 -0700 (PDT)
Received: by 10.50.15.132 with SMTP id x4mr10681488igc.58.1350944633922; Mon,
 22 Oct 2012 15:23:53 -0700 (PDT)
Received: by 10.64.15.7 with HTTP; Mon, 22 Oct 2012 15:23:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208205>

I'm doing some testing on a large Git repository and am finding local
clones to take a very long time. After some investigation I've
determined that the problem is due to a very large number of tags
(~38k). Even with hard links, it just takes a really long time to
visit that many inodes. As it happens, I don't care for most of these
tags and will prune many of them anyway but I expect that over time it
will creep back up again. Have others reported this problem before and
is there a workaround? Perhaps Git should switch to a single-file
block text or binary format once a large number of tags becomes
present in a repository.
