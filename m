From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 03/10] gitweb: separate heads and remotes lists
Date: Mon, 25 Oct 2010 17:01:14 +0200
Message-ID: <201010251701.15334.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOYG-0006Uu-6i
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0JYPB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:01:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52549 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903Ab0JYPBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:01:25 -0400
Received: by bwz11 with SMTP id 11so2436858bwz.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pm+qwphhsQa9irtr5yQZhNLxeSu0by/EeszAEPIEoDY=;
        b=gdIx5aqzLXN61CxYDpjMuOhuEE/tloMKr0Htt41Z3jU60b5Yxjy8iOlJruYhYpKm6A
         TJm7jD3R+09tKX0TDX9TnXN3jBlrydA+MkWR9uRVHmB3C3DZaywybqS1TFCxz5VMGRpC
         InadHF8ABrQ8U9kSZFeYdIm/N706i6zoOEH2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MpXYULWwDfaGIP99EUSq+v/4pBpCaFfKU1CM3ZFKmuF2+l0HsoJc2CwmmJ/9wwl+X9
         RuX0BFrcLVqKTQ+fdmmSEa02NsWi2Sb+xqEeiEGm6ZKXG8KALUrggHLryMvl9wbTsde8
         UgvwxpfBHzbisaoDiwAVWhuFi03IE+aUPm4t8=
Received: by 10.204.73.1 with SMTP id o1mr5228946bkj.71.1288018884018;
        Mon, 25 Oct 2010 08:01:24 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id a25sm4901822bks.20.2010.10.25.08.01.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 08:01:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159954>

On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

> We specialize the 'heads' action to only display local branches, and
> introduce a 'remotes' action to display the remote branches (only
> available when the remotes_head feature is enabled).
> 
> Mirroring this, we also split the heads list in summary view into
> local and remote lists, each linking to the appropriate action.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

> -	my @headlist = git_get_heads_list(16);
> +	my @headlist = git_get_heads_list(16, 'heads');

> -	my @headslist = git_get_heads_list();
> +	my @headslist = git_get_heads_list(undef, 'heads');

Hmmm... I wonder if it wouldn't be better to simply change defaults
in git_get_heads_list() so that second argument defaults always to
'heads', even if 'remote_heads' feature is enabled...

-- 
Jakub Narebski
Poland
