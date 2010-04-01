From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Is there interest in reading ~/.gitconfig.d/* and /etc/gitconfig.d/*?
Date: Thu, 1 Apr 2010 21:20:46 +0000
Message-ID: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 01 23:20:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxRos-0007Ef-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 23:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab0DAVUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 17:20:49 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:39414 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab0DAVUr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 17:20:47 -0400
Received: by fxm27 with SMTP id 27so897019fxm.28
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=VubtPfsXlrFLBQARWe4fooSpGvb6Nd8CYnWV9Lzht9k=;
        b=UG7DDbH0faMOS7ZvF/WAAZE1SLsar3b6SqM7zipxYPjMZa5Fux7jETS6aO+TxdOcpX
         kAksTs1c5c2hmCwybD1bU0QSTZKE8A+10obF0fVhJAb2hNx1vqpX3aKeVGmWfrITYn2u
         KjmDakl3PTIawZNfQUKhMptY4ZUQmYZF9lrSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HkC3L1szTHmkyy+x3V+aX2uwnOLLo+KtYfBYc+IQIELQo3iuAKzUSbW60cSyOUxQGS
         0jzY/i7zr0xG10vg5uzUQZ+P7Ar87EkA81qCzyVjg+8BcHmTgYFNWAyUi94NC0ncPOni
         TNju6tXRSXkeSGdY0zr7+UdlRakqXmT8PTSxc=
Received: by 10.103.177.8 with HTTP; Thu, 1 Apr 2010 14:20:46 -0700 (PDT)
Received: by 10.102.237.8 with SMTP id k8mr695818muh.41.1270156846304; Thu, 01 
	Apr 2010 14:20:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143750>

I've patched Git to read ~/.gitconfig.d/* and /etc/gitconfig.d/* in
addition to reading ~/.gitconfig and /etc/gitconfig where it would
normally do so. the gitconfig.d/* files are read in numeric sort order
as is the custom with such files and read after the main .gitconfig
file so they override it.

This is very useful for me because I maintain my .gitconfig in a
public git repository but I don't want anyone to know my github.token.
Because of that I have to do a little song & dance every time I commit
to the file (if the token is part of the diff) or pull to the file (to
not encounter a merge conflict).

This would also facilitate neat stuff like easily using bits of other
people's gitconfig libraries by cloning their repository somewhere and
symlinking their .gitconfig to ~/.gitconfig.d/99-some-library.

I'm not attaching my patch because it would be inhumane to subject
anyone to it in its current state. However, I'd like to ask if there's
any interest in getting a proper & documented patch for this. If so I
can submit a proper patch, if not I can just continue to patch my Git
build with my hack.

Apologies if this has been brought up before. I tried to search for
prior art but ".gitconfig.d" makes for a really bad search query in
all the search engines I could find that index this list.
