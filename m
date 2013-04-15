From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 19:25:32 -0400
Message-ID: <20130415232532.GA7134@sigill.intra.peff.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 01:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URsmO-0000KE-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604Ab3DOXZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:25:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47223 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839Ab3DOXZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:25:38 -0400
Received: (qmail 30637 invoked by uid 107); 15 Apr 2013 23:27:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 19:27:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 19:25:32 -0400
Content-Disposition: inline
In-Reply-To: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221330>

On Mon, Apr 15, 2013 at 01:28:53PM -0700, Junio C Hamano wrote:

> [Graduated to "master"]
> [...]
> * jk/http-error-messages (2013-04-06) 9 commits
>   (merged to 'next' on 2013-04-11 at 7a03981)
>  + http: drop http_error function
>  + remote-curl: die directly with http error messages
>  + http: re-word http error message
>  + http: simplify http_error helper function
>  + remote-curl: consistently report repo url for http errors
>  + remote-curl: always show friendlier 404 message
>  + remote-curl: let servers override http 404 advice
>  + remote-curl: show server content on http errors
>  + http: add HTTP_KEEP_ERROR option
> 
>  Improve error reporting from the http transfer clients.

I had not been keeping tabs on the progress of this topic, and was
surprised to see it in master already. It hadn't gotten any comments, so
I sort of assumed I would need to re-post to get interest. I don't mind,
but...

...the tip of your current master does not currently pass the test
suite[1]. I bisected the problem to "show server content on http
errors" from the above topic, but haven't figure it out past that. I
typically run "make test" before submitting, so I'm guessing it is an
interaction with another topic that graduated around the same time
(though it's also possible that I just failed to test after the last
rebase).

I'll investigate further, but it may be a few hours.

-Peff

[1] I know you always test master before pushing it out, but I suspect
    you do not run the GIT_TEST_HTTPD tests. The failures are in t5541
    and t5551.
