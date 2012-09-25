From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [RFC/PATCH] git: expand user path in --git-dir
Date: Tue, 25 Sep 2012 07:33:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209250732150.25195@nerf07.vanv.qr>
References: <5060588D.3080202@drmicha.warpmail.net> <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 07:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGNmF-00084H-2B
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 07:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab2IYFdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 01:33:37 -0400
Received: from ares07.inai.de ([5.9.24.206]:38324 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981Ab2IYFdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 01:33:36 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 8548C96A0C99; Tue, 25 Sep 2012 07:33:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 7D97B96A07C5;
	Tue, 25 Sep 2012 07:33:35 +0200 (CEST)
In-Reply-To: <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206347>


On Monday 2012-09-24 14:57, Michael J Gruber wrote:

>Currently, all paths in the config file are subject to tilde expansion
>for user paths while the argument to --git-dir is not expanded, and
>neither are paths in the environment such as GIT_DIR. From the user
>perspective, though, the two commands
>
>GIT_DIR=~user/foo git command
>git --git-dir=~user/foo command
>
>currently behave differently because in the first case the shell would
>perform tilde expansion, but not in the second.

If git uses a standardized option logic (getopt-like) which accepts
both '=' and (new argument) for long options, you could easily do

	git --git-dir ~user/foo command
