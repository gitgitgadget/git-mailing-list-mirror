From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git 2.2.2 annotate crash (strbuf.c:32)
Date: Sun, 8 Feb 2015 23:39:58 -0500
Message-ID: <CAPig+cQ7iYq_c_MstfsMzArCZFM_0ORRa8Gi-YckaeZiWKN=4w@mail.gmail.com>
References: <54D7D634.2050807@aegee.org>
	<20150209012858.GB21072@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dilyan Palauzov <dilyan.palauzov@aegee.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 05:40:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKg8n-00049H-ER
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 05:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133AbbBIEj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 23:39:59 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:59678 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759069AbbBIEj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 23:39:58 -0500
Received: by mail-yh0-f45.google.com with SMTP id a41so6473133yho.4
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 20:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Sc+XImy8ZYAyUk0sdtd+0mVR7MwOw1Nc9za1Xru9mso=;
        b=qVNHfcqJ/0Of/52yqaQb48AC4TDvBqBb6wuoRXUYG+maPZlMXUdYbPldBGQq+w/JtF
         5ZGleDD0VQTL0GExKe0RlLhkyM/3ASTPNG+40/pLUA21+JthABuxfhB/UDFrKiqKkPH/
         KcNeOWXz58cOX87RBlFdGOJPAX9+zg6BBXz5O25ckCVG6Ebb1/Dlmp+NO5q2FFknKjZk
         MzYbCB43Lw1s3npTmLUlSPswN0ROi2jE/mdxRewOrQGhr81hmYYQGw8T/uPov88rSRWj
         LB7691KW8DGZYfSFPC1N/QwjZxF2z+jfKxSMl2C0e0s4TNeTh5LH9rjvT1JpxS4moAAL
         m8Og==
X-Received: by 10.236.105.210 with SMTP id k58mr5007242yhg.52.1423456798185;
 Sun, 08 Feb 2015 20:39:58 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 8 Feb 2015 20:39:58 -0800 (PST)
In-Reply-To: <20150209012858.GB21072@peff.net>
X-Google-Sender-Auth: ihmCo5fjBoYuS7PbvLgHg9x8V20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263545>

On Sun, Feb 8, 2015 at 8:28 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 08, 2015 at 10:33:40PM +0100, Dilyan Palauzov wrote:
>
>> I use git 2.2.2 and on my system git annotate crashed with the following
>> log.
>
> I couldn't reproduce it with a few simple examples. Is it possible for
> you to show us the repository and command that caused this?

I also was unable to reproduce on either Mac OS X or Linux with git
2.2.2. Clues from the traceback suggest the cyrus-imapd project and
annotation of timsieved/parser.c. I tried:

  git clone git://git.cyrusimap.org/cyrus-imapd/
  cd cyrus-imapd
  git --no-pager annotate timsieved/parser.c
