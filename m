From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] difftool: don't assume that default sh is sane
Date: Tue, 29 Jul 2014 01:03:23 -0700
Message-ID: <20140729080322.GB20724@gmail.com>
References: <1405787717-30476-1-git-send-email-charles@hashpling.org>
 <1405787717-30476-2-git-send-email-charles@hashpling.org>
 <20140729075328.GA20724@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:02:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC2N2-0000mX-AC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 10:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbaG2ICr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 04:02:47 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36775 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbaG2ICp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 04:02:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so12034741pad.10
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MsHebGRrs164igY+LA7OaYYvmB75HaeLQYsLckhS/mo=;
        b=wXZ3UVvUhULxdhA2dYsNQBre5j/pJvr+rBh0hk0rpJWAmXDCeE6I+dkpSLTcVztDL3
         UCd2rqLlp2lZNRUhVN00jGJJiBTLwIGKvvn7bauRpdB9akHl1Ecm5GprOPXv/4bACAaa
         tM27z/+j74iqw1hIl3/8Frfg5BF/+0yVX/VnKsjaeOPxQE2qLE1b21t4x8O1Ogb/w44e
         E+ERlEgGPU4kLvV9hd9v4SaBQ3DmLOraTFa1E4iHIPhnZHEuXkAJoB9ahazzqd4CijyA
         ZJ3OE1xG3KCwhAtywf5hzpzos1dMGEIOy1tuwpGDGmGYniNpT1Q5tRdTkVx4G1OvEIp2
         +Orw==
X-Received: by 10.68.200.101 with SMTP id jr5mr467820pbc.36.1406620964774;
        Tue, 29 Jul 2014 01:02:44 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id i8sm19927858pbq.12.2014.07.29.01.02.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 01:02:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140729075328.GA20724@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254403>

On Tue, Jul 29, 2014 at 12:53:29AM -0700, David Aguilar wrote:
> On Sat, Jul 19, 2014 at 05:35:17PM +0100, Charles Bailey wrote:
> > diff --git a/git-difftool.perl b/git-difftool.perl
> > index 18ca61e..598fcc2 100755
> > --- a/git-difftool.perl
> > +++ b/git-difftool.perl
> > @@ -47,13 +47,9 @@ sub find_worktree
> >  
> >  sub print_tool_help
> >  {
> > -	my $cmd = 'TOOL_MODE=diff';
> > -	$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
> > -	$cmd .= ' && show_tool_help';
> > -
> >  	# See the comment at the bottom of file_diff() for the reason behind
> >  	# using system() followed by exit() instead of exec().
> > -	my $rc = system('sh', '-c', $cmd);
> > +	my $rc = system(qw(git mergetool --tool-help=diff));
> 
> I believe qw() in list context is considered deprecated.

Sorry for the noise, I got my warnings mixed up.
It's only deprecated when used as parentheses, so this is fine as-is.
-- 
David
