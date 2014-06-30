From: Jeff King <peff@peff.net>
Subject: [PATCH 0/9] add strip_suffix as an alternative to ends_with
Date: Mon, 30 Jun 2014 12:55:27 -0400
Message-ID: <20140630165526.GA15690@sigill.intra.peff.net>
References: <53AED59B.1020209@web.de>
 <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
 <53AFA775.1090900@web.de>
 <53AFAA89.6050200@web.de>
 <20140630134317.GB14799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:55:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1erc-0008GS-B1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbaF3Qz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 12:55:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:53634 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754195AbaF3Qz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:55:28 -0400
Received: (qmail 7499 invoked by uid 102); 30 Jun 2014 16:55:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:55:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:55:27 -0400
Content-Disposition: inline
In-Reply-To: <20140630134317.GB14799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252682>

Here's a series to do for ends_with what the recent skip_prefix series
did for starts_with. Namely: drop some magic numbers and repeated strin=
g
literals, and hopefully make things more readable.

The first patch is Ren=C3=A9's patch 1/2, with the leak fix from Duy an=
d typo
fixes in the commit message from me. The rest are new, and replace the
changes to prepare_packed_git_one done elsewhere in the thread.

  [1/9]: sha1_file: replace PATH_MAX buffer with strbuf in prepare_pack=
ed_git_one()
  [2/9]: add strip_suffix function
  [3/9]: implement ends_with via strip_suffix
  [4/9]: replace has_extension with ends_with
  [5/9]: use strip_suffix instead of ends_with in simple cases
  [6/9]: index-pack: use strip_suffix to avoid magic numbers
  [7/9]: strbuf: implement strbuf_strip_suffix
  [8/9]: verify-pack: use strbuf_strip_suffix
  [9/9]: prepare_packed_git_one: refactor duplicate-pack check

-Peff
