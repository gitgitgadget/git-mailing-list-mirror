From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 14/15] fast-export: make sure updated refs get updated
Date: Sun, 11 Nov 2012 21:43:26 +0100
Message-ID: <D39D26A9-16B4-4A9F-9102-BD2C92FA10AF@quendi.de>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-15-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
X-From: git-owner@vger.kernel.org Sun Nov 11 21:52:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXeVc-0002uK-0P
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 21:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab2KKUvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 15:51:42 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:35092 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753074Ab2KKUvk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 15:51:40 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.28]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TXeNL-0008Jk-2w; Sun, 11 Nov 2012 21:43:27 +0100
In-Reply-To: <1352642392-28387-15-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1352667100;292a60d9;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209447>


On 11.11.2012, at 14:59, Felipe Contreras wrote:

> When an object has already been exported (and thus is in the marks) it's
> flagged as SHOWN, so it will not be exported again, even if in a later
> time it's exported through a different ref.
> 
> We don't need the object to be exported again, but we want the ref
> updated, which doesn't happen.
> 
> Since we can't know if a ref was exported or not, let's just assume that
> if the commit was marked (flags & SHOWN), the user still wants the ref
> updated.
> 
> IOW: If it's specified in the command line, it will get updated,
> regardless of wihether or not the object was marked.

Typo: wihether => whether

> 
> So:
> 
> % git branch test master
> % git fast-export $mark_flags master
> % git fast-export $mark_flags test
> 
> Would export 'test' properly.
> 
> Additionally, this fixes issues with remote helpers; now they can push
> refs wich objects have already been exported, and a few other issues as

Typo: wich => which


Cheers,
Max
