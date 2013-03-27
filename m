From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 16:35:35 -0400
Message-ID: <20130327203535.GA5220@sigill.intra.peff.net>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:36:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKx4s-0003P7-0O
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab3C0Ufl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:35:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41900 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab3C0Ufl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:35:41 -0400
Received: (qmail 18452 invoked by uid 107); 27 Mar 2013 20:37:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 16:37:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 16:35:35 -0400
Content-Disposition: inline
In-Reply-To: <7v620dss3j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219327>

On Tue, Mar 26, 2013 at 03:40:00PM -0700, Junio C Hamano wrote:

> [Cooking]
> [...]
> * jk/index-pack-correct-depth-fix (2013-03-20) 1 commit
>  - index-pack: always zero-initialize object_entry list
> 
>  "index-pack --fix-thin" used uninitialize value to compute delta
>  depths of objects it appends to the resulting pack.

Any reason this is still in pu? I'd have expected it to be fairly
uncontroversial and slated for maint.

> * jk/pkt-line-cleanup (2013-03-21) 20 commits
>  - do not use GIT_TRACE_PACKET=3 in tests
>  - remote-curl: always parse incoming refs
>  - remote-curl: move ref-parsing code up in file
>  - remote-curl: pass buffer straight to get_remote_heads
>  - teach get_remote_heads to read from a memory buffer
>  - pkt-line: share buffer/descriptor reading implementation
>  - pkt-line: provide a LARGE_PACKET_MAX static buffer
>  - pkt-line: move LARGE_PACKET_MAX definition from sideband
>  - pkt-line: teach packet_read_line to chomp newlines
>  - pkt-line: provide a generic reading function with options
>  - pkt-line: drop safe_write function
>  - pkt-line: move a misplaced comment
>  - write_or_die: raise SIGPIPE when we get EPIPE
>  - upload-archive: use argv_array to store client arguments
>  - upload-archive: do not copy repo name
>  - send-pack: prefer prefixcmp over memcmp in receive_status
>  - fetch-pack: fix out-of-bounds buffer offset in get_ack
>  - upload-pack: remove packet debugging harness
>  - upload-pack: do not add duplicate objects to shallow list
>  - upload-pack: use get_sha1_hex to parse "shallow" lines
> 
>  Cleans up pkt-line API, implementation and its callers to make them
>  more robust.  Even though I think this change is correct, please
>  report immediately if you find any unintended side effect.
> 
>  Will merge to 'master' in the 3rd batch (Risky).

I was kind of surprised to see this still in pu, too. I thought it was
supposed to cook in next for a while to shake out any interoperability
bugs (and it was in next previously). Did it get ejected after the
release and then never put back?

-Peff

PS I notice John Keeping has become quite active these days, and has
   stolen my initials. It makes searching for my topics in "What's
   Cooking" much harder (I read it linearly, but I take special notice
   of the "jk" topics).
