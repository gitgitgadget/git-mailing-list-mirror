From: Matt Wozniski <godlygeek@gmail.com>
Subject: "clean" filter breaks git-svn
Date: Thu, 29 Jul 2010 23:55:37 -0400
Message-ID: <AANLkTikp6PgHyj2ujbuD52884ny88hMyxR1CpsbNAVCJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 30 05:55:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeghE-0002VK-As
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 05:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298Ab0G3Dzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 23:55:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56698 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab0G3Dzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 23:55:38 -0400
Received: by wyb39 with SMTP id 39so784848wyb.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 20:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=iF0DClcy6nhVf73mtHMREVMdZsqaiI6RtgH7dZTawmA=;
        b=EVKpKFu7asm7G4rISWEdV5EGIQurkPuyDVEbiRTAYkH5flVn+603ti8s5rxBYEUqG1
         5A7RcZHP7KjYrmmwHDhgie/esQa7AqkPnnBk2hQixmpHVD5mEB+U1DkwKsXqc2xUEn2N
         AV4/AEp4XlTP7o0bj28+nloQeoDLUAEYyzgwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=S2yGF+uZcda4xmBoaQ6+hd+jpQ7h9+3iwHSHA21VRNH8QE3Ej1tXk6kAtXB8s2CTp9
         xctfR3SRNGYCMb6YH8JBLhZh7vZjTDLkVwJXnqtEfvwurcge9qci3VN7IIY82RR9As43
         YntBp8FNLXbxfFFyyvPcskTj/TIHgj6nP69/M=
Received: by 10.216.231.26 with SMTP id k26mr1136185weq.3.1280462137510; Thu, 
	29 Jul 2010 20:55:37 -0700 (PDT)
Received: by 10.216.168.6 with HTTP; Thu, 29 Jul 2010 20:55:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152218>

I'm playing around with smudge and clean filters, and I've discovered
that they seem to completely break git-svn.  When trying to fetch
commits A and B from the SVN repos, it will fetch A, and then clean(A)
is committed to my repository.  Then when it tries to fetch B, it is
horribly confused - it complains of a checksum mismatch, since the
md5sums of the files in A in the SVN repos don't match up with the
md5sums of the files in the clean(A) commit in git land.  Is this a
known problem?  And, are there any work arounds other than just not
using filters when using git-svn?  Could git-svn be made to accept the
md5sum of *either* A or clean(A) instead?

Thanks!

~Matt

PS - Please CC me if possible; I'm not subscribed
