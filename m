From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] add NORETURN_PTR for function pointers
Date: Thu, 1 Oct 2009 09:57:12 -0700
Message-ID: <40aa078e0910010957q4daf104cja218af3aa5424637@mail.gmail.com>
References: <1254333950-2440-1-git-send-email-kusmabite@gmail.com> <1254333950-2440-2-git-send-email-kusmabite@gmail.com> <20091001081710.GC13436@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org, msysgit@googlegroups.com,  gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Oct 01 18:57:36 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtOy6-00078U-SO
	for gcvm-msysgit@m.gmane.org; Thu, 01 Oct 2009 18:57:27 +0200
Received: by yxe1 with SMTP id 1so269533yxe.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 01 Oct 2009 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=eK9oEmW84age3jl4DvztiRTfQXc9b7vGdXbbsoPG7HM=;
        b=GwH1GQMSfIn1x5z84VRByTqX55EqdVrOy0tY53ELsfEz8RZfJSHfdbQGqjK13f7wdX
         oBWrnEpy3PhCu3LBiN2OtJlqcVl0doh6Dso/3kf3spXb5rbETxKHjY9VyhmhqicpHbgX
         3wB2C8Pt7cTjTF8IzifzqdVfrf0ZXg36R7n5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=lIRnJQZdI8s8o28UkL+bxU7UGhZZIO/2dW8t1c14qlmRtJCcgNp43DTut/RHQ+OHOk
         zQ/6jnTkT9+PIRPNTkf6zbmfK9TEO3TRKhEWFobf72tzq/Grp3IYIq9kKb6XWdW/qSry
         kBDvWVOX7o7fQB+u3GwIQ6ARcO3/haLntX9Vs=
Received: by 10.150.5.5 with SMTP id 5mr176194ybe.17.1254416238637;
        Thu, 01 Oct 2009 09:57:18 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr7203yqd.0;
	Thu, 01 Oct 2009 09:57:15 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.23.6 with SMTP id p6mr39495bkb.34.1254416234656; Thu, 01 Oct 2009 09:57:14 -0700 (PDT)
Received: by 10.204.23.6 with SMTP id p6mr39494bkb.34.1254416234586; Thu, 01 Oct 2009 09:57:14 -0700 (PDT)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com [209.85.220.222]) by gmr-mx.google.com with ESMTP id 16si47635fxm.6.2009.10.01.09.57.13; Thu, 01 Oct 2009 09:57:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.222 as permitted sender) client-ip=209.85.220.222;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.222 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-fx0-f222.google.com with SMTP id 22so334069fxm.36 for <msysgit@googlegroups.com>; Thu, 01 Oct 2009 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=LpH8h1SJeaMAdfObB2XfLB78RFY/vrq7bayWY1t38RU=; b=fGfkyx7mrdaEYb2a6kk8iVjhYnANs+SGAKAjSI/i2xkYZGCEAHfoMCc8cQ7WKjUJfM FlTWvvX/3sswXvUD0csNefz6OThiMzvpxwjXEnO2/sHX6Z219VA2ZuuVVw+lGKBRvgA5 I6QyyLnGpjv41faP7BsIYzwVCHmaUjZKv3p2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=WYXaAoBIVrgDeAs4HJPJSdhLPWjmN7SbWhiV2qkJ1kDb+anM+CYLuSVeARFgmfguwT AivNm2U6uj2yY5yn/gcV+2+MmV6NIjEy5zaULQXAH9Se/km5TbJ86oElhabZoSlgtg+T 2Z9xZwENOHkZ59lW8mhEzoexlWc7VZz2kkNLM=
Received: by 10.204.160.86 with SMTP id m22mr190393bkx.82.1254416232978; Thu,  01 Oct 2009 09:57:12 -0700 (PDT)
In-Reply-To: <20091001081710.GC13436@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129402>


On Thu, Oct 1, 2009 at 1:17 AM, Jeff King <peff@peff.net> wrote:
> Thanks, this version and (your 1/2) both look sane to me. The only thing
> missing are some Makefile knobs to tweak this, but I will assume that
> will come as part of a later MSVC-compatibility series.

Thanks for reviewing :)

I sent an additional patch to the msysgit mailing-list that defines
NORETURN for MSVC, but I think it's better to keep it out of git.git
for a little while. There's no Makefile-knobs, it checks for _MSC_VER
(similar to what's done for GCC).

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
