From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 13:44:32 -0700
Message-ID: <CAJDDKr4TyDp5vxqqHGkBBSiMJXJHW528+nqrag9Rgz+vksqjhg@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFAE1.3070304@gmail.com>
	<7vr4s2mnir.fsf@alter.siamese.dyndns.org>
	<7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
	<500D9E5A.2000204@gmail.com>
	<500D9EDB.90603@gmail.com>
	<7vhasyl0gc.fsf@alter.siamese.dyndns.org>
	<CAHGBnuMCsxmVN8fCSgazqKUwtJzJJxtrVxjKwCEEhZJ_U0cW9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tim Henigan <tim.henigan@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:44:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPUd-00076X-64
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab2GWUoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:44:34 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62133 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab2GWUod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:44:33 -0400
Received: by vcbfk26 with SMTP id fk26so5193742vcb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C07LbjmM+vL/s1U49tkoewH9EkUGJhjBG5LtJapVYB4=;
        b=DVdmK4s1hDEYDhhrJoysBmpYfJinSKpv2B7Q2GX/cBJ4WoQ0cUA1R11tWH72hXAI2M
         aw2bL0nR81g6dRAy93PX7btz1R/s6zqMxbzpXrmGfzaDDyL2KF/8RaZ68fNY7xQA4sBo
         6UdjonQGkMBfqKHON/moqydM8KCgZfmK503HD1lOPj9QzFBXE/2ctxKcGWaBwwab1NSQ
         TaE7LVputjJGc4nhuAYR988ZyLX+qpfpUQELM13tZDk7kjdrPnnhkWpOh5X8dqPYFXOC
         LT6JFbP8h2jl/gu4uJJu4IWYTTCycq9y3V60ggkHYJSbSVzUqCEdJxtry/rHPzRDH78L
         /gbA==
Received: by 10.52.90.144 with SMTP id bw16mr12005886vdb.129.1343076272307;
 Mon, 23 Jul 2012 13:44:32 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Mon, 23 Jul 2012 13:44:32 -0700 (PDT)
In-Reply-To: <CAHGBnuMCsxmVN8fCSgazqKUwtJzJJxtrVxjKwCEEhZJ_U0cW9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201976>

On Mon, Jul 23, 2012 at 1:14 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Mon, Jul 23, 2012 at 9:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>>  -t <tool>::
>>>  --tool=<tool>::
>>> -     Use the diff tool specified by <tool>.  Valid values include
>>> -     emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
>>> -     for the list of valid <tool> settings.
>>> +     Use the diff tool specified by <tool>.
>>
>> I do not see how it is an improvement to drop the most common ones.
>> People sometimes read documentation without having an access to
>> shell to run "cmd --tool-help", and a list of handful of well known
>> ones would serve as a good hint to let the reader know the kind of
>> commands the front-end is capable of spawning, which in turn help
>> such a reader to imagine how the command is used to judge if it is
>> something the reader wants to use.
>
> I don't agree. What "most common ones" are depends on your platform
> and is sort of subjective. So it should be either all or non here.

Let's please leave this section as-is.

This part of the documentation has had a fair amount of churn.
Specifically, it would get touched every time a new tool was added.

The point of bf73fc212a159210398b6d46ed5e9101c650e7db was to change it
*one last time* into something that is helpful, but not a substitute
for the real list output by --tool-help.

If any changes are done then it should be to make git-mergetool.txt
match the advice given in git-difftool.txt.

> Your argument about people not having shell access is a valid one, but
> still that would mean to list all tools in my opinion. And listing all
> tools again thwarts our goal to reduce the number of places where new
> merge / diff tools need to be added. For people adding new merge /
> diff tools it is just clearer what places need to be modified if there
> are no places that list an arbitrary subset of tools.

Yes, indeed, it is arbitrary.  It does have some merit, though--it is
also a good compromise between unhelpful (listing nothing) and painful
to maintain (listing everything).
-- 
David
