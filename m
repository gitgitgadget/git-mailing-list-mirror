From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Smart-http: check if repository is OK to export
	before serving it
Date: Mon, 28 Dec 2009 07:59:31 -0800
Message-ID: <20091228155931.GC2252@spearce.org>
References: <7vk4w963np.fsf@alter.siamese.dyndns.org> <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com> <1261870153-57572-2-git-send-email-tarmigan+git@gmail.com> <20091227211033.GB609@spearce.org> <905315640912272007i8b4904dv2b93879789b453fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	rctay89@gmail.com, drizzd@aon.at, warthog9@kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 17:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPI0U-0000tC-Vr
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 16:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbZL1P7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 10:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbZL1P7h
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 10:59:37 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:46754 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbZL1P7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 10:59:36 -0500
Received: by ywh6 with SMTP id 6so10486107ywh.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 07:59:35 -0800 (PST)
Received: by 10.150.130.36 with SMTP id c36mr8441883ybd.34.1262015975190;
        Mon, 28 Dec 2009 07:59:35 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 7sm4096483ywf.25.2009.12.28.07.59.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 07:59:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <905315640912272007i8b4904dv2b93879789b453fb@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135744>

Tarmigan <tarmigan+git@gmail.com> wrote:
> On Sun, Dec 27, 2009 at 4:10 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> >> Similar to how git-daemon checks whether a repository is OK to be
> >> exported, smart-http should also check. ?This check can be satisfied
> >> in two different ways: the environmental variable GIT_HTTP_EXPORT_ALL
> >> may be set to export all repositories, or the individual repository
> >> may have the file git-daemon-export-ok.
...
> I've been thinking that the not_found() to a forbidden() instead.

Oh.  Interesting question.

Because you can't resolve the access error by authenticating to
the server, we may actually want to just return not_found() here
with a message in the log of "Repository not exported: '%s'".

That would mirror the behavior of git-daemon.

-- 
Shawn.
