From: Chris Packham <judge.packham@gmail.com>
Subject: Getting a list of commits between 2 points without upstream changes
Date: Mon, 18 Jul 2011 11:49:57 +1200
Message-ID: <CAFOYHZC5hQ9JV8a5d20AaPR_eYFDViama+4148MPumvvJ-n6wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 18 01:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qib63-00076g-HX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 01:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab1GQXt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 19:49:58 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59869 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab1GQXt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 19:49:58 -0400
Received: by vxh35 with SMTP id 35so1310028vxh.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 16:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wg1d53Z7pqHHwRxaOlwc6G+WJzx3z0KUML/ELBJN6JY=;
        b=wDlk7N8egxfjKVArYLdBTPt1wIQyCIWEC5oM8auUMCinifsX82KN7srmTsloHbsr3+
         dogl1isclpeqTDIa5fRKTByUkzL66CCOwnRSf3UM7ah2j47hllIDrHVYV7PYadmxkkY4
         wY7256zbTkmYCiwYPfDfgcrk+6U5G0sWvqKA4=
Received: by 10.52.175.170 with SMTP id cb10mr5735379vdc.79.1310946597313;
 Sun, 17 Jul 2011 16:49:57 -0700 (PDT)
Received: by 10.220.191.202 with HTTP; Sun, 17 Jul 2011 16:49:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177324>

Hi List,

I'm trying to send round an incremental changelog for my project which
contains just my changes without changes that have been made upstream.
The history look something like this.

---o--o--o--o--o--o--o--o-- upstream
    \          \        \
     \-m--A--m--B--m--C--D-- topic

What I want is a changelog with just B, C and D in it (i.e. no merge
commits and no commits already in upstream). I know if I wanted A,B,C
and D I could just do 'git log --no-merges upstream..topic'. If I do
'git log --no-merges B..topic' I get the merged commits from upstream.
In set-speak what I think want is the union of upstream..topic and
B..topic.

Is there any existing way to achieve this? I'm happy to hack something
up using git rev-list if necessary.

Thanks,
Chris
