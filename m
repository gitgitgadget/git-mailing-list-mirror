From: David Glasser <glasser@davidglasser.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 12:53:33 -0800
Message-ID: <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net> <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:54:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0lr-00064J-4d
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbbBLUxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 15:53:55 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:65404 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbbBLUxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 15:53:54 -0500
Received: by mail-we0-f176.google.com with SMTP id x3so12671850wes.7
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 12:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CuRa/+kzUvrzGDJ+gVUCja8KdUlMeXSgLXUf93/LW0I=;
        b=0yGylgZm3O3NMsYn9AFyCGFZLW1/o91/re35bvsTi8f4noqua3Hg6wemdj+EeqPpGz
         HNlHsCESUIttg2ezXoVFjFtDCpXqGdQo7O7r5zk8bJ+nufY67Lbe9oFwvRxTSFF4Qy66
         w8wq21YCgBpT+q7zDAKcx5brQ6DwAiS8A47D2zUcq05NBbOpenv6Hr2WQ2jnN+Dalp2y
         vldZK+IzYLFbACP39CzeD/cPyajG9+IOa/60TdOsZPK7gTrGSNttPtCfmv4crdNbSoel
         GBfNcOfDHgTfgseEIWhTZg2oIgjF0MQTLUIseHcQZsjH2hGrena4lJFJTo19/ccFkqYz
         sNPg==
X-Received: by 10.194.2.75 with SMTP id 11mr11574509wjs.78.1423774433731; Thu,
 12 Feb 2015 12:53:53 -0800 (PST)
Received: by 10.194.29.200 with HTTP; Thu, 12 Feb 2015 12:53:33 -0800 (PST)
In-Reply-To: <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: HqdYzvrMP_nQtmbcUn-L9X1e4Og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263769>

On Thu, Feb 12, 2015 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Feb 11, 2015 at 09:21:04AM -0800, David Glasser wrote:
>>
>>> (I'm not sure if this should be a flag to --squash or to commit.
>>> Maybe `git merge --squash`; `git commit --use-squashed-author`?  Seems
>>> like it should be not too hard to implement; SQUASH_MSG is pretty
>>> parseable.  Or just a config value.)
>>
>> It sounds like "git commit -c" is close to what you want, which will
>> pull the author and commit message from a particular commit. But I don't
>> think there is a convenient way to name the commit in your case (it is
>> likely to be the first commit on the branch you are squash-merging, but
>> there isn't a shorthand for that).
>
> I thought David was primarily interested in the case where a branch
> authored by a single person, so specifying the tip of the branch
> being "merged" would be sufficient, no?

Well, using -c appears to override SQUASH_MSG entirely; it replaces
the message as well as the author.  Often I do want to make my own
message based on all the messages provided by the submitter.  (And
typically the branch's tip is the least useful message anyway: it's
usually something like "respond to code review".)

--dave


-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
