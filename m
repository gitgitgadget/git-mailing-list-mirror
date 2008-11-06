From: Yang Zhang <yanghatespam@gmail.com>
Subject: Understanding rebase
Date: Thu, 06 Nov 2008 17:23:28 -0500
Message-ID: <49136E60.4090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 23:25:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyDHi-0008Bk-JW
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 23:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbYKFWXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 17:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYKFWXa
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 17:23:30 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:5066 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbYKFWX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 17:23:29 -0500
Received: by qw-out-2122.google.com with SMTP id 3so549039qwe.37
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 14:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=3LwE3ogEOvgiq1tCJ1+CFak6JT7DqPyi3OM2noqfxxU=;
        b=lstT1KRy0tfhqmjKhezs4MmRgWXIEuSfj/Ml7bdYir8aSrLJ3+8R2mlg/QEukOr2Nf
         Rm5SK6F3BXUR63gBaUB8mWyXvbRqNMvuKGg4HSFgOjo/ZH+zegCD9QRyJJddO33PJrL/
         vtA1dX4AHoQERl3EVOoEUvmj8UXk39wstz1GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=lOP3J+NX+EL5ttak24hAs7ph3wZAIMvpJLCeuLX564CwFFyxD0ClVHky4l3UTA8qTh
         jol++4C8aTXiM3svnebSBo6elWIFJDNRlsYcqnngSvoG4LBqNEDtJ7/cpHDcjgliwGBY
         6M25WQdhe8OPB57GnSO07IkEglVdl7UdIUoUQ=
Received: by 10.214.244.6 with SMTP id r6mr3083699qah.96.1226010208448;
        Thu, 06 Nov 2008 14:23:28 -0800 (PST)
Received: from harvard.csail.mit.edu ( [18.26.1.77])
        by mx.google.com with ESMTPS id 9sm2326421yxs.5.2008.11.06.14.23.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Nov 2008 14:23:27 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100269>

What properties must commits have for them to be rebase-able?

One example arrangement that would cause a rebase to fail is:

- change lines 10, 12, 14 in branch A
- change lines 11, 13, 15 in branch B

These changes are commutative (I believe), but that is insufficient for 
avoiding conflicts on a rebaes.  For a concrete example of this, see:

http://assorted.svn.sourceforge.net/viewvc/assorted/sandbox/trunk/src/git/gitsvn.bash?revision=1065&view=markup

Another question that probably gets at the same thing: I understand what 
rebasing gives me from a high level (rearranging a branch of commits to 
be in a series with another branch), but is there a simple explanation 
of how, precisely, this is accomplished?

Thanks in advance!
-- 
Yang Zhang
http://www.mit.edu/~y_z/
