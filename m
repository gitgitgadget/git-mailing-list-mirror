From: David Michael <fedora.dm0@gmail.com>
Subject: Re: Build fixes for another obscure Unix
Date: Thu, 13 Dec 2012 17:30:27 -0500
Message-ID: <CAEvUa7nNNYREAsxc==tfg+e1XNZFbDVOpGXE6z-7+SfbqNrp6Q@mail.gmail.com>
References: <CAEvUa7nn9M5np3wD=Z1152K4pwNGhSKkC=rS9U=yc=UcaOxMCw@mail.gmail.com>
	<871B6C10EBEFE342A772D1159D13208539FF9088@umechphg.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 23:30:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjHIk-0004MC-65
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 23:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab2LMWa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 17:30:29 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52432 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab2LMWa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 17:30:28 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so3043925vby.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 14:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=kak6ZUxYp39vaHyzSMSiIon6dGfYq2RVJ8xvuCTQx14=;
        b=miwY/XKkiLbtIJS2WIi5Xv4PjHfjSEmYKL0AUSNGbjiY89JhgEvQzovxiyuzqREGD6
         0mB9CcbB0ZJdlBHItaktaV47mOE7ZHYqA67qziQsDhSUx7E4UjeQ785akSGdi0RwyfzB
         FIqhvKhUQ3e1G9uBUvNkzXtlTAN3P7kNn3KRtUPoK/j9Ep5snnqrMQrchfEXaou/5tON
         ulZ+6qIJI5NJ2dgWj4IaogCxNqmP+10F1yzBg1QXh9l5plpIpPyAkfo2RBJ7Q1UsypNE
         KGFxG7HhG7409Rt+kRuSjx4FtaqlXcC/uHkjQYMxkioVSqmJ5fO8TwT00tvIEdMek8SV
         EXlA==
Received: by 10.52.29.175 with SMTP id l15mr5441348vdh.2.1355437827932; Thu,
 13 Dec 2012 14:30:27 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Thu, 13 Dec 2012 14:30:27 -0800 (PST)
In-Reply-To: <871B6C10EBEFE342A772D1159D13208539FF9088@umechphg.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211476>

Hi,

On Thu, Dec 13, 2012 at 12:18 PM, Pyeron, Jason J CTR (US)
<jason.j.pyeron.ctr@mail.mil> wrote:
>> Would there be any interest in applying such individual compatibility
>> fixes for this system, even if a full port doesn't reach completion?
>
> What are the down sides? Can your changes be shown to not impact builds on other systems?

I've pushed a handful of small compatibility patches to GitHub[1]
which are enough to successfully compile the project.  The default
values of the new variables should make them unnoticeable to other
systems.

Are there any concerns with this type of change?  If they would be
acceptable, I can try sending the first four of those patches to the
list properly.  (I expect the last two may be tweaked as I continue
working with the port.)

I do have a concern with strings.h, though.  That file will be
included for most people who run ./configure, when it wasn't before.
Do you think it's worth making a more detailed test to see if
strcasecmp is still undefined after string.h is included, rather than
just testing for the header's existence?

Thanks.

David

[1] https://github.com/dm0-/git/commits
