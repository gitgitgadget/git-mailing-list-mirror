From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] gitweb: fix esc_param
Date: Tue, 13 Oct 2009 18:13:46 -0700
Message-ID: <4AD525CA.8090102@gmail.com>
References: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 03:19:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxsWG-00075b-OF
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 03:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760662AbZJNBPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 21:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760254AbZJNBPk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 21:15:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:60628 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760129AbZJNBPj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 21:15:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1119725fga.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=d6pIXDQP36iWpdSeT53TuYiTAPl7DxjWpG+rSqJiUdc=;
        b=vEqR5HlOSvqUoX7angdW2qhWNIBntc8gvp3QLHgz355Hjc+uohtwZCY8Wv8iO1lFan
         daRZWz1ULLt6mzEuEX8RffRUzRfea6DfyC4NCDDVx7WhvDSpZ6PBhHSTSTUPqUnBW3RV
         ptMRzfBHoq7BCgCaxPX1c2RsWG2X+faLzpWS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=QahyXFGdTE2FHG06DiD34xxLlHbmxfgERAXGqVhSSxdwKvwjgQ9fZXUcvdJ9vRddYD
         w9sl/Ud8kKKC7o6J7EhCQsb+B/aiDLUJMuIf2S78evvcdTi8xKctL2uE1JLxZZE0vSic
         5Jj2VdNxLhVcNJIBvGgvkek+SaBEBqSBLLIZ0=
Received: by 10.86.13.7 with SMTP id 7mr7069734fgm.64.1255482831892;
        Tue, 13 Oct 2009 18:13:51 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm1015119fge.7.2009.10.13.18.13.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 18:13:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130234>

Giuseppe Bilotta wrote:
> The custom CGI escaping done in esc_param failed to escape UTF-8
> properly. Fix by using CGI::escape on each sequence of matched
> characters instead of sprintf()ing a custom escaping for each byte.
>
> Additionally, the space -> + escape was being escaped due to greedy
> matching on the first substitution. Fix by adding space to the
> list of characters not handled on the first substitution.
>
> Finally, remove an unnecessary escaping of the + sign.
>

Signoff?

This works great for my purposes. Thanks.
