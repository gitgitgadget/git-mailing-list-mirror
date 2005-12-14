From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-am --one
Date: Tue, 13 Dec 2005 17:47:31 -0800
Message-ID: <439F79B3.6000309@zytor.com>
References: <439F7105.9050302@zytor.com> <7vy82o5uss.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 02:49:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmLkI-0003MB-ER
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 02:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVLNBrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 20:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVLNBrv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 20:47:51 -0500
Received: from terminus.zytor.com ([192.83.249.54]:57518 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030353AbVLNBru
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 20:47:50 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBE1lgpZ020923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Dec 2005 17:47:43 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy82o5uss.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13612>

Junio C Hamano wrote:
> 
> I understand the motivation, but I suspect skipping mailsplit
> might be simpler, like this untested code perhaps?
> 
> 	case "$one" in
>         '')
>         	... original code ...
> 		;;
>         *)
> 		one=`printf "%${prec}d" 1`
>         	cat "$@" >"$dotest/$one"
>                 echo "$one" >"$dotest/last"
>                 ;;
> 	esac
> 

If that works, great.  I just implemented it in the "most obviously 
correct" way, meaning with as few changes as possible.

	-hpa
