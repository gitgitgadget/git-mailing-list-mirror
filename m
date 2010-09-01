From: Chris Packham <judge.packham@gmail.com>
Subject: getting git to ignore modifications to specific files
Date: Wed, 01 Sep 2010 11:57:03 -0700
Message-ID: <4C7EA1FF.8030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 20:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqsUl-0000AV-8I
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 20:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab0IAS5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 14:57:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54462 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0IAS5C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 14:57:02 -0400
Received: by pzk9 with SMTP id 9so2963057pzk.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=dBL8M5xpJz1xwM+oNsdVC7qjrZmrqfl90lY5ayEAtIQ=;
        b=oOl4y78zk3w+Fs7pDXu0nnljjBtlUTHuXantN33V0/tPOSSgcpP/eVb6t+IWkfwsLk
         WkoPH5XAfn84emlZ+1sqfnE0vv88Jea2RLrig77/1pEq4qiyMQ9mv/1G12u0M/d5Y/AN
         GF9zoS09ZPCT6qsH9QJ1n/BTQ1vk8Ct2y8MAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=xuYEdgEFGQAbvAxaR7wMlQDlOGggrJcJiqjyCJV/RsvfP1JxAXYNN5e/w9A2SKAY2x
         ULkW750lDsU2hdTmibmwFDMfXQSp1d0DumDKi6isqSiWY+b48vObbkRk5/Xkw2YSCl6W
         aKmhE8U+sH7i0e4a6nqyNrQ5iu9D9xFllbEwg=
Received: by 10.114.136.19 with SMTP id j19mr4284163wad.170.1283367419767;
        Wed, 01 Sep 2010 11:56:59 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d39sm19062229wam.16.2010.09.01.11.56.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 11:56:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155068>

Hi,

We have a git repository that as some GNU build system (a.k.a.
autotools) files, my current problem is with the INSTALL file but I
suspect there may be some others. These can get modified if you are
running a different version of autotools from when the files were created.

I've had various arguments about which autotools files should or
shouldn't be included in our repositories. My general rule of thumb is
that if it is automatically generated then it shouldn't go into the
repository.

There are a couple of repositories that are local clones of 3rd party
repositories which have included the pesky auto-generated files so whle
I can remove the offending files from repositories we control I need
another solution for the 3rd part ones.

I did a bit of googling and found
  git update-index --assume-unchanged

Which works locally to stop git status from complaining. Is there anyway
for me to make a change to our clone (a .gitattribues entry?) so that
everyone can get this by default?

Thanks,
Chris
