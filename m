From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 3/3] difftool: Use eval to expand '--extcmd' expressions
Date: Fri, 15 Jan 2010 09:59:15 -0800
Message-ID: <20100115175913.GA21106@gmail.com>
References: <1263539762-8269-1-git-send-email-davvid@gmail.com> <1263539762-8269-3-git-send-email-davvid@gmail.com> <4B502A0C.50108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:59:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqSI-00058f-Bh
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 18:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152Ab0AOR70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 12:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173Ab0AOR70
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 12:59:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:44220 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0AOR7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 12:59:25 -0500
Received: by fg-out-1718.google.com with SMTP id e21so164175fga.1
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ILngiYmYfoKF7JvkJzExBa7h/kjnZbfjyZW68eoxrb0=;
        b=ROp+Iv0fqyBNqF6xj35Si8dCI+zWI/F15BNKYKUIURKPKnXe9OJOjM3ZSO+JNlCQZT
         fKBDMEYEcq7MyzqoGUP5/EXa56Hyk66kq7IOvTjPmuDvfVaWNp1ZIP6N+RjDudy53DUm
         CJnNgtgKR6WB9hqObWh6LfsycCX9FFICOOZig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AvwO09UzevuidF7kQQered0rDyj10DZgxEU5JBEZw3CDSbi8bCL+538aP5n6eAeI/U
         vVesrA+IpZb3LA+yBEp+xRH6PfHOu+0Ny90EJSy3bTVNnmQfhWT/ZrBnPis7t0iRff/M
         R99n055AnWQHf+ynqLbdrOUdGzOlJBHBjH9gM=
Received: by 10.223.4.25 with SMTP id 25mr801787fap.38.1263578364015;
        Fri, 15 Jan 2010 09:59:24 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 22sm2803694fkr.57.2010.01.15.09.59.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 09:59:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B502A0C.50108@viscovery.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137088>

On Fri, Jan 15, 2010 at 09:40:44AM +0100, Johannes Sixt wrote:
> David Aguilar schrieb:
> > -		$GIT_DIFFTOOL_EXTCMD "$LOCAL" "$REMOTE"
> > +		(eval $GIT_DIFFTOOL_EXTCMD "\"$LOCAL\"" "\"$REMOTE\"")
> 
> The new code is broken if $LOCAL or $REMOTE can contain double-quotes. How
> about this alternative:
> 
> 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
> 
> which I find more readable as well.

I'll resend a patch later today (can't quite right now, but will
have time later).

> What's the reason for the sub-shell? Do you want to protect from shell
> code in $GIT_DIFFTOOL_EXTCMD that modifies difftool's variables?
> 
> -- Hannes

None, really, so we can do without that as well.

Thanks for your notes,

-- 
		David
