From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] help: always suggest common-cmds if prefix of cmd
Date: Mon, 29 Nov 2010 10:40:49 -0600
Message-ID: <20101129164049.GH8037@burratino>
References: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
 <1290787239-4508-1-git-send-email-kusmabite@gmail.com>
 <7voc9bpqj2.fsf@alter.siamese.dyndns.org>
 <AANLkTin34AfYnFY5e9B1cuyckfLXU2=qXFciFaaNGt9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	ziade.tarek@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 17:41:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN6mn-0000yC-SV
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 17:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab0K2QlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 11:41:00 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:42570 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0K2Qk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 11:40:59 -0500
Received: by vws15 with SMTP id 15so394077vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JYEuZeksWvb/EVlN2fWW3Y0nJXvDuOcJWZnEK1ZdSNo=;
        b=PdElowRSJqYUjxuk4HoxZbRwcswjaiw3s6NSkmQRg8CIGDel7DN8eNB16J2GgkM6XZ
         unJvLxocrex3SD4F5CX5zd+XUcjIF54hPLrh5/GOHnihBcrl1PfuknynQLtNJemZ1u8P
         5fBNA3f2BMdnIaiKyrSP2FHxXac4hsfkJjtcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SP0XtkTYpFfb+f3iO0u5mi2Uk3pFN4fqz4W7vp5nxD9HJrLaYLAc8BY9eiqtaiblG7
         fLeFhCSHmwgtarmWdd2J2Wo8PegW8FoVoKQpiipOdSI3gLHA620w8tJiAkD1Qda8apyB
         Mp7KCParP8BfOv2RKmQ1xbmCD9LwqV2bC+yn0=
Received: by 10.220.176.73 with SMTP id bd9mr493013vcb.57.1291048858589;
        Mon, 29 Nov 2010 08:40:58 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id m10sm681924vcf.45.2010.11.29.08.40.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 08:40:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTin34AfYnFY5e9B1cuyckfLXU2=qXFciFaaNGt9f@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162398>

Erik Faye-Lund wrote:

> For this code-path to trigger we would have to be able to prefix-match
> every common command AND every "main command" must be included in
> common commands. At the same time. The only possible way to
> prefix-match all commands is if they all start with the same letter.
> Do you really think this is a situation we could ever end up in? Every
> git command being a common-command, starting with the same letter?
> 
> This is basically unreachable code. Perhaps it'd be even clearer just to die:
> 
> if (main_cmds.cnt <= n)
> 	die("Prefix-matched everyting, what's going on?");

(I haven't checked.)  Maybe

	$ git ""

?
