From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix git-init-db creating crap directories
Date: Mon, 19 Sep 2005 17:09:41 -0700
Message-ID: <432F5345.3020303@zytor.com>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz> <432F50BC.5000304@zytor.com> <20050920000731.GJ18320@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:10:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVi8-0004sM-Rm
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVITAKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVITAKE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:10:04 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27593 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932723AbVITAKD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 20:10:03 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8K09kvQ014429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 17:09:47 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050920000731.GJ18320@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8929>

Petr Baudis wrote:
> diff --git a/init-db.c b/init-db.c
> --- a/init-db.c
> +++ b/init-db.c
> @@ -153,7 +153,8 @@ static void copy_templates(const char *g
>  		return;
>  	}
>  
> -	memcpy(path, git_dir, len);
> +	memcpy(path, git_dir, len-1);
> +	path[len] = 0;
>  	copy_templates_1(path, len,

Wrong!  You're not initializing path[len-1]!

	-hpa
