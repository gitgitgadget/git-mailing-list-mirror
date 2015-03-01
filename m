From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Sun, 1 Mar 2015 08:03:08 -0500
Message-ID: <20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com>
References: <54EDBEC2.8090107@peralex.com>
 <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
 <20150225143116.GA13567@peff.net>
 <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
 <20150225185128.GA16569@peff.net>
 <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
 <20150225191108.GA17467@peff.net>
 <20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 14:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS3Wx-0001hH-OX
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 14:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbbCANDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 08:03:31 -0500
Received: from tbsaunde.org ([66.228.47.254]:54670 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbbCANDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 08:03:30 -0500
Received: from tsaunders-iceball.corp.tor1.mozilla.com (174.141.12.210.nw.nuvox.net [174.141.12.210])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 36B04C0B1;
	Sun,  1 Mar 2015 13:03:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264558>

On Sat, Feb 28, 2015 at 07:06:16PM -0800, Junio C Hamano wrote:
> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> 
> >  There have been cases where I wanted grep to always ignore certain
> >  files, but to still get text diffs for those files.  One case is people
> >  insist on using ChangeLog files, and another is people who commit
> >  generated files of one sort or another.
> 
> The attributes are to say "the contents to be stored in this file is
> of this nature".  Something inherent to the type of the contents,
> and that is why there is no way to countermand them from the command
> line.
> 
> The "nature of the content" may be "result of comparing two versions
> of them textually will never make sense to humans", or "result of
> finding substrings in them will never make sense to humans", which
> are what "-diff" and hypothetical "-grep" mean, respectively.
> 
> "It is inconvenient that I see hits in ChangeLog files when I look
> for string BUG" does not make ChangeLog inherently "result of
> finding substrings in it never makes sense to humans"-kind of file
> type.  Maybe somebody who is playing a role of a coder right now may
> not look at existing ChangeLog entries, but when that same person
> plays the role of a release manager next day, running grep on older
> ChangeLog files may become necessary to find changes related to
> recent changes.  For these "per-invocation" differences, attributes
> to declare permenent/inherent nature of the contents is much less
> suited than per-invocation inclusion/exclusion mechanism based on
> pathspecs, I would think.

I think that makes some amount of sense, however typing stuff like
--exclude=ChangeLog all the time is not terribly easy on the hands.
Would it make sense to instead add a config variable grep.exclude?

Trev

> 
> 
