From: Christoph Anton Mitterer <calestyo@gmail.com>
Subject: FEAUTRE-REQUEST: upon git difftool, files which cannot be modified
 (persistently) should be made read only
Date: Thu, 16 Oct 2014 04:45:23 +0200
Message-ID: <1413427523.4706.40.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 04:45:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xeb4H-0007IE-Ic
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 04:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbaJPCp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 22:45:29 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:54415 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaJPCp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 22:45:28 -0400
Received: by mail-wg0-f48.google.com with SMTP id k14so2680505wgh.31
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:mime-version
         :content-transfer-encoding;
        bh=pcbED5hcoIDd6LODR7fdpKyOKqRaGuvk5rq6dU/vd+4=;
        b=d3u2GA7RthqrBtG1pmFb4J8gFprxrFswy0mEDJNq7gDi5Kb949FhLSTHFX1Tbv2AlB
         +XonyUzCGDUSuw/sdzEvrWoTZztOHeqsa7KXTpxuFZEyOPtBa+SHqUhd5EvKsgnk6RDF
         PQKLISMZPKUVKNg/764cmRvhpHtmBeqeSrASNZ4Iq2TpA9U/4w92bkyNVeGjeyEHyajN
         Xuf7kOGB2cgToaeW9jwauAm2tyJXxJPNpCJFgrXMlbyNjrB7yRdA7XHPDDy1npdgmFua
         EJNvonVXPxLb8ECZhTeWwJQIKvW5J38OUx5i+QWhspGrm0VUW/xh5YgG5tYLT7mQhCwS
         ev4w==
X-Received: by 10.194.2.168 with SMTP id 8mr17551509wjv.78.1413427527416;
        Wed, 15 Oct 2014 19:45:27 -0700 (PDT)
Received: from ?IPv6:2001:a60:147e:3801:6267:20ff:fe09:9aa4? ([2001:a60:147e:3801:6267:20ff:fe09:9aa4])
        by mx.google.com with ESMTPSA id el4sm319660wid.11.2014.10.15.19.45.25
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Oct 2014 19:45:26 -0700 (PDT)
X-Mailer: Evolution 3.12.7-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Apparently since a while, git difftool has the awseome feature,
that it just symlinks the files to the working copy, if a diff with
that is requested.

e.g. something like:
git difftool -d
will have 
/tmp/git-difftool.TWYTA

created with subdirs

left:
-rw-r--r-- 1 user     user      45k Oct 16 04:33 file

right: 
lrwxrwxrwx 1 calestyo calestyo   52 Oct 16 04:33 file -> /home/user/foo/file

When one edits and saves this in one's favourite difftool,... it
actually gets into the working copy.

But of course saving the left (in this example) has no effect, so it
would be nice if all these files were marked readonly, so that one
already sees in the difftool "changes here are useless".


Cheers,
Chris.
