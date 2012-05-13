From: Steven Penny <svnpenn@gmail.com>
Subject: Re: Git commit path vs rebase path
Date: Sun, 13 May 2012 18:42:38 -0500
Message-ID: <CAAXzdLWTg8MQ7h6uvto3SxHwxsC63_1mj9WhnXm+ATvPxVf5Fg@mail.gmail.com>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
	<4FA8BBB0.1080406@viscovery.net>
	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
	<4FA8C5DB.5060002@viscovery.net>
	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>
	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>
	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
	<4FAC047A.4010001@ramsay1.demon.co.uk>
	<CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com>
	<4FB03CA1.4030703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon May 14 01:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STiR2-0005DB-5b
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 01:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab2EMXmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 19:42:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46246 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2EMXmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2012 19:42:39 -0400
Received: by yenm10 with SMTP id m10so3801197yen.19
        for <git@vger.kernel.org>; Sun, 13 May 2012 16:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D8r7ebR0y/e9IQwoNhY1xOhkTtW7Z5tLf9YC2hwRE/g=;
        b=xLSm9MWchUDa/vEr9uaOxNIFzOPO/vrXJouDWb30mSn2LVdB4qnegQXAF1bnOUxBBA
         AQK12I353oIV8020HnibnWpPMSnvK6F9QQ6P46Lbv74T6+2/vDCr4TDIEcEMbM2eWNBY
         1mshbh6PrLcMjY1ZBDfkh2j9sqdiWelihndG5OHtM/Sx+l1daoTNxU97NP9h1/St3Fuq
         OU4wo0lX0jIALoYFVGthXZF+yXCxZ1BjCHJBtoGas2fvPu8qy3oQ6iDbTuwMwqOdKgmk
         os8UVvGk8K0sNikYkDwY4F6D6vQV8GxMfMjvhzd3p1bCL5a1aY5N8Qj4rSOHhW6xZUx/
         BClQ==
Received: by 10.50.195.131 with SMTP id ie3mr3066584igc.73.1336952558467; Sun,
 13 May 2012 16:42:38 -0700 (PDT)
Received: by 10.231.69.140 with HTTP; Sun, 13 May 2012 16:42:38 -0700 (PDT)
In-Reply-To: <4FB03CA1.4030703@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197760>

Ramsay Jones wrote:
> I haven't actually tried to apply or test your patch, so take the
> following with a pinch of salt ...
>
> I don't think this will work because:
>
>    - cygpath is not a bash builtin, so bash *should* simply issue
>      an error something along the lines of "not a shell builtin".
>
>    - cygpath requires an input path
>
> So, I would have expected the body of the pwd function to be something like:
>
>    cygpath -m "$PWD"

If you would actually look at the file, you would see that pretty much
everything you just wrote is wrong

SNIPPET

*MINGW*)
	pwd () {
		builtin pwd -W
	}

http://github.com/git/git/blob/master/git-sh-setup.sh
