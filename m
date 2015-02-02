From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Relative paths don't work in .gitignore as would be expected.
Date: Sun, 01 Feb 2015 21:57:30 -0800
Message-ID: <54CF11CA.6000308@gmail.com>
References: <CAKU1PAWMh_3x9OoFmXG4+5b=7PRckC47k-MAq++SXahxAP5V7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "/#!/JoePea" <trusktr@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 06:57:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIA0w-0007dn-0Z
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 06:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbbBBF5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 00:57:34 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65036 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbBBF5d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 00:57:33 -0500
Received: by mail-pa0-f50.google.com with SMTP id rd3so77984576pab.9
        for <git@vger.kernel.org>; Sun, 01 Feb 2015 21:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=2ySY4iI/lWyVEzxTPFvC2aU0IPayoAJQ9eX/NpNBNM4=;
        b=sRYkg5MARERMkyKZIlgVWENnkJHVjgYo7+9BPE6ALZmT7HIG3AgGX1Y1W2T7M88uVK
         7doVhHWuVNx7WK3wThupDc0ZGYj8/eMoMioOpAGIrIzmHqwP+CTRLlOMZgBqX/0YbnqP
         KZBxSWNYK6NGTYm7FwGrWvnwWTUmLsLxdtq9HZpCYH6gmnWAswKMmQfpVQAlkerb/01v
         oRPMF1iYVvMqfZF740vTW6NuonIOVI1pxNW+fKClX0vxq/9af0EDgQTTWsXYGgVZnbdi
         aIiZ88n/7hqHE0znPHd8+Y6fSK55FaVRXwUKCdf4m2VJGHHBbrG83dvqmSmCVny+Lu8v
         Rabg==
X-Received: by 10.70.36.235 with SMTP id t11mr27242126pdj.130.1422856653035;
        Sun, 01 Feb 2015 21:57:33 -0800 (PST)
Received: from [192.168.2.3] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id xq16sm17748834pac.31.2015.02.01.21.57.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2015 21:57:32 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAKU1PAWMh_3x9OoFmXG4+5b=7PRckC47k-MAq++SXahxAP5V7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263250>

On 01.02.2015 14:51, /#!/JoePea wrote:
> I have this in my .gitignore:
> 
>   ./*.js
> 
> I would expect that to cause git to ignore .js files in the same
> folder as .gitignore, but it doesn't do anything. However, this works:
> 
>   /*.js
> 
> I'm not sure what this actually means because a leading slash is the
> root of some filesystem, 

That's true, though you'd never (barely?) git version control an entire
file system?


A trailing "/**" matches everything inside. For example, "abc/**"
matches all files inside directory "abc", relative to the location
of the .gitignore file, with infinite depth.
(from man gitignore, though reading that and not finding a './' it may
need improvement
