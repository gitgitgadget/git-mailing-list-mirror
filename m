From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 9 Nov 2010 16:33:31 -0800
Message-ID: <050F42EE-34FE-499F-B632-471597EB4881@sb.org>
References: <20101109083023.783fad9b@chalon.bertin.fr> <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org> <20101109102428.5ba8dc13@chalon.bertin.fr> <7vlj52jakh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 01:33:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFyd9-0005sj-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 01:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab0KJAde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 19:33:34 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41389 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab0KJAdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 19:33:33 -0500
Received: by pzk28 with SMTP id 28so12765pzk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 16:33:33 -0800 (PST)
Received: by 10.142.88.11 with SMTP id l11mr3317674wfb.314.1289349213331;
        Tue, 09 Nov 2010 16:33:33 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm24755wfg.20.2010.11.09.16.33.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 16:33:32 -0800 (PST)
In-Reply-To: <7vlj52jakh.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161115>

On Nov 9, 2010, at 4:18 PM, Junio C Hamano wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> 
>>>> Syntax like origin/pu^{/Merge 'kb/blame-author-email'}2 would be
>> ...
>> Another idea: origin/pu^{:2/Merge 'kb/blame-author-email'}
> 
> What are these "2"s?
> 
> You need to question how you figured out the commit you want is the second
> one reachable (in whatever traversal order) from something in the first
> place.  Didn't you use "git log --oneline" or something to find that out?
> At that point, you have the object name already, so I doubt such a
> "counting" feature is of much practical use.

The particular case that prompted this for me was I knew I had created two
commits called "WIP", scheduled for renaming later, and I wanted to quickly
look at the contents of the first one. I would have loved to be able to
type something like `git show :/WIP/2`. I suppose this situation may be rare
enough not to bother supporting it in the new syntax. With the new syntax
it will be possible to do something like `git show HEAD^{:/WIP}^^{:/WIP}`, but
that looks awfully awkward.

Another thing to consider - the current :/foo syntax searches for the newest
commit reachable from any ref. Using the ^{} syntax will require specifying
a ref first. I'm not sure this is a problem though, as I'm not really sure why
:/foo searches from all refs to begin with.

-Kevin Ballard