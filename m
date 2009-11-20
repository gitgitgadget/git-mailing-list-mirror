From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] gitweb.js: use unicode encoding for nbsp instead
 of html entity
Date: Thu, 19 Nov 2009 17:00:16 -0800
Message-ID: <4B05EA20.1080706@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <1258659887-5244-3-git-send-email-bebarino@gmail.com> <200911200000.41658.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 02:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBHrR-00008W-HY
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbZKTBAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755544AbZKTBAP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:00:15 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:33536 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbZKTBAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:00:14 -0500
Received: by gxk26 with SMTP id 26so2592150gxk.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=YK944ex+FbCfxMDiCoAj2wsLIiLa9jR6Dzkz5Iqjo8U=;
        b=xmkxJp11biquo9x9HreB+QbzKfCvVmo65JFU8HQCWNsE+kZCUmSLSOIq4Mh15Wdprf
         siY9mbtpZT/vyxQiKIrCZPz2WKXQ9qOvT9dWh3Ju+1P2deFY2dZYTLT2n/4Zpc/lmQZe
         46/O/n88epDw+SM8Frcs2Kz26c/MCsQJqmXVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uY1dz4ObqgJV+eJWUNhCL2jNOZ5NJ9cgid3j41i8KApRs0ZG2XUNGqsrfr/0gmhoJV
         AIucf8S8tMjDlZt3asMYW4LR38Q6fV29Mxd+Bk2wTdCpRza0LndkQRT9sjMtKtbor6VZ
         GcNvjPvZVcMfpVHG7AANnqmjTOK2jVVo5Puow=
Received: by 10.150.106.15 with SMTP id e15mr1356633ybc.300.1258678819476;
        Thu, 19 Nov 2009 17:00:19 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 7sm379504ywc.6.2009.11.19.17.00.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:00:18 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <200911200000.41658.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133272>

Jakub Narebski wrote:
> On Thu, 19 Nov 2009, Stephen Boyd wrote
>> It seems that in Firefox-3.5 inserting nbsp with javascript inserts the
>> literal nbsp; instead of a space. Fix this by inserting the unicode
>> representation for nbsp instead.
>
> Errr... why are you avoiding writing &nbsp; or "&nbsp;" here?

Sorry, this part was rushed out. I can fix it in a resend if this is 
actually the right thing to do.

> Well, since I moved from elem.innerHTML (which is non-standard, and
> does not work for some browsers in strict XHTML mode) to setting
> elem.firstChild.data (which assumes that firstChild exists and it
> is a text node) I have had damned *intermittent* bugs where sometimes
> '&nbsp;' would be shown literally, and sometimes this entity would
> be correctly rendered.
>
> I suspect this is either bug in Firefox, or unspecified part of DOM.
>
> As we need this only for progress report, I am not against this change,
> if it doesn't make it worse in other browsers.

I've tested this in Opera-10.10 now and it looks good. I'll try to get 
my hands on a Windows machine to test with IE, but no promises.
