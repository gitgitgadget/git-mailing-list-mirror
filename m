From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb pathinfo improvements
Date: Sat, 6 Sep 2008 14:47:39 +0200
Message-ID: <200809061447.40459.jnareb@gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com> <200809061322.31094.jnareb@gmail.com> <cb7bb73a0809060455n78145ccdw99beeebbd7e0439a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 14:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbxDh-0003ar-Rj
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 14:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYIFMrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 08:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbYIFMrr
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 08:47:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:34331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbYIFMrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 08:47:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so946586fgg.17
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GWaIP0HFgkd89IVBkn20XskRgIIRLLF0ok4eE/OPwz4=;
        b=kAeRK99/bBJ8atOgTkkgNJLAGCWOc5kpkddyjpS5P03fT/ZQq/xuHWbmSeRiCDCRFm
         6H7VPEPete3LJbD0ME7Jj06HOkdcElziwAIG3GXyBWvEMgbBcllChX7d35dDURp5HGII
         L4/SlrMmMvsIkPEccmYeAtuqMyP53273lM5IU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kI66aW2DBKOSYxNukXZJxS9BjoTEVkAWW8TtZ4HAJ/T7uLiBlJCiXN5SHIj2Z2xS+v
         1ouEgRdguMbbFmSFe0Ukxbq2qcpNgPzs8VP4BzixQ/zKjbbK14YvUXt3/MZh8SkIjnXA
         9VRVZ+6F9j/aFNjqqUjzmNoS0RECKcw+gAWx0=
Received: by 10.86.79.19 with SMTP id c19mr9632019fgb.79.1220705264605;
        Sat, 06 Sep 2008 05:47:44 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.117])
        by mx.google.com with ESMTPS id 4sm2491268fgg.4.2008.09.06.05.47.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Sep 2008 05:47:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809060455n78145ccdw99beeebbd7e0439a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95073>

On Sat, 6 Sep 2008, Giuseppe Bilotta wrote:
> On Sat, Sep 6, 2008, Jakub Narebski <jnareb@gmail.com> wrote:

> > Below there is table of contents / shortlog of this series, which I
> > think is a good practice to include in cover letter describing the
> > series:
> >
> > Table of contents:
> > ==================
> >  * [PATCH 1/5] gitweb: action in path with use_pathinfo
> >  * [PATCH 2/5] gitweb: use_pathinfo filenames start with /
> >  * [PATCH 3/5] gitweb: parse parent..current syntax from pathinfo
> >  * [PATCH 4/5] gitweb: use_pathinfo creates parent..current paths
> >  * [PATCH 5/5] gitweb: remove PATH_INFO from $my_url and $my_uri
> 
> Yes, I really have to learn proper behaviour when sending a patchest.
> I'll make treasure of yours and Junio's hints on the matter 8-)
> 
> I'll probably have to resend this patch series anyway, since I've
> already found a quirk for which an additional patch is ready, and the
> double-dot-filename thing you mention below needs fixing as well.
> 
> BTW, is there a way to automate this summary generation when using
> format-patch or send-email?

Yes, if you have new enough git.

First, to have numbered patches (just in case mail threading screws up,
for example if emails come out of order, or if you don't use chain
reply to), you can use -n / --numbered option, or format.numbered=auto
(I think that now auto numbering is the default).

To generate template for cover letter you can use new --cover-letter
option. I don't think that there is configuration option for that.

Additionally when sending series of patches I usually output patches to 
separate directory (mdir.1, mdir.2,...) using -o <directory> option,
but that is just my workflow.

> > Using ':' or ':/' to separate branch name (hash or hash_base) from
> > filename doesn't lead to problems, as pathinfo is split on _first_
> > occurrence of ':', and refnames cannot contain ':'. Using '..' to
> > separate $hash_parent_base:$file_parent from $hash_base:$filename
> > is IMVHO a very good idea... but when creating pathinfo links we
> > have to consider filenames with '..' in them; an example is there
> > in git repository: "t/t5515/refs.master_.._.git" file. Then we
> > probably want to fallback on CGI query/CGI parameters. 
> > NOTE: I have not read the patch yet, perhaps it does this.
> 
> Actually, this was not a case I had taken into consideration (a
> filename with two dots). It should be straightforward to change the
> link-creation code to switch to CGI parameters in this case. Should I
> change the corresponding patch, or would it be enough to add a patch
> to the series clearing this issue?

I think it would be better to have it correct the first time;
especially if you are resending series anyway.

> > By the way, this is perhs slightly outside the issue of this series,
> > but having a..b syntax would tempt to handcraft gitweb URLs for
> > equivalents of "git log a..b", "git log a...b" and "git diff a...b",
> > neither of which works yet.
> 
> I do have a patch to that effect for the shortlog action:
> http://git.oblomov.eu/git/commitdiff/refs/heads/gitweb/shortlog and
> you can see it in effect on my gitweb with links such as
> http://git.oblomov.eu/git/master..gitweb/pathinfo.

I think that it would be good idea to first refactor generation of 
log-like views in git (log, shortlog, history, search, feed) to 
consolidate them somehow, so revision limiting would work on _all_ 
log-like views.

This is in my TODO list, but I didn't even began implementing it.

-- 
Jakub Narebski
Poland
