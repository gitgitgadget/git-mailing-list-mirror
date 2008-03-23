From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Mon, 24 Mar 2008 02:56:10 +0300
Message-ID: <20080323235610.GB25381@dpotapov.dyndns.org>
References: <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar>
Reply-To: dpotapov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 24 00:57:02 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jda3c-0000rA-Iy
	for gcvm-msysgit@m.gmane.org; Mon, 24 Mar 2008 00:56:56 +0100
Received: by wr-out-0708.google.com with SMTP id c3so879403wra.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=oQkQtMUZ4zvLrYvKacqOSsBP90ucmlf2Jqv/BYViaHs=;
        b=GuBNYxHQzKp+5RCnAhdULtKqyU5oZSbmd1zkp0D258/DujO1BLxiywY30v/s/zW0vYIQXd/0DLRCx2P5wpwBS+e5sMR4s7X1S7qw1rcIOzTgxlXMs+HHOpBvA+G62IC2Z0l/nv0v3cOXxuOrEAa3h0HLxoYJRG0rL/RBAmHns70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=3pZzFPiSA/VDv8cRZb2IXht2ZaoKG4gXtkvpzDJ+x1cuFmwJGo/WDF7YDN6SU/N/LOdgKsYe87e8oD6Bp5CKKGxxeZy3NhgtUBHefZE+cT5VgwS6t75GpVa0jnlQd4KvUccJv1Dpalh75hKrHgsA2APP/5VGUnwh/vKUQaVyrK0=
Received: by 10.100.141.5 with SMTP id o5mr182949and.25.1206316576676;
        Sun, 23 Mar 2008 16:56:16 -0700 (PDT)
Received: by 10.44.242.44 with SMTP id p44gr2008hsh.0;
	Sun, 23 Mar 2008 16:56:16 -0700 (PDT)
X-Sender: dpotapov@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.37.18 with SMTP id p18mr7043361pyj.6.1206316575392; Sun, 23 Mar 2008 16:56:15 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154]) by mx.google.com with ESMTP id z53si8340955pyg.1.2008.03.23.16.56.14; Sun, 23 Mar 2008 16:56:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of dpotapov@gmail.com designates 72.14.220.154 as permitted sender) client-ip=72.14.220.154;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dpotapov@gmail.com designates 72.14.220.154 as permitted sender) smtp.mail=dpotapov@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id 13so2822631fge.11 for <msysgit@googlegroups.com>; Sun, 23 Mar 2008 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta; h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; bh=P+IsIWd/uT2hjKU51shnCNljWCEpNACxTa3BzsyW1jo=; b=G3sxc7+lGWCsdOjtrzKHBMrQou/nTZ7dMWJvX1FQ8xf4Ph0FiKTMMq9YfNCeKrrrIwgicZFjSvJXTQLc7I5bIUH5+Hi+mRJkhDS25THsKlv2fM/XDwkE2els4xIRTJeBkK1Vn3Eo3g/cs8Pl+iirz84BXGwDciztZWih2ie7mls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=beta; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; b=aCYKM4HvnAguTGxe9HXCUxcEmou28zgGUk0jw9fEdXDZpZOeualR3KEPnjPRU/CQi8os/Mbpt59+SllwJfe3j/lBTSBE5mbCLT9u0yHVyap1Jh94Br3+lJ7W9yUGTAxTR0JQxa+bSHPPrVJd9DwD06N/f3ARU5K+Z66JuWg7f+8=
Received: by 10.82.107.3 with SMTP id f3mr15583761buc.0.1206316574594; Sun, 23 Mar 2008 16:56:14 -0700 (PDT)
Received: from localhost ( [85.140.170.114]) by mx.google.com with ESMTPS id j2sm23610671mue.3.2008.03.23.16.56.12 (version=TLSv1/SSLv3 cipher=OTHER); Sun, 23 Mar 2008 16:56:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.OSX.1.00.0803231428220.13789@cougar>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77977>


On Sun, Mar 23, 2008 at 02:42:16PM +0100, Steffen Prohaska wrote:
> 
> We have two conflicting objectives and I do not know how to meet them
> the same time:
> 
>  1) Existing setups should not break.
> 
>  2) Users should have a way to set a global default for autocrlf that
>     overrides our defaults.
> 
> If we store the new default in newly created repositories, (1) would be
> met but (2) is not possible.  If we support ~/.gitconfig for overriding
> the system-wide default, (2) is trivial but (1) is hard to meet.


To meet both requirements you have to copy autocrlf setting for each new
repository during git init or clone and should never use the global
value for any other purpose than this.

This means that you do NOT really need the system or global default for
autocrlf in the sense we have it for other configuration variables, but
you need a template value for it.

We already have templates for different hooks, info/exclude, etc. So,
instead of placing autocrlf in /etc/gitconfig, you should place this
variable to /usr/share/git/templates/config and this file should be
copied by git init or git clone as any other file in templates.


Dmitry
