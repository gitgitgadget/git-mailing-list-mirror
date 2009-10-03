From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 5/7] imap-send: provide fall-back
 random-source
Date: Sat, 3 Oct 2009 11:59:31 -0700
Message-ID: <40aa078e0910031159g68aace80oa7c75b4ffb2b9803@mail.gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com> <1254530385-2824-2-git-send-email-kusmabite@gmail.com> <1254530385-2824-3-git-send-email-kusmabite@gmail.com> <1254530385-2824-4-git-send-email-kusmabite@gmail.com> <1254530385-2824-5-git-send-email-kusmabite@gmail.com> <20091003095811.GB17873@coredump.intra.peff.net> <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 20:59:52 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu9pf-0008Am-1Y
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 20:59:51 +0200
Received: by ywh33 with SMTP id 33so1460432ywh.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=uRbu4DEe88fQnYwcXCCQjZTUyq30r0IPTo03aECFGvw=;
        b=Fy1gUuaAkvG1mhzamz/OLULrMl1SUg9Aw+qiWXBuTTTBgNQaX25/HUjprY3N1YIJ6y
         UucdjsxHX06OHNbLR2HYWq10oxrQ0AnnmNgGjvT0bu+m48dyeIO1GHxeqIMt0MukYUF7
         mOIvFmSoOzfDuQf1GcsBqflM1YU57OiPr+L9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=C86LHUhyLcg2FKLcwn1tvfPXzIRUvoPrm07NLQ/hbepdWnEbsa5jt9XFA1CJfV8Clb
         6cTD5p2CCPONpz/HwBs7jw+Ib26XYqzxNX4wL82wIt4Cs1EQdS1RNoiuYkLitbMvPXrS
         BX4QHmNtQjCxyGkfLTvO4w7nEHr53s6l/BGBk=
Received: by 10.101.58.6 with SMTP id l6mr480393ank.21.1254596382894;
        Sat, 03 Oct 2009 11:59:42 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr7243yqd.0;
	Sat, 03 Oct 2009 11:59:34 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.23.194 with SMTP id s2mr111879bkb.30.1254596373265; Sat, 03 Oct 2009 11:59:33 -0700 (PDT)
Received: by 10.204.23.194 with SMTP id s2mr111878bkb.30.1254596373222; Sat, 03 Oct 2009 11:59:33 -0700 (PDT)
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com [209.85.220.214]) by gmr-mx.google.com with ESMTP id 15si380223bwz.2.2009.10.03.11.59.32; Sat, 03 Oct 2009 11:59:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.214 as permitted sender) client-ip=209.85.220.214;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.214 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by fxm10 with SMTP id 10so1820275fxm.32 for <msysgit@googlegroups.com>; Sat, 03 Oct 2009 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=fUbouIjnx+HuikmGH1YIRWlRPD3aEghdCySAjTQrY6s=; b=n+qcnoD3cbiYhonrPi3tJ+7kGGSvwnePHDvcaxA6jDuSK2xxJH+ihuoAdWyTFGhVaw pvtPA+5E/RkTlwxK3KhLz8ymYCPEKFzOQxOVlkQ07VPo0gPcJn/ZAfzSdDAaICFrNoOm VNd2lTR0bwj1FtEYneP4RThQZijNmX8DPtRxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=VEKTAZLgHyE2RMW6GNrNJXo42gh3strUXlsHXPhL18XK3XXbUd9EhNzCshYD+P45dD q6t62+4vSvdTueWnnCkBrGno2DK2O0HMKX+jToGF660J3WYneMeLhbpsZJo0YLKqQp9j 8375ij8KHVhj9pfLNPHobej7AkG4w25W/fN2Y=
Received: by 10.204.148.78 with SMTP id o14mr2419839bkv.83.1254596371994; Sat,  03 Oct 2009 11:59:31 -0700 (PDT)
In-Reply-To: <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129495>


On Sat, Oct 3, 2009 at 11:45 AM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> I CC'ed Mike McCormack, who initially added imap-send (including the
> arc4 code), as he *might* have more insight on this. It's a long-shot
> though, considering that this appears to be code adapted around 3.5
> years ago.

OK, it seems the e-mail address he used for the commit isn't valid any
more, and I can't easily find another address for him. So I guess
we're out of luck on that front.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
