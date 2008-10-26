From: "Mike Clarke" <clarkema@gmail.com>
Subject: git working tree status
Date: Sun, 26 Oct 2008 21:54:03 +0000
Message-ID: <73f525b90810261454wb902edfk3a696c06ef2148d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 22:55:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuDaU-0002gP-7I
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 22:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbYJZVyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYJZVyF
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 17:54:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:10204 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYJZVyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 17:54:04 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1820318rvb.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ME+X+F22tXLYscvyb3UpXSdYGkdjRWAQ8TMVeAINo6A=;
        b=Qea/mjFGL69eUrY7FJpGreCFBexd1jn56K4USp8i4qbTHm5EUzV/OXs/bv+OCfJrH8
         B9Zh2zhlRSWa/nuRHwkppH8Y8ongfcsp/S+V/Pyd0rXZ3EM5kaaJ87voRqVOZ3UzhU2P
         jECvDWy5Tbbtsn42g7iOnhTv5SHUsQ8kVbx3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xoP/+hkmlKbRl6rkL3EtouCZ5RPIe/KL4zNkpAv9A6kQsrA1PwvchSpxHe7Ng2pBiL
         fbfQSubgUtlYQ2/Gry90hrS0fL5Ixlj6/MvM9e9e3DCfFJKZMt/wV3VfvHptlwfP+yeB
         iRC6fbSx3LeyZZkqahAYIYAmjKNseQZGXJCy0=
Received: by 10.141.129.14 with SMTP id g14mr2804097rvn.50.1225058043500;
        Sun, 26 Oct 2008 14:54:03 -0700 (PDT)
Received: by 10.141.82.19 with HTTP; Sun, 26 Oct 2008 14:54:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99184>

Hi all,

I'd like a way of getting a simple summary of the status of a working
tree,  for consumption by other programs rather than humans.

Specifically, I'd like to know whether the working tree is:

a) fully 'clean' -- i.e., all changes checked in, no stashes;
b) all changes checked in, but there are some stashes; or
c) 'dirty' in some way -- new files, uncommitted changes, etc.

The logical way to do this seems to be via an exit code, but the exit
code of git status is not currently rich enough.  As a result, I'm
considering the addition of an option to git status -- perhaps
'--is-clean' -- that would provide the required information.

My questions are:

1) Is there already some way of doing this that I've overlooked?
2) Would the preferred approach be an option (git status --is-clean)
or a sub-command (git is-clean)?  A sub-command would probably result
in cleaner internal code, but would also clutter the interface.
3) Is a patch for such a feature likely to be accepted?

Thanks,

-- 
Mike Clarke
