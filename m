From: David Glasser <glasser@davidglasser.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 10:42:10 -0800
Message-ID: <CAN7QDoLEbq47ic61_Bryz1yS=dk5WUGuhuGmmi-jY4eZ9qQ6ng@mail.gmail.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net> <54DC9014.1010200@alum.mit.edu> <20150212121258.GA28801@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Fabian Ruch <bafain@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 19:42:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLyis-0002bk-2k
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 19:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbbBLSmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 13:42:32 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:44210 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbBLSmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 13:42:31 -0500
Received: by mail-we0-f172.google.com with SMTP id k48so11992380wev.3
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=spOUYcKs67mTNRLLU+Bbec0XQnM+liiSM5Lh99uu9jc=;
        b=emW93vEUrvxWcb9zXdfBJu1159saNL432crBVh19WGUybZMowjN0+5w8kQpd5eZ7en
         Lg/8W9gZQ7Pb5YGljbb71FWnzDxhxDHyFCWIFC+mdlUcCsah65vQulhMzFhlIZmlF8kL
         DvSXuIQN+BtjIprbRspEWrm1eN+nc0kz1Le42gm/XhTZCbgY+OmKWQchf8N1nOI6l7tL
         woM+gK8InuNYm4QC08CvewKr86f5V01BHVWnlltYdd1xrhetroPZpwhXNDi5umvYWNlH
         7z8ickrYAcw8MjGUApt/jlNllHmAU98Mw3X8Lu7PU0L+UO2OJlrFHZrHBrLAl3Ogo25u
         1WHg==
X-Received: by 10.180.19.7 with SMTP id a7mr8811707wie.62.1423766550156; Thu,
 12 Feb 2015 10:42:30 -0800 (PST)
Received: by 10.194.29.200 with HTTP; Thu, 12 Feb 2015 10:42:10 -0800 (PST)
In-Reply-To: <20150212121258.GA28801@peff.net>
X-Google-Sender-Auth: IXFv1yXWqsRiwrmnuo5jn30lo80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263750>

On Thu, Feb 12, 2015 at 4:12 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 12, 2015 at 12:35:48PM +0100, Michael Haggerty wrote:
>
>> > I assume you are already munging in your editor the template provided by
>> > "git commit" after the squash? What would be really nice, IMHO, is if
>> > there was a way to set the author during that edit (e.g., by moving one
>> > of the "Author:" lines to the top of the file). That would cover your
>> > use case, I think, and would also be useful in general.
>>
>> If only Git supported options on todo list lines [1], this could be
>> implemented via a "--use-author" option:
>>
>>     pick --use-author 1234556 blah
>>     squash 84392ab etc
>>     fixup 49106a5 another
>>
>> Happily, this would work with fixup, too, without forcing the user to go
>> into the editor. Also, it wouldn't require metadata to be read in-band
>> from the commit message.
>
> Yes, that would be nice, but I don't think David is using a sequencer
> todo list here at all. It's just:
>
>   git merge --squash pr/100
>   git commit

That's correct. I certainly know how to do

  git checkout pr/100
  git rebase -i master  # set things to squash, etc
  git checkout master
  git merge pr/100  # or cherry-pick or whatever

And that's how I always used to do it.  But `merge --squash` is so
much more convenient... except for the minor wrinkle of needing an
extra manual step to give the original author their credit.

--dave


-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
