From: Jeff King <peff@peff.net>
Subject: Re: Question about include feature in .gitconfig
Date: Wed, 4 Apr 2012 17:15:04 -0400
Message-ID: <20120404211504.GA19421@sigill.intra.peff.net>
References: <CALOHgxG2q_6EN5HFs=btX2hF4jC7AaJuMu=2AqbCeZBD+wNj3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Shouichi KAMIYA <shouichi.kamiya@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:15:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXXu-00005m-V1
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2DDVPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 17:15:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46243
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100Ab2DDVPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 17:15:07 -0400
Received: (qmail 14543 invoked by uid 107); 4 Apr 2012 21:15:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Apr 2012 17:15:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2012 17:15:04 -0400
Content-Disposition: inline
In-Reply-To: <CALOHgxG2q_6EN5HFs=btX2hF4jC7AaJuMu=2AqbCeZBD+wNj3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194743>

On Thu, Apr 05, 2012 at 06:09:41AM +0900, Shouichi KAMIYA wrote:

> I have a question about "include" feature in config file.
> In .gitconfig I included .my_super_secret_file like below.
> 
> # .gitconfig
> [include]
>     path = .my_super_secret_file
> 
> # .my_super_secret_file
> [github]
>     password = foobar
> 
> Now, my question is return value of "git config --global github.password".
> I expect it to return foobar but it returns nothing. Is this behavior expected?

Yes, that's the expected behavior. Includes are not followed by default
when you ask for the value from a _specific_ file, as you do with
"--global".

If you do "git config github.password", you will get the answer you
want. You can also use "git config --includes --global github.password"
if you want to search only ~/.gitconfig, but following includes.

-Peff
