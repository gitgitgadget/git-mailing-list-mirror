From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 14:48:33 +0100
Message-ID: <4B83DCB1.5050905@gnu.org>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Feb 23 14:54:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjvDz-0003Av-0R
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 14:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab0BWNyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 08:54:50 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:10864 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0BWNyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 08:54:49 -0500
Received: by ey-out-2122.google.com with SMTP id d26so880806eyd.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UXkwAKKqd4J5Twsp/QGmH71xq2r2bHvo2xD5gMncb04=;
        b=hNe+brOzSXr4LUUp95wW5Ue/iwCpQl92jD5aYix5oIHdi9AaJ93AwNfHjGATxte3/L
         qsq4eYJVfZZjqQN4r2vkuYSPCZ5moCndy6sdhH8WP+S3fkPg4gQrrcJnud7BWNQDkhdC
         WxJB7qlzRxQK0ndmMi5byCChwyX1zJMRSN2ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PcZh/xq+b4q3wMqNbuSOk4UA6a5/8vl240a57bWtjo6q7XmBlWatqF7E45rOyXbprQ
         FFYR30V6JyCIVbef6cS/NXFhUJJLYi5Fs72fXnFmSzT3jOJ3uwP+9b5UCq0pslh7vhyD
         jcEt/KDo0CX6aUW25gdHL4yUKVAlpdNjDOFcA=
Received: by 10.213.96.5 with SMTP id f5mr554351ebn.92.1266932923582;
        Tue, 23 Feb 2010 05:48:43 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 14sm29534ewy.10.2010.02.23.05.48.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 05:48:39 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140801>

On 02/23/2010 01:33 PM, Ilari Liusvaara wrote:
> According to relevant RFCs, in addition to alphanumerics, the following
> characters are valid in URL scheme parts: '+', '-' and '.', but
> currently only alphanumerics are allowed in remote helper names.
>
> Allow those three characters in remote helper names (both 'foo://' and
> 'foo::' syntax).

I think '+' could be special-cased in that, for example, "svn+ssh://" 
should still invoke an hypothetic git-remote-svn helper.  There is no 
use yet for this feature, but I'm sure that foreign VCS helpers would 
use it.

Paolo
