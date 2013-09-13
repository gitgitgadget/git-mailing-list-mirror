From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Fri, 13 Sep 2013 12:55:10 +0800
Message-ID: <CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
	<5231CBFA.3070806@web.de>
	<5231F839.3080208@kdbg.org>
	<xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 06:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKLPn-0000ZB-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 06:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab3IMEzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 00:55:13 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:46354 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3IMEzL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 00:55:11 -0400
Received: by mail-wg0-f52.google.com with SMTP id m15so653204wgh.7
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 21:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i4PKmhIi4StgkZEw8fe1NxshD0Ux4oYSwJQUj00wIF0=;
        b=LsUauDerQOeiKvTPM1BSlYPGmzHdlfgEhONh8u8/GxR5jFjfIf8j3Tkt5QZn9dh6iK
         vEI5l28+UqLvW1aQMs6UzWFsVbOKmQIfjrZ9asoG1iZP1Oy+Ng5VdtrxSMcxDLphDhiv
         VI9ykJQyPuA2TIcAuL2LvhZIpSOrvu9MAtb3NU3bkwM6FviRFo8pXekoQ8KBhpZzfKVP
         z6zy3HbEKIa61PcwsTXLWBDCuqoipQTFSYfMgs9tLFr+dxV4KTxLEM2XHaOnjIHo3zbc
         dyOkZhtIapN2xC7QkBaggAxNpZqN5bhx8ZeWSlbCgcUCi7L9ZMiVA8dEwws+XP+F6YYC
         T0KQ==
X-Received: by 10.180.189.49 with SMTP id gf17mr903463wic.23.1379048110399;
 Thu, 12 Sep 2013 21:55:10 -0700 (PDT)
Received: by 10.194.71.175 with HTTP; Thu, 12 Sep 2013 21:55:10 -0700 (PDT)
In-Reply-To: <xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234725>

2013/9/13 Junio C Hamano <gitster@pobox.com>:
>
> For systems that need POSIX escape hatch for Apollo Domain ;-), we
> would need a bit more work.  When both path1 and path2 begin with a
> double-dash, we would need to check if they match up to the next
> slash, so that
>
>  - //host1/usr/src and //host1/usr/lib share the same root and the
>    former can be made to ../src relative to the latter;
>
>  - //host1/usr/src and //host2/usr/lib are of separate roots.
>
> or something.
>
>

But how could we know which platform supports network pathnames and
needs such implementation.

-- 
Jiang Xin
