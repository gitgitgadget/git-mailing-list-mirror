From: Steven Penny <svnpenn@gmail.com>
Subject: Re: Git commit path vs rebase path
Date: Tue, 8 May 2012 01:44:47 -0500
Message-ID: <CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
	<4FA8BBB0.1080406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 08 08:44:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SReAG-0006Xl-LA
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 08:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab2EHGos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 02:44:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36675 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab2EHGor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 02:44:47 -0400
Received: by yhmm54 with SMTP id m54so4998908yhm.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1G7LYY90x8zaXjzijt43nxHgH62WTvNKvHen9FrnSfY=;
        b=d1ydC9/588Mv4iHeKsztoftZkisvZgikKjR8sKzca95/VNhzINfEiypWwNg1DVV6dF
         +MLziCkBRS98z/c/WKlzL83q6A8HFG53WGxKR1ngMviXLS5a5uXxmVhZZMYEkC7an6MR
         s6sLj5C8PyhsP1TYCsEWOOTFLv9rux2bBe6U71JNLwBIzepn9iYZ0jTAy51Ih4kb2v2H
         g544Rjl+5XGn8IfJMbOkB8lF3HEO0YzRGPqX+MqvlkOyQsF3Ui/PMNFnL4U2Y83Ec8Zn
         JuZVyAQPNsR96V1QQbAzIiyopbc3ZdgMQmzIiD0B+tOYCIkbPMv+XsiC80obQTXDPtP1
         0t8w==
Received: by 10.50.160.225 with SMTP id xn1mr6691038igb.3.1336459487107; Mon,
 07 May 2012 23:44:47 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Mon, 7 May 2012 23:44:47 -0700 (PDT)
In-Reply-To: <4FA8BBB0.1080406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197341>

Johannes Sixt wrote:
> The problem should be mitigated by be39048a7 (git-sh-setup.sh: Add an
> pwd() function for MinGW), where the above now returns a Windows-style
> absolute path, albeit with forward slashes instead of the backslashes.

http://github.com/git/git/commit/be390

This looks like a good solution for MinGW, but cygwin will not support that

$ pwd -W
bash: pwd: -W: invalid option
pwd: usage: pwd [-LP]

Cygwin uses cygpath

$ cygpath -m /c/Windows/System32
C:/Windows/System32
