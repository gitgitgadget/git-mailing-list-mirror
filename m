From: Jeff King <peff@peff.net>
Subject: [PATCH 0/15] store length of commit->buffer
Date: Mon, 9 Jun 2014 14:02:36 -0400
Message-ID: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu3u6-0001L1-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbaFISCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:02:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:40318 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751918AbaFISCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:02:38 -0400
Received: (qmail 14991 invoked by uid 102); 9 Jun 2014 18:02:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:02:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:02:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251086>

Here's my series to drop "buffer" from "struct commit" in favor of a
slab, and then add in a length field. It's a lot of commits, but I tried
to break it down into readable chunks.

  [01/15]: alloc: include any-object allocations in alloc_report
  [02/15]: commit: push commit_index update into alloc_commit_node
  [03/15]: do not create "struct commit" with xcalloc
  [04/15]: logmsg_reencode: return const buffer
  [05/15]: sequencer: use logmsg_reencode in get_message
  [06/15]: provide a helper to free commit buffer
  [07/15]: provide a helper to set the commit buffer
  [08/15]: provide helpers to access the commit buffer
  [09/15]: use get_cached_commit_buffer where appropriate
  [10/15]: use get_commit_buffer to avoid duplicate code
  [11/15]: convert logmsg_reencode to get_commit_buffer
  [12/15]: use get_commit_buffer everywhere
  [13/15]: commit-slab: provide a static initializer
  [14/15]: commit: convert commit->buffer to a slab
  [15/15]: commit: record buffer length in cache

-Peff
