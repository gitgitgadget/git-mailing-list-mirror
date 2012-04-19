From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in prepare_shell_cmd
 on Windows
Date: Thu, 19 Apr 2012 07:36:19 +0200
Message-ID: <4F8FA453.8050807@viscovery.net>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org> <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca> <4F8D15B9.70803@viscovery.net> <20120417221449.GC10797@sigill.intra.peff.net> <4F8E539F.7030902@viscovery.net> <7vobqpknoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	jrnieder@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 07:36:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKk2j-0001Zl-2o
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 07:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2DSFg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 01:36:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59784 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562Ab2DSFg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 01:36:26 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SKk2W-0000Ec-8o; Thu, 19 Apr 2012 07:36:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C96401660F;
	Thu, 19 Apr 2012 07:36:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7vobqpknoq.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195922>

Am 4/18/2012 18:30, schrieb Junio C Hamano:
> There is one thing I am confused about your response, though.  I thought
> the suggestion by Peff was to build your binary with "make SHELL_PATH=sh"
> (not "make SHELL_PATH=/bin/sh").  I do not know if that works or does not
> work (I do not see why not, though), but in either case offering a new
> customization point sounds like a separate issue.

I tried this, and it does not work. (Shell scripts' shbang line would end
up as '#!sh', and at least bash does not like to run such scripts.)

The alternative is to customize the -DSHELL_PATH=... compiler option for
Windows, and that is primarily what I don't like: It would mean that
either the name "SHELL_PATH" has different meaning in C code and the
Makefile, or we need a new name for the C macro. (The latter would be "a
new customization point".)

I learn from this conversation that I should note failed alternatives more
frequently in the commit message to save reviewers' time.

-- Hannes
