From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 09:29:52 +0100
Message-ID: <e5bfff550702100029h65d1fd3fke5496da0664642ee@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	 <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	 <Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	 <7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	 <7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	 <7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
	 <e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
	 <7vps8imnis.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 09:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFncL-00075z-E3
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 09:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbXBJI3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 03:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbXBJI3x
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 03:29:53 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:20982 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbXBJI3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 03:29:53 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1035007nze
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 00:29:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SG+rP7ZEMxVBEJM3C27cuP8uSteFvXfeu8+GlQ96nxpIrfpJBUTH2Fx5sGHDPEX3IlJp5msfd3IRbF5RE1Y9z5PfzNAIcg1hrah7ZQahmow6TP/qt0k2W4Irb27atJxj4dTHFMoy44yTIeXim8OozQ+/Mj4iRJvOtQEeum5tXKY=
Received: by 10.114.198.1 with SMTP id v1mr5381006waf.1171096192223;
        Sat, 10 Feb 2007 00:29:52 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 00:29:52 -0800 (PST)
In-Reply-To: <7vps8imnis.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39210>

On 2/10/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Running 'git runstatus' alone shows _all_ the repo files, although are
> > not modified and not touched.
>
> That does not sound right with or without my patch.  Are you
> talking about the 'git runstatus' with my patch is showing
> paths that are cache clean?  If that is the case that means my
> patch is introudcing regression.
>
>
'git runstatus'  shows all the files also _before_ your patch has been
applied (I have tested again now resetting HEAD so to remove your two
patches).

What is strange is that running 'git runstatus' on Linux on a repo
under a ntfs directory shows all the files, while running 'git status'
under windows under the same repo (so now we have write access) shows
things correctly.

It seems that perhaps lstat(2) info of a mounted ntfs directory is not
correct?????? very very  strange!
