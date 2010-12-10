From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 07/18] gitweb: Revert back to $cache_enable vs. $caching_enabled
Date: Fri, 10 Dec 2010 14:48:50 +0100
Message-ID: <201012101448.52936.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3y67y1psd.fsf@localhost.localdomain> <4D019288.9060503@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 14:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR3Le-0006iP-Am
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 14:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab0LJNtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 08:49:17 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:63801 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0LJNtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 08:49:16 -0500
Received: by bwz16 with SMTP id 16so3999461bwz.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 05:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mMofV/aVzMb7WZWnzZxc0NV51uGqkrhOEVm/lQgSfzo=;
        b=Q7k6NhOR7gbD/g23TMrCB6SdAEoX77sE9CBXW5/+eFh7X5bPiXPRj97pDc0XrLkM/1
         tJWrbyajv3ahte92kM3IKg2bitjiHhZKYrmfq0uYAEThF8Tma1vkXvHXpG5lHuN2j/Qa
         aYqQ+lbwt5geY6nAhJBEUloo3Ddmy/Z+tpFt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GpHD2N3OjKvQVn1q71fkpdGaqhTs43tt5B1znY806cZWWym3OrLsJycy+m6NVyrgVd
         txunvORtdUkVdCdcPdqChaRzsdvQ4FDjs0IOYL33DuI9/d5zP1JBgdOz6NZ/Fp4IsJwM
         YSGcnSm3iE1biuOkuaPbQZ05kMWBAdRMoQaNc=
Received: by 10.204.122.65 with SMTP id k1mr732472bkr.80.1291988953628;
        Fri, 10 Dec 2010 05:49:13 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id d27sm1551102bkw.14.2010.12.10.05.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 05:49:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D019288.9060503@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163413>

On Fri, 10 Dec 2010, J.H. wrote:

> > Formally, there is no backward compatibility with any released code.
> > Using out-of-tree patches is on one's own risk.
> 
> I will have to beg to differ with you on this, the entirety of the
> existing caching engine has been released code for a number of years,
> there are rpm packages available for it, at the very least, in Fedora
> and in EPEL.
> 
> The caching engine *IS* released code, and this patchset is as much a
> new feature as an attempt to merge a fork.  Kernel.org isn't the only
> one running this code, and that has been the case for several years now
> already.
> 
> Claiming that this isn't released code is doing me a disservice to me,
> and those who have submitted patches to it independent of git and the
> mainline gitweb.
> 
> Thinking about the patch series outside of that context will lead to me
> putting my foot down and arguing on those other users behalf.  I'm not
> keen on breaking them for no good reason, and I'm not seeing your change
> here as one that's particularly worthwhile, while causing external
> breakage for no reason.

I am so very sorry.  Please excuse me.  I didn't intent this to be arguing
against backwards compatibility with what amounts to gitweb fork, but rather
grumbling about maintaining our mistakes due to backwards compatibility
requirement.  I see now that it reads as arguing for breaking backwards
compatibility: the "Formally" qualifier is too weak.

That said I would rather there was no need for forking, or at least for
the caching patches to be peer-reviewed on git mailing list, even if they
wouldn't be accepted / merged in, or merged in soon enough to avoid need
for fork.

> 
> > But even discarding that, I'd rather use the same solution as in
> > 
> >   [PATCHv6/RFC 22/24] gitweb: Support legacy options used by kernel.org caching engine
> >   http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163058
> >   http://repo.or.cz/w/git/jnareb-git.git/commitdiff/27ec67ad90ecd56ac3d05f6a9ea49b6faabf7d0a
> > 
> > i.e.
> > 
> >   our $cache_enable;
> > 
> >   [...]
> > 
> >   # somewhere just before call to cache_fetch()
> >   $caching_enabled = !!$cache_enable if defined $cache_enable;
> > 
> >>
> >> This reverts back to the previous variable to enable / disable caching
> 
> Is there really any point in changing the name at all?  The intention of
> cache_enable, at one point, was to allow for other caching engines and
> while there aren't any other caching engines that use it, it's already
> treated identically to cache_enable.
> 
> If it really adds enough to the readability to the code, then I'm fine
> with adding:
> 
> 	$caching_enabled = $cache_enable if defined $cache_enable;
> 
> But now you are setting up two variables that control the same thing,
> adding the possibility for conflicts and confusion to end users.
> 
> I just want that stated.

I guess I can live (I'd have to live) with $cache_enable instead of
$caching_enabled as name of *boolean* variable controlling whether
caching is turned on or off.  Though I'd argue that $caching_enabled
is better name:

  if ($caching_enabled) {

reads naturally as "if caching [is] enabled"; not so with $cache_enable.
$cache_enable as enum is just a bad, bad idea, as is conflating enabling
caching with selecting caching engine (c.f. http://lwn.net/Articles/412131/
though only very peripherally - it is about other "conflated designs").


BTW. when leaving $cache_enable from "[PATCHv6/RFC 22/24] gitweb: Support
legacy options used by kernel.org caching engine" I forgot that it is
actually $cache_enable (which is 0 by default) that needs to be set up
if one wants caching.  All the rest of cache config variables can be left
at their default values... though, J.H., are they?

> 
> Also, why the double negative in your original snippet - that doesn't
> entirely make sense....

I don't know why I felt that I needed to convert it to bool...

-- 
Jakub Narebski
Poland
