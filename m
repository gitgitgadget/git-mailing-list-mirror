From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [WIP/RFC PATCH] Support showing notes from more than one notes tree
Date: Sat, 20 Feb 2010 16:23:58 +0100
Message-ID: <201002201623.59179.trast@student.ethz.ch>
References: <7v7hqcww7z.fsf@alter.siamese.dyndns.org> <8c3f1d66d306747d777f04621f1d43d7e07ddc6a.1266677264.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 16:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NirC0-0002hF-Pv
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 16:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab0BTPYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 10:24:23 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:29394 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754325Ab0BTPYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 10:24:22 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 16:24:21 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 16:23:59 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <8c3f1d66d306747d777f04621f1d43d7e07ddc6a.1266677264.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140532>

On Saturday 20 February 2010 15:58:47 Thomas Rast wrote:
> My actual intent was to allow more than one notes.displayref config
> setting, and loading all of them.  But this doesn't seem to work; a
> debugging print confirms that notes_display_config sees the entry, but
> another debugging print shows that it only ever loads one of them.
> What am I doing wrong?

Ah, figured that out myself: for_each_glob_ref has the logic of --glob
to attach /* if there are no globbing characters.  So I'll add some
code to skip for_each_ref and enter it in the list directly if there
is nothing to glob.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
