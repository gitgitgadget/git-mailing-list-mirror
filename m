From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config: Print the delimeter of intuited --bool values
 under --get-regexp
Date: Thu, 26 Aug 2010 22:17:57 -0500
Message-ID: <20100827031757.GD23924@burratino>
References: <1282844716-30591-1-git-send-email-alex@chmrr.net>
 <1282855775-22582-1-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: alex@chmrr.net
X-From: git-owner@vger.kernel.org Fri Aug 27 05:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OopTr-0003NL-NW
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 05:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab0H0DTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 23:19:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43788 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab0H0DTq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 23:19:46 -0400
Received: by yxg6 with SMTP id 6so929456yxg.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 20:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5GMppSh6onzRlFdeQEYD2c5WoMr+aYof9UNSdlwQU94=;
        b=C6VBNIp5lCjYMMSiMqgrg521JxVg06UXu/L99u9qBgzZ8vDDlEvK73q2Pb1BaY+fSp
         H6KelWDlZ9mvvMNexJEgch8sJ+F7F4IseUFVd8w8oyKmEPV1URys3R05dCjJXAculfNN
         F/G7b63sJYCY2R9g7qkR16cHdRbbG06hYp7hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GXDtjfGlFwPRWqeummJerxNwk+PxfoQ0zD3Np7LmyPkh0xgz3jewAyoCiA3aNNAAEh
         A3Iq5n4+07/av970A9BxmU1TBxf6bRhZqy5IdWIMPpWekyYlH5QH/ecwrQhGKa0YjnDT
         x57QOSF7363UvIfkt5+s+VN/AkyCR2rCsGQIQ=
Received: by 10.151.98.15 with SMTP id a15mr1105887ybm.236.1282879185957;
        Thu, 26 Aug 2010 20:19:45 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q21sm3524932ybk.11.2010.08.26.20.19.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 20:19:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282855775-22582-1-git-send-email-alex@chmrr.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154579>

Alex Vandiver wrote:

> @@ -132,14 +129,21 @@ static int show_config(const char *key_, const char *value_, void *cb)
>  		must_free_vptr = 1;
>  	}
>  	else
> -		vptr = value_?value_:"";
> +		vptr = value_;
[...]
>  	if (dup_error) {
>  		error("More than one value for the key %s: %s",
>  				key_, vptr);

Could this segfault?
