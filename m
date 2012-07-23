From: Ramana Kumar <ramana@member.fsf.org>
Subject: Re: empty ident name trashes commit message
Date: Mon, 23 Jul 2012 19:05:10 +0100
Message-ID: <CAMej=25rwCtY6NAJYXNw3jMZSmsZ81Ta1d11kic7CfBkO4zmaw@mail.gmail.com>
References: <CAMej=25=xj61pc+k42dv3byuBqUJzW21Sz+BXwoufqnKwV5Bbg@mail.gmail.com>
 <CAMej=270FDFxyVtKTC9v4KUSkSw+TBNOg+LbGfWOgmTe_xKiRQ@mail.gmail.com> <20120723172726.GA2463@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:05:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StN0j-0003va-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab2GWSFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:05:32 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42852 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab2GWSFb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:05:31 -0400
Received: by qcro28 with SMTP id o28so3409678qcr.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=wHIVjx/ah/lfuWh6sVrHj1rDi39tT8uWmyCC19+C6Z4=;
        b=l6dogXMtYlNJhm5GpLVRzEuBk4Jk8t75N7/rvST4blhtvAKSN6NNjry7ajBhztsuo0
         RJtdjmCoDy6eRAGTsve5meURdKQD6N6xN+TFp1G1vPx92a4pIhTUY9KC85Me0mSQG3M8
         uiKXnN4NuAgsrIhII4XWwup8BxQe9d5gcX3ctzSkLUbqC8MzQjtU2SbLlyGHYtDMGDc/
         nBzmQtbkjUahWLxO4yXp9m4jIO6hC7NjYRGB3gAqMZLxT7OYqlZ4dhHnMjcvyyLEGqZr
         dgDSBYPL8HW++4S6UHXllUbnBwODd0lC/9RRK6oytj2WxrJbLvAPu89GM0y9TWWIrC56
         o2fw==
Received: by 10.224.187.136 with SMTP id cw8mr25925034qab.70.1343066731086;
 Mon, 23 Jul 2012 11:05:31 -0700 (PDT)
Received: by 10.229.132.17 with HTTP; Mon, 23 Jul 2012 11:05:10 -0700 (PDT)
In-Reply-To: <20120723172726.GA2463@sigill.intra.peff.net>
X-Google-Sender-Auth: cW2LMI1ISt34BDxjx4yD9CbxZiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201945>

On Mon, Jul 23, 2012 at 6:27 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jul 21, 2012 at 03:26:26PM +0100, Ramana Kumar wrote:
>
>> If I forget to set user.email and user.name config options and do a commit
>> (possibly the --amend option also required to make this show up), then git
>> 1.7.11.2 will drops me into an editor for a commit message, then after that
>> complain with the fatal message:
>>
>>    *** Please tell me who you are.
>> [...]
>
> Hmm. I think this is an artifact of running --amend. In the normal case,
> we check the author ident beforehand. But in the --amend case, we take
> the existing author, but then fail trying to generate the committer
> ident. So we could probably do better by checking both explicitly
> beforehand.

Indeed.

> Usually we would fall back to your name from /etc/passwd. I guess it is
> blank on your system.
>
>> The commit message I wrote is now lost. [...]
>
> It's not lost. It's in .git/COMMIT_EDITMSG.
>
> We could probably do a better job of informing the user of this when
> commit dies prematurely.
>
> -Peff

I agree, and thank you very much for those two useful pieces of
information! (names stored in /etc/passwd and saving of
.git/COMMIT_EDITMSG).
