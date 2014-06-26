From: Max Kirillov <max@max630.net>
Subject: [BUG/RFC] cherry-pick adds newline to last line of file
Date: Thu, 26 Jun 2014 12:30:29 +0300
Message-ID: <CAF7_NFQopk_1xh1OJyOARuXYYcM7MYdqV=tB5nQoZjSJoZZU=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 11:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X060q-0005M7-Td
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 11:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbaFZJab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 05:30:31 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:44980 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbaFZJaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 05:30:30 -0400
Received: by mail-ve0-f173.google.com with SMTP id db11so3390706veb.32
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=hwrdCWf9tc9YXU2LkMgCRepgVZb9/Prp+AtyVu2T+G8=;
        b=xHE99SB9QsU9tAln4og+Yu3qs/DghHnPg6p3/cExq4CTnG3jqbiFzazpAKJqLYwE5/
         yrXQyUVQKWMq0Nt07qZF59owRmKgnVrFJCYGZ04fq1n3aC9cXQD5jbKQsJQrThEvJcFN
         4zvChhzu5bUTm+IT/uOPBFPFYTNI5yxF4TwgSD9595qiP3UU1ZaQiP3bgYfikGsBZ5D5
         VJLEhPqiYAOxPsIATKJACoERc9dZD9DyfFiATjB9e+BGnDSy0/DH/VMl9ESD6mmUCCCp
         5QVqhRwE7k0wvdzVyHriwxlWL1+Iwxvr1jWWKkbJhxLqILLSKaLpdZd2xYQ2TpHm/gBt
         da5Q==
X-Received: by 10.221.47.9 with SMTP id uq9mr2970vcb.48.1403775029120; Thu, 26
 Jun 2014 02:30:29 -0700 (PDT)
Received: by 10.58.228.202 with HTTP; Thu, 26 Jun 2014 02:30:29 -0700 (PDT)
X-Google-Sender-Auth: L9k_xvdEICRC8kIEZDWwNxfEixw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252495>

Hi.

If a file does not contain newline in the last line, and the file has
changed somewhere
in other branch, and the newline has not been not added in that
change, when I cherry-pick the commit, the commit does contain the
newline in the last line. This sometimes leads to conflict and in
general looks unexpected.

Such files are not uncommon nowadays and however bad it is, I think
merging and cherry-picking should try to keep is as long as the
newline is not added in some of the changes. Are there any option to
preserve the absence of the closing newline? Or maybe the commands
should preserve it unconditionally?

-- 
Max
