From: Jan Larres <jan@majutsushi.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Wed, 3 Apr 2013 10:05:24 +0000 (UTC)
Message-ID: <slrnklnvo6.jdl.jan@majutsushi.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
 <7vtxnogbft.fsf@alter.siamese.dyndns.org>
 <20130402163034.GA19252@sigill.intra.peff.net>
 <7vhajog9xp.fsf@alter.siamese.dyndns.org>
 <20130402165128.GA19712@sigill.intra.peff.net>
 <7v1uasg8e0.fsf@alter.siamese.dyndns.org>
 <20130402191641.GB17784@sigill.intra.peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 03 12:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNKa9-0001Sn-1R
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 12:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759876Ab3DCKFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 06:05:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:39811 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750Ab3DCKFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 06:05:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UNKa0-0001Ja-1T
	for git@vger.kernel.org; Wed, 03 Apr 2013 12:06:08 +0200
Received: from 101.98.187.16 ([101.98.187.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 12:06:08 +0200
Received: from jan by 101.98.187.16 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 12:06:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 101.98.187.16
User-Agent: slrn/pre1.0.0-18 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219932>

Thanks for the clarifications. Just a quick comment about the summary:

Jeff King <peff@peff.net> wrote:
> Yeah, I had the same thought. So you would have to either:
>
>   1. Hook the feature into git-archive, which knows about how it
>      recurses, and can report the correct set of paths.
>
> or
>
>   2. Tell check-attr (or some post-processor) to apply the attribute to
>      elements below the path (or possibly to prune out such paths). This
>      is not the same as recursive application, because you cannot negate
>      it (i.e., you actually find out the final attrs for both "foo" and
>      "foo/bar", and then say "the attr for 'foo' overrides the attr for
>      'foo/bar'".
>
> I posted a patch for (1), but it felt not-very-general. But (2) also
> feels gross and not very general. Even though it could in theory be used
> for things besides git-archive, it is really just applying git-archive's
> pruning rule, which other programs likely don't care about.

I actually think the first approach is not such a bad idea, it would
make "archive" more of a general-purpose archiving tool/helper for the
repository rather than just something for the special cases of tars and
zips. But I guess that's somewhat subjective.

Cheers,
Jan
