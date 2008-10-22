From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Wed, 22 Oct 2008 21:04:34 +0700
Message-ID: <fcaeb9bf0810220704o7a0ed177u48dcada9391ec626@mail.gmail.com>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
	 <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
	 <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 22 16:06:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KseLL-0006VH-Qf
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 16:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYJVOEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 10:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbYJVOEj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 10:04:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:24465 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYJVOEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 10:04:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1430854nfc.21
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1OW1HbhPxy51x54JnYWCtdv1cK6RKSv2ragH/c848Yc=;
        b=tSFreyOV1N/6WFTLwK0+Xyt+N5BmoNCMLaP9cFF1T+58SuZV1+Y4eTtzv41937bEIn
         2gpEhSzS9T/vN4MXI2Q2JacBjPE1TDPhrFHffW2iM1HGVeprEJPGWV5yiKNRNrqv1TCr
         fETifYcj/m6tB1xPh3qV7eE6yguv+4cgTec1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xIrKMimoVvTueDwqRDnzhn1PDAVL1b8znJvoqQRJKAOMhY2i9XrGUFX/X8P6Hgk7IA
         x5rXX420ICfM38zJmfPAzSQZmxx3c6knQKnj3HEo2v5f7X4mD3mPq+8+lGFUDbPvUAuO
         khA4x4rnxEct0C+++pxqjFvjThuvrD7z1Smjc=
Received: by 10.86.4.14 with SMTP id 14mr1053509fgd.20.1224684274299;
        Wed, 22 Oct 2008 07:04:34 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Wed, 22 Oct 2008 07:04:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98868>

On 10/22/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  So I propose this change in semantics:
>
>  - setup_git_directory_gently(): rename to discover_git_directory(),
>   and avoid any chdir() at all.
>  - setup_git_directory(): keep the semantics that it chdir()s to the
>   worktree, or to the git directory for bare repositories.
>
>  Using _gently() even for RUN_SETUP builtins should solve the long standing
>  pager problem, too.

One more thing: "git foo -h" with RUN_SETUP won't run if repository is
not found. Maybe just drop RUN_SETUP and let subcommands call
setup_git_directory()
-- 
Duy
