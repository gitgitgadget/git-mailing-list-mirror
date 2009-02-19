From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 18:58:07 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0902191850260.21164@reaper.quantumfyre.co.uk>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com> <1235020471-59982-2-git-send-email-jaysoffian@gmail.com> <1235020471-59982-3-git-send-email-jaysoffian@gmail.com> <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com> <499D82BC.7020500@xiplink.com> <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 20:01:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaE95-0004bF-Sr
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 20:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169AbZBSS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 13:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756618AbZBSS7u
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 13:59:50 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:57257 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757168AbZBSS7t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 13:59:49 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 258DC136E4D
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 18:59:47 +0000 (GMT)
Received: (qmail 6799 invoked by uid 103); 19 Feb 2009 18:58:08 +0000
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9002. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.038996 secs); 19 Feb 2009 18:58:08 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 19 Feb 2009 18:58:08 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110730>

On Thu, 19 Feb 2009, Jay Soffian wrote:

> On Thu, Feb 19, 2009 at 11:03 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> First, a nit: I don't know if the "w/remote" notation makes sense to
>> non-English speakers.  I also like the alignment achieved by "merges with
>> remote " (note the trailing space).
>
> I tried out a few different option and none was very satisfactory to me.
>
> 1)
>    master            rebases onto remote master
>    another-branch    merges with remote  next
>    some-other-branch rebases onto remote master
>
> Here, the unaligned "with" and "onto" is ugly.
>
> 2)
>
>    master            rebases onto remote master
>    another-branch    merges  with remote next
>    some-other-branch rebases onto remote master
>
> This looks better to me. However, if none of your branches rebase,
> then the extra space looks like it is a mistake. e.g.:
>
>    master            merges  with remote master
>    another-branch    merges  with remote next
>    some-other-branch merges  with remote master
>
> I could add code to detect whether all the branches merge and then not
> output the space, but, sigh. And I couldn't think of any other
> combination of words that had the same character spacing.

or

  3)

     master            rebases onto remote master
     another-branch     merges with remote next
     some-other-branch rebases onto remote master

perhaps, which doesn't look odd without the rebase lines?

> So that's how I ended up with "merges w/remote". This is also slightly
> less wide. I always try to have output fit into 80 columns (how
> quaint, I know) and a merging branch might have multiple upstreams.
> e.g.
>
>   another-branch merges w/foo, bar, baz

or

    another-branch merges with foo
                      and with bar
                      and with baz

perhaps?

> IOW, the output in the patch wasn't arbitrary. I did think about it
> quite a bit. Which isn't to say it's right, just it's the best I came
> up with.
>
> I'm somewhat confused by "w/remote" making sense to non-English
> speakers as it's English output.

But generally the output is not as idomatic as w/foo.  If English is a 
non-native language then "with foo" is going to be much clearer - and if 
nothing else, much easier to lookup in a dictionary.

>> Second, I think it would be good to also change the format of the 'git push'
>> list, for consistency:
>
> I left that out on purpose. The only folks with push refspecs put them
> their manually, and the raw refspec is clearer and more concise than
> any English words can convey. That was my reasoning anyway.
>
> Thanks for the feedback.
>
> j.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Julian

  ---
"You're just the sort of person I imagined marrying, when I was little...
except, y'know, not green... and without all the patches of fungus."
 		-- Swamp Thing
