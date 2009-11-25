From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 17:41:33 -0500
Message-ID: <4B0DB29D.5010101@gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <7vtywiqmbs.fsf@alter.siamese.dyndns.org> <20091125222625.GB2861@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQYQ-0004w7-Cs
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759673AbZKYWla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759590AbZKYWla
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:41:30 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:50479 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759563AbZKYWl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:41:29 -0500
Received: by ywh12 with SMTP id 12so208209ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/hwtpOG/5qgpl+FKfZxQUuxNWTCRBZy/eE/AsQ51dU8=;
        b=jx5BVNjdoAfxOP8Am2yRWu63Ns+IQ3h4DyQpcldvItcRBcLEDL+glh8GVsVVRTVHmS
         uUE9rfpBmLiE8EBV0wVv7IPJsq3SvdNjziGDPk1pw8PClUw51grjIbfKM/EMpbTmRPiw
         uWLtzHPoWGwO5jECZt5/nYPZhIs5KulkjGA3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=w9GDWiL0TWqol1j0W4CGJKtOWpMyHXMfsYK9IOWgH6FOEhiExSdNaXWiM2z1JuT7qA
         6GxOyenA/ytOVUPn7mi9bxowgm0ypZjs66N6rTmzxU/qpvDEpvOaNMl1TqARCLltsplX
         S5cSAxqoGLlIGHyVmI1XbqiFIQr+vx8vJ1Jxc=
Received: by 10.150.109.5 with SMTP id h5mr14629801ybc.240.1259188895749;
        Wed, 25 Nov 2009 14:41:35 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 6sm44172ywc.9.2009.11.25.14.41.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 14:41:35 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20091125222625.GB2861@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133689>

Jeff King wrote:
> On Wed, Nov 25, 2009 at 02:19:35PM -0800, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> ... That is, I don't want to have to remember "git grep
>>> --full-tree" or "git grep /" every time
>> But that cuts both ways.  If you change the default to full-tree,
>> people will forget to put "." every time when asking to limit to the
>> current directory.
> 
> I know. Which is why I am arguing for a configuration option.
> 
> Though as a side note, I think if you are going to err, it is probably
> better to err in showing _too much_ data. It is easier for the user to
> notice the situation and re-issue the command with more limits than it
> is for them to notice that some results are missing and re-issue the
> command with fewer limits.
> 
>>> If I am the one who sets the configuration variable to something more
>>> sensible for my workflow, who am I hurting?
>> Somebody more clueful in git than you who is called to help you in your
>> repository when you have trouble.  Obviously "you" in this sentence is not
>> Jeff King, but I think you get the point.
> 
> Clearly, because there _isn't_ anybody more clueful than me in git. ;)
> 
> But that is what my meta-rant elsewhere in the thread was about. Sure,
> it hurts when more clueful people are called in (and that includes
> asking for help on the list). But that evil to me is much less than a
> user who is frustrated because they have to specify the same thing to
> git over and over again.
> 
>> And re-read what I wrote in its entirety and notice I am not disagreeing
>> with you that the long term goal should be to have the default changed
>> consistently for all command to do the full tree.  The important first
>> step is to make sure we are capable of doing both full tree and limit to
>> current directory and "grep" is one example that cannot do both, and be it
>> the --full-tree option or new /rooted-pathspec, we need some change _now_
>> that is backward compatible to pave the way for later changes.  We give
>> people convenient way to choose between the two, and _train_ them to
>> express which way they want _without_ having to think.  After that is
>> achieved, the default does not matter much and we can safely change the
>> default.
>>
>> Think of it as a way to force existing users _unlearn_ the command
>> specific default we currently have.  Because any change of default will
>> hurt them until that is done, we should start training them as early as
>> possible.
> 
> I agree with all of this as far as changing the default goes. But the
> point of my earlier messages was that I don't think there _is_ one sane
> default. I really do want it different per-project. And that means a
> configuration option.

Since grep is so useful, both interactively and scripted, outside of 
git, this is a pretty convincing argument that git-grep, and all other 
git commands with configurable behavior or defaults that change over 
time, need a both a scripting form and an interactive form.
