From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Don't pass CFLAGS to the linker
Date: Sat, 09 Jan 2010 11:32:07 +0100
Message-ID: <4B485B27.2020404@gnu.org>
References: <1261896918-1953-1-git-send-email-tom@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 11:35:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTYfW-0006Zc-8H
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 11:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0AIKcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 05:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617Ab0AIKcO
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 05:32:14 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:40706 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0AIKcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 05:32:13 -0500
Received: by fxm25 with SMTP id 25so13290014fxm.21
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Kyf2VmHx6WaBcbYmP4z9b3UmDvUc2DH3D2Id3LhbL7w=;
        b=S/Vyycz5ahPWv41Ylna27IFt/b1HvjDVB9U9QUJHeXt8Tedkxlhlq76afQp5lDHPtx
         pIaCqKguvciadEdPwhEt7YI9IX7adwm3NuCAibZgBMZxte5Q8IV32nrV+/XWGpTeAbT+
         qEGHP2SyqAWQrIE37wjQXNJxvxbulsOhN4+GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=f/EWZLoS0NYyxOXAWvwv9yQZMB0R8Qc4cJDvLCbFEMuIIcA5HDt794/8TssCqt1mF/
         5AsoRoccYdj1je/j6xFwf7AwZ0o68lrkDqPrFyegTnU4smQtcPw62gNPxbwksdCueEXB
         UHaZJ3sEhWMZCtl7/Tsv9EJq2pCDWYLPtDtsk=
Received: by 10.223.20.85 with SMTP id e21mr5534172fab.25.1263033131735;
        Sat, 09 Jan 2010 02:32:11 -0800 (PST)
Received: from yakj.usersys.redhat.com ([72.14.240.161])
        by mx.google.com with ESMTPS id h2sm5272259fkh.2.2010.01.09.02.32.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 02:32:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <1261896918-1953-1-git-send-email-tom@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136527>

On 12/27/2009 07:55 AM, Tomas Carnecky wrote:
> Signed-off-by: Tomas Carnecky<tom@dbservice.com>
> ---
>
> I don't remember exactly which tool had problems with CFLAGS being passed
> to the linker. Maybe it was the clang static analyzer, or some other
> tool that I let run on git.git. Anyway, I don't think there's any
> reason to pass CFLAGS to the linker.

One reason is if you want to use GCC's upcoming link-time optimization 
(-flto).

Paolo
