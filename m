From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Google Gerrit
Date: Tue, 2 Mar 2010 07:26:55 -0800
Message-ID: <20100302152655.GC28997@spearce.org>
References: <c1fb08351003020610q25b85b60hf9362aabc4b0126f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	git <git@vger.kernel.org>
To: Anca Emanuel <anca.emanuel@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 02 16:27:11 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NmU06-0006Vk-5v
	for glk-linux-kernel-3@lo.gmane.org; Tue, 02 Mar 2010 16:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797Ab0CBP1B (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 2 Mar 2010 10:27:01 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41996 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0CBP07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2010 10:26:59 -0500
Received: by qyk9 with SMTP id 9so164560qyk.5
        for <multiple recipients>; Tue, 02 Mar 2010 07:26:58 -0800 (PST)
Received: by 10.224.35.163 with SMTP id p35mr2706868qad.6.1267543618196;
        Tue, 02 Mar 2010 07:26:58 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm4204744iwn.5.2010.03.02.07.26.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 07:26:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c1fb08351003020610q25b85b60hf9362aabc4b0126f@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141399>

Anca Emanuel <anca.emanuel@gmail.com> wrote:
> Hi, what do you think about Google Gerrit ? http://code.google.com/p/gerrit/
> 
> see it in action here: http://review.source.android.com

For kernel or at least C-ish folk... a kernel patch under development
might be more relevant to point to.  E.g.:

https://review.source.android.com/13610
 
> quote:
> "Gerrit is a web based code review system, facilitating online code
> reviews for projects using the Git version control system.
> Gerrit makes reviews easier by showing changes in a side-by-side
> display, and allowing inline comments to be added by any reviewer.
> Gerrit simplifies Git based project maintainership by permitting any
> authorized user to submit changes to the master Git repository, rather
> than requiring all approved changes to be merged in by hand by the
> project maintainer. This functionality enables a more centralized
> usage of Git."

I hate that description.  I keep meaning to overhaul the project
landing page with screenshots and try to describe the feature set
better, but I've been too busy with coding.
 
> git needs an friendly UI, web based is the future.

We have a number of UIs for Git... some more user friendly to
certain classes of users than others.  But I'm not sold that a
web based interface is the future.

Sometimes a web UI can be very convient to work with.  Sometimes, the
existing mailing list review infrastructure works very well.  What I
love most about Git is how much choice we really have as users.
 
> Maybe an integration with Wave.

Maybe.  But I'm not actively pursuing that right now.  If someone
else develops a Gitty bot for Wave, that would be cool.

Actually... my goal over the next couple of months here is to
make Gerrit Code Review no longer dependent on a web UI, or on a
backend SQL database.  I'm going to shift all of the data storage
into Git meta branches, and the code annotations into Git notes.
Which will make it very friendly to build other tools like an Emacs
plugin that can interoperate based solely on raw Git commands and
formats, without ever touching the existing Java or web UI.

I think the biggest challenge I have is I need a good inverted
search index, and Git has no standard for that.  I'm tempted to
use Apache Lucene[1] because in Java its simple to work with,
but their C port has been dangling in the wind for a long time.

[1] http://lucene.apache.org/

-- 
Shawn.
