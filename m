From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Sat, 19 Jan 2013 22:49:56 +0100
Message-ID: <CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
References: <50FB1196.2090309@gmail.com>
	<1358632037-ner-2564@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric James Michael Ritz <lobbyjones@gmail.com>,
	git <git@vger.kernel.org>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 22:50:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwgIs-0007LB-On
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 22:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab3ASVt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 16:49:58 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:60845 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3ASVt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 16:49:58 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so2249435eek.6
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=u6lTni0EzX1WJgD0N6P8dNUnKcHTWvqYSgov66AUiWo=;
        b=QqHsoUBrpxnOq4db7Zl7PYuUgJdGGwrzQ2gvSKwzLOdcVuZhZ0Fusjt0ImHDG0PMlz
         RQxjos8EdKzTMGdp7rRcEutkkzBimFo788n3tHInuBJ6RcjaslrYiAmtWP1SJVEgNaF2
         W76st7BwxqP5vTYQLvSn0Bi6ilogZzA0qesD/zBKZaYN7qYoZW9D2Efxs0Po8oXX9qZ8
         VUOGp1qIHCbCF6BKl+Q2M9vSukYROX4zRkthvuLLT8Kkt+lPv2GBbhViDILj6HXmxQd9
         VIOLDS8PGe1pwBH9yAKfps2By1GL6PksxvzoI1geacqkoEaO6Z5v0baHGKD1vexhhJEx
         Zu2A==
X-Received: by 10.14.202.194 with SMTP id d42mr25259837eeo.28.1358632196598;
 Sat, 19 Jan 2013 13:49:56 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Sat, 19 Jan 2013 13:49:56 -0800 (PST)
In-Reply-To: <1358632037-ner-2564@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213991>

I think `git add -u` would be closer. It would stage removal of files,
but would not stage untracked files.
It would stage other type of changes though.

On Sat, Jan 19, 2013 at 10:47 PM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
> On Sat, 19 Jan 2013 16:35:18 -0500, Eric James Michael Ritz <lobbyjones@gmail.com> wrote:
>> Hello everyone,
>>
>> I am thinking about implementing a feature but I would appreciate any
>> feedback before I begin, because more experienced Git developers and
>> users may see some major problem that I do not.
>>
>> Earlier today I deleted a file from a repository.  I deleted it
>> normally, not by using `git rm`.  So when I looked at `git status` on
>> my terminal it told me about the file no longer being there.  In my
>> sleepy state of mind I ran `git rm -u` without thinking about.  I did
>> this because I have a habit of using `git add -u`.  I know `git rm`
>> does not support that option, but I tried it anyways without thinking
>> about it.
>>
>> When I came to my senses and realized that does not work I began to
>> wonder if `git rm -u` should exist.  If any deleted, tracked files are
>> not part of the index to commit then `git rm -u` would add that change
>> to the index.  This would save users the effort of having to type out
>> `git rm <filename>`, and could be useful when a user is deleting
>> multiple files.
>>
>> Does this sound like a reasonable, useful feature to Git?  Or is there
>> already a way to accomplish this which I have missed out of ignorance?
>> Any thoughts and feedback would be greatly appreciated.
>
> Does `git add -A` do what you want?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
