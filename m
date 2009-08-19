From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC 
 toolchain
Date: Wed, 19 Aug 2009 16:51:22 +0200
Message-ID: <40aa078e0908190751g2eb7197cp661f256eb7ff568d@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com> <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com> <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302> <4A8BA9EC.9000006@storm-olsen.com> <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302> <4A8BDAF6.5060805@gmail.com> <alpine.DEB.1.00.0908191455140.5594@intel-tinevez-2-302> <4A8BFD75.8000706@storm-olsen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Marius Storm-Olsen <mstormo@gmail.com>,  "Johan 't Hart" <johanthart@gmail.com>, Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,  git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Aug 19 16:52:47 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdmWr-0005Bn-CV
	for gcvm-msysgit@m.gmane.org; Wed, 19 Aug 2009 16:52:45 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so7636310ywh.22
        for <gcvm-msysgit@m.gmane.org>; Wed, 19 Aug 2009 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=AfoW0ZJXpLLrYdWPr/7Rh/knrK7cHekMl5c32Fipinc=;
        b=zvWtj6z92iilMmUXK4wjNeJWH6iP/4qXKf1TiLedjalZLz/MQAFX+TQBnxqoGH6Qer
         jz0yQJXwNS4S16gDVXVsjUq8SDJgiy/lTqSWm3URVAB0R9+YDXwJ/p3ltwk3xCJ0epOl
         OG8LnG5KUxQ2UruTjK8+ZfIhOZ/QtaRGwakYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=HfkT1Z8UuL854aqpRaDFkYzdRSmy3u1uM6i+56XyHird++slHaCJVwCq4BDCBMjPAj
         hldnih+u3F55FownJZuYnfkStUOU+IUoPzDLuWYnBBmqioXCR81fRI2Jtkj5+oBLdpkK
         aW8+jag0QJvnHAwwKOIEwMnWbGK7ibFUa91Dk=
Received: by 10.220.15.205 with SMTP id l13mr1579256vca.18.1250693547446;
        Wed, 19 Aug 2009 07:52:27 -0700 (PDT)
Received: by 10.230.85.148 with SMTP id o20gr6544vbl.0;
	Wed, 19 Aug 2009 07:51:25 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.77.164 with SMTP id g36mr1270037vck.13.1250693483929; Wed, 19 Aug 2009 07:51:23 -0700 (PDT)
Received: by 10.220.77.164 with SMTP id g36mr1270036vck.13.1250693483864; Wed, 19 Aug 2009 07:51:23 -0700 (PDT)
Received: from mail-qy0-f178.google.com (mail-qy0-f178.google.com [209.85.221.178]) by gmr-mx.google.com with ESMTP id 21si9877vws.1.2009.08.19.07.51.22; Wed, 19 Aug 2009 07:51:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.221.178 as permitted sender) client-ip=209.85.221.178;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.221.178 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-qy0-f178.google.com with SMTP id 8so3464696qyk.26 for <msysgit@googlegroups.com>; Wed, 19 Aug 2009 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=nkGQsak4uXZ9nXLQTz3JOwC+5VaTN+ZqYua9lDm+0v8=; b=hgCaGE4vj8JweZGbEiw27Yfxs1+xYfzjYBJtGw18J6CC9EdGtMipELFekGA+mDnr1T 4Ss82FAX0P/CgV6x0tDasB5kaDcZvxzyP5kf6yc9jmbD+mAJMH2/CtLkAIBRGJiUrvgQ hnoTYoC1UtY0Gc4E7kd12hZCNhwowOId7i0KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=UTOxPS/DakNM/93h3NTYjO5Z9v9a6Hr71CcgRaYg1DWHY8JhzKcaI8fsILQKc1uSJ5 7/J72Rp5Capq1lBfGeKt6RTMBZAe5xFmUwFRh3XAHdeHyQ5tXSm9ibyM/47o410hcNVh jj/mEFTKNRuoVbRmKpCzFlgFjTOKR6GwVWnZ0=
Received: by 10.224.52.170 with SMTP id i42mr6516444qag.285.1250693482501;  Wed, 19 Aug 2009 07:51:22 -0700 (PDT)
In-Reply-To: <4A8BFD75.8000706@storm-olsen.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126548>


On Wed, Aug 19, 2009 at 3:26 PM, Marius
Storm-Olsen<marius@storm-olsen.com> wrote:
> They would still require the rest of the msysgit environment to be able to
> use the result. Not until we have zero scripts left as git commands can we
> ditch the msysgit environment. So yes, even for msvc-built git is msysgit
> required. Its just not build with MinGW.

...perhaps support for msvc for a subset of git-core (without all
shell scripts, that is) is just the incentive some windows-developers
need to start developing c-versions of the lacking functionality? A
pure C git-core would IMO be the ideal case. Utilities could still be
scripted on top of this through bindings given that the developer have
perl installed, no?

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
