From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and 
	MSVC
Date: Thu, 17 Sep 2009 12:57:43 +0400
Message-ID: <e2480c70909170157g4890c408g2086942e7b68301c@mail.gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
	 <4AB10F01.9010703@viscovery.net>
	 <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>
	 <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com>
	 <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>
	 <4AB1EF0E.5010600@viscovery.net>
	 <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>
	 <4AB1F71B.6050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 10:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoCoK-0005QM-1x
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 10:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbZIQI5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 04:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbZIQI5l
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 04:57:41 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:34785 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbZIQI5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 04:57:40 -0400
Received: by fxm17 with SMTP id 17so2821998fxm.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=r0sLKxnhMhyge4NZshukfLfXuCZ/RZ1O83WS+1u60Tk=;
        b=iW2OX8s8vtfkYyxjpxj/TPnRyP19+x96wFj4o6QsiFAyVUGc2QFzL8aOcZoyL2uL3Z
         tLr2lvbeDgWhqURWMQVLBr0w12Y463apIgJ2kUWZHuZfIQ5qr9XvbXRDUdDa0V33LeHY
         MgVxawXAL+WZ1Iq8VxwTVHbxTqpdFtEMwMLXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=raZ3cshrQKbC5NX+lMOaCpGwosOWSN+EewsxnVLmeSyCUtbRIGFyPG0r6n5j/dFe+3
         r4lt+/RDuhYuyyHabu1tIyrpijTkn/mHHvdEOoCbWhIZL9WbLjYMvZ2/D/QFzz5hjfCY
         BmR9Ky7oQ3KyaG60YB6gMYy2hQaFBTKzfdKgI=
Received: by 10.223.20.88 with SMTP id e24mr3440578fab.3.1253177863622; Thu, 
	17 Sep 2009 01:57:43 -0700 (PDT)
In-Reply-To: <4AB1F71B.6050004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128735>

On Thu, Sep 17, 2009 at 12:45 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> we already override the stat() implementation with our own :)

Yes, that's why implementing nsec whould be easy. See compat/cygwin.c
(filetime_to_timespec) and git-compat-util.h (#ifdef NO_NSEC).
Currently mingw doesn't support tv_nsec.
