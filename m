From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: question on service commands in http-backend.c
Date: Sun, 5 Sep 2010 20:59:10 +0530
Message-ID: <AANLkTikH5yzHBA_KO_aMFn6bp3LnMS40S_c3P1QQO4gj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 05 17:29:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsH9k-0006la-VV
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 17:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0IEP3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 11:29:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37667 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab0IEP3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 11:29:12 -0400
Received: by gxk23 with SMTP id 23so1376223gxk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=j4gh73td7We4cOSDs0kJgfcVnjMP6rPDtudjqG6wtBs=;
        b=YTdKKIP+qlc+RHiaCN9mX+6SsxsYKsLec6FhsEOtU2V/gUv49ZLzMglPgamZAJx3xj
         KxRP+hofkKpZqshMKtrPjnndpRB9c4Eu8BjvK/XQONVkqaCP4HhUeCd9UyE4AENAqO0o
         zVHb/rIEsWNqaguRidTj3sgPGUEDbk84sBS9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=DH63dlPN2ERM+xGSOBZEsS99eDhv4SttOXIgTYR7f07mxB5wSyQUmseLCxhPFcp+FS
         6Nf9g2cuZbvwUW2A+dwyRK/Y/uoHKwDAKBxrhBwON2h9lbnq4WgY4pcg+ascvxlci20t
         quqxy9i/m/z/G1zGuVLsT9WE7Xf4kngcoyE3M=
Received: by 10.90.114.7 with SMTP id m7mr1113589agc.112.1283700550852; Sun,
 05 Sep 2010 08:29:10 -0700 (PDT)
Received: by 10.90.209.12 with HTTP; Sun, 5 Sep 2010 08:29:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155457>

Hi,

Short version: can I assume that, of all the service commands [I
assume that's what they're called] in the services[] array in
http-backend.c (approx line 530), only 'git-receive-pack' represents a
*write* attempt?

Long version: I just managed to fixup gitolite so it can be used with
smart http also, and after all that was done I got to wondering about
this.  It matters to gitolite because it needs to recognise whether
the user is trying to perform a write or a read so it can make the
correct access control decision.

With ssh it was very simple: you only had 3 command
(git-upload-archive, git-upload-pack, git-receive-pack) and the first
2 are "read"s.

And yes, I do notice that these new ones are all "GET" so it is hardly
likely they'd be writes -- just wanted to make sure...

Thanks,

-- 
Sitaram
