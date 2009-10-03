From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 5/7] imap-send: provide fall-back
 random-source
Date: Sat, 3 Oct 2009 11:45:55 -0700
Message-ID: <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com> <1254530385-2824-2-git-send-email-kusmabite@gmail.com> <1254530385-2824-3-git-send-email-kusmabite@gmail.com> <1254530385-2824-4-git-send-email-kusmabite@gmail.com> <1254530385-2824-5-git-send-email-kusmabite@gmail.com> <20091003095811.GB17873@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, mike@codeweavers.com
To: Jeff King <peff@peff.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 20:46:19 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu9cT-0004YN-Gt
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 20:46:13 +0200
Received: by mail-yw0-f161.google.com with SMTP id 33so1450693ywh.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=8eazYxM5vVyyAySI7UCZLwlm62VIUiERxnaFX46gULU=;
        b=XmNswSDb4TOwAhxonLx2ZP8EG9kxG9u/Rfbyz4EPiWb5Pm8CulQP5KaKT/DZVAjqlb
         qgCZ2d/GBE8mlm1sHMSr9DWLjTQYxvWjIY/ICgJQXaLfZpY6WmUEAJGVfbw2oG//PfIy
         1IKSqwAWuFi/M1gT47OJd16+I/rk8FwfmxP3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=p7rHj3yXSC5vuVvnhMx8lTDStbrLybY5aVlVo2gUlQyS7k1EoUx0HqL+Q2GhEjCLjo
         AzTOlnekhu0sj7FZx2x6ueqi8pZL5FuJtGq3hZRGmfKD6EOMuuBh55EAWHwjwyL+wAu3
         ZB4WD1r7gVMJWTAkRczWKpWv+vbE2yMAvNnhg=
Received: by 10.90.162.1 with SMTP id k1mr239600age.15.1254595566823;
        Sat, 03 Oct 2009 11:46:06 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr7242yqd.0;
	Sat, 03 Oct 2009 11:45:57 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.23.75 with SMTP id q11mr118201bkb.36.1254595556800; Sat, 03 Oct 2009 11:45:56 -0700 (PDT)
Received: by 10.204.23.75 with SMTP id q11mr118200bkb.36.1254595556767; Sat, 03 Oct 2009 11:45:56 -0700 (PDT)
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com [209.85.218.220]) by gmr-mx.google.com with ESMTP id 16si400975fxm.2.2009.10.03.11.45.55; Sat, 03 Oct 2009 11:45:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.220 as permitted sender) client-ip=209.85.218.220;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.220 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by bwz20 with SMTP id 20so1770212bwz.42 for <msysgit@googlegroups.com>; Sat, 03 Oct 2009 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=79Cb4CX9NhT64Gvc11EXd//QQsUbYmjyr3xxqUfm7Qk=; b=YiezgPCAYF6lBcn0yTCq1JqzaAjLPzDpk0LQvGjICT8GIjGtMqRe7ETkxqVONpBREv P0c+QbnuLLmTw219oGSJRNCjzn7LyxmZGFJe42o9F5txmVohIA40gS8UiowaV3xwBcqx xTht0MxRN6mdvZMgOJ3wL8juEtvFvcKqwMVXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=UHfF3MY3jOiL+26DZn65lBZhr4ZhBfTT3RJx9BEK/fAM1GswuCCXNy4Gi3Dr5y5qFS wVcojIAXppolYwO3nxMoy9f0PGx+Ro4ho1mEqmPHSUwMTkAMIJKIUByea9CFaXQsLgXR wxdlUWqL9tBc9dvI4cAw4YFaagu6r2ClWzIrQ=
Received: by 10.204.25.5 with SMTP id x5mr2131613bkb.166.1254595555509; Sat,  03 Oct 2009 11:45:55 -0700 (PDT)
In-Reply-To: <20091003095811.GB17873@coredump.intra.peff.net>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129494>


On Sat, Oct 3, 2009 at 2:58 AM, Jeff King <peff@peff.net> wrote:
>
> Hmm. It looks like this arc4 RNG is used just for generating a unique
> "X-TUID" header. Which seems to be used in isync (from which imap-send
> is derived) to be to avoid duplicates in synchronization. But imap-send
> doesn't actually use it for anything, as it just blindly pushes the
> messages.
>
> In other words, should all of this TUID code (and the arc4 code) simply
> be ripped out?

Possibly. I must admit that I didn't dig far on this one - I just
added some randomness, and saw that things worked for me.

I tried to trace this a little bit, but I got lost a bit in the
callback-stuff. However, it looks to me like it might get sent to the
server: it gets injected into cb.data in imap_store_msg(), and in
v_issue_imap_cmd() it gets sent to the server if the LITERALPLUS
capability is supported. I might be wrong though, as I find this code
quite confusing.

I CC'ed Mike McCormack, who initially added imap-send (including the
arc4 code), as he *might* have more insight on this. It's a long-shot
though, considering that this appears to be code adapted around 3.5
years ago.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
