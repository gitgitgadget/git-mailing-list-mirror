From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] rev-parse: fix --git-common-dir when executed from
 subpath of main tree
Date: Thu, 19 May 2016 16:49:39 +0900
Message-ID: <20160519074939.GA22796@glandium.org>
References: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
 <CACsJy8CgNy8+s0j+UUVVDk1ru702mtkTrO6QsYNpisGY-eAYGw@mail.gmail.com>
 <CANoM8SWCiJch-nXq=-=ELKOc6tV-TNg6U-hcc9W69Fz4rz+j+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 09:49:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3IiN-0004n1-7E
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 09:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbcESHtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 03:49:47 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35014 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbcESHtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 03:49:47 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b3IiB-00061F-3t; Thu, 19 May 2016 16:49:39 +0900
Content-Disposition: inline
In-Reply-To: <CANoM8SWCiJch-nXq=-=ELKOc6tV-TNg6U-hcc9W69Fz4rz+j+g@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295043>

On Fri, Apr 08, 2016 at 08:35:51AM -0400, Mike Rappazzo wrote:
> On Fri, Apr 8, 2016 at 7:47 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Mon, Apr 4, 2016 at 8:42 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> >> Executing `git-rev-parse --git-common-dir` from the root of the main
> >> worktree results in '.git', which is the relative path to the git dir.
> >> When executed from a subpath of the main tree it returned somthing like:
> >> 'sub/path/.git'.  Change this to return the proper relative path to the
> >> git directory (similar to `--show-cdup`).
> >
> > I faced a similar problem just a couple days ago, I expected "git
> > rev-parse --git-path" to return a path relative to cwd too, but it
> > returned relative to git dir. The same solution (or Eric's, which is
> > cleaner in my opinion) applies. --shared-index-path also does
> > puts(git_path(... and has the same problem. Do you want to fix them
> > too?
> 
> Sure, I can do that.  I will try to get it up soon.

If I'm not mistaken, it looks like this fell off your radar. (I haven't
seen an updated patch, and it doesn't look like the fix made it to any
git branch). Would you mind updating?

Cheers,

Mike
