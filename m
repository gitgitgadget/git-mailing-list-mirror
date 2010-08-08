From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log --stat FILE
Date: Sun, 8 Aug 2010 15:08:53 +0200
Message-ID: <201008081508.53732.jnareb@gmail.com>
References: <yf9wrs1fili.fsf@chiyo.mc.pp.se> <201008081426.21705.jnareb@gmail.com> <yf9bp9ds2mz.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 08 15:08:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi5c7-0002fB-D7
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 15:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0HHNI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 09:08:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57976 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab0HHNIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 09:08:25 -0400
Received: by bwz3 with SMTP id 3so721990bwz.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6ZChpP0atrT2nDoGbMMWbD8/rqdpACWTMuTkhW8jfxc=;
        b=JkAhKkE0fe3bIafqUoLMJnJ3S80A9NqTYlONK68XKNltNWecy0tYQa2y8ILpNqkBJX
         cwn0fgI47cMWwcUTItnZa8uJrJws0ypjwh57rGSvesvMzqdzy1zgqrkG/b3kPOoNdOUv
         vab1oLzx+o0zkpM6+6C60A4J5nuDIpNzgGeTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vjoN8dVobkMTzp8N00awQ9HaFXZyFiwTLk2CglpSDUrBT2InOVExafog2Xj6oSKoSC
         RkvfP4WVSsmyhtJ0u6aTEi+1VFPkDI7gcphydwov1NMRQRjhkSQcRcXneLG2/b6uKK99
         TlwOBsXUPcN669d0PJMEy8XH+3jprlsSaD53U=
Received: by 10.204.1.139 with SMTP id 11mr1967692bkf.174.1281272904394;
        Sun, 08 Aug 2010 06:08:24 -0700 (PDT)
Received: from [192.168.1.13] (abwa128.neoplus.adsl.tpnet.pl [83.8.224.128])
        by mx.google.com with ESMTPS id y2sm2338789bkx.20.2010.08.08.06.08.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 06:08:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <yf9bp9ds2mz.fsf@chiyo.mc.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152906>

Marcus Comstedt wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Diffstat is just a diff format (a way of presenting diff); '--stat'
> > is described in "Common _diff_ options" of git-log(1) manpage.
> >
> > But whats obvious to me might not be obvious to everyone.
> 
> To me (and probably many others), a "diff" is the output of the
> command "/usr/bin/diff".  I notice that git seems to refer to this as
> a "patch" instead.  Nevertheless, the documentation of --full-diff
> explicitly talks about "log -p", rather than "diffs" in general.  So
> it's not clear from the documentation that it affects other types of
> diffs than those produced by -p ("patches").

To me (and probably many others), a "diff" is something that describe
differences between two versions (compares two version).  Note that
'GNU diff' (and other "/usr/bin/diff") supports three output formats:
ed based, context and unified formats.  git-diff supports patch format
(unified, with some extensions), raw aka diff-tree format, and various
versions of diffstat format.

The '--full-diff' is a git-log option, not diff option, as it affects
how git-log uses path limiter.  "git log -p <path>..." is an example
of copmmand that shows diffs with commits, as "git log <path>..." alone
doesn't show diffs (in any format).  But perhaps the description of
'--full-diff' option could be improved.

The '--stat' is git-diff option, as you can see by running e.g.
"git diff --stat HEAD^!"

-- 
Jakub Narebski
Poland
