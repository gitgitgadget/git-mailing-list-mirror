From: Eric Raible <raible@gmail.com>
Subject: RFH: is the current file available to a custom merge driver?
Date: Thu, 26 Aug 2010 15:13:03 -0700
Message-ID: <AANLkTi=mrO_6mv6vacE2sUq=fiJnzb-yS7yT3gHvO61H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 00:13:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ookh5-0003qy-MS
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 00:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab0HZWNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 18:13:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48310 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0HZWNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 18:13:05 -0400
Received: by vws3 with SMTP id 3so2224586vws.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=cyx7uZUjDCOcducN+ln2NYi9moY+45mk/KxIuE6Ppfw=;
        b=k7H3rDjqfyWzvI/yrEpbJKATdkjU+BIB7pO+FhJsieMVU65d+o0Q2HxsoxaP2c8S5+
         vBHsDSV+ft4/HPT2C25TA+O6VL3pq0bRFLXgXNUz0ovDXm9e4XhD4ApuoS5CokYnFVmx
         LaxL5kSbQafAEWKc32YhZYIGEtZ/buD976lkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nYbk/fyNtarSNAv3e7Naqp0K7/rXGkUgfAl7GEOpWO6AVAy3dVUTh5CFmR1ZMfMaOS
         3CK78ac7//+JG7K7cksaERoDvW39JudpCu1pZCww6+v/zZDd4p5oMl2sbFbRrG4CFVM0
         WF693epsTzTW4jX//9YzVv0o2kfjayark2NC4=
Received: by 10.220.62.5 with SMTP id v5mr6711080vch.101.1282860783206; Thu,
 26 Aug 2010 15:13:03 -0700 (PDT)
Received: by 10.220.202.75 with HTTP; Thu, 26 Aug 2010 15:13:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154565>

In writing a custom merge driver to support $dayjob
requirements I've failed to find a simple way of getting
the current file name that the driver is supposed to
be merging.

I of course have the "ancestor", "ours", and "theirs"
temporary files, but for Ui purposes I'd like to know
the filename as well.

As a workaround, I'm grepping for the git-hash-object
of %A (aka "ours) from the output of "git ls-tree -r HEAD".

I've examined the environment, and saw nothing relevant.
"git-ls-files -u" isn't useful, since the items aren't
unmerged yet.

Can anyone offer hints/help/tips?

Thanks - Eric

git version 1.7.0.2.msysgit.0
