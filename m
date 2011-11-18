From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 09:24:12 +0700
Message-ID: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 03:24:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRE8I-0003kL-1G
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 03:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab1KRCYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 21:24:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45107 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab1KRCYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 21:24:44 -0500
Received: by bke11 with SMTP id 11so2848852bke.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=i9zhF5QxfkeQnomSTCvGabtTcWSTN/+a1lGYJx88FIc=;
        b=FcU2IHzdM6mrFoHwKGr4UFpOPoJagPWTsgC+VYxCKBZVMdy6Nd3jrjjd6PWysovJZQ
         KczBlVF4IDErVt8iqGtg+zj5M8KvzbQ0ZcvweKUF7hvMeAFvCE48tZmgXoVwldAZhb2I
         G2ble9OS0qEtaV+HG4X5vhe4jZSSw9Hj44YmI=
Received: by 10.205.124.144 with SMTP id go16mr1035720bkc.119.1321583083164;
 Thu, 17 Nov 2011 18:24:43 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Thu, 17 Nov 2011 18:24:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185625>

Hi,

My builtin/.depend/add.o.d says

add.o: .... cache.h ...

Shouldn't it be "builtin/add.o: ... cache.h ..."? I tried to touch
cache.h and "make builtin/add.o". It did not remake builtin/add.o. If
I modify add.o.d by hand and remake, it works.
-- 
Duy
