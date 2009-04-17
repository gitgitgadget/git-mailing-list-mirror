From: Rich Collins <richcollins@gmail.com>
Subject: Bus error on git merge
Date: Fri, 17 Apr 2009 10:34:10 -0700
Message-ID: <f1bd8f970904171034h734624e9ha0d06ef085460d93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 19:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luryi-0006UR-Ey
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 19:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbZDQReP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 13:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761932AbZDQReN
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 13:34:13 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37439 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761922AbZDQReM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 13:34:12 -0400
Received: by fxm2 with SMTP id 2so1009295fxm.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=DG54xr1f8SZ3q/r1Ol6xYT70SC91DQkMPAiK5H88wBc=;
        b=j2KyoZviu1VWeWtWSKDTiRYku/Sf67sokEfgLwBxTXL1wrUt4CnCOZIGEaTO+/KicW
         dwtlCHLJVhGNIKBNEEZvigCaZ6lT8V6vlx8EfUWx/cLUlJ82flwC8izuNEbOfJg6cl04
         s8dDgZniJH7cq/balCCuhCZsVXXrS87fzXJqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=HxSiYiIQvdnwXokAYHFVtV+fSPINS5bjqzyDgcScUxtUJ/Z1j1DzFV0uuakI4/wbK+
         P5PnSSrJFkRuV6YQFDQCt1uf6aDLxeCY7riwDycV2M1c3geS20VbsifY31osOjx502GD
         F2qkf/lJexor0yVLQZBqY87l8gG4rdhVotXeI=
Received: by 10.103.169.18 with SMTP id w18mr1514314muo.101.1239989650141; 
	Fri, 17 Apr 2009 10:34:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116764>

I'm getting a Bus error when I try to merge on Intel OS X:

(gdb) run
Starting program: /usr/local/bin/git merge
4396bbd7ff5fe3084c11e0cd11a7928cf77e3755
Reading symbols for shared libraries ++++++. done

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_PROTECTION_FAILURE at address: 0x00000004
0x00087e63 in sha_eq ()
(gdb) bt
#0  0x00087e63 in sha_eq ()
#1  0x00088866 in merge_trees ()
#2  0x0008a400 in merge_recursive ()
#3  0x000389dc in try_merge_strategy ()
#4  0x0003a2df in cmd_merge ()
#5  0x000024db in handle_internal_command ()
#6  0x00002742 in main ()
