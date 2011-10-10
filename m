From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG 1.7.6.1] `git config --bool --get-regexp' omits separating space... sometimes!
Date: Mon, 10 Oct 2011 14:44:44 +0200
Message-ID: <vpq1uulm2wz.fsf@bauges.imag.fr>
References: <201110101220.21890.brian.foster@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 14:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDFE3-00046V-Pb
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 14:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab1JJMoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 08:44:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38854 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab1JJMox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 08:44:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p9ACg5H7030754
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2011 14:42:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RDFDo-0006ss-Ej; Mon, 10 Oct 2011 14:44:44 +0200
In-Reply-To: <201110101220.21890.brian.foster@maxim-ic.com> (Brian Foster's
	message of "Mon, 10 Oct 2011 12:20:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Oct 2011 14:42:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9ACg5H7030754
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318855330.53598@EoTqctGCTErx5LvDgxrh4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183240>

Brian Foster <brian.foster@maxim-ic.com> writes:

> example.boolean
> example.booleantrue

There's a problem in

static int show_config(const char *key_, const char *value_, void *cb)

in builtin/config.c. Patch follows.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
