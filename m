From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/3] remote-testsvn.c: Avoid the getline() GNU extension function
Date: Sat, 25 Aug 2012 21:20:44 +0200
Message-ID: <CABPQNSZfUO-vjVmBU2+CMbxTXMj_HT=cTFfVbnehUjqOL-vkxw@mail.gmail.com>
References: <503907B3.9040101@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: florian.achleitner.2.6.31@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Aug 25 21:22:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5LwK-0005nd-9l
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 21:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445Ab2HYTWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 15:22:01 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52097 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290Ab2HYTV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 15:21:26 -0400
Received: by vcbfk26 with SMTP id fk26so3249775vcb.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7m6HyKVDWH50WxAKHSzcHmeo4I4zUfOtiRZ+23mXCMU=;
        b=IO/ckV0huED7WHR8hr94I2yBjNjFywfj+aIzgKTaIpv1r23ZOZZVMSEw9nZG/5Z/8N
         bHIxJJhEWRyPHTooCVpl325ykBwo3l/bz0HKSvuatS+Y+RzOUtfmHbLgk3KrNGDb0Ql0
         IeniZCMpcqAjll07dUtGCU9mDbXg7q0g6IHfRkPZt5D/EdnB9Jdc8iXxwMUCkz9fB0Go
         zWGXnf4neyXvy5dGHCvMZ2N50mm1gcXk7vyKzYN51K3TqIxswX3fALvF4Rz98ZxKW1NW
         lm2D82RORo4RLd8d+5urDlpTh8IkmojLL7mf9ArUPS0x7KfGhhOCQJJNZCqigB8+jOQr
         /rpQ==
Received: by 10.220.222.20 with SMTP id ie20mr7728751vcb.13.1345922485284;
 Sat, 25 Aug 2012 12:21:25 -0700 (PDT)
Received: by 10.58.237.166 with HTTP; Sat, 25 Aug 2012 12:20:44 -0700 (PDT)
In-Reply-To: <503907B3.9040101@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204282>

On Sat, Aug 25, 2012 at 7:13 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> The getline() function is a GNU extension (you need to define
> _GNU_SOURCE before including stdio.h) and is, therefore, not
> portable. In particular, getline() is not available on MinGW.

Actually, getline is a POSIX-2008 feature, so it's not (simply) a GNU extension:

http://pubs.opengroup.org/onlinepubs/9699919799/functions/getline.html
