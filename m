From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 19:17:00 +0200
Message-ID: <CAFjFENq7jXA70KJSk0U7LpAupJv3tkRAfgyMKA1RewW=ttsUdQ@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org>
	<87k3xli6mn.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:17:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svtae-0000NO-AU
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab2G3RRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:17:01 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50170 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab2G3RRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:17:00 -0400
Received: by qadb17 with SMTP id b17so1104350qad.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=goFbmb8XzF6Smoxa5HIX7PmMcSGOcd4kxISVn++w5EU=;
        b=YTp6ihXwrhTzjjciV57BzI5VZLRt0OgymzLBaq8WKCuUAoWYS5VZNCwYTRCv6pxvDm
         rpPVRD+cMEeeGLaGgfEnwIuMXNRupKDcIkp707A+U+6jiInxO9pYvBrHo8NXwgqP8qdB
         r2HU7AwscaKfKmavbo8cWZgGO/PXzZEf8fgkEVwMQ1oU5qRs4kqbjfw8EHjsYTxgMuyC
         uviC03Ry5pEhvMesLKoyCFyEbnv92Yu+Cu+nzXfJzyI/oSGB9zTvWMQW1byrWFr8XQtN
         PyEGwcSvdA5rujuKP+XsiK2/q5sh0XbROlG+RKDJ2udupNVWoC4PN+H5SRoP2/cQu4c8
         IrPg==
Received: by 10.224.109.134 with SMTP id j6mr12961284qap.74.1343668620155;
 Mon, 30 Jul 2012 10:17:00 -0700 (PDT)
Received: by 10.224.128.211 with HTTP; Mon, 30 Jul 2012 10:17:00 -0700 (PDT)
In-Reply-To: <87k3xli6mn.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202585>

2012/7/30 Thomas Rast <trast@student.ethz.ch>:
> Thomas Badie <thomas.badie@gmail.com> writes:
>
>> The idea is to have a perl module which run through
>> the log history and print 10 shortlog associated with a number
>> from 0 to 9, and a message below "Select commit [| 0, 9 |] or
>> next row ?" or this kind of message with several options.
>>
>> So I ask to the community if this module is interesting for git.
>> It can be integrated everywhere a sha1 is requested (git rebase,
>> git reset, ...). IMHO, it can be an enhancement.
>
> I think this is too specific.  If you want full interactivity, use a
> real interactive tool like tig.

Second suggestion for tig. I must definitely try it.

> However, your post and some quick searching gave me another idea.  Bash
> actually has features to let you edit the current command line from
> within key bindings.  So if only we had some clever utility, let's call
> it lineselect for lack of a better name, that let us do
>
>   git log --oneline <args> | lineselect
>
> then we could paste the selected SHA1 into the command line.  That would
> be really neat, wouldn't it?
>
> I haven't found such a utility, so below is my first shot at making
> something useful.  It has:
>
> * a few keybinds that should make most people happy
> * color rendering (yay), but because of issues with the default
>   rendering, it sets white-on-black by default
> * an optional regex arg to select only parts of the lines

Very interesting. I tried it and it is nice. I fix a little bug ("Use of
uninitialized...") on my fork. I will take a look on the things that
don't work yet ;) I'm pretty sure that there is a lot of possible
usage of this script.

> Things that notably _don't_ work yet:
>
> * cursor keys (I have no idea why it doesn't match KEY_UP etc.)
> * ANSI attributes (colors work, of sorts)
> * Searching the next occurrence of a search string
>
> But you can probably guess that those aren't a huge problem for me.
>
> I made a little repo too, for all your forking needs:
>
>   https://github.com/trast/lineselect.git
>   git://github.com/trast/lineselect.git

Thanks for sharing it!

> Thanks for the idea :-)

You're very welcome!

-- 
Thomas "Enki" Badie
