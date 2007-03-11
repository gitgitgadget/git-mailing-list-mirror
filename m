From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 08:26:30 +0000
Message-ID: <200703110826.39283.andyparkins@gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx> <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 09:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQJQy-0005dR-Bg
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 09:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbXCKI3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 04:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXCKI3a
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 04:29:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:44353 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbXCKI33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 04:29:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1848421uga
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 00:29:28 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mQtcSaJ1uo24tIPkJuDNATI6Mn5Hh83/Yg98fS8v3SWwXelwXFuX/nGLoDXG4oEB9X4N5DA28+r4+AUw5whUsBzQBfOoW1bx6xP6XPk2v8JWrcDFQU1ZCTSBfiQJ4z1748p+//ez+ceW/jEagXJtIdvSACX2h6VCNoXLY9MqsmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=q6O6yqCVG7GoD7n3/AxEujM1Ja4Tk98pBUdDBoPXtWjHchgCjCN02fRpylTUqR7yfJxHYcVHB0EJges7Y60pxJf4pVkwotsCiXmKU2I0Tofh2WiCdezSM5Y1T2vK1qNcnhUi94rUCYkspNaHS48naPUa5sNif7yUnMJ5GV4sEz4=
Received: by 10.67.119.13 with SMTP id w13mr14331778ugm.1173601767987;
        Sun, 11 Mar 2007 00:29:27 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm6639706ugd.2007.03.11.00.29.26;
        Sun, 11 Mar 2007 00:29:27 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41915>

On Sunday 2007, March 11, Junio C Hamano wrote:

> What's the real motivation behind all this?

Coincidentally, I found I was needing this feature just yesterday.

I wanted to keep random configuration files in a repository.  I didn't 
want the directory structure though.  The config files are, of course, 
in my home directory, however I didn't want the danger of putting 
a .git that low in my hierarchy.  Having a .git that is findable from 
any location in my tree seems a bad idea.

So; I put the repository somewhere else and set GIT_DIR.  However that 
scuppered my plans.  Trying to add a config file results in "not in a 
working directory" (of course), because even though git can find the 
repository, it has no way of knowing which directory to consider as the 
root of the working tree.

Let me put this in command form for you:

 $ cd $HOME
 $ export GIT_DIR=$HOME/gitrepos
 $ git init
 $ git add .bashrc
 fatal: add must be run in a work tree

Being able to set GIT_WORKING_DIR would have let me do this.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
