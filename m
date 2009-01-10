From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: SSH_ASKPASS
Date: Sat, 10 Jan 2009 21:02:12 +0300
Organization: HOME
Message-ID: <200901102102.12821.angavrilov@gmail.com>
References: <1231584934701-2137400.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:03:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLiBD-0003Os-Nb
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 19:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZAJSCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 13:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbZAJSCG
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 13:02:06 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:14363 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbZAJSCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 13:02:05 -0500
Received: by fk-out-0910.google.com with SMTP id 18so5031701fkq.5
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Z4VNvtScbiB+MCOXXRc3GNX6Vj4K7Ln/bzZRsaonH+o=;
        b=iTyL8rQXulgnO15MpZfm7ISJhP/D02w6NJ+WugZ9zFt9B9TqrPaNhel1NAbbT6QpWJ
         WFhWyzbppGEmtpoaewpC7ukN0syXHK7T87II4gFBkHq/VYtIU6YbNz7UKlfiXRwjXoC7
         5UVknfN0q6LRvhslqM03+F5TncL3uGu6/iLo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xRF1BojsgW2u7xW2dhTGj9bF+JAi5Ea/qaTmwYGh4Gqei4C1kLKEcb1OmcvAOKSXAc
         FvfRUroGlbYK1dthq3s3Ht/B0ohLcdfCm0uxageXatVj4/+DlarfmMOfNyO6mR/M3HD0
         nbsOVTTI0q2aFMZxzt2b3K92MNdKR/gA3QEzM=
Received: by 10.181.153.12 with SMTP id f12mr10232872bko.132.1231610522702;
        Sat, 10 Jan 2009 10:02:02 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id b17sm25396998fka.15.2009.01.10.10.02.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 10:02:02 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.9-159.fc10.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <1231584934701-2137400.post@n2.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105135>

On Saturday 10 January 2009 13:55:34 Henk wrote:
> I'm trying to get "git push" to use git-gui--askpass to ask me for the
> password instead of promting me on the command promt. I need this because I
> start the "git push" command from code and there is no terminal where ssh
> can ask the user for a password. I tried writing the following tcl script
> that allmost is what I need:
> 
> set env(SSH_ASKPASS) "C:/Program
> Files/Git/libexec/git-core/git-gui--askpass"
> exec ssh git@github.com
> 
> Ssh will now ask me for the password using git-gui--askpass. But now the
> standardout is also shown in a dialog, and not on the standardout of the
> process. Looking at the git-gui scripts didn't help me, because I have
> absolutely zero experience in tcl.
> 
> I also tried not using a tcl script, but setting SSH_ASKPASS as an
> environment variable in windows. This doesn't seem to work, ssh will still
> prompt me for a password. 
> 
> Anyone can help me write a script that asks for the password using
> SSH_ASKPASS but still prints the output on standardout? 

OpenSSH won't even try to use SSH_ASKPASS if it has access to a terminal.
Tcl makes it work precisely because the Tcl interpreter is a GUI application
that is detached from the console.

You should set the SSH_ASKPASS variable, and try running the commands as
you actually plan to do it from your code.

Alexander
