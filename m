From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Mon, 12 Nov 2012 12:20:56 +0100
Message-ID: <EA56F0CC-7C93-491F-A076-4A1AA9593ED0@quendi.de>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-12-git-send-email-felipe.contreras@gmail.com> <29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de> <CAMP44s0o1eP+aeT0AHu4uP1NPLqJq56qUDb-+F_x5NjoJCnf+A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXs54-0003d7-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 12:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab2KLLVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 06:21:16 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:45899 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386Ab2KLLVP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 06:21:15 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TXs4W-0003EK-Ck; Mon, 12 Nov 2012 12:20:56 +0100
In-Reply-To: <CAMP44s0o1eP+aeT0AHu4uP1NPLqJq56qUDb-+F_x5NjoJCnf+A@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1352719275;cb23dcdd;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209474>


On 11.11.2012, at 22:22, Felipe Contreras wrote:

> On Sun, Nov 11, 2012 at 9:49 PM, Max Horn <max@quendi.de> wrote:
>> 
>> On 11.11.2012, at 14:59, Felipe Contreras wrote:
>> 
>>> People seeking for reference would find it useful.
>> 
>> Hm, I don't understand this commit message. Probably means I am j git fast-export --use-done-featureust too dumb, but since I am one of those people who would likely be seeking for reference, I would really appreciate if it could clarified. Like, for example, I don't see how the patch below makes anything "clear", it just seems to change the "import" command of git-remote-testgit to make use of the 'done' feature?
> 
> No, the done feature was there already, but not so visible: git
> fast-export --use-done-feature <-there. Which is the problem, it's too
> easy to miss, therefore the need to make it clear.


Aha, now I understand what this patch is about. So I would suggest this alternate commit message:

  remote-testgit: make it explicit clear that we use the 'done' feature

  Previously we relied on passing '--use-done-feature ' to git fast-export, which is
  easy to miss when looking at this script. Since remote-testgit is also a reference
  implementation, we now explicitly output 'feature done' / 'done' to make it
  crystal clear that we implement this feature.


Or perhaps a little bit less verbose. With a commit message like the above, I think I would have grokked the patch right away. With the original message, that was not the case (else I wouldn't have wrote my initial email). And even though I now understand (or at least believe to understand) the patch, I don't think the original message is that helpful... indeed, "make clear the 'done' feature" is ambiguous. You meant it as "make clear the 'done' feature is implemented / used", while I understood it as "make clear what the 'done' feature is about". Looking at the patch can help to resolve that, but (a) my wrong interpretation threw me off-track and (b) I thought that the point of commit messages was to give an overview of a patch without having to look at it...
So at the very least, the message should explain what exactly is "made clear".

Anyway, a small change to the commit message hopefully will not be a problem. :-)


Cheers,
Max