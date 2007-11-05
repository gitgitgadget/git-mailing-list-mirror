From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Mon, 5 Nov 2007 11:59:09 +0100
Message-ID: <8c5c35580711050259p2ec24318r3babf53688b180e6@mail.gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
	 <1194222569-13948-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 11:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iozg0-0000fp-HQ
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 11:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbXKEK7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 05:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbXKEK7M
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 05:59:12 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:32238 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbXKEK7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 05:59:11 -0500
Received: by nz-out-0506.google.com with SMTP id s18so990762nze
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EFctBj1ObRbU+BodsqkYFJJPaWDgW/GkvaHLFfMH8iI=;
        b=lY7Vj15/SzCsF+AIz4tBXAE3PsNoFXeyEYz4acXDmjinkwqhd8IyphhJY1+HMuy7rLOI9GXaAbqXBeeO4aUQ37o/AD541Qk16XVpskJu6A97abVqq/ScVbPVVK51y0nPzjA/fevXArs4Av70gAKT7sRM1M/nFmXSWtWUsAkbU9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lNWGN7Cuv3oGjSrEWsOEu9Nf5jHIjAbdCgoOhoeIcW1h1q4ZCwipTsXGYRZQc2R5m/dCxrQn+tpXpjil0MK7tbwezry0PBEf5CqVrImx4poRK+lB2Uq/rRGg/BjAqjFla5H0mlzu5c8CrIKP6CucgWUGg9GonG3P8mF1Ahd78P4=
Received: by 10.114.200.2 with SMTP id x2mr5003728waf.1194260349726;
        Mon, 05 Nov 2007 02:59:09 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Mon, 5 Nov 2007 02:59:09 -0800 (PST)
In-Reply-To: <1194222569-13948-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63495>

On Nov 5, 2007 1:29 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Lars Hjemli wrote:
> > cgit v0.7 (a fast webinterface for git) is now available
>
>  * Very nice cgit logo,

Thanks!

> but no favicon. Perhaps pacman head and G,
>    or pacman head (like in logo) and +/-...

I've never cared much about favicons, but I guess cgit could provide one.

>
>  * Providing reference with full sha1 of referenced object for tags
>    list is not IMVHO a good design: what is interesting is type of
>    tag, if it is signed it's first line, and if it is lightweight
>    pointing to tag then perhaps commit subject.

Yes, the full sha1 is not very interesting. But I'm not sure what to
replace it with: the first line of annotated tags is very often
identical to tag name. Maybe it should just abbreviate the sha1?

>
>  * Nice diffstat in commit view; the diff view is better, although I
>    wouldn't lump from-file / to-file diff header together with git
>    diff header and extended git diff header.

I've tried to make the diff look similar to 'git log -p' output, but I
agree the first line per file is probably overkill.

>
>  * I like the sidebar very much, although I'm not sure how it would
>    work for larger projects (more branches, much more tags).

How do you think it works out with http://hjemli.net/git/xorg/xserver/
? It's got an impressive number of branches and tags ;-)

> Also the
>    search textbox is not very visible; I'd rather it have "groove"
>    view.

Agreed, it's probably useless trying to style input-controls: the
result is heavily browser/platform dependent.


>  * I like separate 'mirrors' section, although I think it rather
>    clashes badly with notion of forks (alternates).

Well, it's only a section header, i.e. a parameter in cgitrc


>  * I'm not sure if it wouln't be beter to provide -n/+m lines changed
>    instead of nn likes changed column.

Maybe. I think it used to be -n/+m, but then I changed it; don't
remember why...

>
>  * Nice submodule support!

Heh, it's a simple hack, but thanks anyway. It probably needs to be
configurable per repo though.

>
> By the way, Freedesktop provides besides standard gitweb interface
> also cgit interface at
>   http://cgit.freedesktop.org/
> Take a look at how such site looks like with large number of projects
> (perhaps sidebar is noot such a good idea then?), and with large
> projects.

Actually, the filtered branch/tag lists was done partly because of
freedesktop.org. I think it has worked out nicely (but
cgit.freedesktop.org needs to run the latest cgit). Also, the width of
project descriptions is configurable, so it can take up much less
space and leave room for the sidebar.

Thanks for the comments, you've made my day!

-- 
larsh
