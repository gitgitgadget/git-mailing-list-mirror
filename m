From: Gunnlaugur Thor Briem <gunnlaugur@gmail.com>
Subject: Better handling of erroneous git stash save "somemessage" --keep-index
Date: Tue, 26 Feb 2013 15:59:47 +0000
Message-ID: <CAPs+M8JvcnTcZiySmpMBuOxek4THRnTx0jkZv7NHaSDNLhcOAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 17:00:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAMxI-0005Ne-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710Ab3BZQAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:00:09 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47645 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759702Ab3BZQAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:00:08 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so4656339iea.14
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=2PDMc46if0kWXg32bMkAFdiK0XRR2VwVpJo8qUVQOE0=;
        b=QcbYbOnWxNIxXbPAeuiyuWnlSXtu/yTWv/YFfot6dXIxMR03/sRa3C70eHERwn/DTI
         N2rcnMQ+sPANzk9lVIn+p9AYea3k1kiwduY+styX3NGn83zN61UDVmUtlCaYs9lp55e/
         SqENg3JpJloJcuIG8vbNwB1t5B0HPwsH3VgoUa+5y9yq45qTRpBe++DUDPo30JCj+0kK
         p1S7QkQ2WsfVoELg7jWy9d+cQgGUyxJLGYF28TFZEnMBDXjoiXkA85AD1rxqQ53ZDm9n
         8UkJwDXRwvbw81Z8f8wKjUtmdSBrqE2TP2yayKVUOaUH9Q/GHoEKw2uLpZg8GzYRvbIJ
         9QGw==
X-Received: by 10.50.57.168 with SMTP id j8mr5703529igq.51.1361894407733; Tue,
 26 Feb 2013 08:00:07 -0800 (PST)
Received: by 10.64.51.130 with HTTP; Tue, 26 Feb 2013 07:59:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217139>

Hi,

the command:

git stash save "some message" --keep-index

stashes everything, including the index, and adds the "--keep-index"
to the message. The manual labor of separating index hunks from hunks
to stash is lost. This is in version 1.8.1.3.

This is a user error, of course (per the man page, parameters are not
accepted after the message). But it would be better handled by
erroring out, with a message like "git stash save does not permit
parameters after the stash message".

Cheers,

Gulli
