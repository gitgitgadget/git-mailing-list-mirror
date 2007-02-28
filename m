From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 1 Mar 2007 00:36:17 +1300
Message-ID: <46a038f90702280336k6d368b8aj88ce8d3d822b1789@mail.gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
	 <200702271345.09341.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 12:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMN6l-00083v-0N
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 12:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbXB1LgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 06:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbXB1LgT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 06:36:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:3487 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbXB1LgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 06:36:18 -0500
Received: by nf-out-0910.google.com with SMTP id o25so524122nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 03:36:17 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KBN2QUBTcTw0+JVO62xD4aLC48Vkx4AkGn6wM9194LRLxaUX7FnRuc/f8wiVRgsf3BxI8x4FenjRMhkJ4Blq9OJVUQLWDSoCQowra0cAiAVV7GLKHl3EZ9ZJ8jVoBbYPwKNfDzqOKl/MzxBsDt4HvWrfn5a+GdE3Z8ymp8WWgIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N1kfWU+pwTe/ZHOPkgJXmPnOngHU/mJISFRrUteIYK78p+r0GmK7AcJvGglRbjTnlFZiIj65sueitT5L7XvoUPFa1ikkrGICCnQ8+YPQ8kIzMNwJfeoJF+5BnEknVMuvOm18opv+oFyHCAx5sHYE9fbO3FcUkqgylkluQKLiav8=
Received: by 10.48.48.13 with SMTP id v13mr3405359nfv.1172662577312;
        Wed, 28 Feb 2007 03:36:17 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Wed, 28 Feb 2007 03:36:17 -0800 (PST)
In-Reply-To: <200702271345.09341.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40915>

On 2/28/07, Andy Parkins <andyparkins@gmail.com> wrote:
> The config option gitcvs.allbinary may be set to force all entries to
> get the -kb flag.

Hi Andy,

I am a bit confused here... why would we want to do this? We don't
want to support keyword expansion, and that happens at the server end
anyway. CVS clients are pretty dumb and will just write out the file
we give them. When we are going to diff, they send the file to the
server, and the server runs the diff. Etc. No smarts at the client end
that care about -k options.

Or are you trying to control newline mangling on Windows/Mac clients?
I'm not even sure where that mangling happens. If that's the case, a
repo-wide toggle is useless, you really want the per-file-type rules
you mention.

dazed and confused...



martin
