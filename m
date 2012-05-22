From: Jeff King <peff@peff.net>
Subject: Re: git-upload-pack stream
Date: Tue, 22 May 2012 14:12:40 -0400
Message-ID: <20120522181240.GA20305@sigill.intra.peff.net>
References: <4FBBC063.3050108@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Tajti =?utf-8?B?w4Frb3M=?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Tue May 22 20:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtZf-00034I-K8
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760049Ab2EVSMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 14:12:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51873
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992Ab2EVSMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:12:42 -0400
Received: (qmail 20862 invoked by uid 107); 22 May 2012 18:13:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 14:13:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 14:12:40 -0400
Content-Disposition: inline
In-Reply-To: <4FBBC063.3050108@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198219>

On Tue, May 22, 2012 at 06:35:47PM +0200, Tajti =C3=81kos wrote:

> when pushing through http git-http-backend gets a stream of object
> when sending the git-upload-packl command. This stream starts with
> two object ids and a branch name. Is there a specification about how
> this streem exactly looks like?

Have you looked at what's in Documentation/technical in the git.git
repository? Specifically, protocol-common.txt and pack-protocol.txt
describe what happens over the regular protocol. The http version of th=
e
protocol just splits that into chunks, but the output that upload-pack
produces is the same.

You mentioned "pushing", though, which does not involve git-upload-pack
at all. Did you mean git-receive-pack? From your description, I guess
maybe you mean the "command-list" lines sent by send-pack to
receive-pack? They are defined pack-protocol.txt. See the subsection
"Reference Update Request and Packfile Transfer" under "Pushing Data to
a Server".

-Peff
