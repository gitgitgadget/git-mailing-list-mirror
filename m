From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Files with colons under Cygwin
Date: Sun, 5 Oct 2008 11:14:00 +0200
Message-ID: <81b0412b0810050214w15a25e3axfb8bf3ca05ffc215@mail.gmail.com>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
	 <20081004233945.GM21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Giovanni Funchal" <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 11:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmPhs-0004tu-By
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 11:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYJEJOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 05:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbYJEJOD
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 05:14:03 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51173 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYJEJOC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 05:14:02 -0400
Received: by gxk9 with SMTP id 9so4048301gxk.13
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=loT8UfNFFvMqxZAdQxsNwfzGCh/0W7jWVvJy9CJtuXE=;
        b=W28Ds4O/y+azJmiezhyUNbNip6PrUVa6NdlXlF0/vZAmOJpjGDkWg3+9mz3tmQjkwT
         eu9da9SMCXPPxlWQuediDheqae1j8jNcw8HQcPkBWJHyxuAPF4r2hNyoorZdHN+2tplh
         LlAwCijLcxtrUHbgWmgWtckIkP8GqVPzWvOfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ERrOsFZlYhaUESulbncnIRUbtcH+RhEIH7VzditLn2zExopX4EmyZnQC8PTOo8T8ZF
         tsKEffLZL8FMC9otW9HRdEOWdK2ooo32vf5bGyYYAY12qD7ehWMxj7Npj7AND6oYsQSd
         VDhc0GNFJ9QtdiAtcpMV3mC8jF2cY4S8kaNVo=
Received: by 10.100.140.12 with SMTP id n12mr3468298and.78.1223198040303;
        Sun, 05 Oct 2008 02:14:00 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sun, 5 Oct 2008 02:14:00 -0700 (PDT)
In-Reply-To: <20081004233945.GM21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97502>

2008/10/5 Dmitry Potapov <dpotapov@gmail.com>:
> So, here is a patch. It basically disallow backslashes and colons in
> file names on Windows (whether it is MinGW or Cygwin).

With this and sparse checkout patch combined it maybe possible
to make Git work on these backward filesystems in a saner way:
just never checkout the names which the filesystems cannot support
on disk and mark them correspondingly in the index. If at all needed,
the user can fallback to git-show and git-update-index to see the data
and update them in repo. Assumption is that the cases are rare...
