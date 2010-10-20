From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] builtins: utilize startup_info->help where possible
Date: Tue, 19 Oct 2010 20:18:20 -0500
Message-ID: <20101020011820.GA6872@burratino>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-2-git-send-email-pclouds@gmail.com>
 <20101019172953.GC25139@burratino>
 <AANLkTinvSKAyXkzjUgxvrDWvuHWpa+46XVxTu=tWck53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 03:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8NNf-0003oD-BO
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 03:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab0JTBWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 21:22:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56346 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab0JTBWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 21:22:08 -0400
Received: by qwa26 with SMTP id 26so1846212qwa.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8pKaNs6/FVtAP5EzW7lm03oYpmE65tWa+6bLuaAY0nQ=;
        b=F4L/IsQPiUSXI763icDQwEUI1LdKgCA6RgVBv5bWcDOlKEnQQ7WszEp52k3h+kpKH0
         lqcjrvITs9hRdmPzIujU7kbU5LFafaIKJ1xB8kXXdbcsN/AFhpdtR3JODp9eqyNlw2Op
         JArizsRCKEHL/CsP6eFEWF0NHIViLUI9uKH80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gf+9m/fRkS7l53BJbkvRGKthoLoL/LNK0syCshHu0kzmhMAduU40Q9sBjTf1NhiVgh
         aGgkY0puQkOiTJi7rkcvH0a0Hx/JGoQiZr+MTFLwCi/+j1Xy2Bb4SqgbdlQQGsW9K4BU
         X7U3j+XPR60JUeFVPrtKjdrw/ZwtgfoiWLPSk=
Received: by 10.229.228.82 with SMTP id jd18mr2746784qcb.232.1287537726696;
        Tue, 19 Oct 2010 18:22:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id u2sm4672026qcq.19.2010.10.19.18.22.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 18:22:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinvSKAyXkzjUgxvrDWvuHWpa+46XVxTu=tWck53@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159384>

Nguyen Thai Ngoc Duy wrote:

> That. And simpler check. I mean "if (startup_info->help)" takes a tiny
> bit less energy for me to understand than "if (argc == 2 && argv[1] ==
> "-h")". It's also good for grepping.

Mm, that still does not motivate the churn to me.  But "we can change
the meaning to 'if (argc >= 2 && !strcmp(argv[1], "-h"))' some day"
motivates it okay, I think.

> 2010/10/20 Jonathan Nieder <jrnieder@gmail.com>:

>> Maybe (modulo names) it would be better to do
[...]
> Can it be relaxed later when someone comes up with "--help-all" or something?

Yes, I was just thinking out loud.  By "relaxed" I meant the above
(changing == to >= in one place).  Now that I've thought it over,
I don't mind startup_info->help so much.

Hope that helps, and sorry for the noise.
Jonathan
