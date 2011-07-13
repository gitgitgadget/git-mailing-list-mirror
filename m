From: Andreas Ericsson <ae@op5.se>
Subject: Re: Nesting a submodule inside of another...
Date: Wed, 13 Jul 2011 10:43:47 +0200
Message-ID: <4E1D5AC3.5050409@op5.se>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 10:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgv34-0007TQ-2F
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091Ab1GMIn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 04:43:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36009 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965029Ab1GMIn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 04:43:56 -0400
Received: by bwd5 with SMTP id 5so4660646bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 01:43:55 -0700 (PDT)
Received: by 10.204.83.138 with SMTP id f10mr413190bkl.289.1310546634816;
        Wed, 13 Jul 2011 01:43:54 -0700 (PDT)
Received: from vix.int.op5.se (c83-248-99-226.bredband.comhem.se [83.248.99.226])
        by mx.google.com with ESMTPS id o25sm1587623bkf.51.2011.07.13.01.43.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 01:43:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177015>

On 07/12/2011 02:01 PM, John Szakmeister wrote:
> Hi all,
> 
> I've got a project where we have several frameworks involved, and
> external modules we want to pull into the framework tree.  We'd like
> to make use of submodules and have something like this:
>      top-level/<-- .gitmodules lives here
>          src/
>          framework1/<-- a submodule
>              module/<-- another submodule
>          framework2/<-- a submodule
>              module2/<-- another submodule
> 
> Currently, git fails trying to do this.  It's not happy about
> .gitmodules living at the top-level and nesting a submodule inside of
> another[1].  Is there a technical reason that this is not allowed?

Yes. Everything inside a submodule is owned by that submodule, so the
master repo can't know anything about it. You can have a submodule
which in turn has submodules though. If you couldn't, it wouldn't be
possible to checkout only the framework1 repository and get all its
dependencies.

I have no idea what problems you run into with more than 2 tiers of
submodules though, but I guess that's for you to find out and report
about.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
