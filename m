From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Sun, 02 Dec 2007 11:06:43 -0800
Message-ID: <7veje4ykzg.fsf@gitster.siamese.dyndns.org>
References: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org>
	<1196337638-45972-1-git-send-email-win@wincent.com>
	<7vy7cf87jz.fsf@gitster.siamese.dyndns.org>
	<5B4BC281-10BD-437F-A956-EEB73F40A76C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, dzwell@gmail.com, peff@peff.net,
	Matthieu.Moy@imag.fr
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:07:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyu9t-0001iB-7W
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 20:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbXLBTG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbXLBTG4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 14:06:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39917 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbXLBTG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 14:06:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E52402FA;
	Sun,  2 Dec 2007 14:07:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EF089C247;
	Sun,  2 Dec 2007 14:07:09 -0500 (EST)
In-Reply-To: <5B4BC281-10BD-437F-A956-EEB73F40A76C@wincent.com> (Wincent
	Colaiuta's message of "Sun, 2 Dec 2007 15:11:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66810>

Wincent Colaiuta <win@wincent.com> writes:

> Unless by "documentation" you meant to somehow expose these in the  
> interface at runtime... something like this? (applied on top of the  
> patch I just sent to the list):

I did not recall (and was too lazy to check) if they were documented
already, but as you suggest, I think letting people type ? at the prompt
to get a help is always a good idea.  So, instead of doing this part:

> @@ -308,7 +309,7 @@ sub list_and_choose {
>   			print "> ";
>   		}
>   		else {
> -			print ">> ";
> +			print " (?)>> ";

I'd prefer accepting '?'  as a valid "help me" input and showing
appropriate help for _both_ singleton select and multiple select,
without mentioning " (?)".  For this, your prompt_help_cmd needs to be
enhanced to limit the help to singleton case, though.
