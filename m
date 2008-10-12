From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/2 v2] check-attr: Add --stdin-paths option
Date: Sun, 12 Oct 2008 18:30:19 +0400
Message-ID: <20081012143019.GE21650@dpotapov.dyndns.org>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com> <48E9B997.1010006@viscovery.net> <20081007001652.GR21650@dpotapov.dyndns.org> <18671.55733.970601.454074@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 16:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp1yy-0000B2-72
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 16:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbYJLOac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 10:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYJLOac
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 10:30:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:29918 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYJLOab (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 10:30:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so920964fgg.17
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mHeVyrFk/rl21RodP3UG4MgHFLITmNvYozLCeMkoGXE=;
        b=qa281GZPF8/iqgYzExN1Fzn3C4jlsIoSUPAhYIKKK3MTM39mcKs3/k77d+pIYrQAN5
         u0q0u8mjEsNkTBXEmVZBB7vrz0RGRUFchsNOBR9pSIqIYqWiNPRSjtx3AkBh9TeQyK/L
         0k9dPZxWQ5tYpB0UY9E26UD0J60T91bKPzxrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NtVSqQ4wGl4HnUEXKNSJQkh9yaFhMvuNO1b2Z3Yksvuqi7GR8oODLICAd+v++uHUPm
         y4T3B/bX8wIWAd4k73NeSnydXR5G1+GP5KOKiwICk2QeBwvkcOSHoB1Rkl9hI1C+bnrq
         fU6MZx46C6x3l6hxcWTdDkxNSl/COtQ7PR+VQ=
Received: by 10.86.65.9 with SMTP id n9mr3972305fga.55.1223821830155;
        Sun, 12 Oct 2008 07:30:30 -0700 (PDT)
Received: from localhost (ppp91-77-162-44.pppoe.mtu-net.ru [91.77.162.44])
        by mx.google.com with ESMTPS id l19sm5575466fgb.7.2008.10.12.07.30.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 07:30:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <18671.55733.970601.454074@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98025>

On Sat, Oct 11, 2008 at 09:39:49AM +1100, Paul Mackerras wrote:
> 
> Actually, what was done with git diff-tree --stdin was to have it do
> fflush(stdout) when it sees a blank line in the input.  That gives the
> calling program a way to get the output up to that point without
> having to do a flush for every line of output.

It is an interesting idea, but I have not seen any other git command
doing so, and my measurement in git repo on Linux have not offered
any noticeable speed-up. So, I am not sure if it is worth it.

Dmitry
