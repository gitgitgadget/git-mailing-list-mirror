From: kelson@shysecurity.com
Subject: Re: [PATCH v2] git-config support for diff.relative setting
Date: Sun, 21 Dec 2014 14:41:53 -0500
Message-ID: <54972281.9050603@shysecurity.com>
References: <54954054.7080201@shysecurity.com>	<CFEBFB254713492C988FED7E11475227@PhilipOakley> <xmqq61d5d7yn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Dec 21 20:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2mOH-00033r-6z
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 20:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaLUTmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 14:42:04 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:32878 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaLUTmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 14:42:03 -0500
Received: by mail-qg0-f52.google.com with SMTP id a108so2579281qge.39
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 11:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aQUQ2xDWmf6g+HzHRnCs0jRac2NErpctt3dXyyBUWmc=;
        b=dBWCzNVzmQztYxs9J1U5yNfipaFbTMI2MFhE70sjCkA4OSJsavKGtdtdIRchIIvdF4
         mly+8gexKL1Z4w1VPj/3D4D/c0WCgnfaTxU7QXy/EAhVZ5FbqX7OKj8cDw9XjBqy1u8Y
         STDbrdbtqpan+u/rQrfZsGqFn1BbvtpNn4zCKkndH+C0O/kvkDguNz6BuqwIQ/6NphXv
         Ej4fvgEgh2Y48dVyiAmLkAEkVawRafCmEvCFxPGELE3Rb1A18T/D8c+8EwpXswQr47Mx
         uw0VVCmK+6pD8XsXilk8gj9s0MaNW0g56toXxsOy55QFnSikgN/bG8H1eofKvc1jknMw
         6ldg==
X-Gm-Message-State: ALoCoQmtywqwo1KZhbbksxZJ2DgOnraDCEdecW/F/caZDuawHi/VeEubE+8lr8MOOSfBn21uTmLo
X-Received: by 10.224.25.146 with SMTP id z18mr31576095qab.17.1419190921434;
        Sun, 21 Dec 2014 11:42:01 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id r16sm14793687qay.10.2014.12.21.11.42.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Dec 2014 11:42:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqq61d5d7yn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261625>

> "Philip Oakley" <philipoakley@iee.org> wrote:
> Shouldn't this `(identical to "git diff --relative")` also be
>included in the documentation change? It would truly clarify the
> intenbt for the reader.

Updated as follows:
+diff.relative::
+	Show pathnames relative to the current directory and exclude
+	changes outside this directory; equivalent to the 'git diff'
+	option '--relative'.

> "Junio C Hamano" <gitster@pobox.com> wrote:
> There should be a way to run non-relative diff in a repository that
> has the configuration set, perhaps by overriding with some command
> line option (e.g. "--no-relative").

Good idea; I'll put together a second patch for a "--no-relative" option 
to disable diff.relative.

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>
Sent: 12/20/2014 09:58 PM
To: Philip Oakley <philipoakley@iee.org>
CC: <kelson@shysecurity.com>,  "Git Mailing List" <git@vger.kernel.org>, 
  "Duy Nguyen" <pclouds@gmail.com>,  "Jonathan Nieder" <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-config support for diff.relative setting

"Philip Oakley" <philipoakley@iee.org> writes:
> From: <kelson@shysecurity.com>
>> By default, git-diff shows changes and pathnames relative to the
>> repository root. Setting the diff.relative config option to "true"
>> shows pathnames relative to the current directory and excludes
>> changes outside this directory (identical to "git diff --relative").
> Shouldn't this `(identical to "git diff --relative")` also be included
> in the documentation change? It would truly clarify the intenbt for
> the reader.

A configuration that sticks a non-default behaviour without a way to
revert to the default is a no-no.

There should be a way to run non-relative diff in a repository that
has the configuration set, perhaps by overriding with some command
line option (e.g. "--no-relative").
