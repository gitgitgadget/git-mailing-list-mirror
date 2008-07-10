From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: Bug: /usr/local/bin/git-daemon starts /usr/sbin/git-upload-pack?
Date: Thu, 10 Jul 2008 09:32:06 +0200
Message-ID: <200807100932.06569.brian.foster@innova-card.com>
References: <200807092220.10655.J.Wielemaker@uva.nl>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Wielemaker <J.Wielemaker@uva.nl>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqeZ-0001Sf-BI
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbYGJHc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbYGJHc1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:32:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:46313 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYGJHcZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 03:32:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1318540fgg.17
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=xAIHfbkMn84nephlXTa86UANiq6nyGwdL/Wmi2pt+EY=;
        b=PA89mr9y7R+fG9QkTh5q0YixLPHknurCQEjaRTeBCUz6fdr+GIccLvtPRU/OBY4xxo
         8ue4Ngg68B3VOpsgaAriIA/eO6OavZOX6vAoE/3ChOMVfuYL+7vCu2yNcDMIDMZ5aYeo
         DXRjYuDT8AC7zGg+1Dj42Q8g7VVVnqnqBmCY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=rZKitACCQinCwPpBSvSzFtLW7QAnTsDh/D4MOwTMC+iOXpDiu1ujkzhnEzBTNsHTOh
         9hnO5NnSkADkYirMNxca+SDjHYQcOkPZo5dT7xgIygukTqjcdxA088G0EGunXsNbVb0K
         cONCo3kPbcfNWEEg4a5zdwBk7a0ydqDPs2+9Y=
Received: by 10.86.80.5 with SMTP id d5mr8335535fgb.19.1215675142294;
        Thu, 10 Jul 2008 00:32:22 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id d4sm10037524fga.8.2008.07.10.00.32.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jul 2008 00:32:21 -0700 (PDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <200807092220.10655.J.Wielemaker@uva.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87950>

On Wednesday 09 July 2008 22:20:10 Jan Wielemaker wrote:
>[ ... ]
> P.s.	This [ git-daemon using a weird path to exec git-upload-pack
>       was ] quite nasty to debug.  I was forced to to run git-daemon
> 	stand-alone (not xinetd) another port and run strace -f -p <pid>
> 	to discover the	cause of this problem.  Even with --verbose, the
> 	only error response was the client complaining on unexpected EOF.

 Just a hint:  I had some odd exec problems in the past
 (as it happens, also from xinetd and also path-related,
 but not(?) your problem), and found that exporting

    GIT_TRACE=3D/tmp/LOG-git-daemon

 gave some valuable clews.  I'm unaware of GIT_TRACE
 being documented.  I also concur it's annoying neither
 --syslog nor --verbose seems to cause these sort of
 errors to be logged.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
