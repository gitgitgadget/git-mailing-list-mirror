From: Andreas Ericsson <ae@op5.se>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 11:00:57 +0100
Message-ID: <4F685559.8040402@op5.se>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org> <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org> <7v62e09sig.fsf@alter.siamese.dyndns.org> <CANgJU+VF-3LnwkrWgSQ1r50R=zjw8vsK1G686OqetSUGHuFcfw@mail.gmail.com> <7v1uoo9pyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: demerphq <demerphq@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 11:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9vsN-0001S7-E7
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 11:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758812Ab2CTKBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 06:01:03 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61224 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547Ab2CTKBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 06:01:00 -0400
Received: by lbbgm6 with SMTP id gm6so4027925lbb.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 03:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=7ZE0FP1NN3z1w7I4RWvrOrFILKMvyxetQiKVLg2RRME=;
        b=H7PeZaogqPIT61j6M22LvqlInJINqEL2tUGmP/ftpIBELG+kGLHwkpzAuE63nDIJuT
         FNcA/kxwyPHeMqh1cHUC78JIXxqR/0//LHdCPBttGyOtPaHfPscf9h9XK9OfIkvA4Abm
         nvKd2bDRyrd5iE68TqpbQ1YB8m0t2Wh9PumczxQrVSYmEi/Rxgt7CXq03nS7CWI5jiq4
         2a1CaszCEg4uNBPNWIq9u87HjY74bfcelCYoLIq8LSU4g5i32ra3swIokUYBOcEoTGVG
         bPLQm3JQOlJk5pSKENRSnpmKpwAMPzFhQPpAL5uHIJhzWXCyHITIT11ijLjCLB3FIwdS
         qYtw==
Received: by 10.152.147.1 with SMTP id tg1mr6194300lab.37.1332237659162;
        Tue, 20 Mar 2012 03:00:59 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id te8sm1074366lab.3.2012.03.20.03.00.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 03:00:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <7v1uoo9pyo.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmqt/y8Az9EAUUO1TfY09QO2Ks9xqZJex6rl0P745nFJ+webE+AwnkAdfQajzTYK2jad1Em
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193493>

I just realized I've had the proposed behaviour for "upstream" backwards
all along. I thought "upstream" was meant to do what "matching" does
today.

I'd like to change my vote to "upstream" instead, although I think the
name for it is truly horrible. Perhaps that's just me though, since
we're using "upstream" as a remotename for repositories we get from
afar but work on internally as well.

On 03/19/2012 11:38 PM, Junio C Hamano wrote:
> demerphq<demerphq@gmail.com>  writes:
> 
>> ... I thought the worse case here is
>> minor inconvenience, not data loss or anything else that is obviously
>> harmful.
> 
> If your definition of harm is limited to data loss then we wouldn't be
> talking about updating the default from matching to current or upstream.
> "If your push failed, pushed what you did not mean to, or did not push
> what you meant to, you would correct the mistake" applies equally to a new
> person who expected "current" (or "upstream") and got "matching", or an old
> person who expected "matching" and got "current".
> 
> The purpose of the default change is to reduce surprises to people who
> haven't yet learned Git too well.  And for them,
> 
>      I was on master, I said 'git push' without saying what to push to
>      where, and it resulted in master updated at the central repository.
> 
> is the least surprising outcome.  Note that a learnt Git user would not
> express what he did this way; he will say 'I was on *my* master' and
> 'the master at the central repository was updated with *my* master', but
> the change of the default is to help those who haven't even learned that
> your branches and branches at the central server are not always connected.
> 
> Choice of "upstream" is more convenient for users who learned Git a bit
> more and knows the distinction between branches you have and branches the
> central server has.  For them, "I was on my 'topic' branch, that was
> forked from the 'master' branch at the central repository. I said 'git
> push', and I updated the 'master' over there with my 'topic'", is also not
> surprising, but it is more advanced audience than those helped by the
> default setting to push 'current'.
> 
> In either way, once people learn sufficiently to the point that they can
> choose their own default that suit them, there is no need for handholding.
> They won't be surprised.
> 
> But except for one case you should *not* forget about.
> 
> The ones who get pulled the old default under their feet while not paying
> too much attention to this discussion. The change will hit them with a
> surprise, and that is what I am trying to avoid here.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
