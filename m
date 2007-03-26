From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Removing a newly added file
Date: Mon, 26 Mar 2007 16:59:57 +0200
Message-ID: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 17:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVqgM-0002xP-4f
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 17:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbXCZPAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 11:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbXCZPAA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 11:00:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:9541 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbXCZO77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 10:59:59 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2918300nfa
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 07:59:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lUNnFrmtKarLvZxy5kH2hu/0PIcf/4chRD8Luee0hRVImoqE62Qg2E9nphH00iQlRAla6aqKDxagYaYBIpHwon/itg0CRs66ipWtx/u1M1DtnDoyggxiZF7g/nz3FEyA7MOLW3x+A+G6hMq4KtOJQmBnE47R2IB6tUeVevwttPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zf/6ZBSDc0KaWvkHII3lE5M6nOXGHwOeb3GXHyQqOdWZAwroz8Z/y5REolqH8Jtlf8NBBLxN3TwRj6uIZcQXbXq2dxFBtorlilX7xPZKgOk/44pkeCHnyIRUoDxTt8xeb0Xb82N+f+KgzP0Rw1tpRB7STFS2W5dGtYfcW3BxCEs=
Received: by 10.78.106.3 with SMTP id e3mr3023373huc.1174921197956;
        Mon, 26 Mar 2007 07:59:57 -0700 (PDT)
Received: by 10.78.69.4 with HTTP; Mon, 26 Mar 2007 07:59:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43156>

Hi *,

  when you try removing a newly added file it success and removes the
file from the working directory. So if you do:

$ echo "newly added file" > new
$ git add new
$ git rm new

the file "new" is lost, it is not in the index, neither in HEAD. At
this moment the only way to recover the file new is searching for
unreachable objects. (Am I missing something?)

  I think that the "git rm new" should remove "new" from the index or
should fail, maybe with:

$ git rm new
error: 'new' is not in HEAD (hint: try --cached)

  Santi
