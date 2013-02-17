From: Orgad Shaneh <orgads@gmail.com>
Subject: rev-parse fails on objects that contain colon
Date: Sun, 17 Feb 2013 10:37:17 +0200
Message-ID: <CAGHpTBJXM4F3=n3g_Lcb7Dnxkmya5KYeJ5XAsY0PtxftYmUeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 09:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6zkl-0001OU-Ml
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 09:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab3BQIhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 03:37:18 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:56428 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab3BQIhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 03:37:18 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so4838589obb.31
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 00:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=QreLv2MA3lMTccdPFlGsaUsyJLdw5+KglOpP3kDIRyg=;
        b=v8wMEX+34OI4Yl9UetwMycpOw42Wpi8GirKq+o+Sw4ohaqY2vhjfhtUvkvQyPU6N0D
         flG5ZYVUCjo0TcalwkkCyFQJrWLZDhZwIcRZ/4C09kZEbBmSwYauQUBVnvxbhgjTJ2oB
         6KGmgVtcgeaG3f2w54qK/VRF8wWVuV5sTzoPuCBs7DoC0mwy+fDczlj8EAcWvYdF+9qS
         +eSX1c+Wj1qxnMcOS5rX7g2pVhEbXxZvIOhjTjzCkx5FzmgMWT+XCLj0vYXEt6LT1JI6
         l5PgKNcQcDz8dsCK39jO54GfcBN+MvR9k42KSuNsPrEjsWSCCWylZYzyEKwhbFZD19DW
         mAIw==
X-Received: by 10.60.22.198 with SMTP id g6mr4665715oef.45.1361090237423; Sun,
 17 Feb 2013 00:37:17 -0800 (PST)
Received: by 10.182.49.227 with HTTP; Sun, 17 Feb 2013 00:37:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216385>

$ git stash save foo:bar
HEAD is now at 9f88dce Foo
$ git stash pop foo:bar
fatal: Invalid object name 'foo'.
$ git rev-parse foo:bar
foo:bar
fatal: Invalid object name 'foo'.

Tested on Windows (msysGit) and Linux.

- Orgad
