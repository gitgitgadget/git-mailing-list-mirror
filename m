From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use a temporary index for interactive git-commit
Date: Wed, 29 Dec 2010 20:51:26 -0600
Message-ID: <20101230025126.GA1868@burratino>
References: <1293670038-8606-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 03:51:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY8c8-0002Ap-AU
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 03:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab0L3Cvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 21:51:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37183 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab0L3Cvf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 21:51:35 -0500
Received: by vws16 with SMTP id 16so4340182vws.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 18:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=obc0xiiT0dHPzncfnphZOYqLcvofOgVgL22NJlQzx9Q=;
        b=WB4RjXvcmL1pdCNLHcuyULeGJah1DroZdJQAEzRbvPov3yBdXEZ2ZIqg1P7nrCVUr3
         qeMMZvwjR8YdVfffqBUilSaEfSaRnDgJR6lNvNnNH1p9mt3vf0LV79xKCofPE5o5Xipb
         LiqSKiAH+OfcPSsssNHKlQkhUSNhVbv3HGWrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kcKRmPP2tk+E/l6YHR8on3m1KqGdQlzlWkG/afwrWTskXDd7Wqoq1bCDLaYkffVCem
         pmxAD0VcqB1bs5FzWxczblWOKGG9jSk2gJWCk6oS1ZyglDGxGHgDmQMoHCGqIg1XuD1l
         U9a5jhEy5RqGPjkNxSfB8HP39qezJYpXuZAw4=
Received: by 10.220.94.149 with SMTP id z21mr4637376vcm.153.1293677494237;
        Wed, 29 Dec 2010 18:51:34 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id y15sm2750580vch.29.2010.12.29.18.51.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 18:51:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293670038-8606-1-git-send-email-conrad.irwin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164346>

Conrad Irwin wrote:

> I'm not sure that adding parameters to functions willy-nilly is the best
> way of doing this. Can anyone suggest a cleaner mechanism?

Would a simple

	setenv(INDEX_ENVIRONMENT, index_file);

in the caller make sense?
