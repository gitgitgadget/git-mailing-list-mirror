From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Partially private repository?
Date: Fri, 29 Jan 2010 17:10:53 -0500
Message-ID: <32541b131001291410g252ddff4lbf04ac7c1d2d33fc@mail.gmail.com>
References: <78d8a6b51001291401ib93976el25c03694d53aaced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Daed Lee <daed@thoughtsofcode.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:17:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naz9Y-00051o-Mo
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab0A2WRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414Ab0A2WRS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:17:18 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:36807 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab0A2WRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:17:18 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2010 17:17:17 EST
Received: by iwn39 with SMTP id 39so495693iwn.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Y0au5vjxko9ay7vfyTobw3caVjVEV3EdVgc6WM+m0qU=;
        b=WfCl59qEQBv+sgJa+/+AQcchyVu+k/jHQHU4RfAiylvJ0wjPNd3raD5l+Ome9rNsPN
         KHM6S/3KozsfLS7T01GSbuj7+nIq/qIu0TSXs9tbJVKUDxJwyy2ZzyBpq/QbimiUB8Ql
         DLvKV0ah6H+ECJ4uO6FvC1VyxLCnJQ+bmvgGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=I0A2To41kS4Qae9C9NIYAHx/lfRyOX8/6wNXEi/e5MWdqIn1edtoTl/B8Qz8jga76q
         my4ybMnIFBiU3JDMdrZPcQgE6VgNW4trDhzFgDY7sMU8N9CiCWInV/jItLfAWtEdG9mN
         ZvsDOzBtfmUUBiRHfYeM/qpd3t7hpq2bByCXg=
Received: by 10.231.146.8 with SMTP id f8mr2222233ibv.58.1264803074188; Fri, 
	29 Jan 2010 14:11:14 -0800 (PST)
In-Reply-To: <78d8a6b51001291401ib93976el25c03694d53aaced@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138385>

On Fri, Jan 29, 2010 at 5:01 PM, Daed Lee <daed@thoughtsofcode.com> wrote:
> Hi, I'm wondering if git can handle the following use. I have a
> project that started as private experiment, but has morphed into
> something I'd like to release publicly. I want to give others access
> to the repository, but only to commits after a certain cutoff date.
> Commits prior to that date have things like hardcoded file paths,
> emails, etc. that I'd like to keep private.
>
> I suppose the easiest thing to do would be to create a new repository,
> add the project files to it, and make that public, however I'd like to
> keep my private commit history along with the public commit history
> going forward in a single repository if possible. Is there a way to do
> this with git?

You should probably split your history into two pieces: the "before"
and "after" parts.  To split out the "after" part, you could use
git-filter-branch
(http://www.kernel.org/pub/software/scm/git/docs/v1.6.0.6/git-filter-branch.html).
 Then, in your private copy of the repo, you could reattach the
"before" part of the history using git grafts.

Have fun,

Avery
