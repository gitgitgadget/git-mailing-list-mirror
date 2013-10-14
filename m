From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v4 1/3] test: use unambigous leading path (/foo) for mingw
Date: Mon, 14 Oct 2013 09:33:40 +0800
Message-ID: <CANYiYbFGhiztU8=oM3WC8CQSKZ1KuKZtwobJdaNzapZAvPDdzA@mail.gmail.com>
References: <cover.1379644482.git.worldhello.net@gmail.com>
	<15724e27cbef5067902ebebb93aa77d3605402c8.1379644482.git.worldhello.net@gmail.com>
	<52570EC8.3050207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 03:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVX2k-0006oG-Sy
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 03:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab3JNBdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 21:33:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38217 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab3JNBdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 21:33:41 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so6353878wes.19
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sgZK7Tpcsf+rLHgJCps3i+D7Wic5+b3D7mrY2xuS7O8=;
        b=jHJJmZHNj20zw8jlCTpW+PO5BooaaJn8/5uJdcEhFSpXtb/+mUyNdXLAh682ORySCn
         Ky6jv/qEsELv7u/mnRQ9v3wvo0SgQ31Qsgc/NRszH16SziH86sT0SfmsZSrNBkR5pEIw
         c70Z9de5+mFD4qiXAiQQEr2xUn3dRAqncg8XXaiEJVysTW6CU71gGLpekwoamG8v+AHM
         P46BIYUa85qefY/xiXreLWKgwjlpHWZcWA0F1LAaOW/7FJ2HrmXxY91zBLvZzfYo1asT
         Ugrvfw1+yXR3IZ8CgzDL7X8utwSslJNKHqJPcX08FBY4YKPvQbRbwWINGMtYjMYDwlL7
         esXw==
X-Received: by 10.194.173.163 with SMTP id bl3mr27682003wjc.10.1381714420169;
 Sun, 13 Oct 2013 18:33:40 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Sun, 13 Oct 2013 18:33:40 -0700 (PDT)
In-Reply-To: <52570EC8.3050207@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236085>

2013/10/11 Sebastian Schuberth <sschuberth@gmail.com>:
>> In test cases for relative_path, path with one leading character
>> (such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
>> such DOS drive on MINGW platform. Use an umambigous leading path
>> "/foo" instead.
>>
>> Also change two leading slashes (//) to three leading slashes (///),
>> otherwize it will be recognized as UNC name on MINGW platform.
>
> Note that the path mangling comes from MSYS [1], not MinGW, so you should
> place "MINGW" with "MSYS" in several places. As a side-note, the official
> spelling is "MinGW", not "MINGW".
>

I will make a reroll. s/MINGW/MSYS/i

>> -relative_path /a/b/c/  /a/b/           c/
>
>
>> +relative_path /foo/a/b/c/      /foo/a/b/       c/
>
>
> Wouldn't it have been more straight-forward to just replace "a" with "foo",
> "b" with "bar" and "c" with "baz" (or whatever)? So that the first line
> would say
>
> relative_path /foo/bar/baz/     /foo/bar/               baz/
>

These test cases have been used in some commit logs, such as
commit: v1.8.3-rc2-13-gad66df2. And for me (a non-English speaker)
a,b,c,x,y,z are more readable than bar, baz, qux, ...

-- 
Jiang Xin
