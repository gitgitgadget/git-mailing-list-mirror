From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Mon, 11 Feb 2013 01:22:27 -0500
Message-ID: <CAE_TNimshLGK=Asv1nc=TrPJ89ZHMqOo0p32bRi5EGv2jZHdUw@mail.gmail.com>
References: <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin> <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin> <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com>
 <20130211060911.GH15329@elie.Belkin> <CAE_TNi=fN66+9WfMn86H6J_BVAjFP=xiE8m3JHe_4ANHB2V5wA@mail.gmail.com>
 <20130211061553.GJ15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:23:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mnH-0002Xo-P0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab3BKGWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:22:48 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:48159 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3BKGWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:22:47 -0500
Received: by mail-qe0-f49.google.com with SMTP id 5so2397957qea.8
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pLh2mEHe5VhjAxQZjIOKl1XoTby7gURepVA8NSQ4F/g=;
        b=wdoEBbvK6NGM4VGewNciwuemP4jmdNmAyDK00aAg68MiSzkz1wKutfzpVyDZFNkBJ+
         ttReqVpt6Bcu64+myIRXEBegS4vYvmesWqzH9/3Q085gAozHk9wNOKc1gt4A1l18Gz4m
         q/uxHiaoOodbyBK3ugjkLblGX2IhwdyoLRtmNe7YgejuB98dyOACxd3lxalsdEArqlsW
         KT71Rl9g75LJh7wXsKLXFoWXnMx1jzP6bKFy9A8TbWC5VjgSPEHGlrSVWaF47tkZmQGh
         gAVhOwwc2ih5Nrqpd7IMmSHxu+hmjnJhFSavGldvXMwbdYKAZOu5jczmqc2B5eUm6QJv
         dVXA==
X-Received: by 10.224.209.193 with SMTP id gh1mr5127995qab.86.1360563767146;
 Sun, 10 Feb 2013 22:22:47 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 22:22:27 -0800 (PST)
In-Reply-To: <20130211061553.GJ15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216004>

On Mon, Feb 11, 2013 at 1:15 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> [administrivia: please don't top-post]
> Ethan Reesor wrote:
>
>> Why not have both? That way there is a way to get a customizable
>> response that avoids Junio's complaints and there is a way to do what
>> you are trying to achieve.
>
> What was Junio's complaint?

I was referring to the one you recently addressed:

On Mon, Feb 11, 2013 at 1:14 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Junio C Hamano wrote:
>
>>>>               Are you shooting for customizability?
>>>
>>> Yes, and the ability to generate the message dynamically.
>>
>> Hmph, if that is the case, wouldn't it be a better direction to give
>> a better help for majority of the case where git-shell is used as
>> the login shell to allow push and fetch but not for interactive
>> access at all?
>>
>> The first step in that direction may be to give a better canned
>> message, followed by a mechanism (perhaps a hook) that lets a
>> message customized for the site's needs, no?
>
> The trouble is that I can't imagine a canned message that everyone
> will like.  (For example, I quite dislike the current one.)  That's
> exactly the situation in which some configurability is helpful.
>
> Some configurability is nice for other situations, anyway.  For
> example, sites serving a multilingual audience may want the message to
> vary based on the user's language (or even source IP).  The message
> can include a list of available repositories or extra information that
> changes over time.  And so on.
>
> Hope that helps,
> Jonathan

When I made my suggestion, I was tempted to say that both methods
(having help return non-zero and allowing a git-configurable response)
should be included, but I couldn't think of a reason to include both
until you brought your use case back up.

--
Ethan Reesor (Gmail)
