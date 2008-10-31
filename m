From: "Thanassis Tsiodras" <ttsiodras@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 13:16:05 +0200
Message-ID: <f1d2d9ca0810310416n1e9f3700if49951a05cae9a37@mail.gmail.com>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
	 <20081031110245.GA22633@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 12:17:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvs0H-0007h4-SK
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 12:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbYJaLQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 07:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbYJaLQK
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 07:16:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:5142 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbYJaLQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 07:16:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so919486fgg.17
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C+MQZpTEkhDG0ssTkS1xrL71wPMqxEvGLMSN79XotDg=;
        b=pabqjRLtAeVh48lAUL1zmVonum0rQh58G7gHkGNPc3pW2EUKAFUcQr3mkfS0tibAHX
         o+9cpPCs3ui3T0rnYx97yu/qUG3oJ/cxT4hVs0d9i/vdTO4E+8oHlSDmiyIg0Jipjb6W
         2MnLvr4oXLJQEeu0YI7SEq4BFJKURCZJUza2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=w1GXU1CsofJg0MguxCO06u7kg+SSF1eNW8DjSANQ2nZOEGWoJj9BnhSdCyB75m/rrc
         12YnMGAcNC+k5qoxK/bKZW653ABeWSuPfnEjtzWXo9oPRIBTeqbo8ff9+jZ9YwnBzAKs
         U65FyzUta6/6SN7b7FC8HTtqTZ+Z9W2ykOMDg=
Received: by 10.181.231.19 with SMTP id i19mr3022127bkr.205.1225451765709;
        Fri, 31 Oct 2008 04:16:05 -0700 (PDT)
Received: by 10.181.5.13 with HTTP; Fri, 31 Oct 2008 04:16:05 -0700 (PDT)
In-Reply-To: <20081031110245.GA22633@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99577>

Actually, after using git-gc, git-repack isn't really needed...
git-gc identifies that the two files are very similar and re-deltifies
(see the du -s -k outputs in the original mail, after git-gc we have
in fact lower usage than the first commit).

My question is basically...
(a) why doesn't git detect this during commit and needs a git-gc
(b) whether after git-gc I would have seen the massive difference
during a subsequent git-push or not

Thanassis.


> Have you tried to git repack with aggressive options, like:
>
>    git repack --window=500 --depth=500 \
>      --window-memory=<fair amount of your physical RAM>

-- 
What I gave, I have; what I spent, I had; what I kept, I lost. -Old Epitaph
