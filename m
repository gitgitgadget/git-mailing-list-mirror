From: "David Frech" <david@nimblemachines.com>
Subject: how to do directory renames in fast-import
Date: Mon, 9 Jul 2007 18:09:02 -0700
Message-ID: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 03:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I84E5-0001dr-Hd
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 03:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760516AbXGJBJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 21:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758939AbXGJBJI
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 21:09:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:54647 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbXGJBJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 21:09:07 -0400
Received: by nz-out-0506.google.com with SMTP id s18so853726nze
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 18:09:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=ITZgv1h/Oa6CF3lRn+hWexVurPoQWGx1NndQ5txkowzI/LQ9KdarUMzU0tSez8Zr+nmvSw1Uwcq/ndViyAJFE90K7c++t5I5zTUQtd+TtAdF3v5VN4XSMqXULPV/kDxGvGCQoWr85PWWm2FFxEBbS6Mdpn1du2N0NmfYxhrbAjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=rlB88jJNYlgxxMkGxx91StsU5W9LXBxOBV6QA9szWDfsD5fUef/H4/grOL5Ev22sw+0vjCsGVbi2pAOwKGOFRwyXqmhNpKUUUmC/u4eGCcbteYQxL8dwDswv4aO5ko7MDeujPcTqEVawvw1uJz8CnbG+3ni+MkcRFLGZPZ4PhNE=
Received: by 10.114.184.16 with SMTP id h16mr3677454waf.1184029742760;
        Mon, 09 Jul 2007 18:09:02 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Mon, 9 Jul 2007 18:09:02 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: b4d1b3715a95c3cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52027>

Git can track file renames implicitly. If I delete and then add (under
a different name) the same content, git will figure that out.

But if a directory was renamed, I have no way to tell fast-import
about it. I can't delete the directory (using a 'D' command) and then
add it back (with a different name) with all its contents, because my
source material (an svn dump file) doesn't tell me, at that point,
about all the files involved because nothing about them has changed.

fast-import knows about the contents of the directory I want to
rename, but doesn't give me a primitive to do the rename. Is this
something we need to add? My frontend could keep track of this, but I
would duplicating work that fast-import is already doing.

Cheers,

- David

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
