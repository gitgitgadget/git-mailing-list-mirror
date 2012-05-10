From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Thu, 10 May 2012 16:43:26 -0500
Message-ID: <4FAC367E.8070006@gmail.com>
References: <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411213522.GA28199@sigill.intra.peff.net> <4F872D24.8010609@gmail.com> <20120412210315.GC21018@sigill.intra.peff.net> <4F8A2EBD.1070407@gmail.com> <20120415021550.GA24102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 10 23:43:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSb96-0007Oq-N2
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 23:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761633Ab2EJVnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 17:43:31 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58849 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761626Ab2EJVna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 17:43:30 -0400
Received: by gglu4 with SMTP id u4so1295114ggl.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=I6emCbX8PEPBQSfvY1YfcwS0WtV8gJUmwuHifWwP2tU=;
        b=tOAa2WrN+AxB5JsGzQYAG/+usruy6YBneMtkyjBtAhNzwr965k8mmMLXMSHdgHsX8S
         eLhlKGSLrn56yaoFOpy6/AO0dg4TUDPfpFjFU3tNKwlIUdMF3uHRiMRO8X+pdKFMSBC6
         lCgOmWs5bgDgb3tYcdjupZ31IVY8f/QoDmw5CoQMVHS1YLDpD2eb/mJM3hp37kyIv5/2
         4t2KAxzM0ZNg3Dd7qO8gpF7OLfRRHCKzs65aUI9dn0Ar/WV9jVHR3qIwj/PhSVOhMXBa
         DSC5YIWR9mLrLz+VnZcSTZI+G2pazfaH5DnKzUCVh9ZNRf8IpEcdEtvIYnA3KcrYS83B
         T/CA==
Received: by 10.60.18.197 with SMTP id y5mr8173412oed.58.1336686209335;
        Thu, 10 May 2012 14:43:29 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id qb7sm7410054obc.13.2012.05.10.14.43.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 14:43:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120415021550.GA24102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197635>

On 4/14/2012 9:15 PM, Jeff King wrote:
> On Sat, Apr 14, 2012 at 09:13:17PM -0500, Neal Kreitzinger wrote:
>
>> Does a file's delta-compression efficiency in the pack-file directly
>> correlate to its efficiency of transmission size/bandwidth in a
>> git-fetch and git-push?  IOW, are big-files also a problem for
>> git-fetch and git-push by taking too long in a remote transfer?
> Yes. The on-the-wire format is a packfile. We create a new packfile on
> the fly, so we may find new deltas (e.g., between objects that were
> stored on disk in two different packs), but we will mostly be reusing
> deltas from the existing packs.
>
> So any time you improve the on-disk representation, you are also
> improving the network bandwidth utilization.
>
The git-clone manpage says you can use the rsync protocol for the url.  
If you use rsync:// as your url for your remote does that get you the 
rsync delta-transfer algorithm efficiency for the network bandwidth 
utilization part (as opposed to the on-disk representation part)?  (I'm 
new to rsync.)

v/r,
neal
