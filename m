From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 14:10:26 +0100
Message-ID: <20130614130910.GF23890@serenity.lan>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTm2-0006wf-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab3FNNKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:10:34 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:33539 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3FNNKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:10:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 23BBECDA5D1;
	Fri, 14 Jun 2013 14:10:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tc9b0ZmB2w2e; Fri, 14 Jun 2013 14:10:32 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 68477CDA5A9;
	Fri, 14 Jun 2013 14:10:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227823>

On Fri, Jun 14, 2013 at 06:13:33PM +0530, Ramkumar Ramachandra wrote:
> The following command
> 
>   $ git format-patch -o outgoing master
> 
> does not ensure that the output-directory outgoing doesn't already
> exist.  As a result, it's possible for patches from two different series
> to get mixed up if the user is not careful.  Fix the problem by
> unconditionally removing the output-directory before writing to it.

I don't think this is the correct behaviour.  I can think of cases where
I would want to output multiple things into the same directory.

It may be better to issue a warning when this happens, or die and
provide a flag to let the user bypass that.
