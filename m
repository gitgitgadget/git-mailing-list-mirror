From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Tue, 26 Mar 2013 18:03:02 -0400
Message-ID: <20130326220302.GA8880@sigill.intra.peff.net>
References: <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
 <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net>
 <102DBFFC4475445D9180A9C7D2A9D97C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Mar 26 23:03:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbxw-0001ud-NK
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab3CZWDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:03:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40762 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab3CZWDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:03:07 -0400
Received: (qmail 8794 invoked by uid 107); 26 Mar 2013 22:04:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 18:04:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 18:03:02 -0400
Content-Disposition: inline
In-Reply-To: <102DBFFC4475445D9180A9C7D2A9D97C@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219219>

On Tue, Mar 26, 2013 at 09:59:42PM -0000, Philip Oakley wrote:

> Which way does `git bundle file.bundl --all` perform after the changes
> for both the 'transport' checking and being reliable during updates.

Bundles are treated at a fairly low level the same as a remote who
provides us a particular set of refs and a packfile. So we should get
the same protections via index-pack, and still run
check_everything_connected on it, just as we would with a fetch over the
git protocol.

I didn't test it, though.

-Peff
