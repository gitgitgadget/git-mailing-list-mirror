From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: git-clone file permissions and cpio
Date: Mon, 21 Apr 2008 13:41:54 +0200
Message-ID: <480C7D82.9000602@gnu.org>
References: <alpine.BSO.1.10.0804210911170.21918@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
X-From: git-owner@vger.kernel.org Mon Apr 21 13:43:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnuQI-0005Wv-Ax
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 13:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796AbYDULl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 07:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbYDULl6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 07:41:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:38717 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbYDULl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 07:41:56 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1730820fgb.17
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=7Wmfw8OKFUhvTjoHFm8GGl9sr9+6keUo/7d66Lzqba8=;
        b=PSlOTHk/c5H+IBoPScvWLi3PPLbP8z0Bp7GNoENnlbQwIx5uduf/+LABvCii2VjPavcR5NKeNQ3lMw1UPbxjgQxT3kSglC8Ye4n5atOB6/mwMgxfGik3smrv8C0QE2SP8Tz4r2j+Ta91O0F2O500U+pd4b3JljT5Yet8NiL3guU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=YHQTWQpaGYs2SzU/3XSsh3loVAE/RLSpk31SNnDAb5Sv7/vdyMronnhm727icf4FIGdM6h0FESOz+HZIQTS8NUySeJfLjBnXAcN41uHfULuk7QzPNiqM7bXEDb5/MkBAOQUUyQgtWWha9iAZ9vdxLfdeeBrqkM1YdPCeC/+vb6s=
Received: by 10.86.28.5 with SMTP id b5mr12928085fgb.76.1208778115453;
        Mon, 21 Apr 2008 04:41:55 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id l19sm2966343fgb.0.2008.04.21.04.41.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Apr 2008 04:41:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.BSO.1.10.0804210911170.21918@zrgural.vwaro.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80021>


> I got some kind of working behaviour with the diff below, which stops 
> cpio 'fixing' the file permissions (only on the directories). But it 
> seems the underlying cause is cpio trying to copy file permissions which 
> it would be better off not doing in this case (and which there isn't a 
> flag to disable).

I don't think you want to have the setgid bit on files, only on 
directories, so your patch seems okay to me.

Paolo
