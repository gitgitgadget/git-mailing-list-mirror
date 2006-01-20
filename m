From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] DT_UNKNOWN: do not fully trust existence of DT_UNKNOWN
Date: Fri, 20 Jan 2006 16:01:46 +0100
Message-ID: <81b0412b0601200701n76f1d912y4671c6800735cd0d@mail.gmail.com>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	 <7voe277lbe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Fri Jan 20 16:01:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezxlw-0000Jy-M3
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 16:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWATPBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWATPBt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 10:01:49 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:837 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751035AbWATPBt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 10:01:49 -0500
Received: by uproxy.gmail.com with SMTP id s2so29418uge
        for <git@vger.kernel.org>; Fri, 20 Jan 2006 07:01:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwmYEvaLtgouEHM2M+wA2n/1MxPLLHBP3vkLm2flASj8SpmUmqJRAE4T/ZjeJHESvD9Y4EhhoTJ8dj3465TgQbN1S+e0ttdIs1j37O0+Wzt1z6jArJuW+BSAof+rHgdcsdWCu3DBq6k8pS1YdWGrYo9ujmsf49D1JS6OoXLyc1w=
Received: by 10.49.87.4 with SMTP id p4mr147604nfl;
        Fri, 20 Jan 2006 07:01:46 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Fri, 20 Jan 2006 07:01:46 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe277lbe.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14964>

On 1/20/06, Junio C Hamano <junkio@cox.net> wrote:
> The recent Cygwin defines DT_UNKNOWN although it does not have d_type
> in struct dirent.  Give an option to tell us not to use d_type on such
> platforms.  Hopefully this problem will be transient.

You still have to #undef all the DT_ macros if you have a somewhat old Cygwin
(before Christopher removed the macros).
