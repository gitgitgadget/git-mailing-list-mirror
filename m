From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .git/info/refs
Date: Fri, 26 Jan 2007 18:06:36 +0100
Message-ID: <200701261806.37488.jnareb@gmail.com>
References: <45B70D06.3050506@zytor.com> <7vireuxbel.fsf@assigned-by-dhcp.cox.net> <45BA2ED2.7080807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 18:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAUXK-0007zt-4Q
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 18:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030865AbXAZRFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 12:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030873AbXAZRFe
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 12:05:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:30375 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030861AbXAZRFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 12:05:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so766280uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 09:05:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YP56yY6w7EHoqaFFgGg4AKVThCypa4lFm7vCosswZoRf0Wrl1OCr4WCiAJJLEsu1uKjgv3Iy8DElG71k3QZ0aZksxAm11KwyFF/876FoS6Qo4ajf6OBAMLC64PXUtu/PT6KxxAkw9USW4bs0FYrnScawY8WtZDheWRbF+C37cBU=
Received: by 10.67.119.9 with SMTP id w9mr4584874ugm.1169831130976;
        Fri, 26 Jan 2007 09:05:30 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id s1sm3921574uge.2007.01.26.09.05.29;
        Fri, 26 Jan 2007 09:05:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <45BA2ED2.7080807@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37874>

H. Peter Anvin wrote:
> Junio C Hamano wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>> 
>>> For heaven's sake, in computer science we can *NEVER* use the same
>>> feature for *MORE THAN ONE THING*.  If it doesn't work format-wise
>>> that's fine, but "it's only supposed to be used by dumb transports" is
>>> ridiculous.

Please, for the future, mark irony if it might be mistaken...
 
>> Hmmmm... I am lost here....
>
> Jakub and Johannes seems to have been arguing that "info/refs is for 
> dumb transports, therefore it cannot be used for any other purpose."  I 
> find this argument utterly bizarre, since in general, in computer 
> science, you try to be multipurpose whenever practical.

First, changing info/refs format _might_ break fetch related scripts,
which rely on git-peek-remote / git-ls-remote / info/refs format.

Second, it is a bit impractical because info/refs contain (and must
contain) also _tags_ information (which is not needed for gitweb
"Last Change" field in projects list) and referenced object for
those tags. Tags need not to point to commits, nor dereference
to commits: for example in git.git tags v1.0rc1 to v1.0rc6 points
to other tags, and junio-gpg-pub point to out-of-tree blob (which
does not have any "commit time" associated). So what to write there
in the "commit time" field? What to write in "commit time" for tags?
-- 
Jakub Narebski
Poland
