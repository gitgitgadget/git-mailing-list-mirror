From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [RFC] send-email aliases when editing patches or using --xx-cmd
Date: Thu, 4 Jun 2015 20:38:11 -0400
Message-ID: <CAJ80savyruj7rcwGRY6AURJWnm26AyQFjssJmpjuYcv5jEBqkQ@mail.gmail.com>
References: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr>
	<CAGZ79ka89omT3wKqV-J4eyAz+xDXDS+OBcXDDFsO=4kk1HBBpQ@mail.gmail.com>
	<CAPig+cQbOnaNg8dkbFoRrUN47oEAxUNjRXhMK1HSgCLi6ZxHyQ@mail.gmail.com>
	<299923407.139591.1433458411117.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 05 02:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0feM-0003tF-KX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 02:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbbFEAiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 20:38:14 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36537 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbbFEAiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 20:38:12 -0400
Received: by igbpi8 with SMTP id pi8so3990700igb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WGdxtULmsvVzDnucz2G/vpF39/By+Ec8hUSUzjpHifA=;
        b=EXSXXs6HNdb/nMOcHTd1VHnwPT6+PvhigoR0whXK7WcuMf7Fipwk1ATx6WWj6kWMpz
         cgPxIRLoZAhsEQEKC4+g43NQ2gc+CDBHLTVrXzNnMPtD+A7Tm60qpTF63JC8GT8a6WGQ
         d2S7tHpv4bwiH6jEdwlqHi6I4+cr5R2rvbSSH1lFRrGbSbr93LALlC/gC5JBOdAZh1Oh
         SxifjJKCg0ioyPvOSsGc7HaO9BGJZ8k7yKH0D/E7fZFflY9iKl1SX9RxF3aVRWyf7DrK
         4BX3Unfp80B7g/IhGf+fdkMMKKpVvGWBfx7YCXgc7ZVRUVc8JZsXBGUxnaeMiiKgLquY
         X+iA==
X-Received: by 10.50.111.131 with SMTP id ii3mr37357833igb.47.1433464691874;
 Thu, 04 Jun 2015 17:38:11 -0700 (PDT)
Received: by 10.79.84.6 with HTTP; Thu, 4 Jun 2015 17:38:11 -0700 (PDT)
In-Reply-To: <299923407.139591.1433458411117.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270808>

On Thu, Jun 4, 2015 at 6:53 PM, Remi Lespinet
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> On Thu, Jun 4, 2015 at 1:17 PM, Remi LESPINET
> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>>
>> Hi,
>>
>> Working on git-send-email, I've seen that there's no aliases support
>> when manually adding a recipient in a 'To' or 'Cc' field in a patch
>> and for the --to-cmd and --cc-cmd.
>>
>> I would like to add this support, and I wonder if there are reasons
>> not to do it.
>>
>> Thanks.
>
> I just realize that I totally messed up, Of course I don't want to add
> To or Cc fields to patches.
>
> In fact I want to add aliases support for --to-cmd and --cc-cmd options.
> But the modification depends on wheter we can use aliases in fields
> used by send-email (such as author or signoff-by..) when manually
> editing a patch or not.
>
> Sorry for this mistake :(

You are right that Signed-off-by: myAlias wouldn't make sense, but is
that really what you intended to propose?  It's definitely not a good
idea to write patches that way, but on the other hand, if git happens
to accept an alias there, what's the harm?  Git will send an email...
the patch will be rejected.

Also, I believe git-send-email looks for signed-off-by, regardless of
the presence or output of to-cmd (around line 1490 -- "Now parse the
message body").

Something like to-cmd is much more general than just looking for
Signed-off-by, etc, or scanning a patch for things that look like
email addresses.  The to-cmd can also look for keywords in the patch,
like component names, and return an array of maintainer email
addresses for those components, for instance.  It might be the case
that none of the emails returned by the to-cmd are actually ever
explicitly mentioned in the patch.  In my workspace, I might indeed
write a script, specify it as the to-cmd, and have the script return
an array of email addresses according to whatever criteria I can
imagine.  What's the harm if, in my script, in my own workspace, I
return an array of email aliases in the to_cmd, instead?

Now, as long as the to-cmd is already a script, executed by the
computer, there's really very little to gain in using email aliases
versus whole email addresses.  A script can emit a whole properly
formatted email address just as easily as it can emit an email alias.

Your proposal is just a different use for email aliases, which is
independent from where the aliases come from.  There is no conflict
with any of the email alias parsers.
