From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Sat, 3 Oct 2009 13:17:48 -0700
Message-ID: <40aa078e0910031317p4b76b0ci4f5b1f8eeb4a905e@mail.gmail.com>
References: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.com> <40aa078e0910031305u38cfaf4aua72d4c7af2a470b2@mail.gmail.com> <4AC7AF58.1090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 22:18:07 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuB3P-0002T0-0E
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 22:18:07 +0200
Received: by yxe1 with SMTP id 1so2419452yxe.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=1b5gEjxAZYauIYf1FiBVMqtsECsHstdPEYYBJXrvd2k=;
        b=0FMVa4McyVRs4DXY6+JL369vjh6z8l4W7VFXqzVzivxIsjv49s0T6P8mAflHeMWfNj
         fdgacHQkrvdP5W9mMt1sG/7bYuEr+rMCG+Nj/0Ua/4RFSlgPA9yt0ZtcufWnT/xt08pU
         7RUm7OxR7U0bA4WzrlWrXV9hDXbMpAFhs+NQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=vEoOyxgMig2z1UGSllFrYoZ0f2x6PYYxQmhlsdWOAFtIa2M/U0b8Gq5uDtP7VhktcE
         ZeOnilhNVDqA7PKb0iX9tLBjiusZ4tGKsYzNHGsCPNgPW2yP2Xd3tbtWe/abTT6HZKgW
         ythXP+e1uVE403h/59eveshRMS+XXYEs3WKrk=
Received: by 10.91.100.9 with SMTP id c9mr242966agm.31.1254601079597;
        Sat, 03 Oct 2009 13:17:59 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr7247yqd.0;
	Sat, 03 Oct 2009 13:17:51 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.0.66 with SMTP id 2mr110017bka.27.1254601069707; Sat, 03 Oct 2009 13:17:49 -0700 (PDT)
Received: by 10.204.0.66 with SMTP id 2mr110016bka.27.1254601069673; Sat, 03 Oct 2009 13:17:49 -0700 (PDT)
Received: from mail-bw0-f206.google.com (mail-bw0-f206.google.com [209.85.218.206]) by gmr-mx.google.com with ESMTP id 16si413545fxm.2.2009.10.03.13.17.48; Sat, 03 Oct 2009 13:17:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.206 as permitted sender) client-ip=209.85.218.206;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.206 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by bwz2 with SMTP id 2so1537463bwz.47 for <msysgit@googlegroups.com>; Sat, 03 Oct 2009 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=M+LmDUVHYMRvCAFQ4yVswdRuHkqVSdLGX/GMegC3Yi4=; b=tWedFhcFfI0bdc1ApbX3WPrncu6aJSygpYkGn9A722WNqFPKjUi+oU67hBODyneDKp 4rZPpRATkYr9Q5wE0A47Ma88Dv1rDugKN/LIeKi12qNwdzI/M1tMKpzfqV9g0pmYvawh mP7ugzBpDRxBXIxjh1WdWpzf26iK8VSN+KiA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=lKS0xDdn/WjjqMGy8mEbAmcvdoI9t1sSNFnDz2xlMFuVDZYtBMA3BvOEqZ4T4TrJar FFJasCF8fanzlg9WMedim9S8qTrAkoDn+kIcbKtA9shSrPIiH4rc9unTTfHtvlpBunbD IFsCQL/u/YmxWyvlr6Q2Jf70UbVQkQLL37aFA=
Received: by 10.204.11.18 with SMTP id r18mr2454952bkr.15.1254601068458; Sat,  03 Oct 2009 13:17:48 -0700 (PDT)
In-Reply-To: <4AC7AF58.1090603@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129501>


On Sat, Oct 3, 2009 at 1:08 PM, Marius Storm-Olsen
<marius@storm-olsen.com> wrote:
>> Didn't my 7/7 already do this hunk?
>
> Not for MSVC. It has it's own section above the MinGW part. Besides, the
> -lcrypto 'translation' is critical for it to link.

Ahh, thanks for the clarification :)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
