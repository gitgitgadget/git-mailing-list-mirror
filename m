From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/8] config: Don't return negative exit codes.
Date: Sun, 15 Feb 2009 13:22:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151321310.10279@pacific.mpi-cbg.de>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-6-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 13:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYg1a-0005ZU-1A
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 13:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbZBOMVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 07:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZBOMVh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:21:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:47479 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752395AbZBOMVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 07:21:37 -0500
Received: (qmail invoked by alias); 15 Feb 2009 12:21:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 15 Feb 2009 13:21:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PfutbhamPog2Necwpm9Tqxifxk+MkiLFRtT3/Y8
	MVm6yMyfgNFH8S
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234688460-9248-7-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109998>

Hi,

On Sun, 15 Feb 2009, Felipe Contreras wrote:


>  	else if (actions & ACTION_RENAME_SECTION) {
> -		int ret;
>  		check_argc(argc, 2, 2);
>  		ret = git_config_rename_section(argv[0], argv[1]);
> -		if (ret < 0)
> -			return ret;
>  		if (ret == 0)
>  			die("No such section!");
>  	}

You need an "if (ret > 0) ret = 0;" to avoid regressions.

>  	else if (actions & ACTION_REMOVE_SECTION) {
> -		int ret;
>  		check_argc(argc, 1, 1);
>  		ret = git_config_rename_section(argv[0], NULL);
> -		if (ret < 0)
> -			return ret;
>  		if (ret == 0)
>  			die("No such section!");
>  	}

Likewise.

Thanks,
Dscho
