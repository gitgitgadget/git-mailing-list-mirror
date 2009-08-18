From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are
 va_copy.
Date: Tue, 18 Aug 2009 11:54:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181153000.4680@intel-tinevez-2-302>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>  <4A898B27.3040507@gnu.org> <1976ea660908172206hc75c1e6i117806338be5ccea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,  msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 11:54:56 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLP2-0004zw-Iw
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 11:54:52 +0200
Received: by yxe34 with SMTP id 34so5898410yxe.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=qG6GewgtKznhMuSEYbzXUhWSctF1V3vejodttQ3d8Bo=;
        b=Z2t5oc6PtVIAEdBDDYsXZY9QIUgLnhYIxFZC8YM7mVo2k616KiwoLcF3jlB8/wGJmF
         5n/K+InCddybyxPTDVoArUS8htHhp5O7XnzhKQ+HRN2pmfIJMBZn6tziGXbOHP4QxwkN
         xVaXwu82K+0AGP+sewkIHOwhuhLRh3F9NT0MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=gTmSUBtAQWXDIiWyTafavbCH7RGLU1c7HrMXaaIJ+et3hm8y5rz+KkxUUEXnZ2C7CL
         XnxEVgtk+Br+iB+bp6pXDhl5tdjxNCd/6b2JPrm8T8sQXrCLl9vz20GgWlFiiFHLx6rH
         EkDk6mfRKaMCXlN2R+p5hIZJuRt12YDzR3oY8=
Received: by 10.101.29.27 with SMTP id g27mr1552411anj.4.1250589286389;
        Tue, 18 Aug 2009 02:54:46 -0700 (PDT)
Received: by 10.177.154.18 with SMTP id g18gr6449yqo.0;
	Tue, 18 Aug 2009 02:54:45 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.143.2 with SMTP id s2mr151239fau.17.1250589284794; Tue, 18 Aug 2009 02:54:44 -0700 (PDT)
Received: by 10.223.143.2 with SMTP id s2mr151238fau.17.1250589284742; Tue, 18 Aug 2009 02:54:44 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si746121bwz.6.2009.08.18.02.54.44; Tue, 18 Aug 2009 02:54:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 18 Aug 2009 09:54:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp013) with SMTP; 18 Aug 2009 11:54:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iQ445kyCiz1/G2OKdWpOj9WOAsSQoyeq4RMJCvM RuhSyK4Z9cEzIc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1976ea660908172206hc75c1e6i117806338be5ccea@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126368>


Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> > #ifndef va_copy
> > #define va_copy(dst, src)	((dst) = (src))
> > #endif
> >
> > if it works on MSVC?
> 
> I test it, it works.

But please, either put it into compat/msvc.h or make it dependent on some 
#define such as "DEFINE_VA_COPY_TRIVIALLY" so that other platforms who 
might miss va_copy (but can use the trivial definition above) can use it.  
I do not think that va_copy can be defined like this in general.

Ciao,
Dscho
