From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 19:09:36 +0000
Message-ID: <200703161909.38662.andyparkins@gmail.com>
References: <20070316042406.7e750ed0@home.brethil> <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com> <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Rocco Rutte" <pdmef@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 20:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSHqr-0000L1-Hr
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 20:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965874AbXCPTMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 15:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965887AbXCPTMa
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 15:12:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:36428 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965874AbXCPTM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 15:12:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so778972uga
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 12:12:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NUByecpuChRk58U+JrAaQWjrnbuhhQ91XY+hofWE6QPU9fJbDj7x/KfXvvegnptYGNzdyzyw9lYm9oQoUYpljiJ3siSxSzYTomXPyNbNiKaY1j6Pmsr78jpfUS+zQcevhGDdxTGqT/WUPSRFmZfcB7/XsyMzSQ3LcRPwKYK/SWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KL8dUEbjSzQSugndI7YWyGj+vjLGeEW/Ff76j6el8T4S3DljfSw5LhXRrRatQYRa93uU8JmD/go+L37pbWdWgNqM6h6+dFxya7Djy096HWcBCInRQjNBuPOrS2FgBI4Renot7xUZi6brLOZnQq9SwO9UFdoOAnxGG599Po4t0jk=
Received: by 10.67.22.2 with SMTP id z2mr4989720ugi.1174072347605;
        Fri, 16 Mar 2007 12:12:27 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 55sm4206590ugq.2007.03.16.12.12.26;
        Fri, 16 Mar 2007 12:12:27 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42395>

On Friday 2007, March 16, Marco Costalba wrote:

> There is no way that a GUI tool is allowed to *freeze* for that
> amount of time. Currently, because an external process is forked when
> running 'git rev-list' all the problem is happly handled by the
> kernel scheduler and the QProcess callback mechanism (based on
> select()). In case of a libified git-rev-list this could be an issue.

I don't think that is ever going to be an issue.  At the worst you could 
just fork() and run the libgit command in that.  Threads are fairly 
easy in Qt as well.

In short, I wouldn't worry about libgit blocking - in fact it's almost a 
guarantee that libgit /will/ block; it would be a nightmare to write an 
asynchronous libgit.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
