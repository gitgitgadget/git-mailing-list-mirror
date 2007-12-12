From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Wed, 12 Dec 2007 11:31:01 +0100
Message-ID: <200712121131.01471.jnareb@gmail.com>
References: <200712102332.53114.jnareb@gmail.com> <7vprxehrlv.fsf@gitster.siamese.dyndns.org> <200712120009.36560.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 11:31:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2OsH-000543-CV
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbXLLKbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 05:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756366AbXLLKbI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:31:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:8124 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbXLLKbH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 05:31:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so515584ugc.16
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 02:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ZVg1yEm2qY49fF1JbqsNZyY2OkCFp9dxVz3pDKs5jNA=;
        b=ZkncSkdLsjdax2tasBZDjFoPvhsYOFvwD4+UpO96ZUfhQsEPcXHHRGOwNFg5bpwDjRGeVhMmOIlAp/a1edtzA9pw4r88YpLJbDjtJKCRp4Zn6PuoreotNGOpVMQWsGl/DpOV1uKrm0a/krpfxl9I9D9QuPZd3qYZnho92K3pZZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dJwx+e9XoFqV/9EKx/NMo2kmsIZGVrFkIo0YQvnj1f6kQBQUx6pKkxlvR30q8iyAnmv3VMDxKixWQmQxFmTpAt0VAiOWMR9S+VGpCj72J+dSGBQ7Hl6e/mJb1h9XleZz8Zllnk489ZJKeS19ErNky5QGFVylW5o3x7c005JCO80=
Received: by 10.67.27.3 with SMTP id e3mr2070067ugj.22.1197455465613;
        Wed, 12 Dec 2007 02:31:05 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.28])
        by mx.google.com with ESMTPS id k29sm8103135fkk.2007.12.12.02.31.03
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2007 02:31:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712120009.36560.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68033>

BTW. I have noticed something strange with current (after my two
patches) diffstat code:

 3606:[gitweb/web@git]# ./git diff-tree -C -C -r --stat gitweb/test~8 
 0456a2ba58efb0e1d5f7421d5a8a2278e3b15ebc
  .../test/file with spaces\tand\ttabs"              |    4 +++-
  1 files changed, 3 insertions(+), 1 deletions(-)
 3607:[gitweb/web@git]# ./git diff-tree -C -C -r --numstat gitweb/test~8
 0456a2ba58efb0e1d5f7421d5a8a2278e3b15ebc
 3       1       gitweb/test/file with spaces    "gitweb/test/file with spaces\tand\ttabs"

but:

 3603:[gitweb/web@git]# ./git diff-tree -C -C -r --stat gitweb/test~6
 cfb9ef9ec73b37f44e9370c4f5d91e01d46ec6e4
  gitweb/test/Documentation-symlink1                 |    1 +
  gitweb/test/Documentation-symlink2                 |    1 +
  .../{git-shortlog.8.html => git-shortlog.html}     |    0 
  3 files changed, 2 insertions(+), 0 deletions(-)

So rename detection works. Strange.

P.S. gitweb/test branch can be found on
  http://repo.or.cz/w/git/jnareb-git.git

-- 
Jakub Narebski
Poland
