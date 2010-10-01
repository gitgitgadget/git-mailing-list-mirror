From: Nate Parsons <parsons.nate@gmail.com>
Subject: Re: git .lock file error
Date: Thu, 30 Sep 2010 20:57:20 -0400
Message-ID: <AANLkTi=eMt_OduJ8d=5mhhnt+q-Mpb8b1iimt_0bws3f@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
 <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
 <AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
 <AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com>
 <7vbp7fhtt0.fsf@alter.siamese.dyndns.org> <AANLkTinFJ5rSA7Om0ZxhuqzQiqEDvJ+JoEQFpz=NDvxE@mail.gmail.com>
 <AANLkTikV=f1ncAxQ1LWzntnOwiBKMfw_D8Mcuh+wCO3+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 01 02:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Twa-0000oQ-UW
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 02:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab0JAA5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 20:57:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59165 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0JAA5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 20:57:41 -0400
Received: by iwn5 with SMTP id 5so3119328iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=lpLOHXYe9e95DXFLbAG4o7fAzu/TLvz0DOUsnVq0amM=;
        b=q1l4Ir2jtsjqn8Q5IrVnP0F0/luRZVrIqaZP/yrZjfAONMEKD+bze1k2XLmLMHU6HJ
         WD3VlKjbuw0Oob2S+YqlkVCA11WtRssPGbYRc4GFH8SZwUY9UnpsoLLrdMiafyzGu05l
         srzQxa+sGnfCXOnja7zzTpwzJNsRAyWdXixQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QTgZhIfH1lzKfNZCtFcoBeHaxqS9/YkwsFpKRWrCTcXEQtKkH2CTbmABgtqmM5bck7
         0QGOL4nTsIf0Tq25T8Usv7SOfXHQktC/FvJyU3hQbvJ7NukYbw8+ojt7UXX5eWMnPMTB
         NDlhJOoXSR36BeNIWI5qCf0e9RHtNrf9vrd0g=
Received: by 10.231.30.76 with SMTP id t12mr4609965ibc.161.1285894660549; Thu,
 30 Sep 2010 17:57:40 -0700 (PDT)
Received: by 10.231.155.210 with HTTP; Thu, 30 Sep 2010 17:57:20 -0700 (PDT)
In-Reply-To: <AANLkTikV=f1ncAxQ1LWzntnOwiBKMfw_D8Mcuh+wCO3+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157726>

On Thu, Sep 30, 2010 at 7:45 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Are you running some anti-virus, or from a Dropbox-folder (or
> something similar)? If so, these applications tend to open files for a
> short while and then release the file handle. This can some times
> cause race conditions with other software, like Git.
>
> I haven't looked into this particular code-path for what kind of
> hazards might be, but this sounds very much like one such case to me.
>

Any of these things are possible. As much as I'd like to find the root
cause of this problem, isn't making Git more robust a good thing in
general? Finding every program that could conflict with Git and
disabling/uninstalling it isn't really a good long term solution, I
think.
