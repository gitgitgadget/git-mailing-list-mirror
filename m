From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: remove another ternary expression always evaluating
 to true
Date: Thu, 8 Aug 2013 23:36:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1308082335050.24252@s15462909.onlinehome-server.info>
References: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com> <alpine.DEB.1.00.1308082257580.24252@s15462909.onlinehome-server.info> <52040C18.4030306@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens.Lehmann@web.de, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Xsp-00025c-1h
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966754Ab3HHVgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:36:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:57890 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966743Ab3HHVga (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:36:30 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MfSrf-1VWduB40EN-00P8OC
 for <git@vger.kernel.org>; Thu, 08 Aug 2013 23:36:29 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <52040C18.4030306@googlemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:h9wNFA0v10oVIRgBvzxuCXwV1bkGHbdPDZsDwiVTcpUWRUBUcG/
 hCegKdOZJa6cxszLJsorHIzGz65hbdkUXy62eqkpMrUWx2/7+NMYqQwFJvzwmE3KNJuBwng
 oY35UQZsChsN/o2qA2V9BYlVvbtZS7La7VYanP9ihq7WQC3nmaGcFYlIHIvA+gRUn7IaXYx
 EeejQ4l69JZqZsB4Fdy3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231939>

Hi Stefan,

On Thu, 8 Aug 2013, Stefan Beller wrote:

> So you rather propose to have 
> -		show_submodule_summary(o->file, one ? one->path : two->path,
> +		show_submodule_summary(o->file, one->path ? one->path : two->path,

I do. The reason is that one->path could be NULL (but not both one->path
and two->path) and the summary would not be as helpful as possible if it
wrote "(null)" instead of the path of the submodule.

Ciao,
Johannes
