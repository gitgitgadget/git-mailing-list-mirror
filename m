From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v2] test-lib.sh: set PERL5LIB instead of GITPERLLIB
Date: Tue, 03 Jun 2008 00:19:13 +0200
Message-ID: <484471E1.4040509@gmail.com>
References: <4843FEE2.1070708@gmail.com> <1212415996-32130-1-git-send-email-LeWiemann@gmail.com> <7v4p8b7gij.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 00:20:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3INu-0005Bv-5H
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 00:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYFBWTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYFBWTS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:19:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:4176 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbYFBWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 18:19:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so855133fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=d8TLc+nT0t4LF/VfoJ3rImcH31cmOxzTmWoZFH2W0PA=;
        b=WYIyik4HUNTq0xWsZbrsPljejydMvxE8tN9Vs3lFopuFOZ+oAkr6Nu8cYw21/faydoLGKtWebxcgMDDskbV1kS91Gw9hhEVMFbfqiDC/soKaXFRMGwrrFszmI5sQ/wFndR+M6ydoFxS+8YGZXSJXxU1/4NCufjtGOAV2HKgpkyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ovh6IMFnlbHYA7jSQ4z4pHVNjXZp2dQfUnrj3FJ9Ac258RPuxXhECAIVwEnRWNaBR4+1SV0HyI0cSW9ECL6zQFIZUF9K84KP/4iw0QDSNALEcPlel55B+9PFM73n/pV1UNEv+5Ad0StFzk7qYcj6Lz87oTbXh8EeFYRk+cKiU0k=
Received: by 10.86.98.14 with SMTP id v14mr6364702fgb.74.1212445155535;
        Mon, 02 Jun 2008 15:19:15 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id e11sm4402974fga.4.2008.06.02.15.19.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 15:19:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7v4p8b7gij.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83584>

Junio C Hamano wrote:
> the precedence between "use lib @these_paths"

Apologies, I somehow missed the or-expression in $$ENV{GITPERLLIB} || 
"@@INSTLIBDIR@@" and thought we didn't set any library paths if we unset 
GITPERLLIB. :(  So yes, of course my patch is rubbish -- sorry for 
wasting your time, I'll check more carefully next time!

> If [t/t9700/<many>.perl] unconditionally do "use lib $ENV{GITPERLLIB};"
> upfront, wouldn't that be enough to guarantee that you would use the
> freshly built one during the test, not the instsalled one?

Yup, that's fine.  I'll add it to the test file.

-- Lea
