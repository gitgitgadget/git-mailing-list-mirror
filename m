From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/2] make git installation footprint smaller
Date: Fri, 23 Jul 2010 14:12:20 -0400
Message-ID: <4C49DB84.9060001@gmail.com>
References: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 23 20:12:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcMjh-0007Eh-3F
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 20:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0GWSMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 14:12:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41220 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab0GWSMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 14:12:34 -0400
Received: by gyg10 with SMTP id 10so238161gyg.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tVKGyNh94UlA0GWGzmRJZ5pO6m8cjhgbBkJ9tjBLSFE=;
        b=eIdRIAG7amPbv9f17rBN1VqmoEICUTXIR3XaTpS9rJmUSKuFIO0xcBoTpTHNqoKoor
         JAIdzq9qwjDG3JjVfy70Y/CnVD7D9WyRI8LC01TO37vgjaxTbR4aRPyOfC3uaHO9opll
         3Hu05ff76mjyAbI0Iam4HOAr15v6cXJf1t8VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=cUTbMgsspqXZIaYlT4kosif6P8SXyiyNBlrOGViwiOCnaphtwo8xbXX3IQQARTEPoJ
         lWqqh/aPwKDa++kFQYXx5v9zSVgDbycmAVpeARY2CgJ0tytaU+ipulCyHMXgZJpR/S5a
         mCTTBfTSWdkyrv8N/OMfKlJgEkgjAxDs22wNA=
Received: by 10.150.181.3 with SMTP id d3mr6305318ybf.302.1279908747997;
        Fri, 23 Jul 2010 11:12:27 -0700 (PDT)
Received: from [10.0.1.133] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id h11sm844937ybk.17.2010.07.23.11.12.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 11:12:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151561>

On 07/23/2010 01:50 PM, Brandon Casey wrote:
> Ever wonder where that extra 5MB of disk space went that you thought you
> had?  Well, it turns out that git isn't being quite as space-efficient as
> it could be.  Some files that could be installed as links are instead being
> installed as full copies of the original.
>
> With these two patches, we shrink the installation footprint of git by
> making hard or symbolic links for non-builtin programs and for those binaries
> installed in the bin directory.  We already do this for binaries installed
> in libexec.  This can reduce the size of a git installation on the order of
> 10-30%.  Probably about 5-10MB.  Whoopee!!!
>
> Enjoy.
>
> Brandon Casey (2):
>    Makefile: link builtins residing in bin directory to main git binary
>      too
>    Makefile: make hard/symbolic links for non-builtins too
>
>   Makefile |   15 ++++++++++++---
>   1 files changed, 12 insertions(+), 3 deletions(-)
>

What happens when bindir and execdir are the same?
