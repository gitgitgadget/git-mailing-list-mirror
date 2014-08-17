From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 01:08:40 +0200
Message-ID: <53F135F8.60508@gmail.com>
References: <ygfvbpqooog.fsf@corbe.net> <CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com, Daniel Corbe <corbe@corbe.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 01:08:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ9ZC-0003Mm-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 01:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaHQXIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 19:08:45 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:32815 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbaHQXIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 19:08:44 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so3589313lbg.34
        for <git@vger.kernel.org>; Sun, 17 Aug 2014 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1jxodxc79jPiLAvC9RrebCOr5+hFvD/cSLtAleqfyso=;
        b=jsDzxFJxNP3eb6YTSk+7/Q4LpqbJTiAOcq79zSdmVNtLAlMtlYo+5Ua7t8G6djBq5S
         t3enSZZESsuHBBUQurAA2+ONwulgjc0Jw/bZfE6nE/chnrRxi7Yj8Ys4rYXewKYyCgco
         LkyvdEP1PAX69af2cvradjT14XSrAORuypSZHGFZGa1vEmELdd8MnEYe6VXsc0a933QP
         zTjTeTlHu5Rtx1LkPlBUh0Sar32pt8ycDgjXjN6xpuhzauXDOEY/OELENvajaDTimPk3
         agPMtnvzeiXmMjpjGCrkJTIej3Ddzl6xzBZKAEqPQYBlg7ubp2+VyThLE1DEwKaH7/9H
         Yztw==
X-Received: by 10.113.5.41 with SMTP id cj9mr24062543lbd.81.1408316922517;
        Sun, 17 Aug 2014 16:08:42 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id er11sm24260846lbc.49.2014.08.17.16.08.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Aug 2014 16:08:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255378>

Am 18.08.2014 00:01, schrieb Erik Faye-Lund:
> On Sun, Aug 17, 2014 at 10:18 PM, Daniel Corbe <corbe@corbe.net> wrote:
>>
>> I installed git on my Windows machine while it was connected to my
>> corporate network.  It picked up on that fact and used a mapped drive to
>> store its configuration file.
>>
>> As a result, I cannot currently use git when disconnected from my
>> network.  It throws the following error message: fatal: unable to access
>> 'Z:\/.config/git/config': Invalid argument
>>
>> Obviously this value is stored in the registry somewhere because I made
>> an attempt to uninstall and reinstall git with the same results.
>>
>> Can someone give me some guidance here?
> 
> Git looks for the per-user configuration in $HOME/.gitconfig, and if
> $HOME is not set, it falls back to $HOMEDIR/$HOMEPATH/.gitconfig. My
> guess would be some of these environment variables are incorrectly set
> on your system.

To be precise, git checks if %HOME% is set _and_ the directory exists before
falling back to %HOMEDRIVE%%HOMEPATH%.

If %HOMEDRIVE%%HOMEPATH% isn't set or the directory doesn't exist either, it
falls back to %USERPROFILE%, which is always local (C:/Users/<yourname>), even
if disconnected from the network (at least that's how its supposed to be).
