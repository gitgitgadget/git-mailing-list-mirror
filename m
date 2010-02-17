From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v2 07/11] notes: implement helpers needed for note copying during rewrite
Date: Wed, 17 Feb 2010 01:09:24 +0100
Message-ID: <201002170109.25211.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch> <b8d8e699a7067f0bb095f4df73966fc61ffeb6c6.1266361759.git.trast@student.ethz.ch> <7v635w20o5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXTy-0006TO-RH
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933709Ab0BQAJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:09:29 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:54014 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933701Ab0BQAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:09:28 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 01:09:26 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 01:09:25 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7v635w20o5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140188>

On Wednesday 17 February 2010 00:58:18 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Implement helper functions to load the rewriting config, and to
> > actually copy the notes.  Also document the config.
> 
> I find it somewhat unnerving that this series is a bit overengineered to
> have fancier and facier handling of notes, while at the same time still
> sticking to the "only one default notes tree" mode of operation.  Are you
> digging a deep hole that you will find hard to get out of when you finally
> need to support copying/rewriting notes from multiple trees at the same
> time?

Hmm, very good point.

I believe the code in this patch is fairly well-prepared to deal with
it.  It would merely need to learn to store a list of trees in the
notes_rewrite_cfg, provided that it's ok to load them all
simultaneously.

However, I haven't really thought about having several notes trees.
Is this automatic copying the only operation that needs this feature,
or were you thinking of others too?  Is it enough to, say, introduce a
way of configuring it at the branch level, or declaring that we
rewrite everything in refs/notes, or some such?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
