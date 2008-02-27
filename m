From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] http-push: add regression tests
Date: Wed, 27 Feb 2008 20:23:34 +0100
Message-ID: <20080227192334.GA1818@localhost>
References: <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org> <20080225232820.GA18254@localhost> <7vprukfttt.fsf@gitster.siamese.dyndns.org> <20080227085442.GA22501@localhost> <alpine.LSU.1.00.0802270947110.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURst-0003dV-LM
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938AbYB0TXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756813AbYB0TXa
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:23:30 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:31066 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbYB0TX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:23:29 -0500
Received: by fk-out-0910.google.com with SMTP id z23so3889495fkz.5
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 11:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=i7mhBT/p+1tnPqF4A97Dyu24VGngs7b7xmZDuY7xt7Y=;
        b=FXpViFb/LSKRRCVWSwQBoYQJojhizCCmdPBuiceWgzFIpwyMBQRFYDFSLdwn2YyYuhThTtoFKsjma8y04N+wXol2rkH4dCm/dbsoM6+N4yn1mYCMlXZVZJmI4xHtWE9cch+iPDS5kaoHc5zzpY5e32sU4ROeunFCtfRsvwYxjks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=E460S1b0yIWe9r0r6GfHzcXN2ShrJShJU1QUwZ5pXmgECljrw4XnDdS5h98uXwJCwtZ/CEHoqtn2ZWufvFF+O7WSkGz1Tlh7wJH/NFGfa936PtQiVBCo6x2cMa0OmjaCO3S84UlOrYEr5K4hjYxl0KYcLaCI5TxVbmSXTdT6xH4=
Received: by 10.82.158.12 with SMTP id g12mr2648080bue.2.1204140206392;
        Wed, 27 Feb 2008 11:23:26 -0800 (PST)
Received: from darc.dyndns.org ( [84.154.73.116])
        by mx.google.com with ESMTPS id y6sm14767619mug.1.2008.02.27.11.23.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 11:23:24 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JURsM-0000ia-Ix; Wed, 27 Feb 2008 20:23:34 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802270947110.22527@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75287>

Hi,

On Wed, Feb 27, 2008 at 09:51:35AM +0000, Johannes Schindelin wrote:
> just rename the variable "GIT_TEST_NET" in lib-httpd.sh to 
> "GIT_TEST_HTTPD".

My intention was to use this variable as a global "enable network testing"
flag, as implicated by Junio. I don't see a real usecase for enabling only
HTTPD tests, as opposed to other networking tests for git-daemon or git-shell,
for example. But here you go.

On Wed, Feb 27, 2008 at 10:16:42AM +0100, Mike Hommey wrote:
> > I wanted to state explicitly that HTTPD_ROOT_PATH and
> > HTTPD_DOCUMENT_ROOT_PATH do not have to be related. I added the -p flag to
> > both commands, however.
> 
> They *are* related, because HTTPD_DOCUMENT_ROOT_PATH is what is in
> httpd.conf, set with the DocumentRoot directive, and it's a path relative to
> HTTPD_ROOT_PATH. And it is set statically to "www".

This dependency can easily be removed by using a symlink. But I don't feel
strongly enough about this point to resist any longer. :-)

Thank you again for your numerous suggestions. I will resubmit both patches in
reply to this message.

Regards,
Clemens
