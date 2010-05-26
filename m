From: Dale Rowley <ddrowley@gmail.com>
Subject: Re: [PATCH 1/1] run-command.c: ignore bad permissions on dirs in
 PATH
Date: Tue, 25 May 2010 20:36:51 -0600
Message-ID: <4BFC8943.6090504@gmail.com>
References: <4BFB3C0A.2030505@gmail.com> <7vaarownmv.fsf@alter.siamese.dyndns.org> <4BFB75DD.7030201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 26 04:37:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH6Uo-0002Eg-0s
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 04:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933765Ab0EZChI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 22:37:08 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64744 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933501Ab0EZChG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 22:37:06 -0400
Received: by pwi2 with SMTP id 2so1355749pwi.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=qsr/D9uV0QWRQ3SudDDx2Ocu3JEEZGbSZpoIxxL31tU=;
        b=MWuk2EWkg4LRUcg9sj3S8gFu77enpurn6N8LwZJd606rdFsarOUs7JxPONWcXT/N/t
         QBHTkqA+B4nBlXlqTc9AfIiDQ7AgOzg6+d1+LEGi/49qTDeeot/JLI1aR89qwndvh/Zm
         tLrQsKfSEq75Wx82tdjErRuaoxCr6q7M1D7Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=k5+jQVhqs+OM/sHY8e66Cxd3hCmy5fxm8wisTSFNjMhdN+2eWMBNa0tbpiSsHEcmL5
         v60RA0AGTZ/hJ0X2Xv6wiUzIgHBmkvbdu9wzplYsg/kHvrSXIDcAUXXW09Oq+Qv6wM8/
         WMYuLFyNJodp3c7Cm3uTIVZf4Jjt4IOsron9A=
Received: by 10.142.249.16 with SMTP id w16mr5448908wfh.134.1274841424410;
        Tue, 25 May 2010 19:37:04 -0700 (PDT)
Received: from [192.168.2.3] (97-118-8-44.hlrn.qwest.net [97.118.8.44])
        by mx.google.com with ESMTPS id v41sm1875968wfh.21.2010.05.25.19.37.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 19:37:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100411 Thunderbird/3.0.3
In-Reply-To: <4BFB75DD.7030201@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147729>

> That is, when you write a new git command and forget to set execute
> permission, you lose the "Permission denied" error. (Ditto if you
> accidentally remove execute permission from an existing external git command.)

True, but after getting the warning that 'git-frob' doesn't exist, it
would probably only take a minute to figure out that 'git-frob'
permissions need to be fixed, and then it's understandable why git
choked on it. In contrast, it took me a while to discover my PATH
permissions problem, and even then it wasn't clear why git should die
because of a permissions problem on a directory that had little to do
with git.

Dale
