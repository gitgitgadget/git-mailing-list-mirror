From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] grep: expose "status-only" feature via -q
Date: Thu, 28 Jan 2010 08:32:02 -0800
Message-ID: <4B61BC02.3070408@gmail.com>
References: <7vk4v53gek.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 17:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaXI4-00075Y-5m
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 17:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab0A1QcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 11:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755617Ab0A1QcN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 11:32:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:51913 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab0A1QcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 11:32:11 -0500
Received: by qw-out-2122.google.com with SMTP id 8so159682qwh.37
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pQ3trEimzG+PiCULrSJk1KhoHZ0ktgJc6MSBpkNHTdc=;
        b=V6YJcoW3m2RbgTtAxyIHpO0Zva7+QVY3c3xECp43N39PbslTH4xziGAaDLL/4A+jc0
         +VWcorofW6QT3cTBs3c1abLZ0vDXGlafXbwKeu5HG2plyFAIkYrR/cXQdwpfz7zLuj7I
         1FRpMgBmI8XvWLyTt5BUb2xkWIJ6fkgrY/eFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=D446Y2d0R11mo4FGZui1i+jRvhfY2dSNrFiNdFqBC/IKqz4YgsaCZL/wj57UzQtfEJ
         uceRewD+UuHqOofzUJ7RZy75juKMWbQOv+k5TgYvi/wyFvZhzKAKf3qGWrVYEBTOqJGh
         oFDbwMcpwi5WrO/W5M8tU7i+FtNve2mf02gpI=
Received: by 10.103.50.15 with SMTP id c15mr190367muk.35.1264696327642;
        Thu, 28 Jan 2010 08:32:07 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id y37sm6859281mug.38.2010.01.28.08.32.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 08:32:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vk4v53gek.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138257>

On 01/25/2010 03:37 PM, Junio C Hamano wrote:
> @@ -505,6 +512,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>   		{ OPTION_CALLBACK, ')', NULL,&opt, NULL, "",
>   		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
>   		  close_callback },
> +		OPT_BOOLEAN('q', "quick",&opt.status_only,
> +			    "indicate hit with exit status without output"),
>

Why isn't this --quiet just like grep? I think this might be mistaken 
for enabling threads or some fancy algorithm to go faster.
