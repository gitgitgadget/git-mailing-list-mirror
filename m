From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-am --one
Date: Tue, 13 Dec 2005 17:58:50 -0800
Message-ID: <439F7C5A.4030509@zytor.com>
References: <439F7105.9050302@zytor.com>	<7vy82o5uss.fsf@assigned-by-dhcp.cox.net> <439F79B3.6000309@zytor.com> <7v7ja85tqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 03:00:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmLvc-0007Q3-3l
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 02:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVLNB7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 20:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbVLNB7d
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 20:59:33 -0500
Received: from terminus.zytor.com ([192.83.249.54]:48088 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030324AbVLNB7c
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 20:59:32 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBE1wt4Q021120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Dec 2005 17:58:55 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7ja85tqe.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13615>

Junio C Hamano wrote:
> 
> Another thing you may probably want is to loop over "$@", so
> that the flag is not --one anymore, but --2822 (or --bare as
> opposed to mbox format) and do something like this:
> 
> 	case "$series_of_2822_messages" in
>         '') ... original code ... ;;
>         *)
>         	i=1
>                 for input
>                 do
> 			this=`printf "%${prec}d" $i
>                         cp "$input" "$dotest/$this"
>                         i=$(($i+1))
> 		done
>                 printf "%${prec}d" $# >"$dotest/last"
>                 ;;
> 	esac
> 

That is definitely a good idea.  I'll mess with it a bit.

	-hpa
