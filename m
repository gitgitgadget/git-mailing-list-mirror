From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fw: [git-users] How do I git-push to an FTP server?
Date: Mon, 8 Oct 2012 01:02:08 -0700
Message-ID: <20121008080208.GC19733@elie.Belkin>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org>
 <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
 <20121007172754.GA29560@elie.Belkin>
 <7vvcemovrh.fsf@alter.siamese.dyndns.org>
 <CALkWK0nSxBsiE5_BZ67dPrwDRQSipL0LBR9Pf252iqL21HwZBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org, git-users@googlegroups.com,
	August Karlstrom <fusionfile@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:02:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL8IP-0003GX-Ke
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 10:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab2JHIC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 04:02:26 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44845 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2JHICZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 04:02:25 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3716066pad.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vAMUOf7tOjClTKb6v0E2bFP5Jthm0Ps5ZvMp1Sx/wYc=;
        b=FRS6+e/JxtuYGcnXFU6X/r157EH/jXPLSKKyGDbGo4c5Ma0GOrIWcRVTruQnc2TDEk
         JWkUj7tZT2owsoj8Zos0uCEsrvPueJydBFzRZauS05aZ3t9xK18hNDUkiyK5Tv1wp/eR
         ra08DVqzVLFkDgAMJeEBtkiBzWdnL+QK+RHquDNxRZaxYVH1frtassdkPQsxs7vgzIrk
         7w7IDVhL/yuET4NljuvKDEnJQWUt14ic1lSVdn27GqnmRgwrnH/4mdyJp1B+6kcuXyiP
         3/Zg0hGcm2eH4xQb9B1NDbDqoE11N5hVKwlJGtVJakj9LHuOPI29zr5gmlxG9qh6tduo
         QKHQ==
Received: by 10.68.225.199 with SMTP id rm7mr51535912pbc.150.1349683344977;
        Mon, 08 Oct 2012 01:02:24 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id op7sm4553365pbc.52.2012.10.08.01.02.17
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 01:02:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nSxBsiE5_BZ67dPrwDRQSipL0LBR9Pf252iqL21HwZBA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207224>

Ramkumar Ramachandra wrote:

> I see.  Will we remove ftp[s] support too?  I hope this is in order.

I don't see why that would be desirable, as long as libcurl continues
to support it for free.

[...]
> Fetching and pushing over rsync, and fetching over ftp or ftps are
> deprecated, and will soon be removed.  Add a note saying this.

I thought the real rationale was to avoid creating the illusion of
supporting push over ftp.  Having a paper trail to comfort people who
notice when rsync support vanishes is just an added bonus.

[...]
> @@ -31,6 +29,11 @@ syntaxes may be used:
>  - /path/to/repo.git/
>  - file:///path/to/repo.git/
> 
> + Git also has (less efficient) support for fetching and pushing over
> + rsync protocol and fetching over ftp or ftps, using the same
> + "protocol://host/path/to/repo.git/" syntax.  However, these are
> + deprecated, and will soon be removed.

I'd suggest dropping ", and will soon be removed." or replacing it
with ". Don't use them." to avoid the question of how soon "soon" is.

With that change and with a clearer commit message, this will probably
be good to go imho.

Thanks,
Jonathan
