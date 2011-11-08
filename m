From: Matt Arsenault <arsenm2@rpi.edu>
Subject: git svn rebase bug
Date: Tue, 8 Nov 2011 15:50:25 -0500
Message-ID: <39110A70-A25E-4A6B-A401-FCCE895B2CE5@rpi.edu>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 21:50:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNscs-000518-FL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 21:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab1KHUua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 15:50:30 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46329 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab1KHUu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 15:50:29 -0500
Received: by pzk2 with SMTP id 2so2614965pzk.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 12:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=1yN5XJKqNcRqAoXHpkRo+Hs6iL7uaMJ9gyZxC4IR4u0=;
        b=j92JlYcUmKN1S95APFCOCqU4IdaK/JhWuePn6yRRR19JSfEHJRGLKk60ecE3st4Rh5
         XcDGGfwKSM+pGv8OaeqY2RRHCJawiVohkCoIZJqtiuuIMXB/PlhtJD/68f7bqcy9/ZiA
         r5XQwjSnGvu4W3Q/sZwc+EuTHlLgBtZ9PdldE=
Received: by 10.68.38.41 with SMTP id d9mr3521777pbk.103.1320785429155;
        Tue, 08 Nov 2011 12:50:29 -0800 (PST)
Received: from mattbook.nycap.rr.com (cpe-67-246-47-231.nycap.res.rr.com. [67.246.47.231])
        by mx.google.com with ESMTPS id p6sm6980094pbf.3.2011.11.08.12.50.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 12:50:28 -0800 (PST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185108>

There seems to be a bug using git svn rebase with strategies

git version 1.7.7.2


$ git svn rebase --strategy=theirs

First, rewinding head to replay your work on top of it...
/usr/lib/git-core/git-rebase--merge: line 69: git-merge-theirs: command not found
Unknown exit code (127) from command: git-merge-theirs deabad54a6d5ce3ab3f655e06b9c24eadbba6f6c^ -- HEAD deabad54a6d5ce3ab3f655e06b9c24eadbba6f6c
rebase --strategy=theirs refs/remotes/git-svn: command returned error: 1