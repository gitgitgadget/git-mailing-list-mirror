From: Chris Packham <judge.packham@gmail.com>
Subject: [BUG?] "git submodule foreach" when command is ssh
Date: Thu, 6 Jan 2011 11:32:27 +1300
Message-ID: <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 05 23:32:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PabuG-0003YZ-68
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 23:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab1AEWca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 17:32:30 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39433 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1AEWc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 17:32:28 -0500
Received: by fxm20 with SMTP id 20so15522277fxm.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 14:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=PEoDzy0tm+oVBQ46A9dgp8XQki8dVu6P4EarhQqqaqU=;
        b=im/G5FhAAzhqBqXuQcHkK2iNe2859UyOx1HEYDdwAzKCfD+MduDZhXrPKg8X9MEBiV
         3wW95pXU2Ehl7FJjXSd9pM3qEZeVkhZ32pQyWsJeoecYgmXwpciJ/MZ+2JjZTjR39+lo
         XgbSlNAk6wTLYi1rVolO2hXb/UmmuKHWx3yZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Lz7T/wmZsA/hq5W3Te91qZ6kbro8DJpyn6nugsRurofajFHBuaScbp/v/3aVripug/
         5WXoj8uxNYxNGtGBMoE//+an/c9Z3Qh/kPAo95AcMzFnzLYl29AunOUW0ecsjcydgAa/
         F8chWP4kbARRrfwugzD6k4cDCZm/79DeMNzYA=
Received: by 10.223.83.8 with SMTP id d8mr286956fal.94.1294266747255; Wed, 05
 Jan 2011 14:32:27 -0800 (PST)
Received: by 10.223.73.205 with HTTP; Wed, 5 Jan 2011 14:32:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164600>

Hi All,

I just noticed something odd with "git submodule foreach". I was
running a script to create a backup of each submodule on a server I
have ssh access to. I was surprised to find that git submodule foreach
stopped silently after the first submodule.

A little debugging and I find that

git submodule foreach 'ssh localhost "ls /"' - stops silently after
the first module (note that the command does produce the expected
listing and there is no error about the command failing).

git submodule foreach 'echo foo' - works as expected

Any thoughts as to whats going on?

---
git version 1.7.3.2
