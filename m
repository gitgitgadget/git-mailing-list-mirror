From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: need help stripping a repo to one file
Date: Sun, 19 Oct 2008 06:27:35 -0400
Message-ID: <81bfc67a0810190327i7842d346g4c20f5816e8a9eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 08:32:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrVWt-000737-4m
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 12:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYJSK1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 06:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYJSK1i
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 06:27:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:1745 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbYJSK1g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 06:27:36 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1342237rvb.1
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=/50Oh4gtCbnpnGgDpN/OGRe21WlpwaVMkLHGr2dz3kE=;
        b=Vi//8tC+AG26bJbnHAwsdMo8QYGIlkMH5eyDHwgeuOYgoyxvB1PH2NK3V7F1/jrF96
         dCzqB8EsmiTlWHp4fRxQx3vus+V6pHGD3Ola/k4BTGojc++7i3Jn3CTkgjyJCnNUD5Ku
         5B8/JQpJzbQ9UVZJSCoVMVWx0Wb6YaR2yrBtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=uzWt5YSahraJ14iYWAzyrPzGEOUienlw+v+WTFsMdm+XbhucxB/RaGW5wZLVB++Ebq
         NYLdSgdR5ceP4XvLdm7ozEAWJxvFVGslzCO2QDLajHwmlfPkHc3dyQSgz59qqh8hT77Z
         gFQLBxfhjrJ9/yD2enzOcon57X//y4XTppsfQ=
Received: by 10.141.156.11 with SMTP id i11mr3976627rvo.1.1224412055195;
        Sun, 19 Oct 2008 03:27:35 -0700 (PDT)
Received: by 10.141.145.7 with HTTP; Sun, 19 Oct 2008 03:27:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98620>

here's what I've done so far (note: this is a public repo if anyone
wants to take a look)

git clone git@github.com:xenoterracide/dot_usr.git sql_iabbr
cd sql_iabbr/
git checkout db3c5ffb180f10dde8e539a81a6644760e098dcd
git branch -D master
git checkout -b master
git filter-branch --subdirectory-filter  vim/ftplugin/ -- --all


that leaves me with this
html  sgml  sh  tex  vim  xhtml  xml  sql_iabbr.vim  xml.vim

all I want left is sql_iabbr.vim and it's history

I've used stuff like
git filter-branch --tree-filter 'rm -rf xml.vim' HEAD

to remove the files... but I notice that leaves the logs.

I'm thinking I could do that and then remove those commits but I
haven't figured out how to remove the commits, and even then I'm not
sure the repo would be in the state I want.

can anyone help me get to where I want to be? also is there an easier
way to do what I've done so far?
-- 
Caleb Cushing
