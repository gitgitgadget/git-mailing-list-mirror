From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 14:25:51 -0700
Message-ID: <7vr4reigm8.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vboiilpvs.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
 <20120810180836.GA29597@sigill.intra.peff.net>
 <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com>
 <20120810182555.GA29707@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Borowitz <dborowitz@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szwij-0003a4-7k
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670Ab2HJVZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:25:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757593Ab2HJVZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:25:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2B08B38;
	Fri, 10 Aug 2012 17:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oqeGNdZw1arJUlvvqsZrLy8FWsw=; b=wLfeId
	U/48MpuowuhPOl1g1eZxl3uv98fTedVaujsFDk02JACmQ3edGyedhJjjA4J/o31M
	hVWrkCF+W4P4BQljyaoQZ3deAGfBVuChSH/1IFwt47y1w7Wc0pVOlxUbHeFesTD+
	Mz3g1ghrQ6L6SPg3GTv/2NVW2A38aPG/7KVnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1gn+zS4MoSCAaQ2u/Gx/7vOuvpalKob
	2I4MZTLNGA6yr2gRMfa/yMeuu/4paHcMDlGH3sDYXGcNquBSELpMnOsYmY29Ayf7
	1uZwqYCafxSYbbUHYiu5Sk2C2NR/ICVaMDc0eCJld73Kycp+avJltYzyNdHdtFpR
	7LeR89aLinE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BDB18B37;
	Fri, 10 Aug 2012 17:25:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47AAB8B36; Fri, 10 Aug 2012
 17:25:53 -0400 (EDT)
In-Reply-To: <20120810182555.GA29707@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 14:25:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6E6652E-E331-11E1-B7A4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203263>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 10, 2012 at 11:13:30AM -0700, Dave Borowitz wrote:
>
>> > Thanks for the data point. I knew you guys ran some custom code, so I
>> > wasn't sure how widespread this is. The fact that other dulwich-based
>> > servers would see the same issue makes me doubly sure that my fix is the
>> > right direction.
>> 
>> You may also notice in that code a set of innocuous_capabilities,
>> which IIRC is the complete set of capabilities, at the time of
>> writing, that the C git client may send without the server advertising
>> them. Such a set (painstakingly assembled, I assure you :) may be
>> useful as we move further in this direction.
>
> Oh, hmm. When initially writing my message I thought that might be the
> case, but I checked to see that the features were sent only when the
> server had first advertised them. However, I didn't notice that is true
> only in _some_ of these lines from fetch-pack.c:
>
>     if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
>     if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
>     if (no_done)            strbuf_addstr(&c, " no-done");
>     if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
>     if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
>     if (args.use_thin_pack) strbuf_addstr(&c, " thin-pack");
>     if (args.no_progress)   strbuf_addstr(&c, " no-progress");
>     if (args.include_tag)   strbuf_addstr(&c, " include-tag");
>
> The early ones are checking that the server claimed support, but all of
> the args.* ones are influenced directly by the arguments, whether the
> server supports it or not.

> I don't think there's any bug here. They are all of a class of features
> where the client can handle the case where the server simply ignores the
> request. However it is certainly food for thought if we are considering
> tightening git's server side (even if we fix these, we have to support
> the innocuous capabilities list forever for older clients).

I doubt the "innocuous" approach is really viable, unless we have an
autoritative documentation that tells which ones are and which ones
are not innocuous, and everybody follows it, so that everybody's
server and client understands the same set of capabilities as such.

Which is not likely to happen.  So in that sense, the above have
three bugs.  A new person that starts writing his server without
knowing the workaround Dulwich used that has been hidden from the
Git community until today will have to rediscover the "innocuous"
workaround on his server, unless such buggy clients die out.

I'd rather make sure that 10 years on, the maintainer does not have
to worry about interoperating with a new server written by some
third-party.

Something like this, perhaps.

 builtin/fetch-pack.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bc7a0f9..fdec7f6 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -818,6 +818,12 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
+	if (!server_supports("thin-pack"))
+		args.use_thin_pack = 0;
+	if (!server_supports("no-progress"))
+		args.no_progress = 0;
+	if (!server_supports("include-tag"))
+		args.include_tag = 0;
 	if (server_supports("ofs-delta")) {
 		if (args.verbose)
 			fprintf(stderr, "Server supports ofs-delta\n");
