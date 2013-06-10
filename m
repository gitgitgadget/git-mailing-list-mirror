From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 16:41:24 -0400
Message-ID: <20130610204123.GB13333@sigill.intra.peff.net>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
 <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
 <7vd2rvqgra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 22:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um8uG-0006ix-5C
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 22:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab3FJUla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 16:41:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:48034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab3FJUl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 16:41:28 -0400
Received: (qmail 30963 invoked by uid 102); 10 Jun 2013 20:42:19 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 15:42:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 16:41:24 -0400
Content-Disposition: inline
In-Reply-To: <7vd2rvqgra.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227373>

On Sun, Jun 09, 2013 at 11:30:01AM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] test: test_output_must_be_empty helper
> 
> There are quite a lot places where an output file is expected to be
> empty, and we fail the test when it is not.  The output from running
> the test script with -i -v can be helped if we showed the unexpected
> contents at that point.
> 
> We could of course do
> 
>     >expected.empty && test_cmp expected.empty actual
> 
> but this is commmon enough to be done with a dedicated helper.

Thanks, I think this improves the readability of the test suite (and its
output when there are failures).

You can also do:

  test_cmp /dev/null actual

for the same effect, but I guess the diff is not all that interesting
(by definition, it would consist only of added lines, and you are
already showing them, so it would not be an improvement).

-Peff
