From: Chris Packham <judge.packham@gmail.com>
Subject: [BUG] git-1.7.2-rc1, cherry-picking with gitk
Date: Fri, 09 Jul 2010 14:21:42 -0700
Message-ID: <4C3792E6.5060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 23:21:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXL17-00038N-DU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 23:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab0GIVVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 17:21:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33890 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab0GIVVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 17:21:48 -0400
Received: by pvc7 with SMTP id 7so1014519pvc.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=HwIjFEc8zGh/iUdWRo83++0imN2hxIphUujMoElT2kU=;
        b=K4WcoTy4iVKFPtxRNQUAypeCswsSRXWoIEnt/4emEzN4c7ovfhCzq2ejoERGY1FN3d
         W/2xlSh7HzeUnGhFbOcZv6Ys+M9sQofut87b469w7GkZUioV4gyQpwCb6GoTOPpywJ5r
         v9jkWX375+HO4tqtpSmaDQObSI1+rySb6syeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=RKat9Htj0AX/25BpF4Rwp6yzHFBRgZ3WZ6vKAXGAjjIAebhECFLNqUPA1FwBYONLNY
         hJF5QMKmS5eKGO31WeQYEuBvi3NYOnjJ/qKkgj2Rvr7nBzcpDA73Q696eTlrCZpLKJ0r
         lyiu34IxgQsO8zNE0ED9HZFPI8gkwhK7NNYng=
Received: by 10.115.18.1 with SMTP id v1mr9830319wai.75.1278710507467;
        Fri, 09 Jul 2010 14:21:47 -0700 (PDT)
Received: from [10.4.6.94] (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d35sm19908922waa.9.2010.07.09.14.21.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 14:21:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.10) Gecko/20100520 SUSE/3.0.5 Thunderbird/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150689>

Hi,

Just noticed this when I was trying to cherry-pick a commit from one
branch to another.

I launch gitk with 'gitk master..work' and right-click a commit to be
cherry-picked. The cherry-pick seems to work (i.e. a new commit appears
on master) but I get the following message from gitk:

can't read "circleitem(5)": no such element in array
can't read "circleitem(5)": no such element in array
    while executing
"$canv itemconf $circleitem($row) -fill $ofill"
    (procedure "redrawtags" line 13)
    invoked from within
"redrawtags $oldhead"
    (procedure "cherrypick" line 46)
    invoked from within
"cherrypick"
    invoked from within
".rowctxmenu invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .rowctxmenu 1"
    (command bound to event)

I've been doing similar things with older versions of git without
problems (technically I usually do 'gitk --all' instead of 'gitk
master..work').

--
Thanks,
Chris
