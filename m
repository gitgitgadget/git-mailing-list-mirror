From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 17:51:23 +0200
Message-ID: <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net> <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sebastian Schuberth" <sschuberth@gmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 17:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IInqe-00023A-2e
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 17:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742AbXHHPwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 11:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756133AbXHHPwp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 11:52:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:59540 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757742AbXHHPwn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 11:52:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l78Foe4I002981;
	Wed, 8 Aug 2007 17:50:40 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l78FocYs006585
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Aug 2007 17:50:39 +0200 (MEST)
In-Reply-To: <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55328>


On Aug 8, 2007, at 3:50 PM, Mark Levedahl wrote:

> On 8/7/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>> I read your message and I just checked the most recent installer
>> of cygwin (screenshot attached).
>>
>> I see three choices I'm offered:
>> 1) the path to install;
>> 2) install for all or just me;
>> 3) choose the default text file type.
>>
>> I wouldn't call that deprecated, not even obsolenscent.
>
> Call it passively deprecated. there has been a lot of discussion about
> removing it, or at least hiding it behind the mount command and not
> offering it at all during installation. The objective of text mounts
> was noble, but it really is hard to automatically convert any
> occurrence of crlf->lf and lf->crlf everywhere it should be done but
> not where it should not be done. However, a lot of people use text
> mounts without trouble (or at least without complaining to the lists),
> so removing the option outright was thought too likely to cause an
> uproar.

That is what I'm facing now. A policy I need to handle tells
people explicitly to choose textmode to force cvs in cygwin to
do the right thing: converting lf->crlf->lf.

I'm not in a position to tell them not to follow this policy;
and I don't think it's reasonable to change the policy right away.
They have a lot of cvs working copies checked out and if they
switched from textmode to binmode now, they'd get crlf's on the
next commit, which they deliberately chose to avoid by using
textmode.


> So, consider that Cygwin is taking the "let it rot, remove it
> later" approach.

This may take years.

For me it would be easier if Cygwin (not I) told the world
very clearly: You must no longer use binary mounts. Consider
switching now, but you must switch until end of 2007. This
would make my life much more easier. I could tell that it's
not my fault and not git's fault, it's Cygwins decision to
drop support for textmode.

People might complain but I think they would understand.
Providing an option and letting people install software that is
not able to handle this option causes nothing but trouble. The
very least would be to only allow installing software that is
known to handle textmode. Or provide another mode that
guarantees that no conversion takes place and offers a larger
selection of packages.


> Anyone who has troubles is generally and not so
> gently encouraged to just use binary mounts. There are some known crlf
> problems, largely with bash/sh, pipes, forks, and redirection (of
> which git is a heavy user so git is a prime candidate to get into
> trouble) that are not being worked.
>
> For instance, when working on git-bundle.sh, I got bit by crlf
> conversions corrupting packfiles sent through a pipe on a system with
> pure binary mounts and CYGWIN=binmode. The cure to that bug is
> *removing* auto-crlf conversion from Cygwin.

Technically I agree. The problem is, textmode is not removed,
but appears as if it was supported (see installer).

I'm running out of options: git in cygwin appeared to work for
me, but it's not working in the context of the organization that
I need to deal with. I can't force them to switch to binary mode.
Other approaches to git on Windows are on their way, but, to my
understanding, are not mature enough. git-cvsserver doesn't provide
sufficient cvs functionality to be compatible with the needed
workflows.

The bottom line for me is, git does not yet support Windows in a
usable way for the organizations that I need to convince.

	Steffen
