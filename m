From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Make update verbose for up to date path
Date: Tue, 04 Mar 2008 12:31:03 -0800
Message-ID: <7v7igi5j08.fsf@gitster.siamese.dyndns.org>
References: <1204642691-3220-1-git-send-email-pkufranky@gmail.com>
 <alpine.LSU.1.00.0803041503360.22527@racer.site>
 <46dff0320803040803v2f93d749t6b45fc8e47e66d21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWdoC-0003rp-Ti
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 21:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933706AbYCDUbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 15:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764409AbYCDUbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 15:31:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764421AbYCDUbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 15:31:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 838E03DEC;
	Tue,  4 Mar 2008 15:31:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BB8173DEA; Tue,  4 Mar 2008 15:31:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76133>

"Ping Yin" <pkufranky@gmail.com> writes:

> When i run 'git submodule update' in a repository whose submodules are
> all clean, there is not any output which makes me not know whether
> this command are successful. I think this is not friendly.

Not at all.  If you are unsuccessful and did not issue an error message,
you have a bug to fix.

When a command finishes successfully doing what it was asked to do,
especially when it does a lot of things and has potential to issue useful
error messages and warnings to some but not all of them, it should stay
quiet for successful ones unless there is a very good reason not to.  The
reasons may include "the user told it to be chatty with --verbose", "it
may make the user think it hang, because it takes a long time", and
perhaps "it is a rare thing to run and the user may not be familiar with
how it acts".
