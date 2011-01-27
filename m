From: Andreas Ericsson <ae@op5.se>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Thu, 27 Jan 2011 21:09:39 +0100
Message-ID: <4D41D103.4080502@op5.se>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 21:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiYAB-00085J-9X
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 21:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab1A0UJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 15:09:46 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35877 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab1A0UJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 15:09:45 -0500
Received: by ewy5 with SMTP id 5so1163238ewy.19
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 12:09:44 -0800 (PST)
Received: by 10.14.37.134 with SMTP id y6mr2263142eea.45.1296158982837;
        Thu, 27 Jan 2011 12:09:42 -0800 (PST)
Received: from [192.168.1.186] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id b52sm13191478eei.19.2011.01.27.12.09.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Jan 2011 12:09:41 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165588>

On 01/27/2011 08:38 PM, Thomas Hauk wrote:
> Back when I worked at a large games company, we used Perforce, and
> our repo structure looked a little something like this:
> 
> /branches /alpha /beta /mainline /packages /external /foolib /1.0 
> /1.1 /2.0 /internal /barlib /dev /1.0 /2.0 /bazlib /2.34 /2.35 /qux 
> /dev
> 
> At the package level, we would split up packages/libraries into two
> groups based on if they were developed at the company or not
> (external/internal), and inside each one, we might have multiple
> versions. In the example above, the repo is for the "qux" game, which
> uses an internal "bazlib" library developed by another group, and the
> "barlib" library which was developed for use on "qux" and may be used
> simultaneously on other projects.
> 
> Project-level branches took mainline as a base and branched into the
> /branches directory. Package-level branches would usually take the
> "dev" version (which represented the current development version,
> akin to "master" in Git) as a base and branch into the same parent
> directory but with an actual version name.
> 
> I've successfully used this repo structure with several other
> projects over the years at other companies (who were mostly using
> Subversion). Now I'm trying to get into the Git swing of things, but
> it seems to be that Git only offers project-level branching, and
> doesn't allow for the kind of package-level branching I'm describing
> here.
> 
> Am I incorrect or is there a way to accomplish with Git what I was
> doing before with P4 and SVN?
> 

You're correct. There's no way to accomplish what you wish to do
inside git. I'd suggest submodules, but that still doesn't get
you the per-directory branching inside a git repository, even
though it does make it rather trivial to change versions at will.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
