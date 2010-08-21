From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 11:15:55 +0200
Message-ID: <20100821111555.11879d02@hyperion.delvare>
References: <20100821092616.5e57135b@hyperion.delvare>
	<m3wrrknzph.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 11:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmkBP-00007Y-9K
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 11:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003Ab0HUJQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 05:16:06 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:1315 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0HUJQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 05:16:04 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1OmkAF-0003Cx-7G
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Sat, 21 Aug 2010 11:14:59 +0200
In-Reply-To: <m3wrrknzph.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154126>

Hi Jakub,

On Sat, 21 Aug 2010 01:22:05 -0700 (PDT), Jakub Narebski wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> 
> > I have a feature request for gitweb. In the history view, I would like
> > to be (optionally) able to see the tags, interlaced with the actual
> > commits. The idea is to get an immediate view of all commits that
> > happened between specific tags.
> > 
> > The actual format for displaying the tags can certainly be discussed, I
> > have no strong opinion on this myself. We may want to let the admin
> > filter which tags should show up that way, maybe even letting him/her
> > define primary and secondary tag formats (think main releases vs.
> > release candidates) for nicer output. Then we may want to group (or
> > hide) tags when a file hasn't been modified in a long time. But these
> > are implementation details, even the raw functionality would be quite
> > useful IMHO, and hopefully not too difficult to implement.
> 
> Currently in 'shortlog' view you can see 'ref' markers... which
> include tags.
> 
> For example 'shortlog' view for 'maint' branch has the following
> fragment:
> 
>  2010-07-28 	 Matthieu Moy	 Document ls-files -t as semi-obsolete.
>  2010-07-27 	 Junio C Hamano	 Git 1.7.2.1  [v1.7.2.1]
>  2010-07-27 	 Junio C Hamano	 Sync with 1.7.1.2
>  2010-07-27 	 Junio C Hamano	 Git 1.7.1.2  [v1.7.1.2]
>  2010-07-27 	 Junio C Hamano	 Sync with 1.7.0 series
>  2010-07-27 	 Junio C Hamano	 Git 1.7.0.7  [v1.7.0.7]
> 
> where e.g. [v1.7.2.1] is ref marker for 'v1.7.2.1' tag.
> 
> If you have something different in mind, please provide moackup,
> either as ASCII-art, or link to HTML or image.

Yes, visually this would be very fine with me.

But shortlog is a repository-wide view, while I need the same for
history which is a file-specific view. Things are obviously a little
more complex there, because for a given file, it is statistically
unlikely that each commit affecting the file in question corresponds to
a tag. So we have to find the best tag to display in front of
each commit (easiest bet would be the next tag time-wise) and maybe
improve a bit from there (for example by not showing the same tag
twice). But then again I would be very happy with a relatively raw
output for the time being.

Thanks,
-- 
Jean Delvare
