From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 05/14] mingw: use real pid
Date: Sun, 10 Oct 2010 15:53:55 -0400
Message-ID: <4CB219D3.8000801@sunshineco.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-6-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 21:54:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51yE-0006T7-Uc
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab0JJTyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 15:54:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49996 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0JJTyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 15:54:03 -0400
Received: by pxi16 with SMTP id 16so107106pxi.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GITj6PjoMhXuxCMEsXG7RcgdfVwkttcE1OMjV8EDteg=;
        b=MTXkU9GfJWj2Zld8Lljnd96Ha3JTHTtiCAJb7cF7z89SjZohpb6EhZqxfKBRXFAybn
         GrAoN7C29nVFa91PMzXKWULKWPZHXHMa1NywuBUCZlmIAaZ2tTGpQ0P5yvZyG7wIH83j
         eS21ZmynONaJHP7SNv+mRmmqRWyO/cp+wOjZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Z0ZaiiEvnfKUlTyzz6psLxDSv24cHjkSuyGTdb3dbCKu8yswNNkwBHgZFFt93TCOYz
         BkFcv49zjnN1LHED1cB2MtxgPOHbMUALyXFV4LYGpkkq+aL61WRgVTDe+8tOOuGGMLq8
         VGN5l1r3qqjmeJCUe5p4ee9K3rVi5qE+BASNw=
Received: by 10.114.132.17 with SMTP id f17mr6026552wad.223.1286740439959;
        Sun, 10 Oct 2010 12:53:59 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id i4sm1666527wal.22.2010.10.10.12.53.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 12:53:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1286716854-5744-6-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158694>

On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
> The Windows port so far used process handles as PID. However,
> this does not work consistently with getpid.

Perhaps this could be elaborated a bit to explain the interaction with 
getpid() and how it is causing problems for daemon mode. For the casual 
reader, it is not immediately obvious what is failing or why this patch 
is needed.

-- ES
