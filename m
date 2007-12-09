From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Teach "a=blob" action to be more lenient about blob/file mime type
Date: Sun, 9 Dec 2007 11:06:13 +0100
Message-ID: <200712091106.14124.jnareb@gmail.com>
References: <1197114913-15626-1-git-send-email-jnareb@gmail.com> <7vk5notub9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 11:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1J3a-0006pK-56
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 11:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXLIKGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 05:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbXLIKGV
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 05:06:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:59253 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbXLIKGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 05:06:20 -0500
Received: by nf-out-0910.google.com with SMTP id g13so718466nfb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=HnyQooHt64Sw8ssTZC5clzuiLTRJm00vYDF+30T7Dxc=;
        b=MjR71VF94i0cnKtF1W57Qi5MN8Uap5cpSIswDbv2SUf1w4mfWQIdKmT+cUkryXC0Lyu6blW0mGAldEQtDJXUZiC1iA5JAmCKpMi2Mwn6OaBEYNqJDxiSnh9q4u3sQTF4k7gT9Ft1B2YB5l5SLZ+Gtobzc7cz6sBMwujY6t/5kSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Zcj3MdaQ+kiMEtCHT9VvDg9Y7qlY2F2op5atLJvwuY12ZO+/tKp22uVRnoH/8DQ6YDVHBmh4X2UdVrIPOtHWwSY1p8EKMEvMPDCIz046JDpQKLwhmjfMdfs5ikjvpqpUZRiy8drG3OOvi8+UJqH4X4ZcTR7cdlY/R1K/dc05zNY=
Received: by 10.86.26.11 with SMTP id 11mr4277219fgz.1197194779172;
        Sun, 09 Dec 2007 02:06:19 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.230.31])
        by mx.google.com with ESMTPS id e20sm2099309fga.2007.12.09.02.06.16
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Dec 2007 02:06:17 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk5notub9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67612>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

>> +		}
>> +	} els
 
> There is a "Huh?" on the last line, though.

I'm sorry for this wart. Can you correct this, or should I send
amended patch?
 
>> P.S. BTW is there some plumbing for scripts to help with
>> gitattributes, for example showing all gitattributes (or status of
>> selected attributes) for given path?
> 
> $ git grep gitattributes Documentation | grep -i display

Thanks. 

But as far as I can see you cannot specify _revision_,
i.e. git-check-attr operates _only_ on working directory, and
can be run only in a work tree. For gitweb I'd like it to run
in bare repository, and check $GIT_DIR/info/attributes and
<revision>:[*/].gitattributes

-- 
Jakub Narebski
Poland
