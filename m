From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 03 Jun 2008 13:42:58 +0200
Message-ID: <48452E42.9080305@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 13:44:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Uvd-0006EY-4Q
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 13:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYFCLm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 07:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYFCLm5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 07:42:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:34252 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYFCLm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 07:42:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1012413fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 04:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=lMOlOiYUOVG7epA2UtwXwabH5hDudg4YhOonw6eG714=;
        b=SJsH5RLlhVaUgZ7u+6YOFzxkRWnmwGAnhHT7Q188T8lBpXIYl+gkjHedjyHY73qytJgIjvEmTmR/OofsQNoDEjMmiGTXOEOHvDl7OC6t0NKxOcHoFqZUn9P4WduiUZowgh98lfPvY98eCw5AnmEjG4J4O3YMMbfjQFYCKZodWFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=xBMYSZwQ/SdvT/QyTsn07YmLTNl0hmb3KHc5xGukpXCmSE5Y9bUBih2gZ4nUgcBWQp3Yc8RFI0hHdtKv2W/DhHDpaHPqbn4tFwk0UUNC2rK98vFejwvSjP+leb2FyBetDsbRyjXO2RufTo1ZA10fmeYiZKtT/xq0KLvykiJCNhc=
Received: by 10.86.63.19 with SMTP id l19mr7384087fga.60.1212493374850;
        Tue, 03 Jun 2008 04:42:54 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id 4sm5107136fgg.9.2008.06.03.04.42.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 04:42:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83642>

Rafael Garcia-Suarez wrote:
> git-rev-parse will abort with an error when passed a non-existent
> revision spec, [...]
>
> -		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
> +		open (my $dd, "-|", git_cmd(), "rev-parse", '--revs-only', "$full_rev^")

This is no formal objection, but it would be nice if you could at the 
same time add a comment to the code that explains this -- like "do not 
fail [or 'barf on stderr'] if there is no parent revision".  Makes it 
easier to change it later, since "--revs-only" is not particularly 
obvious. :)

-- Lea
