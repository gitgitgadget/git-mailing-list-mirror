From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Tue, 10 Aug 2010 11:52:40 -0400
Message-ID: <20100810155240.GA5116@localhost.localdomain>
References: <i3pdkj$hut$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 17:52:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oir8F-0003gk-Rz
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 17:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab0HJPwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 11:52:46 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45070 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154Ab0HJPwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 11:52:45 -0400
Received: by qwh6 with SMTP id 6so8342742qwh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eneYcxvOLSoBVYZeu/68VRfLvqIpDbhk6o+aX8uvSkU=;
        b=ivZ4nA1OcFCaHz4wgYvZe6glb7xDMOCiBpPSF4onMIVlIwnzEImvxhw6nrqBorVAch
         SzN1QUVNz8jNiO3mo3xIdYsxRXOEhiFjTajlpMyWLkUlqXiyZinKOTU/jpaeUMaaBsqB
         3BaaEGiROaeC1Cb7aPTxd8hiEQRKJ7oUVWrSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yEyEH/XiX6dRXL7kKjzJtTlgAAt4wSd20PODFNKhq0wYm9gu5LS5u4T6JQYI2Uk98R
         y3Yp13zPHoJZm1NuLrQlqTgZGpg4tMkymjYJzWuKmksV9B5axsfT+DXOzNtPZoB98Sh0
         4kkgK+XffsLPl0nRMRav38hVlakn+zQMUlRyE=
Received: by 10.224.65.81 with SMTP id h17mr9643612qai.386.1281455564409;
        Tue, 10 Aug 2010 08:52:44 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id l8sm598813qck.30.2010.08.10.08.52.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 08:52:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i3pdkj$hut$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153123>

On Mon, Aug 09, 2010 at 07:24:35PM +0200, Ralf Ebert wrote:
> old: Not a git repository (or any of the parent directories): .git
> new: Not in a git repository: /home/bob/somefolder

Don't we lose information here? Perhaps print the value of
DEFAULT_GIT_DIR_ENVIRONMENT.

> old: Not a git repository (or any parent up to mount parent /home/bob)
> old: Stopping at filesystem boundary
> (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
> new: Not in a git repository: /home/bob/somefolder
> new: (stopped searching at /home because
> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set)

This certainly looks good, but some people might not realize /home is
a filesystem boundary (perhaps those who had someone else set up their
system and don't know their partition setup. I suggest:

(stopped searching at the filesystem boundary, /home, because
GIT_DISCOVERY_ACROSS_FILESYSTEM is not set)
